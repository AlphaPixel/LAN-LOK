# CLAUDE.md — LAN-LOK Reverse Engineering

This file provides AI-session context for continuing the decompilation of LAN-LOK.

---

## Project Summary

LAN-LOK is a 1991 DOS sabotage game written in Microsoft QuickBASIC at Palmer Station,
Antarctica. We are decompiling the executable back to BASIC source code using:
- `lanlok.asm` — Ghidra disassembly of the code segment
- `lanlokre.bas` — working decompilation file (mix of real BASIC + raw ASM stubs)
- `LANLOKDS.BIN` — data segment dump for resolving string/float constants
- `WORK_PLAN.md` — comprehensive plan with function inventory and translation reference

The complete work plan (function list, translation reference, variable map, session protocol)
is in **`WORK_PLAN.md`** — read that first in any new session.

---

## Quick Start for a New Session

```powershell
# 1. Measure progress
.\tools\progress.ps1

# 2. Find next raw ASM block
Select-String -Path lanlokre.bas -Pattern '^\s+01a2:[0-9a-f]{4}' | Select-Object -First 1

# 3. Extract the function from the ASM
.\tools\extract_fn.ps1 -FunctionName FUN_01a2_XXXX
```

Then translate the ASM to BASIC and replace the raw ASM lines in `lanlokre.bas`.

---

## Key Conventions

### ⚠️ ASCII-Only Comments in `lanlokre.bas`

**All comments in `lanlokre.bas` must use plain ASCII characters only.**
Non-ASCII Unicode (e.g. `≈`, `—`, `→`) renders as mojibake (`â‰ˆ`, `â€"`, `â†'`) in
Notepad++ and the GitHub web UI when those tools assume Windows-1252/Latin-1 encoding.

Use these ASCII substitutes in comments (never the Unicode originals):

| Avoid | Use instead |
|-------|-------------|
| `—` (em dash, U+2014) | `--` |
| `≈` (almost equal, U+2248) | `~` |
| `→` (right arrow, U+2192) | `->` |
| Any other non-ASCII | Plain ASCII equivalent |

This rule applies only to `lanlokre.bas` comments. Markdown files (`.md`) may use Unicode freely.

### File Structure of `lanlokre.bas`
- Lines starting with `       01a2:` are **raw ASM** — not yet decompiled
- Lines that look like BASIC are **done**
- Both kinds appear in the same file; the ASM lines are the work-remaining marker
- A compiled check: `(Select-String lanlokre.bas -Pattern '^\s+01a2:').Count` → target 0

### Variable Naming (DS address → BASIC name)
- `Fa_xxxx!` = single-precision float at DS offset 0x_xxxx
- `Sa_xxxx$` = string variable at DS offset 0x_xxxx
- Key vars: `Fa22e!`=drawX, `Fa232!`=drawY, `Fa236!`=color, `Fa472!`=target#,
  `Fa456!`=score, `Sa46e$`=command input, `Fa246!(i,j)`=computer status array

### Subroutine Labels
- BASIC labels use the CS address: `L3c57:` for `FUN_01a2_3c57`
- `CALL FUN_01a2_XXXX` in ASM → `GOSUB LXXXX` in BASIC
- `RET` in ASM → `RETURN` in BASIC

### Runtime Calls → BASIC
- `CALLF COLOR` → `COLOR fg[,bg]`
- `CALLF LOCATE` → `LOCATE row,col`
- `CALLF PRINT_STR_NEWLINE` → `PRINT "string"`
- `CALLF LINE` → `LINE (x1,y1)-(x2,y2),c[,style]`
- `CALLF SOUND` → `SOUND freq,duration`
- `CALLF TIMER` returns float pointer in SI; `d9 04` then `FSTP` = `Fvar! = TIMER`
- `CALLF FPCOMPARE_2stack` compares top 2 FP stack values; sets ZF/CF flags for JZ/JC/JA etc.

### Control Flow
- JZ/JE = `IF x=y` / JNZ = `IF x<>y` / JC = `IF x<y` / JNC = `IF x>=y`
- JA (above) = `IF x>y` (unsigned) / JBE = `IF x<=y`
- A loop that increments and tests against a limit → `FOR/NEXT` or `WHILE/WEND`

---

## ⚠️ MANDATORY: Delay Loop Conversion Policy

**All calibrated FOR-loop delays MUST be converted to `_DELAY <seconds>` — no exceptions.**

QuickBASIC's original timing system uses a startup calibration loop to measure CPU speed,
then scales every delay by the result. QB64 running on modern hardware makes the calibration
instant (TEND−TSTART ≈ 0), producing infinite loop limits. The game hangs on the first pause.

### How to Identify a Delay Loop

A delay loop is a `FOR/NEXT` with an **empty body** whose limit is one of the calibrated
timing variables (`F0046!`, `F004a!`, or any `(expression)*F0042!`):

```asm
; ASM signature — empty calibrated delay:
FLD  float ptr [0x46]      ; or [0x4a] — the pre-scaled limit
FSTP float ptr [Fa_xxxx]   ; save to temp var
FLD  float ptr { 1.0 }
JMP  test_label
loop_label:
  FLD  [F003a!]
  FADD { 1.0 }
test_label:
  FSTP [F003a!]
  FLD  [limit_temp]
  FLD  [F003a!]
  CALLF FPCOMPARE_2stack
  JBE  loop_label          ; loop until F003a! > limit
```

### Conversion Formula

The timing constants in `LANLOKDS.BIN` reflect the last run on the original Palmer Station
machine. Use them to compute exact wall-clock durations:

```
calibration_rate  = 37700 / (0.9902 / F0042!)   = 37700 / 0.375  = 100,533 iters/sec
```

| Variable | DS value | _DELAY value | Formula |
|----------|----------|--------------|---------|
| `F0046!` | 26405 | **0.263 s** | 26405 / 100533 |
| `F004a!` |  6601 | **0.066 s** |  6601 / 100533 |
| `(RND*500000+500000)*F0042!` | varies | **`(RND(1)+1)*13.132`** | (RND+1)×500000×0.9902/37700 |

For any **new** delay limit variable encountered: `_DELAY = DS_value / 100533`.

### Mandatory Replacement Pattern

```basic
' WRONG — do not write this:
FaXXXX! = F0046!
FOR F003a! = 1 TO FaXXXX!
NEXT F003a!

' CORRECT — write this instead:
_DELAY 0.263   ' ≈ 0.263 s (orig: F0046!=26405 iters on Palmer Station hardware)
```

Rules:
1. **Never translate** a calibrated empty FOR loop literally — always emit `_DELAY`.
2. **Drop** the temp variable (`FaXXXX!`) and loop counter (`F003a!`) from the output.
3. **Keep the subroutine label** — callers use `GOSUB` to reach it.
4. When the limit is a **runtime expression** multiplied by `F0042!`, cancel `F0042!`
   algebraically and express the delay in wall-clock seconds directly.
5. **Add a comment** showing the original iteration count and the computed duration.

### Already-Converted Loops (do not re-convert)

| Label | `_DELAY` | Original iters |
|-------|----------|----------------|
| `L3c57` | 0.263 s | F0046! = 26405 |
| `L3c90` | 0.263 s | F0046! = 26405 |
| `L3cc9` | 0.066 s | F004a! = 6601 |
| `L3d02` | 0.066 s | F004a! = 6601 |
| (ENTRY lockout) | `(RND(1)+1)*13.132` s | (RND*500000+500000)*F0042! |

The calibration block itself (TSTART!/TEND!/F0042!/F0046!/F004a! assignments) has been
removed from ENTRY and must not be re-added.

---

## Safety Rules for Unattended Operation

These operations are **safe without confirmation**:
- Reading any file in this repo
- Writing to `lanlokre.bas` (the working decompilation file)
- Writing to `WORK_PLAN.md` (the plan/status tracker)
- Writing to `PROGRESS.md` (auto-generated progress)
- Writing to `tools/*.ps1` (helper scripts)
- Writing to `CLAUDE.md` or `CLAUDE.local.md`
- Running `.\tools\progress.ps1`
- Running `Select-String` queries on any repo file
- Git add + commit (but not push)

These operations **require confirmation**:
- Modifying `lanlok.asm` (the ground truth — should be read-only)
- Modifying `LANLOKDS.BIN`, `MEMDUMP*.BIN` (binary data — read-only)
- Git push
- Running QB64 or DOSBox (external tools, require installation)

---

## Commit Message Format

```
Decompile FUN_01a2_XXXX (LabelName): one-line description

Co-Authored-By: Claude Sonnet 4.6 <operated by xenon at alphapixel.com>
```

---

## Where Things Stand

See `WORK_PLAN.md` §"Current State" for the latest status table.
See `PROGRESS.md` (if it exists) for the auto-generated progress snapshot.

The `lanlokre.bas` file is the single source of truth for decompilation progress.
The ratio of raw-ASM lines to total lines is the primary progress metric.

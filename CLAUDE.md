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

# LAN-LOK Reverse Engineering: Work Plan

## Overview

LAN-LOK is a 1991 DOS sabotage game written in Microsoft QuickBASIC, created at Palmer Station,
Antarctica. No source code survives. This project decompiles the game executable back to BASIC
using a Ghidra disassembly and memory dumps.

---

## Current State (as of 2026-05-27)

| Item | Status |
|------|--------|
| Total lines in `lanlokre.bas` | 16,481 |
| Raw ASM lines still in file | 14,106 (85.6%) |
| Decompiled BASIC lines | 2,375 (14.4%) |
| Estimated functional completion | ~28% (BASIC is denser than ASM) |
| Named ASM functions (Ghidra) | 43 + ENTRY = 44 code regions |
| Completed subroutines | L2e2d, L3522, L376f, L3a10 |

### What Is Done
- **Main game body (ENTRY)** — partially decompiled; intro, rules, main game loop, command
  dispatch (`select`, `print`, `send mail`, `del *.*`, `format c:`) are largely BASIC.
- Several small subroutines: `L0b97`, `L0bcb`, `L0d53`, `L2d76`, `L2dbb` (timer display),
  part of `L2e2d` (computer icon draw), `L3c90` (delay loop)
- **Session 1:** `L2e2d` — computer icon drawing (18 LINE + 2 PSET)
- **Session 2:** `L3522` — animate computer screen (3 LINE + PSET + scan-line WHILE loop)
- **Session 3:** `L376f` — Al fixes computer (SOUND, tally counters, PRINT, erase+redraw icon)
- **Session 4:** `L3a10` — score recalculator (FOR loop computers 1-9, Hobbs special case, clamp, display)
- Variable naming convention established (DS address → `Fa_xxxx!` / `Sa_xxxx$`)

### What Remains
Every raw ASM block still in `lanlokre.bas` — identifiable by lines matching
`^\s+01a2:[0-9a-f]{4}`. These must be replaced with equivalent BASIC statements.

---

## File Inventory

| File | Purpose |
|------|---------|
| `lanlok.asm` | Ghidra disassembly — **ground truth**. 23,451 lines, 1.3 MB. |
| `lanlokre.bas` | Working decompilation file. Hybrid: BASIC + raw ASM stubs. |
| `LANLOKDS.BIN` | Data segment dump (DS = 1997:0000). For resolving string/float constants. |
| `MEMDUMP.BIN` | Full program code area, FP-emulation stubs converted to x87. Fed to Ghidra. |
| `MEMDUMP_orig.BIN` | Original unmodified memory dump. |
| `archival/Lanlok.zip` | Original DOS EXE for DOSBox testing. |
| `tools/progress.ps1` | Script to measure decompilation progress. |
| `tools/extract_fn.ps1` | Script to extract a named function from `lanlok.asm`. |
| `WORK_PLAN.md` | This document. |
| `CLAUDE.md` | Context for AI-assisted decompilation sessions. |

---

## ASM Function Inventory

All 43 named functions plus ENTRY, in address order.
Status: ✅ Done / 🔄 Partial / ⬜ Todo

| ASM Name | BASIC Label | Description | Status |
|----------|-------------|-------------|--------|
| ENTRY | (main body) | Timer calibrate, intros, game loop, commands | 🔄 Partial |
| FUN_01a2_0b97 | L0b97 | Random sound effect | ✅ Done |
| FUN_01a2_0bcb | L0bcb | Draw arrows | ✅ Done |
| FUN_01a2_0d53 | L0d53 | Clear arrows | ✅ Done |
| FUN_01a2_0d85 | L0d85 | Continue intro / rules | 🔄 Partial |
| FUN_01a2_145c | L145c | (unknown — score/status area?) | ⬜ Todo |
| FUN_01a2_19e9 | L19e9 | (unknown) | ⬜ Todo |
| FUN_01a2_19fa | L19fa | (unknown — Al repair loop?) | ⬜ Todo |
| FUN_01a2_2d76 | L2d76 | Reset selection | ✅ Done |
| FUN_01a2_2dbb | L2dbb | Update displayed timer | ✅ Done |
| FUN_01a2_2e2d + 341d + 3460 + 3469 + 3471 | L2e2d | Display computer icon (18 LINEs + 2 PSETs) | ✅ Done |
| FUN_01a2_341d | L341d | (unknown) | ⬜ Todo |
| FUN_01a2_3460 | L3460 | (unknown) | ⬜ Todo |
| FUN_01a2_3469 | L3469 | (unknown) | ⬜ Todo |
| FUN_01a2_3471 | L3471 | (unknown) | ⬜ Todo |
| FUN_01a2_3522 | L3522 | Animate computer screen: 3 LINEs + flickering PSET + scan-line WHILE loop | ✅ Done |
| FUN_01a2_376f | L376f | Al fixes computer: SOUND alert, tally damage counters, PRINT score, erase+redraw icon | ✅ Done |
| FUN_01a2_3a10 | L3a10 | Score recalculator: loop computers 1-9 (damage pts 50/100/200/60), Hobbs special (75/130/400/85), clamp ≥0, LOCATE+PRINT score | ✅ Done |
| FUN_01a2_3c57 | L3c57 | Delay ≈ 0.263 s → `_DELAY 0.263` (was F0046!=26405 iters) | ✅ Done |
| FUN_01a2_3c90 | L3c90 | Delay ≈ 0.263 s → `_DELAY 0.263` (same; shares RET) | ✅ Done |
| FUN_01a2_3cc9 | L3cc9 | Delay ≈ 0.066 s → `_DELAY 0.066` (was F004a!=6601 iters; no RET, falls through) | ✅ Done |
| FUN_01a2_3d02 | L3d02 | Delay ≈ 0.066 s → `_DELAY 0.066` (same; owns shared RET) | ✅ Done |
| FUN_01a2_3d3b | L3d3b | (unknown — send mail attack?) | ⬜ Todo |
| FUN_01a2_422d | L422d | (unknown) | ⬜ Todo |
| FUN_01a2_4246 | L4246 | (unknown) | ⬜ Todo |
| FUN_01a2_42d5 | L42d5 | (unknown — print attack?) | ⬜ Todo |
| FUN_01a2_5018 | L5018 | (unknown — del *.* attack?) | ⬜ Todo |
| FUN_01a2_50b2 | L50b2 | (unknown) | ⬜ Todo |
| FUN_01a2_5124 | L5124 | (unknown — format attack?) | ⬜ Todo |
| FUN_01a2_56c4 | L56c4 | (unknown — format c: action?) | ⬜ Todo |
| FUN_01a2_61cb | L61cb | (unknown) | ⬜ Todo |
| FUN_01a2_637d | L637d | Al animation draw | ⬜ Todo |
| FUN_01a2_902f | L902f | Error: no target selected (print) | ⬜ Todo |
| FUN_01a2_90ad | L90ad | Error: no target selected (mail) | ⬜ Todo |
| FUN_01a2_90f7 | L90f7 | Error: no target selected (del) | ⬜ Todo |
| FUN_01a2_9170 | L9170 | Win condition check / victory sequence | ⬜ Todo |
| FUN_01a2_9ae7 | L9ae7 | (unknown — win/lose?) | ⬜ Todo |
| FUN_01a2_9c28 | L9c28 | Error: no target selected (format) / loss path | ⬜ Todo |
| FUN_01a2_ae3d | Lae3d | (unknown — Al init?) | ⬜ Todo |
| FUN_01a2_b029 | Lb029 | (unknown) | ⬜ Todo |
| FUN_01a2_b207 | Lb207 | (unknown — game state init?) | ⬜ Todo |
| FUN_01a2_b786 | Lb786 | (unknown — screen setup?) | ⬜ Todo |
| FUN_01a2_bab9 | Lbab9 | Win/lose message screen | ⬜ Todo |
| FUN_01a2_bca2 | Lbca2 | Prompt for start/exit | ⬜ Todo |

---

## Decompilation Methodology

### Session Protocol

Each work session should follow this process:

**Step 1 — Measure progress**
```powershell
.\tools\progress.ps1
```
This shows ASM lines remaining, subroutine completion, and a progress bar.

**Step 2 — Identify the next work target**

Find the first raw ASM block in `lanlokre.bas`:
```powershell
Select-String -Path lanlokre.bas -Pattern '^\s+01a2:[0-9a-f]{4}' | Select-Object -First 1
```
The address on that line tells you which ASM function you're working in.

**Step 3 — Extract the function from the ASM**
```powershell
.\tools\extract_fn.ps1 -FunctionName FUN_01a2_XXXX
```
This prints the complete function body from `lanlok.asm`.

**Step 4 — Translate ASM block to BASIC**

Refer to the **Translation Reference** below. Work through each ASM instruction:
- `CALLF COLOR` → `COLOR r,b` 
- `CALLF LOCATE` → `LOCATE row,col`
- `CALLF PRINT_STR_NEWLINE` → `PRINT "string"`
- Float loads/stores → float variable assignments
- Conditional jumps → `IF ... THEN ... ELSE`
- Loops → `FOR/NEXT` or `WHILE/WEND`
- `CALL FUN_01a2_XXXX` → `GOSUB L_xxxx`
- `RET` → `RETURN`
- `JMP` to beyond function end → `GOTO`

**Step 5 — Replace the ASM block in `lanlokre.bas`**

Locate the raw ASM lines in `lanlokre.bas` that correspond to the function.
Replace them with the translated BASIC. Add a `' --- DONE: FUN_01a2_XXXX ---` marker.

**Step 6 — Update the status table** in `WORK_PLAN.md`.

**Step 7 — Commit progress**
```
git add lanlokre.bas WORK_PLAN.md
git commit -m "Decompile FUN_01a2_XXXX (LabelName): brief description"
```

---

## ASM-to-BASIC Translation Reference

### Calling Conventions

QuickBASIC's compiled code pushes arguments **right-to-left** (Pascal/BASIC convention).
Arguments are pushed with `MOV AX, value / PUSH AX` pairs, then `CALLF` the runtime.

### Runtime Function Map

| ASM CALLF Name | BASIC Statement | Notes |
|----------------|-----------------|-------|
| `CLS` | `CLS n` | AX=mode |
| `COLOR` | `COLOR fg,bg` | pushes: nargs(4), mode(2), bg, fg |
| `LOCATE` | `LOCATE row,col` | pushes: nargs(4), mode(2), col, row |
| `PRINT_string_newline` / `PRINT_STR_NEWLINE` | `PRINT "..."` | DS offset pushed |
| `PRINT_string_semi` / `PRINT_STR_SEMICOLON` | `PRINT "...";` | no newline |
| `PRINT_float_newline` / `PRINT_FLOAT_NEWLINE` | `PRINT x` | DS float words pushed |
| `PRINT_FLOAT_semicolon` | `PRINT x;` | |
| `PRINT_INT` | `PRINT n` | |
| `PRINT_USING` | `PRINT USING fmt$; x` | |
| `LINE` | `LINE (x1,y1)-(x2,y2),color[,style]` | |
| `CIRCLE` | `CIRCLE (x,y),r,color[,...]` | |
| `PAINT` | `PAINT (x,y),fill,border` | |
| `SOUND` | `SOUND freq,duration` | |
| `SCREEN` | `SCREEN mode` | |
| `INKEY$` | `INKEY$` | returns in string var |
| `TIMER` | `TIMER` | returns float in DS; SI = ptr |
| `RANDOMIZE` | `RANDOMIZE TIMER` | |
| `RND` | `RND` | |
| `MID$` | `MID$(s$,start,len)` | |
| `INPUT_LINE` / `LINE INPUT` | `LINE INPUT s$` | |
| `GOSUB_return` / `SET_STRING` | string assignment | |
| `FPCOMPARE_2stack` | FP comparison, sets flags | |
| `Implicit_FP_to_INT` | convert float→int | result in AX |
| `GRAPHICS_setpt1_float` / `GRAPHICS_SETPT1` | sets LINE/PSET/PAINT start point | |
| `GRAPHICS_setpt2_float` / `GRAPHICS_SetPT2` | sets LINE end point | |
| `SUB_0e71_1274` | `PSET (x,y),color` | setpt1 first, then CALLF with color arg |

### Variable Naming Convention

Variables are named by their DS (data segment) offset:
- `Fa_xxxx!` — single-precision float at DS:0x_xxxx  (e.g., `Fa22e!` = float @ DS:0xa22e)
- `Sa_xxxx$` — string at DS:0x_xxxx  (e.g., `Sa242$` = string @ DS:0xa242)
- `Ia_xxxx%` — integer at DS:0x_xxxx  (rarely used directly; often converted from float)

Known named variables:
| Name | DS offset | Meaning |
|------|-----------|---------|
| `Fa246!(i,j)` | a246 | 10×5 computer status array |
| `Fa22e!` | a22e | Current computer X position (for drawing) |
| `Fa232!` | a232 | Current computer Y position (for drawing) |
| `Fa236!` | a236 | Color parameter |
| `Sa242$` | a242 | Key input buffer (INKEY$) |
| `Sa46e$` | a46e | Command input string |
| `Fa46a!` | a46a | Loop counter / FOR variable |
| `Fa466!` | a466 | Loop counter |
| `Fa472!` | a472 | Selected target (0=none, 1-9=computer, 10=Hobbs) |
| `Fa44a!` | a44a | Game end time (TIMER + 300) |
| `Fa44e!` | a44e | |
| `Fa452!` | a452 | |
| `Fa456!` | a456 | Player score |
| `Fa43a!` | a43a | Al's printers unjammed count |
| `Fa43e!` | a43e | Al's computers unlocked count |
| `Fa442!` | a442 | Al's erasures restored count |
| `Fa446!` | a446 | Al's hard disks reconstructed count |
| `Sa436$` | a436 | Player name |
| `Sa432$` | a432 | Computer name string (temp) |
| `Sa42a$` | a42a | All computer names string |
| `F003a!` | 003a | Timer calibration loop counter |
| `F0042!` | 0042 | Timer scale factor |
| `F0046!` | 0046 | Timer factor × 10000 |
| `F004a!` | 004a | Timer factor × 2500 |
| `Fa4a2!` | a4a2 | Delay start time |
| `Fa49e!` | a49e | Delay start time (for L3c57) |

### Float Variable Patterns

```asm
; Load float from DS variable into FP stack:
FLD float ptr [0xXXXX]     →  just reading Fa_xxxx!

; Store FP stack top to DS variable:
FSTP float ptr [0xXXXX]    →  Fa_xxxx! = (expression)

; Float constant from data segment:
FLD float ptr { 1.0 }      →  literal 1.0
FLD float ptr [0xb4XX]     →  literal constant (look up in LANLOKDS.BIN area)

; Integer to float conversion:
CALLF Implicit_FP_to_INT   →  INT() or CInt() — result in AX, then used as integer
```

### Control Flow Patterns

| ASM | BASIC |
|-----|-------|
| `JMP LAB_01a2_XXXX` | `GOTO LXXXX` |
| `JZ / JE` after compare | `IF x = y THEN` |
| `JNZ / JNE` | `IF x <> y THEN` |
| `JC` (carry) after FPCOMPARE | `IF x < y THEN` |
| `JNC` | `IF x >= y THEN` |
| `JA` (above, unsigned) | `IF x > y THEN` |
| `JBE` (below or equal) | `IF x <= y THEN` |
| `JL` | `IF x < y THEN` |
| `CALL FUN_01a2_XXXX` | `GOSUB LXXXX` |
| `RET` | `RETURN` |
| Loop with counter | `FOR/NEXT` or `WHILE/WEND` |

**FPCOMPARE_2stack**: pops 2 values from FP stack, sets CPU flags:
- ZF=1 if equal (→ `JZ`)
- CF=1 if arg1 < arg2 (→ `JC`)
- Neither if arg1 > arg2 (→ `JA`)

### Array Access Pattern

The `Fa246!(i,j)` array is 10 rows × 5 cols of singles (4 bytes each):
```asm
; Accessing Fa246!(Fa466!, column):
FLD [Fa466!]
CALLF Implicit_FP_to_INT  ; AX = INT(Fa466!)
SHL AX,1 / SHL AX,1       ; AX *= 4 (float size)
ADD AX, 0x2c + (col * 4)  ; offset into array row, col=0..4
MOV SI,AX
FLD float ptr [SI + Fa246!] ; loads Fa246!(Fa466!, col)
```
Column offsets from 0x002c base:
- col 0 = +0x002c = Fa246!(i,1)
- col 1 = +0x0030 = Fa246!(i,2)
- col 2 = +0x0034 = Fa246!(i,3) — Y position
- col 3 = +0x0038 = Fa246!(i,4) — X position? (verify)
- col 4 = +0x003c = Fa246!(i,5)

(Row 6-10 have a different base offset: 0x0058)

---

## Testing Strategy

### Level 1 — Progress Metric (always available)
```powershell
.\tools\progress.ps1
```
Output: count of remaining raw ASM lines. Target: 0.

### Level 2 — Syntax Check (requires QB64 installed)
```powershell
& "C:\QB64\qb64pe.exe" -c lanlokre.bas -o lanlokre_test.exe 2>&1
```
A successful compile proves the file is valid BASIC. Errors identify problem spots.
QB64-PE download: https://github.com/QB64-Phoenix-Edition/QB64pe/releases

### Level 3 — Behavioral Comparison (requires DOSBox)
Run the original EXE in DOSBox:
```
dosbox archival/Lanlok.exe
```
Compare gameplay behavior with the compiled QB64 version. Key test cases:
1. Intro sequence plays correctly (logo animation, rules display)
2. Game starts, timer counts down
3. `select` command accepts valid computer names
4. Attack commands (`print`, `send mail`, `del *.*`, `format c:`) work
5. Al repairs computers over time
6. Win condition triggers
7. Loss condition triggers

### Level 4 — String/Constant Verification
Cross-reference string constants from `LANLOKDS.BIN` against literals in the BASIC.
Use the DS offset in ASM (`MOV AX, 0xXXXX / PUSH AX / CALLF PRINT_STR`) to look up
the string at that offset in `LANLOKDS.BIN`.

---

## Work Order

### Recommended Function Order (dependency-based)

Work roughly in this order to maximize runnable code at each step:

**Priority 1 — Complete existing partial functions** (highest ROI)
1. Complete `L2e2d` (computer icon draw) — already partially done
2. Complete ENTRY body remaining ASM blocks (scattered throughout)
3. Complete `L3c90` (delay loop)

**Priority 2 — Short, well-understood functions** (quick wins)
4. `L3c57` — delay/pause loop (similar to L3c90)
5. `L3d02` — (short, look up)
6. `L3cc9` — (short, look up)
7. `L0d85` — continue intro (already partially done as part of ENTRY)

**Priority 3 — Core game mechanic functions**
8. `L3522` — computer status display (called in game loop)
9. `L376f` — Al repair notification
10. `L3a10` — (unknown, called from select/status area)
11. `L3d3b` — send mail attack
12. `L42d5` — print attack
13. `L5018` — del *.* attack
14. `L5124` — format attack sub
15. `L56c4` — format c: action
16. `L637d` — Al animation

**Priority 4 — Support and AI functions**
17. `L19fa` — Al repair loop
18. `L19e9` — (related to Al?)
19. `L145c` — score/status area?
20. `L9170` — win check/victory
21. `L9c28` — loss path / no-target error
22. `L9ae7` — win/lose?

**Priority 5 — Supporting functions**
23. `L422d`, `L4246` — (unknown, check XREF)
24. `L341d`, `L3460`, `L3469` — (unknown)
25. `L3471` — (unknown)
26. `L50b2` — (unknown)
27. `L61cb` — (unknown)
28. `L902f`, `L90ad`, `L90f7` — no-target-selected errors
29. `Lae3d` — Al init
30. `Lb029`, `Lb207`, `Lb786` — game state init, screen setup
31. `Lbab9` — win/lose message screen
32. `Lbca2` — prompt for start/exit

**Priority 6 — Variable renaming pass**
After ALL functions are in BASIC:
- Build a complete variable reference map
- Globally rename `Fa_xxxx!` → meaningful names (e.g., `score!`, `targetX!`)
- Rename `Sa_xxxx$` → meaningful names
- Add comments explaining each section

---

## Progress Tracking

The file `PROGRESS.md` (auto-generated by `tools/progress.ps1`) tracks:
- Lines of raw ASM remaining
- Functions status table (auto-updated by parsing WORK_PLAN.md)
- Last-updated timestamp

Quick manual check:
```powershell
(Select-String -Path lanlokre.bas -Pattern '^\s+01a2:[0-9a-f]{4}').Count
```
Target: reduce this count to 0.

Commit after each completed function with message format:
```
Decompile FUN_01a2_XXXX (LabelName): one-line description
```

---

## Known Constants in Data Segment

Key floating-point constants seen in the ASM, from LANLOKDS.BIN offsets
(segment 1997, so address 1997:0000 maps to the start of LANLOKDS.BIN):

| DS Offset | Value | Used As |
|-----------|-------|---------|
| 0xa550 | (loop increment for timer calibration) | `Fa250!` equiv |
| 0xa554 | 37700.0 | calibration loop count |
| 0xa558 | 0.9902 | timing constant |
| 0xa55c | 10000.0 | `F0046! = 10000 * F0042!` |
| 0xa560 | 2500.0 | `F004a! = 2500 * F0042!` |
| 0xb416..0xb4c6 | various | pixel offsets for drawing |
| 0xa5XX | strings | game text strings |
| 0xa666 | (string) | `` `Evil Al' `` (address 0xa666 — noted with amusement) |

String constants can be looked up by reading LANLOKDS.BIN at (DS_offset - 0xa000) bytes from
the start (since LANLOKDS.BIN is cropped to start at 1997:0000, not at DS start).
Actually: the data segment starts at DS=0x1997, and LANLOKDS.BIN starts at offset 0x0000 of
that segment. So DS offset 0xXXXX maps to byte offset 0xXXXX in LANLOKDS.BIN.
Wait — read RE_NOTES.md: LANLOKDS.BIN is "cropped to align with the start of the data segment
(1997:0000)". So DS:0x0000 = LANLOKDS.BIN[0]. A string at DS:0xa5bc is at byte 0xa5bc in
LANLOKDS.BIN.

---

## Stopping and Restarting

This is designed to be **fully resumable**:

1. Check in whatever is done: `git add -A && git commit -m "WIP: partial decompile of FUN_01a2_XXXX"`
2. Next session: run `.\tools\progress.ps1` to see where things stand
3. Find the next raw ASM block and continue

The raw ASM lines are the marker for "work remaining" — as long as they exist in `lanlokre.bas`,
there is work to do. The number goes only down, never up.

---

## Risks and Mitigations

| Risk | Mitigation |
|------|-----------|
| Misidentify a BASIC construct | Add `' ???` comment and move on; revisit later |
| Data constant lookup fails | Mark with DS offset comment; resolve in renaming pass |
| Control flow is complex | Draw a flow diagram; use intermediate GOTO labels |
| Function has no RETURN (tail-call optimized) | Check next function's XREF list |
| QB64 incompatibilities | Note them; mostly SCREEN 12 graphics should be fine |
| Memory corruption in original (self-modifying code) | Note in comments; unlikely in BASIC |

---

*Last updated: 2026-05-27*

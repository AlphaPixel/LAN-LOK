# CLAUDE.local.md — Local Session Context

This file is for session-specific notes that supplement `CLAUDE.md` and `WORK_PLAN.md`.
Update this file at the end of each work session.

---

## Session Log

### 2026-05-27 — Planning Session
- Created `WORK_PLAN.md`, `CLAUDE.md`, `CLAUDE.local.md`, `tools/progress.ps1`, `tools/extract_fn.ps1`
- Inventoried all 43 named ASM functions + ENTRY
- Established progress metrics (15,456 raw ASM lines remaining as baseline)
- No decompilation work done in this session — planning only

---

## Current Work State

**Next target:** Complete `L2e2d` (FUN_01a2_2e2d) — the computer icon draw routine.
It starts at `lanlokre.bas` around line 572 where BASIC transitions to raw ASM mid-subroutine.
The ASM for this function is at `lanlok.asm` line 5702.

**Baseline progress (2026-05-27):**
- Raw ASM lines in lanlokre.bas: 15,456
- Total lines: 17,890
- BASIC completion estimate: ~25% (functional), ~14% (by line count)

---

## Local Tool Paths (if installed)

```
QB64-PE:   C:\QB64\qb64pe.exe          (not yet installed)
DOSBox:    C:\Program Files\DOSBox\...  (check archival\Lanlok.zip)
```

Update these paths once tools are installed.

---

## Decompilation Notes / Discoveries

### Timer calibration loop (ENTRY, lines 0-8)
- F0042! is the speed-scaling factor: `0.9902 / (TEND! - TSTART!)`
- All delay loops use this factor to normalize for CPU speed
- F003a! is used as the calibration loop variable (counts to 37700)

### `L3c57` vs `L3c90` (both are delay loops)
Both are nearly identical BASIC pause loops. They differ in which "snapshot" variable they save
into (L3c57 uses Fa49e!, L3c90 uses Fa4a2!) and their loop increment. `L3c57` uses `F0042!`
(the base scale factor) and `L3c90` uses the pre-scaled value. Need to verify exact timing.

### `FUN_01a2_637d` = Al animation
Called as `GOSUB L637d` in the BASIC. The XREFs in the ASM (line 7604, 8236+) show it's
called from L3c90's XREF area and from within drawing routines.

### Array `Fa246!(i,j)` layout
- Dim'd as DIM Fa246!(10,5) — 10 computers × 5 attributes
- Row 1-5: top row computers (Y base = 16)
- Row 6-10: bottom row computers (Y base = 127)
- Col 1: computer enabled state (0=OK, nonzero=damaged)
- Col 2: time when Al will fix it (TIMER value)
- Col 3: Y screen position
- Col 4: X screen position
- Col 5: (TBD — damage type?)

### `Sa42a$` layout (computer names)
```
"            lab     labstore    admin     Susi     Calvin    rabbit   library     ratt     Tfive     Hobbs             "
```
Each computer name is padded to 10 characters. Index by `MID$(Sa42a$, 10*n, 10)` for n=1..10.
Computer index 10 = Hobbs (the "boss" machine).

### `Fa472!` = selected target
- 0: SKUA (player's own machine — attacks rejected)
- 1-9: network computers (lab, labstore, admin, Susi, Calvin, rabbit, library, ratt, Tfive)
- 10: Hobbs (special/boss)

---

## Common Patterns to Watch For

```
; Pattern: FP variable assignment from constant
d9 06 XX a5     FLD  float ptr [0xaXXX]    ; push constant from data area
d9 1e XX a4     FSTP float ptr [0xaXXX]    ; store to variable
→ BASIC: FaXXXX! = constant_value

; Pattern: Float comparison → conditional branch
d9 06 (A)       FLD  floatA
d9 06 (B)       FLD  floatB
9a 1d 04 75 0d  CALLF FPCOMPARE_2stack      ; compares top 2, sets flags
77 03           JA   label                 ; if A > B goto label
→ BASIC: IF FaA! > FaB! THEN GOTO Llabel

; Pattern: TIMER read
9a 00 07 71 0e  CALLF TIMER               ; returns SI = ptr to float
8b f0           MOV SI, AX
90              NOP
d9 04           FLD float ptr [SI]         ; push timer value
d9 1e xx xx     FSTP float ptr [varaddr]   ; store to variable
→ BASIC: FaXXXX! = TIMER

; Pattern: SOUND call
b8 dur 00       MOV AX, duration
50              PUSH AX
d9 06 xx xx     FLD float ptr [freq_var]    (or MOV AX,literal; PUSH AX for freq)
...             (push freq)
9a ac 1d 71 0e  CALLF SOUND
→ BASIC: SOUND freq, duration

; Pattern: GOSUB then return
e8 XX XX        CALL FUN_01a2_YYYY
c3              RET
→ BASIC: GOSUB LYYYY\nRETURN
```

---

## Questions / Uncertainties

- [ ] What is `FUN_01a2_19e9`? (appears right before `FUN_01a2_19fa`)
- [ ] What does `FUN_01a2_61cb` do? (large function at line 12237 of ASM)
- [ ] Verify column mapping of `Fa246!(i,j)` — especially cols 1, 2, 5
- [ ] Confirm `FUN_01a2_9ae7` vs `FUN_01a2_9c28` — which is the main loss path?
- [ ] Does the game use any self-modifying code or INT calls beyond timer/FP emulation?
- [ ] What string is at DS:0xa4ca? (used in a PRINT call near end of ENTRY)

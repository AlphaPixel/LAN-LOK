# CLAUDE.local.md — Local Session Context

This file is for session-specific notes that supplement `CLAUDE.md` and `WORK_PLAN.md`.
Update this file at the end of each work session.

---

## Current practices

- Do not commit without asking. When ready to commit, summarize all work and wait for the go-ahead.
- After each substantiative session, record and appeand a thorough summary of the work done since the previous commit in the mini-sprint in PROGRESS_LOG.md
- Something else to watch for - the plan referenced QB64. I tried running what I had in there, and it will hang - the timer calibration doesn't work since QB64 runs too fast. Claude might need to replace the delay loops with specific _delay instructions.

## Session Log

### 2026-05-27 — Planning Session
- Created `WORK_PLAN.md`, `CLAUDE.md`, `CLAUDE.local.md`, `tools/progress.ps1`, `tools/extract_fn.ps1`
- Inventoried all 43 named ASM functions + ENTRY
- Established progress metrics (15,456 raw ASM lines remaining as baseline)
- No decompilation work done in this session — planning only

### 2026-05-27 — Decompilation Session 8: L3d3b (type-1 attack)
- Completed `FUN_01a2_3d3b` + Ghidra stubs `FUN_01a2_422d` + `FUN_01a2_4246` = L3d3b
- Player attack routine: repair-time scheduling, "LAN LOCKED" display, type-1 damage tag,
  5-step fill-flicker animation (black/white×2/yellow), shrinking B-box loop, icon marker
- Key discovery: 5th flicker LINE (yellow) has **no SOUND** — the 4 black/white LINEs do
- Key discovery: LINE calling convention is **left-to-right** (color, style, mode)
- STATUS indicator drawn as: magenta box, black inner box, magenta vertical line, magenta PSET
- **-614 ASM lines** (14,054 → 13,440)
- Confirmed: DS:0xa624 = 3.0 (Fa624! is read-only constant, SOUND 200,3)
- Confirmed: COLOR 2,14 (green on yellow) for "LAN LOCKED" text
- New variable: Fa4ae! = attack/repair time accumulator

### 2026-05-27 — Delay Loop Conversion Pass (all known loops)
- Removed calibration block from ENTRY (TSTART!/TEND!/F0042!/F0046!/F004a! assignments)
- Converted 4 delay subroutines + 1 random lockout to `_DELAY`:
  - L3c57 / L3c90: `_DELAY 0.263` (was F0046!=26405 iters)
  - L3cc9 / L3d02: `_DELAY 0.066` (was F004a!=6601 iters)
  - ENTRY random lockout: `_DELAY (RND(1)+1)*13.132` (was (RND*500000+500000)*F0042! iters, 13–26 s)
- Added mandatory delay conversion policy to CLAUDE.md (⚠️ section)
- Derivation: 37700 iters / 0.375 s = 100,533 iters/sec on original Palmer Station machine
- F0042! cancels algebraically in all formulas — wall-clock seconds need no runtime calibration

### 2026-05-27 — Decompilation Session 5: L3cc9 + L3d02
- Completed `FUN_01a2_3cc9` + `FUN_01a2_3d02` — paired delay loops
- L3cc9 has no RET; falls through into L3d02 which owns the shared RET
- Both loop F003a! from 1 to F004a! (~6601 = 2500 × F0042!); L3cc9 uses Fa4a6! temp, L3d02 uses Fa4aa!
- L3cc9 has 15 callers (L3d3b, L42d5, L56c4); L3d02 has 3 direct callers (L0d53, L56c4)
- **-52 ASM lines** (14,106 → 14,054)
- Confirmed: F004a! ≈ 6601 (≈ 2500 × F0042!), vs F0046! ≈ 26405 (≈ 10000 × F0042!)
- QB64 note: these loops need `_DELAY` conversion like L3c57/L3c90

### 2026-05-27 — Decompilation Session 4: L3a10
- Completed `FUN_01a2_3a10` = L3a10 subroutine (score recalculator + display)
- FOR loop i=1 to 9: checks Fa246!(i,1) damage type, adds 50/100/200/60 to running total
- Hobbs (computer 10) has higher point values: 75/130/400/85 (type 1-4)
- Clamp to ≥0, then LOCATE 4,74 / PRINT 4 spaces (clear) / LOCATE again / PRINT Fa49a!;
- Fa456! = Fa49a! (stores score in the "active score" variable)
- **-247 ASM lines** (14,353 → 14,106)
- Score point values from DS: type1=50 (constant), type2=100 ([0xb47a]), type3=200 ([0xb47e]), type4=60 ([0xb3da])
- Hobbs from DS: type1=75 ([0xb482]), type2=130 ([0xb486]), type3=400 ([0xb3c8]), type4=85 ([0xb48a])
- DS:0xb48e = "    " (4 spaces) used as score field clear string via PRINT_STR_SEMICOLON
- Confirmed: `Fa456!` = active score variable (saved from Fa49a!)
- Confirmed: score display is at column 74 (0x4a), row 4 — scan-line 29 (0x1d) = visible cursor

### 2026-05-27 — Decompilation Session 3: L376f
- Completed `FUN_01a2_376f` = L376f subroutine (Al fixes a computer)
- SOUND 800,2 then SOUND 1200,3 — rising two-tone alert beep
- Reads Fa246!(INT(Fa46a!), 1) = damage type (1-4); increments one of 4 tally counters
- LOCATE 4,44 / PRINT score counter (by damage type) / PRINT "O.K.       "
- Fa246!(INT(Fa46a!), 1) = 0 (clear damage entry)
- GOSUB L3a10 + GOSUB L637d (Al animation)
- LINE fill color 3 (erase icon), then GOSUB L2e2d (redraw clean icon)
- **-272 ASM lines** (14,625 → 14,353)
- Confirmed: SOUND arg order is freq first (integer), then duration (float) — SOUND 800, 2
- Confirmed: JC fires when ST(0) < ST(1) (second pushed < first pushed)
- New variables: Fa46a! (Al's target computer index), Fa496! (damage type temp), Fa43e!/Fa442!/Fa446!/Fa43a! (damage-type tally counters)
- New DS string: 0xb46a = "O.K.       " (11 chars, PRINT_string_newline)
- New runtime: PRINT_float_newline = PRINT; PRINT_string_newline = PRINT "..."

### 2026-05-27 — Decompilation Session 2: L3522
- Completed `FUN_01a2_3522` = L3522 subroutine (computer screen animator)
- 3 LINE calls (screen fill cyan, clear indicator box, screen outline)
- IF/THEN flickering status pixel: dark grey (8) or yellow (14) at 50/50 RND
- WHILE loop: 10 scan-lines of random-length white (color 15) across screen rows y+3 to y+21, step 2
- **-257 ASM lines** (14,882 → 14,625)
- RND pattern confirmed: FLD x / CALLF RND / FLD [SI] → ST(0)=RND(), ST(1)=saved value
- No stub splits; clean single RET at 01a2:376e
- Added .gitattributes to enforce LF line endings repo-wide; silences CRLF warnings

### 2026-05-27 — Decompilation Session 1: L2e2d
- Completed `FUN_01a2_2e2d` (+ split stubs 341d/3460/3469/3471) = L2e2d subroutine
- Computer icon draw routine: 18 LINE calls + 2 PSET calls
- **-574 ASM lines** (15,456 → 14,882)
- Discovered: `SUB_0e71_1274` = PSET runtime function
- Discovered: Ghidra splits single QB subroutines at runtime callback points
- Fixed pre-existing bug: LINE 3 had +35 for pt1.x instead of correct -5
- Added PSET to translation reference in WORK_PLAN.md
- QB64-PE compile attempt launched (will fail on remaining ASM but verifies our BASIC syntax)

---

## Current Work State

**Next target:** `L42d5` (FUN_01a2_42d5) — second attack type (PRINT attack?).
At `lanlokre.bas` line 716, address 01a2:42d5.
Run: `.\tools\extract_fn.ps1 -Address 42d5`

**Progress after session 8 — L3d3b (2026-05-27):**
- Raw ASM lines in lanlokre.bas: 13,440 (85.4% of 15,740)
- Functions done: L2e2d, L3522, L376f, L3a10, L3c57, L3c90, L3cc9, L3d02, L3d3b/422d/4246
- Lines removed this session: 614 (via L3d3b splice)

**Baseline (before any decompilation work):**
- Raw ASM lines: 15,456 (86.1%)
- Total lines: 17,946

---

## Local Tool Paths

```
QB64-PE:   "C:\Program Files\qb64pe"
DOSBox:    "C:\Program Files (x86)\DOSBox-0.74-3\DOSBox.exe"
```

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

## Key Discoveries (2026-05-27)

### `SUB_0e71_1274` = PSET
Called as: `setpt1(x,y)` then `CALLF SUB_0e71_1274(color)`.
BASIC translation: `PSET (x,y), color`
Verified by visual context (drawing pixel indicators on monitor icon).

### Ghidra splits subroutines at QB runtime callback points
`FUN_01a2_341d`, `FUN_01a2_3460`, `FUN_01a2_3469`, `FUN_01a2_3471` are all continuations
of `FUN_01a2_2e2d`. Ghidra splits because the QB runtime calls back into user code at those
addresses. In the .bas file they appear as consecutive raw-ASM blocks, all belonging to the
same GOSUB. Translate as one continuous subroutine body, ending with the first `RET`.

### L2e2d had a pre-existing bug
BASIC line for LINE 3 said `Fa22e!+35` for pt1.x, but ASM uses constant `[0xb3f2]=-5`.
Correct: `LINE (Fa22e!+(-5),Fa232!+41)-(Fa22e!+55,Fa232!+60),0,B`.
Fixed in 2026-05-27 session.

### Constant table for computer icon drawing (b3xx range)
See WORK_PLAN.md for the full constant lookup table. Key:
- `0xa550`=1, `0xa654`=50, `0xa674`=4, `0xa67c`=12, `0xa60c`=15, `0xaf94`=9
- `0xaf70`=16, `0xa6b0`=40, `0xaf80`=6
- `0xb3da`=60, `0xb3e6`=-4, `0xb3ea`=49, `0xb3ee`=34, `0xb3f2`=-5, `0xb3f6`=35
- `0xb3fa`=41, `0xb3fe`=55, `0xb402`=42, `0xb406`=54, `0xb40a`=59, `0xb40e`=28
- `0xb412`=31, `0xb416`=-1, `0xb41a`=47, `0xb41e`=51, `0xb422`=36, `0xb426`=48
- `0xb42a`=45, `0xb42e`=20, `0xb432`=44, `0xb436`=57, `0xb43a`=19, `0xb43e`=43
- `0xb442`=58, `0xb446`=23, `0xb44a`=39, `0xb44e`=26, `0xb452`=52, `0xb456`=24
- `0xb036`=30

---

## Questions / Uncertainties

- [ ] What is `FUN_01a2_19e9`? (appears right before `FUN_01a2_19fa`)
- [ ] What does `FUN_01a2_61cb` do? (large function at line 12237 of ASM)
- [ ] Verify column mapping of `Fa246!(i,j)` — especially cols 1, 2, 5
- [ ] Confirm `FUN_01a2_9ae7` vs `FUN_01a2_9c28` — which is the main loss path?
- [ ] Does the game use any self-modifying code or INT calls beyond timer/FP emulation?
- [ ] What string is at DS:0xa4ca? (used in a PRINT call near end of ENTRY)

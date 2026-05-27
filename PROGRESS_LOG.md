# LAN-LOK Decompilation — Progress Log

This file records decompilation sessions in reverse-chronological order.
Each entry covers one working session: what was attempted, what succeeded, what was discovered,
and what changed in the repo.

---

## Session 10 — 2026-05-27 (L5018: ERASED Attack Subroutine)

### What was done
Completed the full decompilation of `FUN_01a2_5018` (plus its two Ghidra stubs `FUN_01a2_50b2` and
`FUN_01a2_5124`), which together implement the type-2 ERASED disk-wipe attack. All three stubs form one
continuous GOSUB subroutine starting at label `L5018` in `lanlokre.bas`.

### Functions decompiled
- **L5018** = `FUN_01a2_5018` + `FUN_01a2_50b2` + `FUN_01a2_5124` — ERASED (damage type 2)

### Lines changed
- **806 lines replaced** (raw ASM + Ghidra headers) with **42 lines** of BASIC
- Net: **-719 raw ASM lines** (11,926 → 11,207)
- File: 14,174 → 13,410 total lines

### Structure of L5018
1. **Timer/repair-time preamble** (identical pattern to L3d3b / L42d5):
   `IF TIMER > Fa4ae! THEN Fa4ae! = TIMER`
   `Fa4ae! = Fa4ae! + 30 + RND(1) * 15` (30–45 second repair window)
2. **Array stores**: `Fa246!(INT(Fa472!), 2) = Fa4ae!` (repair time), `Fa246!(INT(Fa472!), 1) = 2` (damage type)
3. **Score recalculate**: `GOSUB L3a10`
4. **Header display**: `LOCATE 4, 68, 1, INT(17+Fa472!), 1` / `COLOR 2, 12` / `PRINT "ERASED     "`
5. **Load screen coords**: `Fa232! = Fa246!(INT(Fa472!), 3)` / `Fa22e! = Fa246!(INT(Fa472!), 4)`
6. **4-step flicker animation** using `GOSUB L3c90` (0.263 s per step — the longer delay):
   - Steps 1, 3: `LINE (...), 0, BF` + `SOUND 200, 3` (black fill + sound)
   - Steps 2, 4: `LINE (...), 15, BF` + `SOUND 200, 3` (white fill + sound)
   - Flicker box: `(Fa22e!+6, Fa232!)-(Fa22e!+44, Fa232!+24)` — DS:0xb432=44, DS:0xb456=24
7. **5th step**: `LINE (...), 0, BF` (final black fill, no delay), then `SOUND 100, 12` (~0.66 s)
8. **Red X arm 1** (upper-left to lower-right diagonal band):
   ```
   LINE (Fa22e!, Fa232!-5)-(Fa22e!-5, Fa232!), 4         ' top-left notch
   LINE (Fa22e!-5, Fa232!)-(Fa22e!+50, Fa232!+60), 4     ' main diagonal
   LINE (Fa22e!+50, Fa232!+60)-(Fa22e!+55, Fa232!+55), 4 ' bottom tail
   LINE (Fa22e!+55, Fa232!+55)-(Fa22e!, Fa232!-5), 4     ' close quadrilateral
   PAINT (Fa22e!, Fa232!), 4, 4
   ```
9. **Red X arm 2** (upper-right to lower-left diagonal band):
   ```
   LINE (Fa22e!+50, Fa232!-5)-(Fa22e!+55, Fa232!), 4     ' top-right notch
   LINE (Fa22e!+55, Fa232!)-(Fa22e!, Fa232!+60), 4       ' main diagonal
   LINE (Fa22e!-5, Fa232!+55)-(Fa22e!+50, Fa232!-5), 4  ' close other arm
   PAINT (Fa22e!, Fa232!+55), 4, 4
   PAINT (Fa22e!+50, Fa232!), 4, 4
   ```
10. `RETURN`

### Key discoveries
- **Attack message**: DS:0xb4d6 → len=11, ptr=0xb4da, data=`"ERASED     "` (5 trailing spaces for field-width)
- **COLOR 2, 12** = green text on light-red (color 12) background — unique per attack type:
  - L3d3b (type 1): COLOR 2, 14 (green on yellow)
  - L5018 (type 2): COLOR 2, 12 (green on light-red)
  - L42d5 (type 4): COLOR 2, 9 (green on cyan)
- **Flicker uses L3c90** (0.263 s), not L3cc9 (0.066 s) — type-2 is 4× slower than type-4's flicker
  - L3d3b also used L3c90; L42d5 used L3cc9. The longer flash is more dramatic for "disk wipe"
- **5th step has no delay** — the `SOUND 100, 12` (12 ticks ≈ 0.66 s) provides all pacing after final black fill
- **3 PAINT calls** needed: the X shape has two separate enclosed regions that cannot share a seed point
  - First arm seeded at `(Fa22e!, Fa232!)` — top-left corner of the icon
  - Second arm seeded at `(Fa22e!, Fa232!+55)` and `(Fa22e!+50, Fa232!)` — two points in the other arm
- **No status indicator PSET** unlike L3d3b — the red X completely replaces the icon visual
- **Repair time 30–45 s**: longer than L42d5 (16–31 s), comparable to L3d3b
- **DS lookup confirmed**: 0xb432=44, 0xb456=24 (flicker box), 0xa60c=15 (RND scale for repair time)
- **GRAPHICS_setpt1_float argument order**: (x, y) with x the deeper stack argument (pushed first)

### Files changed
- `lanlokre.bas`: L5018 splice (lines 796–1601 replaced)
- `WORK_PLAN.md`: L5018/50b2/5124 rows marked ✅ Done
- `CLAUDE.local.md`: Session 10 log prepended; Current Work State updated to L56c4

---

## Session 9 — 2026-05-27 (L42d5: PRINTER JAM Attack Subroutine)

### What was done
Completed decompilation of `FUN_01a2_42d5` (L42d5), the PRINTER JAM attack routine. This is
the type-4 damage attack, and it is the largest single function tackled so far — 1,647 raw ASM
lines replaced by 81 lines of BASIC.

### Function structure
1. **Preamble** (identical pattern to all attacks): TIMER check/update for repair scheduling,
   `Fa4ae! += 16 + RND()*15` (repair time 16–31 s), array store to Fa246!(target,2),
   `LOCATE 4,68,1,INT(17+Fa472!),1`, `COLOR 2,9`, `PRINT "PRINTER JAM "`,
   Fa246!(target,1)=4 (damage type), GOSUB L3a10, load Fa232!/Fa22e! from Fa246!(target,3/4).

2. **Printer icon** (7 LINE calls): Cyan body fill, black housing frame, grey top cover,
   black paper-feed slot, dark-grey slot-depth shadow, paper-guide outline, paper-output slot.
   GOSUB L3cc9 (pause) after drawing.

3. **Five paper-feed animation frames**, each as: two LINEs (black outline box + white fill),
   GOSUB L3cc9, then a FOR loop drawing random-width horizontal black "text" lines on the paper:
   - Frame 1: y=2..12, text lines y=3..9 step 2
   - Frame 2: y=12..22, text lines y=11..19 step 2
   - Frame 3: y=22..30 (fill starts 1px higher at y=22, outline at y=23 — original quirk),
     text lines y=21..29 step 2
   - Frame 4: y=30..36, text lines y=31..35 step 2
   - Frame 5: y=36..Fa4b6! (random), text lines y=37..Fa4ba!=Fa4b6!-1 step 2 (WHILE loop)
   Each paper advance is signalled by SOUND 200, 1.

4. **Alarm cascade**: FOR Fa496! = 700 TO 100 STEP -50 → SOUND INT(Fa496!), 1 (13 notes).

5. **Chaos loop**: FOR Fa496! = 1 TO 30 → two RND calls (Fa4b2!=RND*35+10 for x,
   Fa482!=RND*20+3 for y), LINE at random (x,y), SOUND 130, 1. Creates chaotic "paper jam" visual.

### Key technical discoveries

**LINE push order finally confirmed as color → style → mode:**
- The ASM always pushes: (1) color integer, (2) style integer (0xffff=solid), (3) mode (0/1/2)
- 0xffff as style = all 16 bits set = solid line = equivalent to omitting style in QB BASIC
- This unambiguously resolves the ambiguity that had persisted from session 2. The CLAUDE.md
  note saying "left-to-right (first arg pushed first = color)" was correct — mode was listed last
  in that note and is indeed the last (third) push, which is consistent.
- Confirmed by cross-checking: push 3, push 0xffff, push 2 → LINE ..., 3, BF (cyan body fill)

**QB string descriptor format (confirmed):**
- At DS:0xb4ae: 2-byte length=12, 2-byte pointer=0xb4b2, data at 0xb4b2="PRINTER JAM "
- Same pattern seen in earlier sessions; now explicitly verified with binary read.

**Fa246!(i,j) column-major layout confirmed:**
- j=2 (repair time): offset = j×44 = 88 = 0x58 (ADD AX, 0x58 in ASM) ✓
- j=3 (Y pos): offset = 3×44 = 132 = 0x84 ✓
- j=4 (X pos): offset = 4×44 = 176 = 0xb0 ✓

**New DS constants resolved for L42d5:**
- 0xb45e=21, 0xa614=8, 0xb4ca=29, 0xb466=17, 0xa610=18, 0xb412=31, 0xb4ce=37,
  0xb4a6=700, 0xb4d2=-50, 0xb4be=-3, 0xb4c2=-2, 0xb4c6=22

**New variables:**
- Fa4b6! (DS:0xa4b6): random paper height for frame 5 (RND*23+37)
- Fa4ba! (DS:0xa4ba): Fa4b6!-1, upper limit for frame-5 text-line loop
- Fa482! (DS:0xa482): random Y position in the chaos loop (RND*20+3)

### Files changed
- `lanlokre.bas`: lines 714-2361 replaced (1648 raw ASM → 82 BASIC + 1 blank)
- `WORK_PLAN.md`: L42d5 row updated to ✅ Done with description
- `CLAUDE.local.md`: session 9 log entry added, Current Work State updated
- `PROGRESS_LOG.md`: this entry

### Progress metrics
- Raw ASM lines before: 13,440 (85.4% of 15,740 total)
- Raw ASM lines after: 11,926 (84.1% of 14,174 total)
- Net ASM reduction this session: **-1,514 lines**
- Next target: L5018 at lanlokre.bas line 804

---

## Session 8 — 2026-05-27 (L3d3b: Type-1 Attack Subroutine)

### Objective
Decompile `FUN_01a2_3d3b` (+ Ghidra stubs 422d and 4246) = `L3d3b`, the player attack
subroutine for damage-type 1.  Session resumed from summary mid-task; full ASM analysis
was already complete.

### Functions Completed
- **L3d3b** (FUN_01a2_3d3b + FUN_01a2_422d + FUN_01a2_4246 — single BASIC subroutine)

### What L3d3b Does
Player attacks the selected computer (Fa472!). Actions in sequence:
1. **Repair-time scheduling**: Fa4ae! = max(Fa4ae!, TIMER) + 12 + RND()*10 seconds.
   Stores this as Fa246!(INT(Fa472!), 2) — the time when Al will fix the machine.
2. **Status notification**: LOCATE row 4, col 68 (adjusted by target index); COLOR 2,14;
   PRINT "LAN LOCKED " to the score/status line.
3. **Damage tagging**: Fa246!(INT(Fa472!), 1) = 1 (type-1 attack).  Calls GOSUB L3a10
   to recalculate and redisplay the total score.
4. **Attack animation** (uses Fa232!/Fa22e! = target Y/X loaded from array col 3/4):
   - 5-step fill flicker: 0→15→0→15→14 (black/white/black/white/yellow), each with
     SOUND 200,3 and GOSUB L3cc9; the 5th step (yellow) has NO preceding SOUND.
   - Shrinking box outline FOR loop (i=0 to 18): draws inward-collapsing black B-mode
     rectangles with descending SOUND from 700 Hz to 160 Hz at 1 duration each.
5. **Locked-state icon marker** (drawn in magenta, color 13):
   - LINE box outline (+21..+30, +4..+14) in magenta
   - LINE box outline (+21..+26, +8..+14) in black (partial black box inside)
   - LINE vertical (+26, +14..+18) in magenta
   - PSET (+26, +21) in magenta
   - SOUND 100, 12 (low confirmation tone)
   - RETURN

### ASM Lines Removed
- **-614 raw ASM lines** (14,054 → 13,440)
- Stubs involved: FUN_01a2_3d3b (677 ASM lines), FUN_01a2_422d (22), FUN_01a2_4246 (72)
  → replaced by 39 BASIC lines

### Discoveries
- **5th flicker LINE has no SOUND**: The pattern black/white/black/white/yellow alternates
  SOUND+GOSUB for the first four, but the 5th (yellow) only has GOSUB L3cc9 — no SOUND.
- **LINE calling convention confirmed** (left-to-right): push color, push style (-1=solid),
  push mode (0=line, 1=B, 2=BF).  Different from LOCATE/COLOR which are right-to-left.
- **DS:0xa624 = 3.0** (Fa624! is a constant — not written anywhere found, only read).
- **COLOR 2, 14**: "LAN LOCKED" text is green-on-yellow.
- **SOUND 100, 12**: 12 units of 100Hz tone marks the "locked" confirmation.

### Progress Totals (cumulative)
- Raw ASM lines: 13,440 (85.4% of 15,740 total lines)
- Lines removed this session: 614
- Lines removed all sessions: 2,016

---

## Session 7 — 2026-05-27 (QB64 Delay Loop Conversion Pass)

### Objective
Convert all calibrated FOR-loop delays to wall-clock `_DELAY` equivalents, and codify
the conversion policy as a mandatory directive in CLAUDE.md.

### Why This Was Needed
QuickBASIC's timing system: startup calibration measures CPU speed (37700-iteration loop via
TIMER), then all delays are `FOR F003a! = 1 TO (calibrated_limit) : NEXT F003a!`.
On a 1991 Palmer Station machine: 37700 iters took ~0.375 s → 100,533 iters/sec.
QB64 on modern hardware: calibration loop runs in microseconds → limits become astronomical
→ game hangs on the first pause.

### Changes Made

**1. Calibration block removed (ENTRY, line 2):**
```basic
' Removed:
TSTART!=TIMER
FOR F003a!=1 to 37700:NEXT F003a!
TEND!=TIMER
F0042! = .9902 / (TEND!-TSTART!)
F0046! = 10000 * F0042!
F004a! = 2500 * F0042!
' Replaced with comment explaining the removal.
```

**2. Random computer-lockout delay converted (ENTRY ~line 449):**
```basic
' Was: Fa47a! = (RND*500000+500000)*F0042! / Fa47e!=Fa47a! / FOR Fa482!=1 TO Fa47e!...
' Now:
_DELAY (RND(1) + 1) * 13.132  ' lockout 13–26 s
```
Formula: (RND+1) × 500000 × 0.9902 / 37700 = (RND+1) × 13.132 s

**3. L3c57 / L3c90 converted:**
```basic
L3c57: _DELAY 0.263   ' was F0046!=26405 iters = 26405/100533 = 0.263 s
L3c90: _DELAY 0.263
RETURN
```

**4. L3cc9 / L3d02 converted:**
```basic
L3cc9: _DELAY 0.066   ' was F004a!=6601 iters = 6601/100533 = 0.066 s
L3d02: _DELAY 0.066
RETURN
```

### Directive Added to CLAUDE.md
New mandatory section "⚠️ MANDATORY: Delay Loop Conversion Policy" with:
- ASM signature for recognising calibrated delay loops
- Conversion formula and lookup table for all known limit variables
- Mandatory replacement pattern (never emit a calibrated FOR loop literally)
- List of already-converted loops (do not re-convert)

### Timing Derivation
| Variable | DS value | Duration | Derivation |
|----------|----------|----------|------------|
| `F0042!` | 2.6405 | — | speed factor; cancels algebraically |
| `F0046!` | 26405 | 0.263 s | 26405 / 100533 |
| `F004a!` |  6601 | 0.066 s |  6601 / 100533 |
| lockout  | varies | 13–26 s | (RND+1)×500000×0.9902/37700 |

### Files Changed
- `lanlokre.bas` — calibration block, 4 delay loops, 1 random-lockout delay converted
- `CLAUDE.md` — mandatory delay-loop conversion directive added
- `WORK_PLAN.md` — L3c57/L3c90 marked ✅ Done with conversion notes
- `PROGRESS.md` — regenerated

### Progress Delta
- Total lines: 16,404 → 16,394 (−10, replacements are shorter)
- Raw ASM lines unchanged at 14,054 (conversions were all in existing BASIC sections)
- Functions: done=13 (L3c57 and L3c90 now counted as complete)
- Next target: L3d3b (FUN_01a2_3d3b) at lanlokre.bas line 683, address 01a2:3d3b

---

## Session 6 — 2026-05-27 (Decompilation: L3cc9 + L3d02)

### Target
`FUN_01a2_3cc9` (L3cc9) and `FUN_01a2_3d02` (L3d02) — a pair of calibrated delay loops.

### What Was Decompiled

**L3cc9 + L3d02: Paired delay loops** (lanlokre.bas lines 673–683)

```basic
' Delay loop: F003a! from 1 to F004a! (~6601 calibrated iters); falls through to L3d02
L3cc9:
Fa4a6! = F004a!
FOR F003a! = 1 TO Fa4a6!
NEXT F003a!
' Second delay loop (same limit, stored in Fa4aa!); shared RET covers both fall-through calls
L3d02:
Fa4aa! = F004a!
FOR F003a! = 1 TO Fa4aa!
NEXT F003a!
RETURN
```

### Technical Notes

**Fall-through pattern:** L3cc9 has NO RET — its JBE loop exits and execution falls straight
into L3d02 at address 3d02. L3d02's RET at 3d3a serves both. In BASIC: both labels share
the same RETURN. When GOSUB L3cc9 is called, both loops run (total ~13202 iterations).
When GOSUB L3d02 is called directly, only the second loop runs (~6601 iterations).

**F004a! = 6601.3:** DS:0x4a holds ~6601 (a calibrated value = ~2500 × F0042! speed factor).
Compare: F0046! ≈ 26405 = 10000 × F0042! (used in L3c57/L3c90, 4× longer delay).

**15 callers of L3cc9** (from L3d3b × 5, L42d5 × 6, L56c4 × 3) confirms this is a heavily
used short delay. 3 callers of L3d02 independently (from L0d53 × 2, L56c4 × 1).

**QB64 note:** Like L3c57/L3c90, these FOR loops will spin too fast in QB64. Should be
converted to `_DELAY` equivalents in a QB64 compatibility pass.

### Files Changed
- `lanlokre.bas` — L3cc9+L3d02 ASM (88 lines) replaced with 11-line BASIC pair
- `WORK_PLAN.md` — L3cc9 and L3d02 marked ✅ Done
- `PROGRESS.md` — regenerated

### Progress Delta
- Before: 14,106 raw ASM lines (85.6%), 16,481 total
- After:  14,054 raw ASM lines (85.7%), 16,404 total
- Removed: **52 raw ASM lines** (88 raw replaced by 11 BASIC = net -77 total lines)
- Next target: L3d3b (FUN_01a2_3d3b) at lanlokre.bas line 693, address 01a2:3d3b

---

## Session 5 — 2026-05-27 (Decompilation: L3a10)

### Target
`FUN_01a2_3a10` (L3a10) — damage score recalculator and display.

### What Was Decompiled

**L3a10: Score Recalculator** (lanlokre.bas lines 642–663)

```basic
' Recalculate total damage score and display it
L3a10:
Fa49a! = 0
FOR Fa492! = 1 TO 9
    IF Fa246!(Fa492!, 1) = 1 THEN Fa49a! = Fa49a! + 50
    IF Fa246!(Fa492!, 1) = 2 THEN Fa49a! = Fa49a! + 100
    IF Fa246!(Fa492!, 1) = 3 THEN Fa49a! = Fa49a! + 200
    IF Fa246!(Fa492!, 1) = 4 THEN Fa49a! = Fa49a! + 60
NEXT Fa492!
' Hobbs (computer 10) scores at higher values
IF Fa246!(10, 1) = 1 THEN Fa49a! = Fa49a! + 75
IF Fa246!(10, 1) = 2 THEN Fa49a! = Fa49a! + 130
IF Fa246!(10, 1) = 3 THEN Fa49a! = Fa49a! + 400
IF Fa246!(10, 1) = 4 THEN Fa49a! = Fa49a! + 85
IF Fa49a! < 0 THEN Fa49a! = 0
LOCATE 4, 74, 1, 29, 1
COLOR 2, 13
PRINT "    ";
LOCATE 4, 74, 1, 29, 1
PRINT Fa49a!;
Fa456! = Fa49a!
RETURN
```

### Technical Notes

**Score system revealed:** L3a10 is the central score accumulator. It loops over all 9 regular
computers, adding points per damage type:
- Type 1 (unknown): 50 pts
- Type 2 (unknown): 100 pts  
- Type 3 (unknown): 200 pts
- Type 4 (unknown): 60 pts

Hobbs (computer 10, the admin/boss machine) uses higher multipliers from a separate block:
- Type 1: 75 pts / Type 2: 130 pts / Type 3: 400 pts / Type 4: 85 pts

Score is clamped to ≥ 0. Displayed at LOCATE 4,74 (column 74 = far right of screen, row 4 = status bar).
The display first PRINTs 4 spaces to clear the old value, then re-LOCATEs and PRINTs the new value.

**Array access pattern confirmed:** Fa246!(Fa492!, 1) uses column-major addressing:
`SI = INT(Fa492!)*4 + 0x2c` (where 0x2c = 44 = j=1's offset from base 0xa246).
For Fa492!=1: SI=48 → DS:0xa276. For Fa492!=9: SI=80 → DS:0xa296.
Hobbs (i=10, j=1) directly accesses DS:0xa29a (hardcoded address, not through the loop).

**New DS constants discovered:**
| DS offset | Value | Role |
|-----------|-------|------|
| 0xb47a | 100.0 | Type 2 pts (regular computers) |
| 0xb47e | 200.0 | Type 3 pts (regular computers) |
| 0xb482 | 75.0  | Type 1 pts (Hobbs) |
| 0xb486 | 130.0 | Type 2 pts (Hobbs) |
| 0xb3c8 | 400.0 | Type 3 pts (Hobbs) |
| 0xb48a | 85.0  | Type 4 pts (Hobbs) |
| 0xb48e | str "    " (4 spaces, len=4) | Score field clear string |

**FOR loop structure:** The compiled QuickBASIC FOR loop uses an unusual pattern in the ASM:
initial value pushed on FPU, then JMP to the "increment+test" block (LAB_3b16). On first
entry this stores the initial value and tests it; on subsequent entries it increments first,
then tests. The loop body then runs if counter ≤ limit.

### Files Changed
- `lanlokre.bas` — L3a10 ASM block (298 lines) replaced with 23-line BASIC subroutine
- `WORK_PLAN.md` — L3a10 marked ✅ Done, Current State table updated
- `PROGRESS.md` — regenerated

### Progress Delta
- Before: 14,353 raw ASM lines (85.7%), 16,756 total lines
- After:  14,106 raw ASM lines (85.6%), 16,481 total lines
- Removed: **247 raw ASM lines** (298 raw replaced by 23 BASIC = net -275 total lines)
- Next target: L3cc9 (FUN_01a2_3cc9) at lanlokre.bas line 695, address 01a2:3cc9

---

## Session 2 — 2026-05-27 (Planning + Decompilation: L2e2d)

### Summary
Two sessions run back-to-back on 2026-05-27: one planning/setup session and one decompilation
session focused on `FUN_01a2_2e2d` (the computer icon drawing subroutine).

---

### Part A — Planning & Infrastructure

#### Goals
Set up the project for repeatable, unattended, token-efficient decompilation sessions with
measurable incremental progress.

#### Files Created
- **`WORK_PLAN.md`** — Master plan: function inventory (43 functions + ENTRY), translation
  reference (ASM patterns → BASIC), variable map (DS address → BASIC name), session protocol.
- **`CLAUDE.md`** — AI session context: project summary, quick-start commands, key conventions,
  safety rules, commit format.
- **`CLAUDE.local.md`** — Local/private context: session log, tool paths (QB64-PE, DOSBox),
  decompilation notes, discovered patterns.
- **`tools/progress.ps1`** — Progress tracker: counts raw-ASM vs BASIC lines in `lanlokre.bas`,
  reports metrics, optionally regenerates `PROGRESS.md`.
- **`tools/extract_fn.ps1`** — ASM extractor: given a function name or code address, prints
  the complete function body from `lanlok.asm`. Address mode finds the enclosing function.

#### Baseline Metrics (before any decompilation)
| Metric | Value |
|--------|-------|
| Total lines in lanlokre.bas | 17,946 |
| Raw ASM lines | 15,456 (86.1%) |
| BASIC lines | 490 (2.7%) |
| Functions done | 0 |

#### Key Decisions
- Progress metric = ratio of lines NOT matching `^\s+01a2:[0-9a-f]{4}` (raw ASM pattern)
- Variable naming: `Fa_xxxx!` for float at DS:0xaxxx, `Sa_xxxx$` for string at DS:0xaxxx
- Subroutine labels: `L_xxxx:` in BASIC corresponds to `FUN_01a2_xxxx` in Ghidra ASM
- Work order: game-loop functions first (highest payoff / most cross-references)

---

### Part B — Decompilation: L2e2d (Computer Icon Drawing Subroutine)

#### Target
`FUN_01a2_2e2d` — draws a single computer icon on the network map screen.
- Location in lanlokre.bas: lines 565–1212 (648 lines of raw ASM)
- Location in lanlok.asm: lines 5702–6610 (909 lines)
- Called from: main game loop / network display routine

#### Ghidra Stub Splitting — Key Discovery
Ghidra split what is actually one QB subroutine into five stubs:
`FUN_01a2_2e2d`, `FUN_01a2_341d`, `FUN_01a2_3460`, `FUN_01a2_3469`, `FUN_01a2_3471`.

These appear as five consecutive raw-ASM blocks in `lanlokre.bas`. They are all part of the
same `GOSUB L2e2d … RETURN` — Ghidra splits at QB runtime callback points (the QB runtime
calls back into user code at those addresses, so Ghidra treats them as function entry points).
**Rule**: translate all consecutive stubs as one unified BASIC subroutine body ending at the
first `RET`.

#### Float Constant Resolution via LANLOKDS.BIN
DS-segment offsets referenced in the ASM as `FLD float ptr [0xbXXX]` are constant pixel
offsets baked into the code. They live in `LANLOKDS.BIN` as IEEE 754 little-endian singles:

```powershell
$bin = [System.IO.File]::ReadAllBytes("LANLOKDS.BIN")
[System.BitConverter]::ToSingle($bin, 0xb3f2)   # e.g., → -5.0
```

Full constant table resolved for L2e2d (b3xx / a5xx / a6xx / afxx ranges):

| DS offset | Value | DS offset | Value | DS offset | Value |
|-----------|-------|-----------|-------|-----------|-------|
| 0xa550    | 1     | 0xa654    | 50    | 0xa674    | 4     |
| 0xa67c    | 12    | 0xa60c    | 15    | 0xaf94    | 9     |
| 0xaf70    | 16    | 0xa6b0    | 40    | 0xaf80    | 6     |
| 0xb3da    | 60    | 0xb3e6    | -4    | 0xb3ea    | 49    |
| 0xb3ee    | 34    | 0xb3f2    | -5    | 0xb3f6    | 35    |
| 0xb3fa    | 41    | 0xb3fe    | 55    | 0xb402    | 42    |
| 0xb406    | 54    | 0xb40a    | 59    | 0xb40e    | 28    |
| 0xb412    | 31    | 0xb416    | -1    | 0xb41a    | 47    |
| 0xb41e    | 51    | 0xb422    | 36    | 0xb426    | 48    |
| 0xb42a    | 45    | 0xb42e    | 20    | 0xb432    | 44    |
| 0xb436    | 57    | 0xb43a    | 19    | 0xb43e    | 43    |
| 0xb442    | 58    | 0xb446    | 23    | 0xb44a    | 39    |
| 0xb44e    | 26    | 0xb452    | 52    | 0xb456    | 24    |
| 0xb036    | 30    |           |       |           |       |

#### SUB_0e71_1274 = PSET — Key Discovery
Pattern observed:
```asm
; set point 1 (x, y)
CALLF GRAPHICS_setpt1_float
; then immediately:
CALLF SUB_0e71_1274    ; with a single color argument
```
This is the QB `PSET (x, y), color` call. The QB runtime PSET function is `SUB_0e71_1274`.
BASIC translation: `PSET (x, y), color`

#### Pre-existing Bug Fixed
LINE 3 in the partial hand decompilation had:
```basic
LINE (Fa22e!+35,Fa232!+41)-(Fa22e!+55,Fa232!+60),0,B   ' WRONG: +35 for pt1.x
```
DS:0xb3f2 = -5.0, not 35. Corrected to:
```basic
LINE (Fa22e!+(-5),Fa232!+41)-(Fa22e!+55,Fa232!+60),0,B  ' FIXED
```

#### Decompiled BASIC (final, verified)
```basic
' Display a computer icon
L2e2d:
' --- Monitor body and outline ---
LINE (Fa22e!+1,Fa232!+(-4))-(Fa22e!+49,Fa232!+34),7,BF        ' Monitor body (gray fill)
LINE (Fa22e!,Fa232!+(-5))-(Fa22e!+50,Fa232!+35),0,B            ' Monitor outline
' --- Base / stand ---
LINE (Fa22e!+(-5),Fa232!+41)-(Fa22e!+55,Fa232!+60),0,B         ' Base outline
LINE (Fa22e!+(-4),Fa232!+42)-(Fa22e!+54,Fa232!+59),7,BF        ' Base fill (gray)
' --- Front panel detail ---
LINE (Fa22e!+4,Fa232!+28)-(Fa22e!+12,Fa232!+31),0,B            ' Keyboard slot
LINE (Fa22e!+(-1),Fa232!+47)-(Fa22e!+9,Fa232!+51),0,B          ' Drive bay outline
' --- Lower trim / floppy drive bay ---
LINE (Fa22e!+15,Fa232!+35)-(Fa22e!+35,Fa232!+41),0,B           ' Drive bay frame outline
LINE (Fa22e!+16,Fa232!+36)-(Fa22e!+34,Fa232!+40),7,BF          ' Drive bay frame fill (gray)
' --- Power light box (right side of base) ---
LINE (Fa22e!+47,Fa232!+48)-(Fa22e!+50,Fa232!+51),0,BF          ' Power light box
PSET (Fa22e!+45,Fa232!+49),10                                   ' Power indicator (bright green)
' --- Disk drive area ---
LINE (Fa22e!+20,Fa232!+44)-(Fa22e!+42,Fa232!+57),8,BF          ' Drive area fill (dark gray)
LINE (Fa22e!+19,Fa232!+43)-(Fa22e!+43,Fa232!+58),0,B           ' Drive area outline
LINE (Fa22e!+23,Fa232!+47)-(Fa22e!+39,Fa232!+48),0,BF          ' Drive slot 1
LINE (Fa22e!+26,Fa232!+51)-(Fa22e!+36,Fa232!+52),0,BF          ' Drive slot 2
' --- Screen area ---
LINE (Fa22e!+6,Fa232!)-(Fa22e!+44,Fa232!+24),Fa22a!,BF         ' Screen content (color=Fa22a!)
LINE (Fa22e!+41,Fa232!+28)-(Fa22e!+44,Fa232!+31),0,BF          ' Screen indicator box
PSET (Fa22e!+39,Fa232!+30),14                                   ' Screen indicator (yellow)
LINE (Fa22e!+6,Fa232!)-(Fa22e!+44,Fa232!+24),0,B               ' Screen outline
RETURN
```

#### Variables Used in L2e2d
| Variable | DS offset | Meaning |
|----------|-----------|---------|
| `Fa22e!` | 0xa22e    | Icon X position (drawX) |
| `Fa232!` | 0xa232    | Icon Y position (drawY) |
| `Fa22a!` | 0xa22a    | Screen fill color (changes with computer status) |

#### Replacement Mechanics
The 641-line raw-ASM block was too large for the Edit tool's exact-string-match approach.
Used PowerShell array splicing to perform the replacement:
```powershell
$lines  = Get-Content lanlokre.bas
$before = $lines[0..564]        # lines before the block
$after  = $lines[1212..($lines.Count-1)]  # lines after the block
$newLines = $before + $newBasic + $after
[System.IO.File]::WriteAllLines("lanlokre.bas", $newLines, [Text.Encoding]::ASCII)
```

#### QB64-PE Syntax Verification
A minimal test program `test_l2e2d.bas` was created to compile just the L2e2d BASIC in
isolation. Two compile errors encountered and fixed:

1. **UTF-8 BOM**: `Out-File -Encoding utf8` in PowerShell 5.1 writes a BOM that QB64-PE
   rejects. Fix: use `[System.IO.File]::WriteAllText(path, content, [Text.Encoding]::ASCII)`.

2. **DIM type suffix + AS clause**: `DIM Fa22e! AS SINGLE` is invalid in QB64-PE — you
   cannot combine the `!` type suffix with `AS SINGLE`. Fix: use `DIM Fa22e!, Fa232!, Fa22a!`
   (suffix only, no AS clause).

Final compile result: **exit code 0** — syntax verified.

#### Net Result
| Metric | Before | After | Delta |
|--------|--------|-------|-------|
| Total lines | 17,946 | 17,326 | -620 |
| Raw ASM lines | 15,456 | 14,882 | **-574** |
| BASIC lines | 490 | 2,444 | +1,954 |
| % done | 13.9% | 14.1% | +0.2% |
| Functions done | 0 | 1 | +1 |

*(Line counts differ from raw delta because blanks/comments were also rationalized.)*

---

### Files Changed (Not Yet Committed)

| File | Status | Description |
|------|--------|-------------|
| `lanlokre.bas` | Modified | L2e2d ASM block replaced with verified BASIC |
| `WORK_PLAN.md` | Modified | L2e2d marked Done; PSET runtime entry added |
| `CLAUDE.local.md` | Modified | Session log, discoveries, next target added |
| `PROGRESS.md` | Modified | Auto-regenerated progress snapshot |
| `test_l2e2d.bas` | Untracked | Minimal QB64 syntax test for L2e2d |

### Proposed Commit Message
```
Decompile L2e2d: computer icon subroutine (641 ASM → 28 BASIC lines)

Co-Authored-By: Claude Sonnet 4.6 <operated by xenon at alphapixel.com>
```

---

### Next Target: L3522 (FUN_01a2_3522)

- **Role**: Computer status display — draws status indicators for each machine on the network
  map. Called from the main game loop.
- **Location in lanlokre.bas**: line 603, address 01a2:3522
- **Extract command**: `.\tools\extract_fn.ps1 -Address 3522`

---

*Log entry written 2026-05-27. *

---

## Session 3 — 2026-05-27 (Decompilation: L3522 + housekeeping)

### Target: FUN_01a2_3522 — Computer Screen Animator

- **Location in lanlokre.bas**: lines 593–884 (292 raw ASM lines + 10-line Ghidra header)
- **Location in lanlok.asm**: lines 6614–6905
- **Called from**: FUN_01a2_19fa (game loop, twice) and FUN_01a2_bab9
- **No Ghidra stub splits** — single clean `RET` at 01a2:376e

#### What L3522 Does
Called each time the game needs to animate a computer's screen. Uses the same `Fa22e!` / `Fa232!`
coordinate variables as L2e2d but draws a live "active" overlay rather than the static icon.

**Phase 1 — Redraw screen area:**
```basic
LINE (Fa22e!+6,Fa232!)-(Fa22e!+44,Fa232!+24),9,BF     ' Screen fill (cyan/9)
LINE (Fa22e!+41,Fa232!+28)-(Fa22e!+44,Fa232!+31),0,BF  ' Clear indicator box
LINE (Fa22e!+6,Fa232!)-(Fa22e!+44,Fa232!+24),0,B        ' Screen outline
```

**Phase 2 — Flickering status pixel:**
```basic
IF RND(1) > 0.5 THEN Fa236! = 8 ELSE Fa236! = 14
PSET (Fa22e!+36,Fa232!+54),Fa236!   ' Activity indicator in drive area
```
50/50 chance of dark grey (8) vs yellow (14) each frame — simulates a blinking LED.

**Phase 3 — Scan-line animation (WHILE loop):**
```basic
Fa48e! = Fa232! + 21     ' upper y bound
Fa226! = Fa232! + 3      ' starting y (top of screen content area)
WHILE Fa226! <= Fa48e!
    Fa492! = RND(1) * 32 + 9
    LINE (Fa22e!+9,Fa226!)-(Fa22e!+Fa492!,Fa226!),15
    Fa226! = Fa226! + 2
WEND
```
Draws 10 random-length white horizontal lines (min 9 px, max 41 px) at every other row
across the screen area (y+3 to y+21 inclusive), simulating a CRT scan / data activity.

#### ASM Loop Structure
The WHILE loop uses a "init-then-check" pattern:
- Initial value computed, pushed to FPU, then `JMP LAB_3751` (the check)
- `LAB_3751`: FSTP stores to Fa226!, then tests Fa226! vs Fa48e!
- `JA` exits when Fa226! > Fa48e!; otherwise continues to `LAB_36da` (body)
- Body ends: FLD Fa226!+2, falls into LAB_3751 — this is the increment

#### New Constants Resolved
| DS offset | Value | Role |
|-----------|-------|------|
| `0xa618`  | 0.5   | RND() comparison threshold |
| `0xa614`  | 8.0   | Dark-grey colour value |
| `0xb45a`  | 14.0  | Yellow colour value |
| `0xb45e`  | 21.0  | Scan-line loop y upper-bound offset |
| `0xa624`  | 3.0   | Scan-line loop y start offset |
| `0xb462`  | 32.0  | Scan-line random-length multiplier |
| `0xa6b4`  | 2.0   | Scan-line y step |

#### RND Pattern Confirmed
```asm
FLD  [threshold]        ; save threshold on FPU ST(0)
CALLF RND               ; AX = ptr to RND() result (does not consume FPU stack)
MOV  SI,AX
FLD  float ptr [SI]     ; ST(0)=RND(), ST(1)=threshold
CALLF FPCOMPARE_2stack  ; JA fires when ST(0) > ST(1), i.e. RND() > threshold
```
BASIC: `IF RND(1) > threshold THEN ... ELSE ...`

#### Housekeeping Committed Alongside
- **`.gitattributes`** added: all text files (`.bas`, `.asm`, `.ps1`, `.md`) enforced as LF.
  Silences the "LF will be replaced by CRLF" git warnings permanently.

#### Net Result
| Metric | Before | After | Delta |
|--------|--------|-------|-------|
| Total lines | 17,326 | 17,053 | -273 |
| Raw ASM lines | 14,882 | 14,625 | **-257** |
| % done | 14.1% | 14.2% | +0.1% |
| Functions done | 1 | 2 | +1 |

#### QB64 Timing Issue (User-Reported)
QB64 runs too fast for the original timer calibration loop (ENTRY function).
The game hangs at startup. **When decompiling delay loops** (`L3c57`, `L3c90`, ENTRY),
the `FOR/NEXT` busy-wait loops must be replaced with QB64's `_DELAY seconds` built-in.
The calibration code (`F0042! = 0.9902 / (TEND! - TSTART!)`) will likely produce
a near-zero or incorrect scale factor, breaking all timed events.
Strategy: detect delay-loop functions and emit `_DELAY` instead of busy-wait.

### Files Changed This Session
| File | Change |
|------|--------|
| `lanlokre.bas` | L3522 ASM (292 lines + header) → 19 lines BASIC |
| `WORK_PLAN.md` | L3522 marked ✅ Done |
| `CLAUDE.local.md` | Session 2 log added, current state updated, QB64 timing noted |
| `PROGRESS.md` | Regenerated |
| `.gitattributes` | Created (LF enforcement) |
| `PROGRESS_LOG.md` | This entry |

### Next Target: L376f (FUN_01a2_376f)
- **Role**: Unknown — possibly Al-fix notification (adjacent to L3522, called from similar context)
- **Location**: lanlokre.bas line ~620, address 01a2:376f
- **Extract command**: `.\tools\extract_fn.ps1 -Address 376f`

---

*Log entry written 2026-05-27.*

---

## Session 4 — 2026-05-27 (Decompilation: L376f)

### Target: FUN_01a2_376f — Al Fixes a Computer

- **Location in lanlokre.bas**: lines 612–938 (327 raw ASM lines including Ghidra header)
- **Location in lanlok.asm**: lines 6906–7232
- **Called from**: FUN_01a2_19fa (game loop, 01a2:1fad) and FUN_01a2_bab9 (01a2:bbbc)
- **No Ghidra stub splits** — single clean `RET` at 01a2:3a0f

#### What L376f Does
This is the handler invoked when Al (the automated repair character) finishes fixing a damaged
computer on the network. Full sequence:

1. **Rising two-tone alert** — `SOUND 800, 2` then `SOUND 1200, 3`
2. **Read damage type** — `Fa496! = Fa246!(INT(Fa46a!), 1)` (column 1 of the computer array holds damage type 1–4, or 0=OK)
3. **Tally counters** — Four independent IF tests increment `Fa43e!`, `Fa442!`, `Fa446!`, `Fa43a!` based on which damage type was just fixed
4. **Score display** — `LOCATE 4, 44` then `COLOR 2, 13` then `PRINT` the matching tally
5. **OK label** — `LOCATE 4, 68`, `COLOR 2, 2`, `PRINT "O.K.       "`
6. **Clear damage** — `Fa246!(INT(Fa46a!), 1) = 0` marks the computer as repaired
7. **Al animation** — `GOSUB L3a10` then `GOSUB L637d`
8. **Erase + redraw icon** — `LINE (Fa22e!+(-5),Fa232!+(-5))-(Fa22e!+55,Fa232!+60),3,BF` (fill with dark cyan) then `GOSUB L2e2d` (redraw clean icon)

#### Decompiled BASIC (final)
```basic
L376f:
SOUND 800, 2
SOUND 1200, 3
Fa496! = Fa246!(INT(Fa46a!), 1)
IF Fa496! = 1 THEN Fa43e! = Fa43e! + 1
IF Fa496! = 2 THEN Fa442! = Fa442! + 1
IF Fa496! = 3 THEN Fa446! = Fa446! + 1
IF Fa496! = 4 THEN Fa43a! = Fa43a! + 1
IF Fa496! < 4 THEN
    LOCATE 4, 44, 1, INT(18 + Fa46a!), 1
ELSE
    LOCATE 4, 44, 1, 18, 1
END IF
COLOR 2, 13
IF Fa496! = 1 THEN PRINT Fa43e!
IF Fa496! = 2 THEN PRINT Fa442!
IF Fa496! = 3 THEN PRINT Fa446!
IF Fa496! = 4 THEN PRINT Fa43a!
LOCATE 4, 68, 1, INT(17 + Fa46a!), 1
COLOR 2, 2
PRINT "O.K.       "
Fa246!(INT(Fa46a!), 1) = 0
GOSUB L3a10
GOSUB L637d
LINE (Fa22e!+(-5),Fa232!+(-5))-(Fa22e!+55,Fa232!+60),3,BF
GOSUB L2e2d
RETURN
```

#### Key Discoveries
- **SOUND arg order confirmed**: `SOUND freq, dur` → freq pushed first (integer), dur pushed second (float).  `SOUND 800, 2` = 800 Hz for 2 ticks (~0.11 sec). `SOUND 1200, 3` = 1200 Hz for 3 ticks (~0.16 sec).
- **JC confirmed**: `JC` fires when ST(0) < ST(1) (second-pushed < first-pushed). Used here for the `Fa496! < 4` branch.
- **`PRINT_float_newline`** = QB `PRINT float_var` (with newline, no trailing semicolon).
- **`PRINT_string_newline`** = QB `PRINT "string literal"`. DS address (0xb46a) is a QB string descriptor: 2-byte length + 2-byte data offset. String content = `"O.K.       "` (11 chars).
- **`Fa246!(i, 1)` = damage type** (values 1–4; 0 = OK). Confirmed by this function reading then zeroing it.
- **LOCATE 5-arg form**: `LOCATE row, col, cursor, scan_start, scan_stop`. Cursor scan-line values set above VGA max (18+) to effectively hide the cursor during PRINT.

#### New Constants / Variables
| Symbol | DS offset | Value | Role |
|--------|-----------|-------|------|
| `Fa46a!` | 0xa46a | (runtime) | Al's target computer index (1–10) |
| `Fa496!` | 0xa496 | (runtime) | Damage type of target (1–4) |
| `Fa43e!` | 0xa43e | 0 initial | Damage-type 1 fix counter |
| `Fa442!` | 0xa442 | 0 initial | Damage-type 2 fix counter |
| `Fa446!` | 0xa446 | 0 initial | Damage-type 3 fix counter |
| `Fa43a!` | 0xa43a | 0 initial | Damage-type 4 fix counter |
| `0xa610` | — | 18.0 | LOCATE cursor scan-line base (types 1–3) |
| `0xb466` | — | 17.0 | LOCATE cursor scan-line base (OK label) |
| `0xa64c` | — | 0.0  | Value stored to clear damage entry |
| DS:0xb46a | — | "O.K.       " | Fixed-computer confirmation string |

#### Net Result
| Metric | Before | After | Delta |
|--------|--------|-------|-------|
| Total lines | 17,053 | 16,756 | -297 |
| Raw ASM lines | 14,625 | 14,353 | **-272** |
| % done | 14.2% | 14.3% | +0.1% |
| Functions done | 2 | 3 | +1 |
| All-session total removed | 831 | 1,103 | +272 |

### Files Changed This Session
| File | Change |
|------|--------|
| `lanlokre.bas` | L376f: 327 ASM lines → 30 lines BASIC |
| `WORK_PLAN.md` | L376f marked ✅ Done |
| `CLAUDE.local.md` | Session 3 log added, current state updated |
| `PROGRESS.md` | Regenerated |
| `PROGRESS_LOG.md` | This entry |

### Next Target: L3a10 (FUN_01a2_3a10)
- **Role**: Unknown — called immediately before Al animation (L637d) in L376f
- **Location**: lanlokre.bas line ~653, address 01a2:3a10
- **Extract command**: `.\tools\extract_fn.ps1 -Address 3a10`

---

*Log entry written 2026-05-27.*

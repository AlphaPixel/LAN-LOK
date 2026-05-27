# LAN-LOK Decompilation — Progress Log

This file records decompilation sessions in reverse-chronological order.
Each entry covers one working session: what was attempted, what succeeded, what was discovered,
and what changed in the repo.

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

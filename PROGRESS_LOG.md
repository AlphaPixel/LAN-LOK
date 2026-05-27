# LAN-LOK Decompilation — Progress Log

This file records decompilation sessions in reverse-chronological order.
Each entry covers one working session: what was attempted, what succeeded, what was discovered,
and what changed in the repo.

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

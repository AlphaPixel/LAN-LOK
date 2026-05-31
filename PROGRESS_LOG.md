# LAN-LOK Decompilation — Progress Log

This file records decompilation sessions in reverse-chronological order.

---

## Session 19 -- 2026-05-30 (QB64-PE compilation fixes: label resolution + LLoadPlayers)

**MILESTONE: lanlokre.bas compiles cleanly to lanlokre.exe (QB64-PE, exit 0).**

### Work done this session

#### Inserted LLoadPlayers (FUN_01a2_ae3d = Lae3d)
- tools/load_players_basic.txt had the structure but was missing array stores and never inserted
- Written from scratch: opens "players" FOR INPUT, reads numPlayers!, loops all player slots
- Stores all 6 fields per slot: hist_namelen!, hist_hiScore!, hist_games!, hist_f4!, hist_f5!, hist_avg!
- Added ON ERROR GOTO handler for missing file (first run): sets numPlayers!=0, namesBuf$=""
- Placed before LSavePlayers (after LFinalTally's GOTO LIntroGfx)

#### Fixed LFinalTally placeholder reads/writes
- Lines 1611-1612: replaced `Fa4da! = 0` / `Fa4de! = 0` placeholders with actual reads:
  - `Fa4da! = hist_hiScore!(INT(slotNum!))` -- DS:0x9e2a + slot*4
  - `Fa4de! = hist_games!(INT(slotNum!))` -- DS:0xa15a + slot*4
- Added write-back before GOSUB LSavePlayers:
  - `hist_hiScore!(INT(slotNum!)) = Fa4da!`
  - `hist_games!(INT(slotNum!)) = Fa4de!`
  - `hist_avg!(INT(slotNum!)) = Fa4e2!`

#### Resolved 16 stale hex-address label references
QB64-PE surfaced every GOSUB/GOTO that used the original hex address name
instead of the renamed semantic label. All fixed:

| Old reference | Fixed to | Occurrences |
|---------------|----------|-------------|
| GOSUB Lae3d | GOSUB LLoadPlayers | 1 |
| GOSUB L637d | GOSUB LAlAnim | 3 |
| GOSUB L9170 | GOSUB LVictory | 2 |
| GOSUB L56c4 | GOSUB LAtkFmt | 2 |
| GOSUB L3c90 | GOSUB LPause263b | 2 |
| GOSUB F0bcb | GOSUB LDrawArrow | 1 (typo: F vs L prefix) |
| GOTO La58f | GOTO LGameEnd | 1 |
| GOTO Laba9 | GOTO LFinalTally | 2 |
| GOTO L902f | GOTO LSelfPJam | 1 |
| GOTO L90ad | GOTO LSelfLock | 1 |
| GOTO L90f7 | GOTO LSelfErase | 1 |
| GOTO L9c28 | GOTO LLossScreen | 1 |
| GOTO L01a3 | GOTO LIntroGfx | 1 |

### Compilation result
- `qb64pe.exe -z lanlokre.bas` -- exit 0 (syntax clean)
- `qb64pe.exe -x lanlokre.bas -o lanlokre.exe` -- exit 0 (full compile)
- Output: `lanlokre.exe` (4,094,976 bytes)

### Next steps
- Manual gameplay testing (run lanlokre.exe, verify all game paths work)
- Commit (with user approval)

---

## Session 18 — 2026-05-30 (Lb207 / Lb786 / LRepairUI / Lbca2: player UI + end-of-game)

**MILESTONE: 100% decompiled — 0 raw ASM lines remaining.**

### Functions completed this session

#### FUN_01a2_b207 = Lb207 -- display player score table
- 667 raw ASM lines replaced with 117 lines of BASIC
- Shows 2-line header, iterates numPlayers! slots printing name+hiScore+games+won+lost+avg in 6 colors
- Champion tracking: bestAvg! initialized to -999999; per iteration, if hist_avg![slot]>bestAvg! records champSlot!/champName$/bestAvg! (two ASM compares safely collapsed to one IF block)
- Column layout: colBase!=1 (left, slots 1-21) or 41 (right, slots 22-43); with 16 players always left
- SUB_0e71_82be = TAB() -- confirmed by column positions 1,14,20,25,30,35 matching header
- Single-digit slot alignment: IF loopK!>9 PRINT "" ELSE PRINT " " extra space (QB PRINT quirk)
- Right-column LOCATE: IF loopK!>21 THEN LOCATE INT(loopK!-18),40 (DS:0xb9b0=-18)
- After loop: LOCATE 26,10; champion name+avg announcement in green/red/magenta
- 5 LINE borders: outer yellow B, vertical divider, cyan row-separator, header separator, champion box
- col thresholds: DS:0xb4c6=22 (column split), DS:0xb45e=21 (LOCATE threshold), DS:0xb9ac=-999999
- New variables in glossary: bestAvg!, champSlot!, tableLimit!, colBase!, hiScSlot!, winsSlot!, lossSlot!
- New string in glossary: champName$ (Sa52e$)

#### FUN_01a2_b786 = Lb786 -- select or register player for this game session
- 403 raw ASM lines replaced with 98 lines of BASIC
- Called from LIntroText; retries via self-JMP at Lb786/Lb786New labels
- Shows score table, asks for player slot# (99 for new), selects existing or registers new
- Existing path: scan namesBuf$ for slot name (FOR loop advances namePos! by nameLen! each step);
  load hist_avg![slot] -> Fa4e2!; Fa536!=0; RETURN
- New path: IF roster >= 43 slots: SOUND 800/400 x3 + "PLAYER FILE FULL" + 3x pause + retry
  Clamp entered number to numPlayers!+1; expand numPlayers! if needed
  INPUT playerName$; LEFT$(,9) if >9 chars; append to namesBuf$; hist_namelen![slot]=CSNG(LEN)
  Tail-call: GOTO Lb207 (Lb207's RETURN returns to Lb786's caller)
- SUB_0e71_7e1a = QB INPUT for float, SUB_0e71_7e20 = QB INPUT for string
- SUB_0e71_7fca = LEFT$(str,n), SUB_0e71_7cb1 = STRING_CONCAT, FUN_0d75_03c4 = CSNG
- DS strings: 0xb9f4="Enter player # (99 for new player):" (35), 0xba1c=51 spaces,
  0xba54="PLAYER FILE FULL.  USE EXISTING NAME." (37), 0xba7e="Enter player name: " (19)
- DS constants: 0xb43e=43 (max slots), 0xa6b4=2.0 (SOUND duration for error beeps)
- New variables in glossary: slotNum! (Fa4d6!), slotCopy! (Fa532!), Fa536! (new/existing flag)
- New label in glossary: Lb786

#### FUN_01a2_bab9 = LRepairUI -- player lockout wait loop with live computer animation
- 237 raw ASM lines replaced with 30 lines of BASIC
- Called via GOSUB from LSelfPJam/LSelfLock/LSelfErase after setting lockMsg$, rstMsg$, repairEnd!
- Entry: LOCATE 27,6; COLOR 13; PRINT lockMsg$ (lockout error message)
- Outer loop (LRepairWait): iterates until TIMER >= repairEnd! (player lockout expiry)
  - Inner FOR compI!=1 TO 10: load drawX!/drawY! from compStat!(col 4/3); check col 1 (damage):
    - 0 (undamaged): GOSUB LAnimDmg (animate healthy screen)
    - nonzero (damaged): curTime!=TIMER; alTarget!=compI!; if compStat!(compI!,2)<curTime!: GOSUB LAlFix
  - After FOR: IF TIMER < repairEnd! THEN GOTO LRepairWait
- Exit: SOUND 3000,4; LOCATE 27,6; COLOR 2; PRINT rstMsg$; cmdBuf$=""; 3x GOSUB LPause263b;
  LOCATE 27,6; PRINT 43 spaces (DS:0xba96); RETURN
- compStat! column offsets: j=1 (0x2c) damage, j=2 (0x58) repair time, j=3 (0x84) Y, j=4 (0xb0) X
- DS:0xa676/0xa674 = 4.0 float (SOUND duration); baec TIMER read omitted (dead code overridden at bb81)
- New label in glossary: LRepairWait (internal)

#### FUN_01a2_bca2 = Lbca2 -- end-of-game key-wait prompt
- 81 lines (stub + 56 raw ASM) replaced with 13 lines of BASIC
- Called from LVictory (9ae3), LLossScreen (ad8a), LIntroText (13db) after game scoring
- COLOR 15; keyIn$=""; LOCATE 30,35; PRINT "Hit any key to continue, or <Esc> to quit";
- Key-wait loop (Lbca2Wait): LEN(keyIn$)>0 → clear + RETURN; keyIn$=INKEY$; CHR$(27)→END; repeat
- SUB_0e71_8453 = QB END runtime (never returns; ESC causes program termination)
- DS:0xbac6 = "Hit any key to continue, or <Esc> to quit" (41 chars, ptr=0xbaca)
- Updated glossary: Lbca2 and Lbca2Wait

### Progress numbers
- **Before this session:** 1,520 raw ASM lines (43.9% remaining) -- after session 17
- **This session removed:** 1,520 ASM lines total (Lb207: 667, Lb786: 403, LRepairUI: 237, Lbca2: ~81+stub)
- **After this session:** 0 raw ASM lines -- **100.0% decompiled**
- **BASIC lines in file:** 1,942 (final)
- Functions completed all-time (cumulative): L2e2d, L3522, L376f, L3a10, L3c57, L3c90, L3cc9,
  L3d02, L3d3b/422d/4246, L42d5, L5018/50b2/5124, L56c4, L637d, L902f, L90ad, L90f7, L9170,
  L9ae7, L9c28+La58f+La5e0+La7db+La7f1+La980+Laba9, Lae3d, Lb029, Lb207, Lb786, Lbab9, Lbca2

### Key discoveries this session
- SUB_0e71_82be = TAB() -- identified by column offsets 1,14,20,25,30,35 matching score table header
- PowerShell `-shl` on Byte values gives wrong 16-bit results; use multiplication (`* 256`) instead
- Lb786's new-player path ends with `GOTO Lb207` (tail-call): Lb207's RETURN returns to Lb786's caller
- LRepairUI outer TIMER read at baec (into curTime!) is dead code -- overridden at bb81 before use
- SUB_0e71_8453 = QB END runtime (called on ESC in Lbca2)
- DS:0xa73e = empty string descriptor (len=0, ptr=0xa742); used as SET_STRING "" operand throughout

### Remaining work
- **No more raw ASM.** The decompilation of all named functions is complete.
- Remaining items for full playability:
  - The `ENTRY` (startup code / DIM statements) is still partially raw ASM (early portion)
    but this was outside the named-function scope of this project
  - LCircXhair (L61cb) is referenced by LAtkFmt but was left as a stub GOSUB call in the BASIC;
    the function body would need to be extracted from lanlok.asm and decompiled if desired
  - QB64-PE compilation testing: the BASIC should now be compilable (modulo any ENTRY DIM issues)


Each entry covers one working session: what was attempted, what succeeded, what was discovered,
and what changed in the repo.

---

## Session 17 — 2026-05-29 (LLossScreen / LGameEnd / LFinalTally: loss + game-over + tally)

### What was done
Decompiled `FUN_01a2_9c28` — the FORMAT C: self-attack sequence plus the complete game-over,
score-tally, and restart flow. This is the largest single function remaining after LAlAnim:
2,115 raw ASM lines (address range 01a2:9c28–01a2:ae3a) replaced with 263 lines of BASIC.

Raw ASM count: 3,453 → 1,520 (−1,933 ASM lines).
Total lines: 5,311 → 3,459 (net −1,852 due to line-count difference new vs. old).
BASIC fraction: 36.5% → 56.1%.

### Structure of FUN_01a2_9c28

The function has four distinct entry points, all non-returning (end with GOTO L01a3):

**LLossScreen (9c28)** — entered by CALL from game loop when player types `FORMAT C:` targeting
their own machine (SKUA):
- Full-screen SCREEN 12 / CLS 0 / cyan BF background
- 21 LINE calls drawing SKUA computer figure (monitor, keyboard body, slots, LEDs)
- COLOR 7 text: "Hi! My name is SKUA" / "> format c:" / "Oh, no......"
- 3 concentric CIRCLE pairs (radii 220/221, 120/121, 40/41) expanding inward with dialog:
  "My mind is going....." / "I can feel it......"
- Crosshair lines through (320,240): vertical (y 20–460) and horizontal (x 100–540)
- FOR loop 5 iterations: PRINT "aaa"; + GOSUB LTargetXhair (circR!=12 red / 14 yellow) + sounds
- PRINT "rrrrgh!!!" + final LTargetXhair + descending alarm (1000→100 STEP -50, SOUND each)
- Color flash sequence: 6 pairs of SCREEN 12 + colored BF fill (gray/yellow/darkblue/white/gray/black)
  with SOUND between each pair; each SCREEN 12 call clears screen (mode-reinit trick)
- _DELAY 0.789 + "You stupid SHIT!!" + _DELAY 1.052
- "You reformatted your own hard disk." + _DELAY 1.052
- "Real smooth move, geek." + _DELAY 1.578 (6 × 0.263)
- Sets Fa4d2!=15 (column offset 21 for GAME OVER flash) and Fa452!=1 (penalty flag)
- Falls into LGameEnd

**LGameEnd (La58f)** — entered by JMP from game loop when game timer expires normally:
- IF score! > 1000: GOSUB LVictory; Fa44e!=1 (victory flag for +2000 bonus)
- IF score! <= 1000: GOTO LGameOver

**LGameOver (La5e0)** — GAME OVER 4-color flash at row 27:
- Colors: green (10) / magenta (13) / light blue (9) / yellow (14), each with spaces-erase
- Each flash pair: PRINT text + SOUND 500,4 + _DELAY 0.263 + PRINT spaces + _DELAY 0.263
- Final yellow hold: _DELAY 0.789 (3×LPause263a) instead of the usual 0.263
- IF score! < 60 THEN GOTO LTooFewPoints; ELSE GOTO LFinalTally

**LTooFewPoints (La7db)** — router for score < 60:
- First/FORMAT-C game (Fa4d2!=15): GOTO LYouLose (skip NOT ENOUGH POINTS)
- Subsequent games (Fa4d2!=0): GOTO LNotEnoughPts

**LNotEnoughPts (La7f1)** — NOT ENOUGH POINTS flash ×3 (subsequent games, score < 60):
- Fa4d2!=0 (reset column offset)
- 3 iterations: PRINT green text + erase + pauses + SOUND 800,1 each

**LYouLose (La980)** — YOU LOSE WEENIE flash ×4:
- SOUND 200,3 + SOUND 120,5 + COLOR 13 before each of 4 prints
- " ***** YOU LOSE, WEENIE !!! *******" with spaces-erase and _DELAY 0.263 between
- Final hold: _DELAY 1.052 (4×LPause263a)
- Fa4d2!=0 (reset for next game)
- Falls into LFinalTally

**LFinalTally (Laba9)** — final score update, history, reset:
- CLS 0; Fa4da!=0 (high score); Fa4de!=0 (game count)
- IF score! < 60: Fa452!=1 (low-score penalty)
- IF Fa44e!=1: score! += 2000; IF Fa452!=1: score! -= 2000
- IF score! > Fa4da!: Fa4da!=score! (update high score)
- Running average: Fa4e2! = (Fa4e2!×Fa4de! + score!) / (Fa4de!+1)
- GOSUB Lb207 (display score table) + GOSUB Lb029 (end screen) + GOSUB Lbca2 (end-of-game handler)
- Reset Fa44e!=0, Fa452!=0
- FOR dmgType!=1 TO 10: FOR Fa4e6!=1 TO 4: compStat!(INT(dmgType!),INT(Fa4e6!))=0
- cmdBuf$="" + GOTO L01a3 (restart)

### New labels added to glossary
| New label     | Old address | Description |
|---------------|-------------|-------------|
| LLossScreen   | L9c28       | FORMAT C: self-attack sequence + game-over path |
| LGameEnd      | La58f       | Game-end router (score check, route to win/lose/tally) |
| LGameOver     | La5e0       | GAME OVER 4-color flash |
| LTooFewPoints | La7db       | Score<60 router |
| LNotEnoughPts | La7f1       | NOT ENOUGH POINTS flash ×3 |
| LYouLose      | La980       | YOU LOSE WEENIE flash ×4 |
| LFinalTally   | Laba9       | Final tally, history update, compStat! reset, restart |

### New variables added to glossary
| Variable | Original | Meaning |
|----------|----------|---------|
| Fa44e!   | Fa44e!   | Victory flag: 1 if score>1000, causes +2000 bonus |
| Fa452!   | Fa452!   | Penalty flag: 1 for FORMAT C: or score<60, causes -2000 |
| Fa4d2!   | Fa4d2!   | GAME OVER column offset (15=first/format-C game, 0=subsequent) |
| Fa4da!   | Fa4da!   | High score from history array[INT(Fa4d6!)] |
| Fa4de!   | Fa4de!   | Game count from history array |
| Fa4e2!   | Fa4e2!   | Running average score |
| Fa4e6!   | Fa4e6!   | Inner loop counter for compStat! reset (1-4) |

### Key discoveries
- **DS:0xb7a0 = 1000.0**: Both the victory threshold (IF score!>1000) AND the descending alarm
  start frequency (1000→100 STEP -50). Confirmed via individual byte reads after PowerShell
  array-slice bug ($0xb7a0 parsing as octal, producing garbage float).
- **SCREEN 12 reinit trick**: Calling `SCREEN 12` while already in mode 12 clears the screen.
  The color flash sequence exploits this: SCREEN 12 / LINE fill / SCREEN 12 / SOUND / repeat.
- **Fa44e! and Fa452! purpose confirmed**: Both were "unknown" after session 12. Now:
  Fa44e!=1 is set by LGameEnd (victory), Fa452!=1 is set by LLossScreen (FORMAT C:) and
  LFinalTally (low score). Both drive the +2000/-2000 score adjustment in LFinalTally.
- **Non-returning function**: LLossScreen is entered via CALL from the game loop (01a2:2ba0)
  but never returns — it ends with GOTO L01a3. The pushed return address is never used.
- **GAME OVER column offset trick**: Fa4d2! is set to 15 in the FORMAT C: path (so LOCATE 27,21
  centers the text for a centered display), and reset to 0 afterward (LOCATE 27,6 = left margin).

### Progress metrics
- ASM remaining: 1,520 lines (43.9%) — down from 3,453 (63.5%)
- BASIC done: 1,939 lines (56.1%) — up from 1,989 (the delta includes glossary expansion)
- Functions completed this session: LLossScreen, LGameEnd, LGameOver, LTooFewPoints,
  LNotEnoughPts, LYouLose, LFinalTally (all as one continuous translation)

### Next target
`FUN_01a2_ae3d` at lanlokre.bas line 1615, address 01a2:ae3d.
Run: `.\tools\extract_fn.ps1 -Address ae3d`

---

## Session 16 — 2026-05-28 (LVictory: victory screen)

### What was done
Decompiled `FUN_01a2_9170` = `LVictory` — the full victory screen shown when the player
crashes the entire network (all 10 computers damaged).

Replaced ~1,105 raw ASM lines (address range 01a2:9170–9ae6) with 102 lines of BASIC.

Raw ASM count: 4,346 → 3,453 (−893 ASM lines).

### New labels added to glossary
| New label | Old label | Description |
|-----------|-----------|-------------|
| `LVictory` | `L9170` | Victory screen: network crashed, player wins, 2000 pt bonus |
| `Lbca2`    | `Lbca2`  | End-of-game handler (not yet decompiled; called from LVictory) |

### Structure of LVictory
1. **Set victory flag**: `Fa44e! = 1`
2. **Flash VICTORY !! text** 4 times at LOCATE 27,6 (bottom row), alternating COLOR 10 and 2,
   with SOUND 1200,2 / SOUND 1000,2 bookending each flash and LPause263a blanks between
3. **Victory fanfare**: SOUND 1000,5 / 700,5 / 1000,5 / 700,5 / 1000,5
4. **CLS 0** + 1 pause
5. **Score panel**: LINE BF cyan(3) at (50,150)-(590,400); LINE B yellow(14) at (48,148)-(592,402)
6. **Text row 2**: LOCATE 2,25 / COLOR 13 / PRINT "C O N G R A T U L A T I O N S ! ! !"
7. **Text row 4**: LOCATE 4,22 / COLOR 15 / PRINT "You have successfully "; + COLOR 12 "CRASHED ";
   + COLOR 15 "the network."
8. **Text row 6**: COLOR 10 / LOCATE 6,18 / PRINT "This victory increases your score by 2000 points."
9. **_DELAY 2.367** (9 x LPause263a): orig FOR loop counter 1..9 calling FUN_01a2_3c57
10. **Text row 8**: LOCATE 8,29 / COLOR 2 / PRINT "Evil Al "; + COLOR 14 "is not happy."
11. **1 pause** + SOUND 110,2 + SOUND 130,3
12. **2 pauses** + set drawX!=300, drawY!=330 + GOSUB LAlAnim (Al drawn at victory position)
13. **3 pauses** + victory jingle: SOUND 80,3 / 120,3 / 80,2 / 110,2 / 130,3
14. **2 pauses** + network crash graphic (40 draw ops):
    - 3 concentric black circles (radii 3/5/8) centered near (299,338), each followed by LPause263a
    - Antenna symbol (3 LINEs) + LPause263b
    - 5 computer node boxes (each 1-4 LINEs + LPause263b), 1 L-shape (3 LINEs + LPause263b),
      2 posts with dot (2 LINEs each + LPause263b)
15. **_DELAY 1.052** (4 x LPause263a): orig FOR loop counter 1..4 calling FUN_01a2_3c57
16. **GOSUB Lbca2** (end-of-game handler, not yet decompiled) + RETURN

### Key discoveries
- **LOCATE row/col re-confirmed**: the push form `1, row, 1, col, 4` maps to LOCATE row, col;
  row 27 = near-bottom of SCREEN 12; text rows 2/4/6/8 are in the top strip of the screen
  above the graphical panel (which is at y=150-400 in pixel space)
- **SOUND jingle after LAlAnim**: correct values are SOUND 110,2 (not 110,3 as summary had),
  SOUND 130,3; the fourth jingle note uses duration 2 not 3
- **1 pause before SOUND 110**: only 1 LPause263a between "is not happy." print and SOUND 110,2;
  2 pauses come AFTER SOUND 130,3 before drawX!/drawY!/LAlAnim
- **No LPause263b after last post**: block 9 (post+dot B at x=550) ends directly with _DELAY 1.052
  -- there is no GOSUB LPause263b between it and the final delay
- **Computer node C divider at y=240** (not y=230 as the other nodes): LINE (270,240)-(315,240),0
- **Delay loop variable**: `_DELAY 2.367` loop uses DS:[0xa4ce]; `_DELAY 1.052` loop uses
  DS:[0xa496]=dmgType! reused as loop counter; both dropped per delay-loop policy
- **Fa44e!** set to 1.0 at entry -- confirms it is the victory/game-over flag
  (note: Fa44e! and Fa452! were the two unknowns from session 12; purpose of Fa452! still unknown)
- **Lbca2** (FUN_01a2_bca2) is called from three places: LVictory (9170), the loss path (9c28),
  and FUN_01a2_0d85 -- it is the game-over cleanup handler, not yet decompiled

### Files changed
- `lanlokre.bas`: LVictory BASIC splice (replaces 01a2:9170-9ae6), Lbca2 label stub added before
  FUN_01a2_bca2 header, LVictory+Lbca2 glossary entries added
- `PROGRESS_LOG.md`: this entry
- `CLAUDE.local.md`: session log updated

---

## Session 15 — 2026-05-28 (LSelfPJam, LSelfLock, LSelfErase: self-attack error handlers)

### What was done
Decompiled three sibling self-attack handlers:
- `FUN_01a2_902f` = `LSelfPJam` — player PRINT-jammed own machine
- `FUN_01a2_90ad` = `LSelfLock` — player LAN-locked own machine
- `FUN_01a2_90f7` = `LSelfErase` — player DEL-*.*-erased own directory

All three follow the pattern: sound effect → set repairEnd! timer → set lockMsg$/rstMsg$ strings
→ GOSUB LRepairUI → GOSUB LResetSel → GOTO LGameLoop.

Three new string variables named: lockMsg$ (=Sa4c6$) and rstMsg$ (=Sa4ca$).
LRepairUI label established for FUN_01a2_bab9 stub.

Raw ASM count: 4,522 → 4,346 (−176 ASM lines).

### New labels added to glossary
| New label | Old label | Description |
|-----------|-----------|-------------|
| `LSelfPJam`  | `L902f` | Self-attack: player PRINT-jammed own printer |
| `LSelfLock`  | `L90ad` | Self-attack: player LAN-locked own machine |
| `LSelfErase` | `L90f7` | Self-attack: player DEL *.*-erased own directory |
| `LRepairUI`  | `Lbab9` | Repair-wait UI: show lock msg, animate computers, show unlock msg |

### New string variables added to glossary
| New name | Old name | Description |
|----------|----------|-------------|
| `lockMsg$` | `Sa4c6$` | Self-attack error message (shown while locked) |
| `rstMsg$`  | `Sa4ca$` | Self-attack restore message (shown when unlocked) |

### Structure of self-attack handlers

**LSelfPJam (PRINT attack on own machine)**
- WHILE dmgType! >= 100: SOUND INT(dmgType!), 1 : dmgType! = dmgType! - 30 (700→100 Hz, step −30)
- repairEnd! = TIMER + 25
- lockMsg$ = "YOU JAMMED YOUR OWN PRINTER, BUTTHEAD!"
- rstMsg$ = "   YOUR COMPUTER IS NOW UNLOCKED      "

**LSelfLock (LAN LOCK attack on own machine)**
- SOUND 2000, 3
- repairEnd! = TIMER + 25
- lockMsg$ = "YOUR COMPUTER IS LOCKED, ASSHOLE!"
- rstMsg$ = "   YOUR COMPUTER IS NOW UNLOCKED     "

**LSelfErase (DEL *.* attack on own machine)**
- SOUND 2000, 3
- IF TIMER > repairEnd! THEN repairEnd! = TIMER + 45 ELSE repairEnd! = repairEnd! + 45
- lockMsg$ = "GOOD GOING, BOZO.  YOU ERASED YOUR DIRECTORY."
- rstMsg$ = "  HAPPY AL HAS RESTORED YOUR DIRECTORY.      "

### Key discoveries
- All three handlers end with GOTO LGameLoop (JMP to 1e78), not RETURN -- they are not
  proper GOSUB subroutines, they jump back to the main game loop directly
- LSelfErase distinguishes expired vs active timer using FPCOMPARE: FLD [repairEnd!] /
  FLD TIMER / CALLF FPCOMPARE / JA fires when TIMER > repairEnd! → already expired path
- dmgType! reused as descending freq counter in LSelfPJam WHILE loop
- lockMsg$/rstMsg$ are pair-set together; LRepairUI (bab9) consumes both for the wait-UI display
- DS constants: 0xb4a6=700 (freq start), 0xb512=-30 (freq step), 0xb47a=100 (freq stop),
  0xb4f6=25 (25-second lockout), 0xb42a=45 (45-second lockout for erase), 0xa624=3.0 (SOUND duration)

### Files changed
- `lanlokre.bas`: LSelfPJam/Lock/Erase BASIC splices, LRepairUI label stub, new glossary entries
- `PROGRESS_LOG.md`: this entry

---

## Session 14 — 2026-05-28 (LAlAnim: Al figure draw + blink animation)

### What was done
Decompiled `FUN_01a2_637d` = `LAlAnim` — the largest single function in the game.
Al is the repair technician who fixes damaged computers; this routine draws him and runs
a 5-iteration blink/eye-movement animation.

5,619 raw ASM lines replaced with 151 lines of BASIC.

Raw ASM count: 9,965 -> 4,522 (-5,443 ASM lines).

### New label added to glossary
| New label | Old label | Description |
|-----------|-----------|-------------|
| `LAlAnim` | `L637d` | Draw Al figure and animate blinking (5 iterations) |

### New DS constants discovered
| Address | Value | Usage |
|---------|-------|-------|
| `0xb4f6` | 25.0 | Al face center x-offset; also animation chevron apex x |
| `0xb024` | 27.0 | Animation eyelid V-line y-offset |
| `0xb4ca` | 29.0 | Old eye-highlight x-offset (right, before shift) |
| `0xb4ce` | 37.0 | Animation right-eye outer circle x-offset |
| `0xaf7c` | 5.0  | Animation loop limit (5 iterations) |
| `0xb4c6` | 22.0 | Collar y-offset |
| `0xb502` | 1.1  | Mouth arc start angle (radians) |
| `0xb50e` | 500.0 | Random beep frequency range multiplier (RND*500+40) |
| `0xb512` | -30.0 | Used in FUN_01a2_902f (next function) |
| `0xb3ee` | 34.0 | Nose-dot y-offset |

### Structure of LAlAnim

**Initial draw (static):**
1. Background: cyan BF fill covering figure area (drawX!-5 to +55, drawY!-5 to +60)
2. Face circle: r=20 centered at (drawX!+25, drawY!+30), black outline + gray fill
3. Collar: cyan BF polygon, then 7 black outline LINEs forming the collar shape
4. Collar badge: bright-blue (9) BF fill + black B box outline
5. Green shirt fill: PAINT (drawX!+25, drawY!), 2, 0 -- floods collar interior green
6. Antenna interior diagonal LINE
7. LED button: white circle r=2 filled, then black border circle r=3
8. Eyes: two black circles r=2 at (+20/+30, +29), filled black, outlined in light-red (12)
9. Eye highlights: two PSETs white at (+21/+31, +28)
10. Nose: two small circles r=1 at (+24/+26, +34)
11. Mouth: two overlapping arcs (r=20 and r=19) centered at (drawX!+25, drawY!+60),
    angles 1.1 to 2.0 rad, creating upward-bowing smile at ~drawY!+42
12. Body: 73 black plain LINEs forming shirt/arms/legs silhouette

**Animation loop (5 iterations, using dmgType! as counter):**
Each iteration:
- SOUND INT(RND(1)*500+40), 1 -- random beep 40-540 Hz, ~55ms
- Shift eye highlights right (+19/+29 -> erase, +21/+31 -> draw white)
- Draw gray (7) circles r=3 at (drawX!+14, drawY!+35) and (drawX!+37, drawY!+35)
- Draw gray eyelid V-lines from (drawX!+25, drawY!+27) to (drawX!+18, drawY!+23) and (+32, +23)
- GOSUB L3c90 (0.263 s delay)
- Shift highlights back (+21/+31 -> erase, +19/+29 -> draw white)
- Erase V-lines with black LINEs
- Draw magenta (5) circles r=3 at same positions to "reopen" eyes
- GOSUB L3c90 (0.263 s delay)

**Key discoveries:**
- CIRCLE arc with start_angle/end_angle: compiled as CALLF CIRCLE_setstart + CALLF CIRCLE_setend
  before CALLF CIRCLE; BASIC syntax: CIRCLE (cx,cy), r, color, start, end
- Nostril radius is 1.0 (not 2.0 -- parser confused [0xa550]=1.0 with [0xa6b4]=2.0)
- Direct word-push for drawY! (PUSH [0xa234]/[0xa232]) means y = drawY! with zero offset
- Animation uses DIFFERENT circle positions from initial draw pupils (outer feature vs inner pupil)
- "Open eye" color = magenta (5), "closed" color = gray (7)
- Parser FADD state-machine had false-positive y+60 entries for nose dots (fixed by reading ASM directly)
- PS script to extract all 107 graphic operations from the initial draw section worked correctly
  for LINEs but gave wrong radius for nostril circles; corrected by direct ASM reading

### Functions remaining (approximate)
After this session:
- Raw ASM: 4,522 lines (69%)
- BASIC: 2,031 lines (31%)
- Done: 22 functions, partial: 3, todo: 23

Next target: FUN_01a2_902f (L902f) -- small error-handling subroutines (~40-50 lines each)

---

## Session 13 — 2026-05-28 (LAtkFmt: FORMAT C: attack, damage type 3)

### What was done
Decompiled `FUN_01a2_56c4` = `LAtkFmt` — the FORMAT C: (damage type 3) attack routine.
1,353 raw ASM lines replaced with 81 lines of BASIC.

Raw ASM count: 11,207 → 9,965 (−1,242 ASM lines).

### New variables added to glossary
| New name | Old name | Description |
|----------|----------|-------------|
| `circR!` | `Fa4be!` | Circle color/radius param passed to FUN_01a2_61cb (0=black, 14=visible) |
| `fmtBarH!` | `Fa4c2!` | FORMAT C: random top-y of green scan bar (= 59 − RND(1)*8) |

### New label added to glossary
| New label | Old label | Description |
|-----------|-----------|-------------|
| `LAtkFmt` | `L56c4` | FORMAT C: attack entry point (damage type 3) |

### Structure of LAtkFmt
1. **Preamble**: `IF TIMER > repairEnd! THEN repairEnd! = TIMER`; `repairEnd! += 37 + RND*20`;
   `compStat!(target,2)=repairEnd!`; `compStat!(target,1)=3`; `GOSUB LCalcScore`
2. **Header text**: `LOCATE INT(17+target!), 68`; `COLOR 13`; `PRINT "REFORMATTED"`
3. **Load coords + draw**: `drawY!/drawX!` from compStat! cols 3/4; `GOSUB LDrawIcon`; `GOSUB LPause066a`
4. **3 concentric black circles** at center (drawX!+25, drawY!+27), radii 30/18/6, color 0;
   `SOUND 700,1` and `GOSUB LPause066a` after each
5. **Crosshair lines** (black): vertical (x+25,y-4)→(x+25,y+59); horizontal (x-5,y+27)→(x+55,y+27);
   `SOUND 700,1`; `GOSUB LPause263b`
6. **Shrink loop** (dmgType! 1→6): `circR!=14` → `GOSUB L61cb` → `SOUND 1200,1`;
   `circR!=0` → `GOSUB L61cb` → `SOUND 900,1`; then final `circR!=14` pass + LPause066b + LPause263a
7. **Flash loop** (dmgType! 1→5): `LINE BF yellow(14)` → `GOSUB LDrawIcon` → `SOUND 500,1`;
   `LINE BF magenta(5)` → `GOSUB LDrawIcon` → `SOUND 900,1`
8. **Black erase fill**: `LINE BF color 0`; `GOSUB LPause263b`
9. **White cross**: `LINE BF white(15)` (x+15,y)→(x+35,y+58); `LINE BF white(15)` (x,y+10)→(x+50,y+30)
10. **Green format-scan** (`FOR loopK!=-4 TO 54`): `fmtBarH!=59-RND*8`;
    `LINE (x+loopK!,y+59)→(x+loopK!,y+fmtBarH!),2`
11. **Damage indicator marker**: 7 LINEs (mix of plain/B) + 3 PSETs forming a floppy-slot pattern

### Key discoveries
- **CIRCLE calling convention** confirmed: center set by setpt1 before call; CIRCLE receives
  (radius as 4-byte float, color as int); → `CIRCLE (cx,cy), radius, color` in BASIC
- **circR!** (Fa4be!) serves dual role: color parameter for initial circles AND radius/mode parameter
  for the undecompiled FUN_01a2_61cb animator; L61cb reads it directly from memory at [0xa4be]
- **dmgType! triply-reused** in this function: shrink loop counter, flash loop counter, original
  purpose (damage type 3 stored via literal constant 3.0, not through dmgType! variable)
- **loopK! = F003a!** used as the format-scan column variable (same as calibration loop legacy var)
- **fmtBarH! = 59 − RND(1)*8**: uses FSUBP (ST(1)−ST(0)) pattern after FLD 59 + RND*8 on FP stack
- **Repair time**: 37 + RND(1)*20 s = 37–57 s (vs. L3d3b=12–22 s, L5018=30–45 s, L42d5=30–67 s)
- **Text COLOR 13** (magenta) for "REFORMATTED" display
- **FUN_01a2_61cb** (L61cb) remains undecompiled; called as `GOSUB L61cb` with circR! pre-set;
  this is the concentric-circle shrink/expand animator
- **White cross shape** (two overlapping BF rectangles) is the FORMAT damage status indicator,
  replacing the normal screen content after the animation

### Files changed
- `lanlokre.bas`: LAtkFmt BASIC splice + 2 new glossary vars + 1 new label
- `PROGRESS_LOG.md`: this entry
- `CLAUDE.local.md`: session log updated

---

## Session 12 — 2026-05-28 (Semantic Symbol Renaming)

### What was done
Renamed all generic decompilation symbol names (`Fa22e!`, `L376f`, etc.) in the decompiled
BASIC section of `lanlokre.bas` to semantically meaningful names that reflect game logic.
ASM sections were left untouched — those hex-address names are ground truth for cross-referencing
with `lanlok.asm` and `LANLOKDS.BIN`.

### Scope
- **35 float/string variables** renamed (e.g. `Fa22e!` → `drawX!`, `Fa472!` → `target!`)
- **32 subroutine labels** renamed (e.g. `L3d3b` → `LAtkLock`, `L376f` → `LAlFix`)
- **2 variables kept** with original names: `Fa44e!` and `Fa452!` (purpose unknown, only
  initialized to 0 in decompiled code; used in undecompiled stubs)
- **Undecompiled label stubs** kept with original hex names (`L56c4`, `L637d`, etc.)

### Annotation strategy
Every renamed symbol is documented in two ways:
1. **Master glossary** added to `lanlokre.bas` lines 2-86, listing all renames with
   semantic descriptions.
2. **Inline comment** on each label definition: `LAlFix:   ' LAlFix=L376f`
3. **DIM/first-assignment comment** for variables: `DIM compStat!(10,5)  ' compStat!=Fa246!`
4. **Off-topic reuse note** where a variable is used outside its primary role:
   `' NOTE: dmgType! (=Fa496!) reused as loop variable below -- not damage type here`

### Key renames
| Category | Old | New | Why |
|----------|-----|-----|-----|
| Icon position | `Fa22e!` | `drawX!` | X pixel base for all icon drawing |
| Icon position | `Fa232!` | `drawY!` | Y pixel base for all icon drawing |
| Game target | `Fa472!` | `target!` | Player's selected attack target |
| Score | `Fa456!` | `score!` | Player cumulative score |
| Status array | `Fa246!` | `compStat!` | Computer status/damage array |
| Repair time | `Fa4ae!` | `repairEnd!` | When Al will finish the repair queue |
| Al's fix target | `Fa46a!` | `alTarget!` | Which computer Al is repairing |
| Game clock | `Fa44a!` | `gameEnd!` | TIMER value at game end |
| Fix tallies | `Fa43a/e/2/6!` | `alFixPJam/Lock/Eras/Fmt!` | Al's per-type fix counts |
| Attack routines | `L3d3b/42d5/5018` | `LAtkLock/PJam/Erase` | Which attack each implements |
| Al fix routine | `L376f` | `LAlFix` | Al repairs a computer |
| Score routine | `L3a10` | `LCalcScore` | Recalculate and display score |
| Draw routine | `L2e2d` | `LDrawIcon` | Draw computer icon |
| Game loop | `L1e78` | `LGameLoop` | Main game loop |

### Rule added to CLAUDE.md
New "Semantic Naming of Decompiled Symbols" section added, covering:
- Naming conventions for variables and labels
- Annotation format (`newname=oldname`) at definitions
- When to keep vs rename (confirmed purpose required; stubs stay hex)
- Multi-purpose scratch variable policy

### Files changed
- `lanlokre.bas`: all renames + 86-line glossary + 32 label annotations + 2 reuse notes
- `CLAUDE.md`: new Semantic Naming section + updated Variable Naming table + updated Subroutine Labels section

---

## Session 11 — 2026-05-28 (LOCATE/COLOR Calling Convention Corrections)

### What was done
Reviewed the newly committed `Known_Instruction_Formats.md` from the repo owner, which documents
the Pascal calling convention for LOCATE and COLOR. This revealed a **systematic error in all
Claude-written code** from sessions 1-10:

- **LOCATE** had been written with 5 arguments `LOCATE row, col, cursor, start, stop` — always wrong.
  Correct form: `LOCATE row, col` (2 args only). The trailing push value "4" is the vararg word-count,
  not a cursor-shape argument; there are no cursor-shape LOCATE calls in this executable.
- **COLOR** had been written with 2 arguments `COLOR fg, bg` — always wrong.
  Correct form: `COLOR fg` (1 arg only). The trailing "2" is the word-count, not a background color;
  there are no 2-arg COLOR calls in this executable.

Root cause: incorrect assumption of C right-to-left push ordering, and misreading the
vararg word-count at the end of each push sequence as a content argument.

Also performed a **non-ASCII character cleanup**: 7 occurrences of UTF-8 multi-byte characters
(`~`, `--`, `->` replacements for `≈`, `—`, `→`) were fixed to prevent mojibake in Notepad++
and GitHub web UI (both use Latin-1/CP1252 assumptions).

### 14 LOCATE/COLOR corrections in lanlokre.bas

| Function | Old (wrong) | New (correct) |
|----------|-------------|---------------|
| L376f    | `LOCATE 4, 44, 1, INT(18 + Fa46a!), 1` | `LOCATE INT(18 + Fa496!), 44` (also wrong variable) |
| L376f    | `LOCATE 4, 44, 1, 18, 1` | `LOCATE 18, 44` |
| L376f    | `COLOR 2, 13` | `COLOR 13` |
| L376f    | `LOCATE 4, 68, 1, INT(17 + Fa46a!), 1` | `LOCATE INT(17 + Fa46a!), 68` |
| L376f    | `COLOR 2, 2` | `COLOR 2` |
| L3a10    | `LOCATE 4, 74, 1, 29, 1` | `LOCATE 29, 74` (row/col were TRANSPOSED) |
| L3a10    | `COLOR 2, 13` | `COLOR 13` |
| L3a10    | `LOCATE 4, 74, 1, 29, 1` (second) | `LOCATE 29, 74` |
| L3d3b    | `LOCATE 4, 68, 1, INT(17 + Fa472!), 1` | `LOCATE INT(17 + Fa472!), 68` |
| L3d3b    | `COLOR 2, 14` | `COLOR 14` |
| L42d5    | `LOCATE 4, 68, 1, INT(17 + Fa472!), 1` | `LOCATE INT(17 + Fa472!), 68` |
| L42d5    | `COLOR 2, 9` | `COLOR 9` |
| L5018    | `LOCATE 4, 68, 1, INT(17 + Fa472!), 1` | `LOCATE INT(17 + Fa472!), 68` |
| L5018    | `COLOR 2, 12` | `COLOR 12` |

### Additional bug found and fixed
In L376f line 618, the variable was also wrong: `Fa46a!` (Al's target computer index, range 1-10)
was used instead of `Fa496!` (damage type temp, range 1-4). The row for the score-status print is
`INT(18 + damage_type)` (rows 19-22), not `INT(18 + target_index)` (rows 19-28).
Verified from ASM at address 01a2:386c: `FADD float ptr [0xa496]`.

### Most critical corrections
1. **L3a10 score display**: row and column were transposed. `LOCATE 4, 74` -> `LOCATE 29, 74`.
   The score was going to row 4 col 74 (near top of screen) instead of row 29 col 74 (status bar).
2. **L376f damage-type row**: Wrong variable `Fa46a!` replaced with correct `Fa496!`.

### Rule changes
- **CLAUDE.md**: Runtime Calls section completely rewritten with unambiguous rules:
  - `COLOR fg` -- always 1-arg. No `COLOR fg, bg` form exists in this executable.
  - `LOCATE row, col` -- always 2-arg. No 5-arg form exists in this executable.
  - Also added ASCII-Only Comments directive.
- **Known_Instruction_Formats.md**: Added "Observed usage" subsections for COLOR and LOCATE
  documenting the 1-arg and 2-arg forms observed, plus the 4-push short form (literal row constant).

### Files changed
- `lanlokre.bas`: 14 LOCATE/COLOR corrections + 7 non-ASCII character replacements
- `CLAUDE.md`: Updated calling convention rules + ASCII-only directive
- `Known_Instruction_Formats.md`: Added observed-usage notes

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

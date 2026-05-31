DIM compStat!(10,5)     ' compStat!=Fa246!  -- computer status array (10 computers x 5 attrs)
DIM hist_namelen!(43)   ' DS:0x9d5e  -- player name length per slot (1..43)
DIM hist_hiScore!(43)   ' DS:0x9e2a  -- player high score per slot
DIM hist_f4!(43)        ' DS:0x9ef6  -- wins count per slot ("won" column)
DIM hist_f5!(43)        ' DS:0x9fc2  -- losses count per slot ("lost" column)
DIM hist_avg!(43)       ' DS:0xa08e  -- running avg score per slot
DIM hist_games!(43)     ' DS:0xa15a  -- games played per slot

' ---------------------------------------------------------------------------
' SYMBOL RENAMING GLOSSARY
' Generic decompilation names -> semantic names (newname=oldname)
'
' VARIABLES (floats unless noted)
'   drawX!      =Fa22e!   icon base X pixel coordinate
'   drawY!      =Fa232!   icon base Y pixel coordinate
'   iconScr!    =Fa22a!   icon screen-area fill color
'   drawClr!    =Fa236!   current pen/arrow draw color
'   score!      =Fa456!   player cumulative score
'   target!     =Fa472!   player selected target (0=none/SKUA, 1-10)
'   gameEnd!    =Fa44a!   game end timestamp (TIMER + 300 s)
'   minsLeft!   =Fa462!   time remaining in minutes (display value)
'   lockUntil!  =Fa29e!   input throttle: skip game loop until TIMER exceeds this
'   compI!      =Fa466!   game-loop computer iterator (1-10)
'   alTarget!   =Fa46a!   Al's current repair-target index
'   dmgCount!   =Fa45a!   count of damaged computers per loop pass
'   curTime!    =Fa45e!   TIMER snapshot for repair-due comparison
'   repairEnd!  =Fa4ae!   repair-queue end timestamp (shared by attack routines)
'   newScore!   =Fa49a!   score recalculation accumulator
'   dmgType!    =Fa496!   damage type of repaired computer (L376f primary use);
'                          reused as loop variable in LAtkPJam -- see comments there
'   alFixLock!  =Fa43e!   Al fix tally: computers unlocked (damage type 1)
'   alFixEras!  =Fa442!   Al fix tally: erasures restored  (damage type 2)
'   alFixFmt!   =Fa446!   Al fix tally: disks reconstructed(damage type 3)
'   alFixPJam!  =Fa43a!   Al fix tally: printers unjammed  (damage type 4)
'   compIdx!    =Fa42e!   computer-name index during setup loop
'   selI!       =Fa476!   SELECT animation loop index
'   rejectP!    =Fa486!   SELECT network-rejection probability
'   hobbsFmt!   =Fa48a!   flag: Hobbs FORMAT attack succeeded this turn
'   rndSndF!    =Fa23a!   intro random-sound frequency
'   fanSndF!    =Fa23e!   intro fanfare sound frequency
'   scanYBot!   =Fa48e!   scan-line animation bottom Y bound
'   paperLen!   =Fa4b2!   printer paper random line length
'   jamH!       =Fa4b6!   jammed paper frame height (random)
'   jamLim!     =Fa4ba!   jamH - 1 (variable-frame loop limit)
'   chaosY!     =Fa482!   printer-jam chaos random row
'   circR!      =Fa4be!   FORMAT C: circle radius/color param (0=black, 14=visible) for L61cb
'   fmtBarH!    =Fa4c2!   FORMAT C: random top-y of green scan bar (=59-RND*8)
'   loopI!      =Fa226!   first general-purpose loop variable (also scanline Y)
'   loopJ!      =Fa492!   second general-purpose loop variable / scan-line length
'   loopK!      =F003a!   third general-purpose loop variable (calibration legacy)
'   Fa44e!      =Fa44e!   victory flag: set to 1 if score>1000 at LGameEnd; causes +2000 bonus
'   Fa452!      =Fa452!   penalty flag: set to 1 if FORMAT C: self-attack or score<60; causes -2000
'   Fa4d2!      =Fa4d2!   GAME OVER column offset (15 first/format-C game; 0 for subsequent games)
'   Fa4da!      =Fa4da!   high score read from history array[INT(Fa4d6!)] (LFinalTally)
'   Fa4de!      =Fa4de!   game count; read from file in LLoadPlayers / used in LFinalTally avg
'   Fa4e2!      =Fa4e2!   running avg score; read from file in LLoadPlayers / computed LFinalTally
'   Fa4e6!      =Fa4e6!   compStat! column reset iterator (inner loop 1-4 in LFinalTally)
'   numPlayers! =Fa4ee!   total player history slots in "players" file (LLoadPlayers)
'   playersLim! =Fa4f2!   loop limit copy of numPlayers! (LLoadPlayers)
'   histHiSc!   =Fa4fa!   high score read from "players" file for current slot (LLoadPlayers)
'   Fa4fe!      =Fa4fe!   history field 4 per slot ("won" count; read in LLoadPlayers)
'   Fa502!      =Fa502!   history field 5 per slot ("lost" count; read in LLoadPlayers)
'   namePos!    =Fa506!   current start position in namesBuf$ for MID$ extraction (LSavePlayers/Lb207)
'   saveLim!    =Fa50a!   loop limit for save loop (= numPlayers!) (LSavePlayers)
'   nameLen!    =Fa50e!   current player name length from hist_namelen! array (LSavePlayers/Lb207)
'   bestAvg!    =Fa512!   running max average seen in Lb207 loop (init -999999; DS:0xb9ac)
'   champSlot!  =Fa516!   slot index of player with best average (Lb207)
'   tableLimit! =Fa51a!   Lb207 loop limit (= numPlayers!)
'   colBase!    =Fa51e!   Lb207 column base: 1 (left, slots<22) or 41 (right, slots>=22)
'   hiScSlot!   =Fa522!   high score for current Lb207 display slot (hist_hiScore![loopK!])
'   winsSlot!   =Fa526!   wins count for current Lb207 slot (hist_f4![loopK!])
'   lossSlot!   =Fa52a!   losses count for current Lb207 slot (hist_f5![loopK!])
'   slotNum!    =Fa4d6!   player slot number entered at login prompt (Lb786)
'   slotCopy!   =Fa532!   loop limit copy of slotNum! for name extraction (Lb786)
'   Fa536!      =Fa536!   new-vs-existing flag: 0=existing player selected; non-0=new (Lb786)
'
' STRING VARIABLES
'   keyIn$      =Sa242$   INKEY$ keyboard input buffer
'   cmdBuf$     =Sa46e$   command input accumulator
'   compNames$  =Sa42a$   packed computer-names string (10 chars each)
'   compName$   =Sa432$   current computer name temp
'   playerName$ =Sa436$   player machine name ("SKUA")
'   lockMsg$    =Sa4c6$   self-attack error message (shown while computer is locked)
'   rstMsg$     =Sa4ca$   self-attack restore message (shown when computer is unlocked)
'   namesBuf$   =Sa4f6$   accumulated player name string (built in LLoadPlayers for display)
'   champName$  =Sa52e$   current champion player name (set in Lb207 loop; displayed after)
'
' SUBROUTINE LABELS (decompiled; undecompiled stubs keep hex names)
'   LIntroGfx   =L01a3   graphical intro entry point
'   LRndSound   =L0b97   play a random intro sound
'   LDrawArrow  =L0bcb   draw intro arrow graphic
'   LClrArrow   =L0d53   clear intro arrow graphic
'   LIntroText  =L0d85   third intro segment (text box 3)
'   LGameLoop   =L1e78   main game loop
'   LNextComp   =L1fb0   skip to next computer in game loop
'   LNoInput    =L20a1   branch: no key pressed this frame
'   LInputEnd   =L20c8   after key accumulation
'   LCmdProc    =L210a   parse and dispatch entered command
'   LCmdSel     =L2276   SELECT command entry
'   LSelLoop    =L22a5   SELECT: await target name input
'   LSelChk     =L2390   SELECT: display partial input
'   LSelParse   =L23b5   SELECT: ENTER pressed, parse name
'   LSelDone    =L26a3   SELECT: after target validated
'   LCmdPrint   =L28d7   PRINT command entry
'   LCmdMail    =L29bd   SEND MAIL command entry
'   LCmdDel     =L2aa3   DEL *.* command entry
'   LCmdFmt     =L2b8d   FORMAT C: command entry
'   LResetSel   =L2d76   reset target selection to SKUA
'   LUpdTimer   =L2dbb   update on-screen timer display
'   LDrawIcon   =L2e2d   draw a computer icon at (drawX!,drawY!)
'   LAnimDmg    =L3522   animate screen of a healthy/active computer
'   LAlFix      =L376f   Al fixes a damaged computer
'   LCalcScore  =L3a10   recalculate and display player score
'   LPause263a  =L3c57   delay ~0.263 s (instance A)
'   LPause263b  =L3c90   delay ~0.263 s (instance B)
'   LPause066a  =L3cc9   delay ~0.066 s (instance A)
'   LPause066b  =L3d02   delay ~0.066 s (instance B)
'   LAtkLock    =L3d3b   attack: LAN LOCKED  (damage type 1)
'   LAtkPJam    =L42d5   attack: PRINTER JAM (damage type 4)
'   LAtkErase   =L5018   attack: ERASED      (damage type 2)
'   LAtkFmt     =L56c4   attack: FORMAT C:   (damage type 3)
'   LCircXhair  =L61cb   draw/erase 3 circles + crosshairs at icon center (color=INT(circR!))
'   LAlAnim     =L637d   draw Al figure and run 5-iteration blink animation
'   LRepairUI   =Lbab9   repair-wait UI: show lock msg, animate computers, show unlock msg
'   LSelfPJam   =L902f   self-attack: player jammed own printer (PRINT on SKUA)
'   LSelfLock   =L90ad   self-attack: player locked own LAN (on SKUA)
'   LSelfErase  =L90f7   self-attack: player erased own directory (DEL *.* on SKUA)
'   LTargetXhair=L9ae7   draw bullseye (3 ring pairs + crosshair) at screen center, color=INT(circR!)
'   LVictory    =L9170   victory screen: network crashed, player wins, 2000 bonus pts
'   LLossScreen =L9c28   FORMAT C: self-attack sequence then game-over path (non-returning)
'   LGameEnd    =La58f   game-end entry from game loop: check score, route to win/lose/tally
'   LGameOver   =La5e0   GAME OVER 4-color flash (row 27), routes to LFinalTally or LTooFewPoints
'   LTooFewPoints=La7db  score<60 router: first-game -> LYouLose; subsequent -> LNotEnoughPts
'   LNotEnoughPts=La7f1  NOT ENOUGH POINTS flash x3 (subsequent games only)
'   LYouLose    =La980   YOU LOSE WEENIE flash x4 (first game and low-score path)
'   LFinalTally =Laba9   final score tally, history update, compStat! reset, GOTO L01a3
'   LLoadPlayers=Lae3d   read player history from "players" file into in-memory arrays (startup)
'   LSavePlayers=Lb029   write player history from in-memory arrays to "players" file (end-of-game)
'   Lb207       =Lb207   display player score table (name+hiScore+games+won+lost+avg, champion)
'   Lb786       =Lb786   player select/register: INPUT slot#, look up or add new player
'   Lbca2       =Lbca2   end-of-game: "hit any key" prompt at row 30 col 35, ESC quits
'   Lbca2Wait   =Lbca2   key-wait loop (internal label in Lbca2)
' ---------------------------------------------------------------------------

' Calibration block removed -- QB64 runs too fast for the original timing loop.
' Original: 37700 iterations measured with TIMER to scale F0042!/F0046!/F004a!.
' All delay loops are now _DELAY with pre-computed wall-clock durations (see CLAUDE.md).

' Play first intro
CLS 0
COLOR 14
LOCATE 8,15
PRINT "               *****  LAN-LOK  *****"
GOSUB LPause263a:GOSUB LPause263a:GOSUB LPause263a
COLOR 9
LOCATE 12,15
PRINT "          by Mark Chappell and Shane Maloney"
GOSUB LPause263a:GOSUB LPause263a:GOSUB LPause263a
COLOR 12
LOCATE 16,14
PRINT "   Developed at Palmer Station, February-March 1991"
GOSUB LPause263a:GOSUB LPause263a:GOSUB LPause263a

' Init for second intro
SCREEN 12
RANDOMIZE TIMER

GOSUB LLoadPlayers   ' Lae3d -- read "players" file into hist_* arrays
LIntroGfx:   ' LIntroGfx=L01a3
CLS 0

GOSUB LRndSound
' Set background
LINE (0,0)-(640,444),3,BF
' Draw L
LINE (40,30)-(30,150),4:LINE (44,30)-(26,150),4:LINE (38,30)-(31,150),4:LINE (30,150)-(80,140),4:LINE (26,149)-(76,137),4

GOSUB LPause263b
GOSUB LRndSound

' Draw A
LINE (110,135)-(140,20),4:LINE (105,128)-(135,24),4:LINE (107,130)-(137,22),4:LINE (134,20)-(160,134),4
LINE (130,22)-(155,136),4:LINE (120,70)-(140,75),4:LINE (115,74)-(145,74),4:LINE (114,76)-(146,76),4

GOSUB LPause263b
GOSUB LRndSound

' Draw N
LINE (200,20)-(190,134),4:LINE (197,22)-(192,136),4:LINE (204,21)-(195,136),4:LINE (200,20)-(240,150),4
LINE (198,20)-(235,140),4:LINE (197,19)-(236,144),4:LINE (235,145)-(240,20),4:LINE (233,144)-(235,23),4

GOSUB LPause263b
GOSUB LRndSound

' Draw -
LINE (260,80)-(290,80),4:LINE (260,76)-(289,82),4:LINE (259,82)-(292,84),4

GOSUB LPause263b
GOSUB LRndSound

' Draw L
LINE (330,24)-(325,140),4:LINE (326,22)-(333,143),4:LINE (324,138)-(390,140),4:LINE (320,140)-(392,135),4:LINE (319,142)-(393,142),4

GOSUB LPause263b
GOSUB LRndSound

' Draw O
CIRCLE (440,78),65,4,,,1.5:CIRCLE (437,79),66,4,,,1.4:CIRCLE (433,77),63,4,,,1.3

GOSUB LPause263b
GOSUB LRndSound

' Draw K
LINE (520,20)-(535,143),4:LINE (522,21)-(534,142),4:LINE (518,23)-(530,140),4:LINE (520,80)-(570,24),4
LINE (518,82)-(574,23),4:LINE (517,85)-(570,20),4:LINE (517,74)-(575,144),4:LINE (516,70)-(580,145),4:LINE (515,72)-(583,142),4

' Draw (C)
FOR loopI! = 15 TO 18
CIRCLE (600,80),loopI!,1
NEXT loopI!

FOR loopI! = 8 TO 11
CIRCLE (600,80),loopI!,1,0.5,5.8
NEXT loopI!

GOSUB LPause263a: GOSUB LPause263a

' Text box 1
LINE (10,162)-(350,260),0,BF
COLOR 14
LOCATE 14,5
SOUND 1200,3
PRINT "Use your Computer skills"
LINE (260,170)-(330,250),14,BF

' Computer icon
iconScr!=1.0
drawX!=270
drawY!=180
GOSUB LDrawIcon

' Text box 2
iconScr! = 0
GOSUB LPause263a: GOSUB LPause263a
SOUND 800,3
LINE (280,275)-(630,330),0,BF
drawX! = 410
drawY! = 50
COLOR 12
LOCATE 19,50
PRINT "to defeat ";
COLOR 2
PRINT "`Evil Al'"		' Funny aside: The original DS memory address for this string is 0xa666 ...
LOCATE 20,38
GOSUB LPause263a
SOUND 200,4

' Al animation
GOSUB LAlAnim

' Arrow animation
drawClr! = 63:GOSUB LDrawArrow
drawClr! = 13:GOSUB LClrArrow:GOSUB LDrawArrow
drawClr! = 12:GOSUB LClrArrow:GOSUB LDrawArrow
drawClr! = 13:GOSUB LClrArrow:GOSUB LDrawArrow:GOSUB LClrArrow
drawClr! = 4:GOSUB LDrawArrow   ' F0bcb = L0bcb

GOSUB LPause263a
SOUND 900,3
COLOR 10
PRINT "The noxious, noisome, nasty Network Narc"
GOSUB LPause263a
GOSUB LPause263a
GOTO LIntroText     ' Continue the intro there

LRndSound:         ' LRndSound=L0b97 -- Random sound effect
rndSndF! = RND*600+40
SOUND rndSndF!,3
RETURN

LDrawArrow:    ' LDrawArrow=L0bcb -- Draw the arrows
SOUND 100,2
LINE (520,270)-(470,200),drawClr!
LINE (520,270)-(490,270),drawClr!
LINE (470,200)-(490,270),drawClr!
PAINT (500,265),drawClr!,drawClr!
LINE (460,202)-(480,198),drawClr!
LINE (460,175)-(460,202),drawClr!
LINE (460,175)-(480,198),drawClr!
PAINT (463,185),drawClr!,drawClr!
RETURN

LClrArrow:  ' LClrArrow=L0d53 -- Clear the arrows
GOSUB LPause066b
LINE (460,175)-(520,270),3,BF
GOSUB LPause066b
RETURN

LIntroText:		' LIntroText=L0d85 -- Continue the intro

' Text box 3
LINE (10,370)-(630,410),0,BF
COLOR 11
LOCATE 25,4
FOR loopK! = 1 to 8
fanSndF! = RND * 1500 + 40
SOUND fanSndF!,1
NEXT loopK!

PRINT "and";
COLOR 13
PRINT " IRREVOCABLY CRASH";
COLOR 11
PRINT " your reliable, user-friendly  ";
COLOR 10
PRINT "`LOCAL  AREA  NETWORK'"

' Prompt for keypress
LOCATE 29,45
COLOR 15
PRINT "Hit any key to display the rules:";
WHILE LEN(keyIn$)=0
keyIn$=INKEY$
WEND
keyIn$=""

' Rules page
CLS 0
COLOR 9
PRINT "                               L A N - L O K"
COLOR 7
PRINT "    The object of this contest is to try and crash the network by";:color 12:PRINT " disabling "
PRINT " as many of its computers as possible in 5 minutes.";:COLOR 7:PRINT "  You fight against the"
PRINT " efforts of";:COLOR 2:PRINT " Evil Al";:COLOR 7:PRINT ", who attempts to restore the machines.  He fixes them in"
PRINT " the same order that you wreck them.  You gain points by trashing a computer"
PRINT " but you lose points when ";:COLOR 2:PRINT "Al ";:COLOR 7:PRINT "fixes it.  So try to keep ahead of him."
PRINT
PRINT "     There are a total of eleven computers on the Network.  Yours is called "
COLOR 14:PRINT " SKUA ";:COLOR 13:PRINT "-- leave it alone!";:COLOR 7:PRINT "  The other ten are legitimate targets for attack."
PRINT " Before you attack a computer you must ";:COLOR 15:PRINT "select ";:COLOR 7:PRINT "it.  Type `";:COLOR 13:PRINT "select";:COLOR 7:PRINT "' and hit"
PRINT " the ENTER key.  You are then asked the name of the target.  ";:COLOR 15:PRINT "Type it in"
COLOR 12:PRINT " EXACTLY ";:COLOR 15:PRINT "as it appears on the screen or you will get a nasty error message."
PRINT
COLOR 7:PRINT "     When you have selected a target, you can attack it in four ways:"
COLOR 14:PRINT "  (1 and 2)  The easiest methods (i.e. most likely to succeed) are to `";:COLOR 13:PRINT "print";:COLOR 14:PRINT "'"
PRINT "    or `";:COLOR 13:PRINT "send mail";:COLOR 7:PRINT "'.  With high probability, these actions lock the target's"
PRINT "    LAN connection or jam the printer.  ";:COLOR 2:PRINT "Al";:COLOR 7:PRINT " takes 20-30 seconds to fix it."
COLOR 14:PRINT "  (3)  The third attack mode is to erase a directory with `";:COLOR 13:PRINT "del *.*";:COLOR 7:PRINT "'.  This"
PRINT "    is worth more points and takes longer to fix than a LAN lock, but it is"
PRINT "    less likely to succeed."
COLOR 14:PRINT "  (4)  The best (but most difficult) attack mode is to reformat the target's"
PRINT "    hard disk with `";:COLOR 13:PRINT "format c:";:COLOR 7:PRINT "'.  This is worth lots of points and takes a"
PRINT "    long time to fix.  ";:COLOR 12:PRINT "Killing Hobbs is even harder but worth more."
COLOR 7:PRINT
COLOR 14:PRINT "    You WIN";:COLOR 7:PRINT " by";:COLOR 2:PRINT " (1) reformatting Hobbs when you have more than 400 points;"
PRINT " (2) disabling 9 or more of the target computers at once; (3) attaining over  "
PRINT " 1000 points in a single game."
PRINT
COLOR 9:PRINT "    You LOSE";:COLOR 7:PRINT " by";:COLOR 2:PRINT " (1) ending with less than 60 points or (2) reformatting ";:COLOR 14:PRINT "SKUA.";
LINE (0,0)-(639,463),14,B
' Prompt for start or exit
GOSUB Lbca2

CLS 0
GOSUB Lb207
GOSUB Lb786
' Draw the main game screen
compNames$="            lab     labstore    admin     Susi     Calvin    rabbit   library     ratt     Tfive     Hobbs             "
RANDOMIZE TIMER
FOR loopI!=1 TO 5
compStat!(loopI!,3)=16
compStat!(loopI!,4) = loopI! * 120 + -70
NEXT loopI!
FOR loopI!=6 TO 10
compStat!(loopI!,3)=127
compStat!(loopI!,4)=loopI! * 120 + -670
NEXT loopI!
SCREEN 12

' Cyan background
LINE (0,0)-(640,480),3,BF

' Computer terminals
drawY! = 16
loopK! = 6
compIdx! = 1
FOR drawX! = 50 TO 540 STEP 120
GOSUB LDrawIcon
LOCATE loopK!,drawX!/8
compName$=MID$(compNames$,10*compIdx!,10)
PRINT compName$
compIdx!=compIdx!+1
NEXT drawX!
drawY! = 127
loopK! = 13
FOR drawX!=50 TO 540 STEP 120
GOSUB LDrawIcon
LOCATE loopK!,drawX!/8
compName$=MID$(compNames$,10*compIdx!,10)
PRINT compName$
compIdx!=compIdx!+1
NEXT drawX!

' Status window
iconScr!=9
LINE (428,235)-(638,477),0,BF
LINE (430,237)-(636,475),14,B
LINE (430,256)-(636,256),14
LINE (433,441)-(634,470),14,B
COLOR 9
LOCATE 16,58
PRINT "Network Status Board"
COLOR 15
LOCATE 18,57:PRINT "lab:"
LOCATE 19,57:PRINT "labstore:"
LOCATE 20,57:PRINT "admin:"
LOCATE 21,57:PRINT "Susi:"
LOCATE 22,57:PRINT "Calvin:"
LOCATE 23,57:PRINT "rabbit:"
LOCATE 24,57:PRINT "library:"
LOCATE 25,57:PRINT "ratt:"
LOCATE 26,57:PRINT "Tfive:"
LOCATE 27,57:PRINT "Hobbs:"
COLOR 2
FOR loopK!=18 TO 27
LOCATE loopK!,68: PRINT "O.K."
NEXT loopK!
COLOR 12
LOCATE 29,56: PRINT playerName$;"'s SCORE:";
LOCATE 29,74: PRINT 0;

' Al window
LINE (10,235)-(420,350),0,BF
LINE (12,237)-(418,348),14,B
drawX!=30
drawY!=263
GOSUB LAlAnim

alFixPJam!=0
alFixLock!=0
alFixEras!=0
alFixFmt!=0
LOCATE 16,15
COLOR 14
PRINT "Scoreboard for ";:COLOR 2: PRINT "Evil Al";:COLOR 14:PRINT ", Network Narc"
COLOR 3
LOCATE 18,17:PRINT "Printers unjammed:"
LOCATE 19,17:PRINT "Computers unlocked: "
LOCATE 20,17:PRINT "Erasures restored: "
LOCATE 21,17:PRINT "Hard disks reconstructed:  "
COLOR 13
LOCATE 18,44:PRINT alFixPJam!
LOCATE 19,44:PRINT alFixLock!
LOCATE 20,14:PRINT alFixEras!
LOCATE 21,14:PRINT alFixFmt!

' Command window
LINE (10,355)-(420,470),0,BF
LINE (12,357)-(418,468),14,B
LOCATE 24,16
COLOR 2
PRINT "ENTER COMMANDS HERE"
COLOR 9
LOCATE 25,6
PRINT "select, send mail, print, del *.*, format c:"
LOCATE 29,1
COLOR 2
PRINT "TARGET COMPUTER:  ";
COLOR 14:PRINT "SKUA";
COLOR 12
LOCATE 29,34
PRINT "TIME TO GO: ";       
COLOR 13
PRINT "5.00";
LINE (19,445)-(250,465),3,B
LINE (255,445)-(414,465),12,B
LINE (30,363)-(399,404),3,B
LINE (20,410)-(414,436),15,B
SOUND 500,4
SOUND 300,4
SOUND 500,4
SOUND 300,4
gameEnd!=TIMER+300
Fa44e!=0   ' purpose unknown -- used in undecompiled stubs; keep original DS-address name
Fa452!=0   ' purpose unknown -- used in undecompiled stubs; keep original DS-address name
score!=0

' Main game loop?
LGameLoop:   ' LGameLoop=L1e78
dmgCount!=0
curTime!=TIMER
COLOR 15:LOCATE 27,4:PRINT ">"
GOSUB LUpdTimer
IF minsLeft! < 0 THEN GOTO LGameEnd
FOR compI!=1 to 10
  drawX! = compStat!(compI!,4)
  drawY! = compStat!(compI!,3)
  IF compStat!(compI!,1) <> 0 THEN   ' damaged
    dmgCount!=dmgCount!+1
    curTime!=TIMER
    alTarget!=compI!
    IF compStat!(compI!,2) < curTime! THEN GOSUB LAlFix
  ELSE   ' undamaged
    GOSUB LAnimDmg
  END IF
LNextComp:   ' LNextComp=L1fb0
NEXT compI!
IF dmgCount! > 8 THEN GOSUB LVictory
IF dmgCount! > 8 THEN GOTO LFinalTally
IF TIMER > lockUntil! THEN lockUntil!=0
IF TIMER < lockUntil! THEN GOTO LGameLoop

' User input processing
keyIn$ = INKEY$
LOCATE 27,6
IF keyIn$=CHR$(13) THEN GOTO LCmdProc
IF LEN(keyIn$) = 0 THEN GOTO LNoInput
PRINT "                                     "
LNoInput:   ' LNoInput=L20a1
IF LEN(keyIn$) = 0 THEN GOTO LInputEnd
cmdBuf$ = cmdBuf$ + keyIn$
LInputEnd:   ' LInputEnd=L20c8
IF keyIn$=CHR$(27) THEN END
LOCATE 27,6
PRINT cmdBuf$
GOTO LGameLoop

LCmdProc:		' LCmdProc=L210a -- Process the command
IF cmdBuf$="print" OR cmdBuf$="PRINT" THEN GOTO LCmdPrint
IF cmdBuf$="select" OR cmdBuf$="SELECT" THEN GOTO LCmdSel
IF cmdBuf$="send mail" OR cmdBuf$="SEND MAIL" THEN GOTO LCmdMail
IF cmdBuf$="del *.*" OR cmdBuf$="DEL *.*" THEN GOTO LCmdDel
IF cmdBuf$="format c:" OR cmdBuf$="FORMAT C:" THEN GOTO LCmdFmt
LOCATE 27,6
SOUND 200,4
cmdBuf$=""
COLOR 13
PRINT "SYNTAX ERROR, YOU MORON!!!"
GOSUB LResetSel
GOTO LGameLoop

' SELECT command
LCmdSel:   ' LCmdSel=L2276
cmdBuf$=""
LOCATE 27,6
PRINT "SELECT TARGET:"
LSelLoop:   ' LSelLoop=L22a5
FOR selI! = 1 TO 10
drawX! = compStat!(selI!,4)
drawY! = compStat!(selI!,3)
IF compStat!(selI!,1) = 0 THEN GOSUB LAnimDmg
NEXT selI!       
keyIn$ = INKEY$
IF keyIn$ = CHR$(13) THEN GOTO LSelParse
IF LEN(keyIn$)=0 THEN GOTO LSelChk
cmdBuf$ = cmdBuf$ + keyIn$
LSelChk:   ' LSelChk=L2390
LOCATE 27,21
PRINT cmdBuf$
GOTO LSelLoop
LSelParse:	' LSelParse=L23b5 -- ENTER pressed
target! = 0
IF cmdBuf$="lab" THEN target! = 1
IF cmdBuf$="labstore" THEN target! = 2
IF cmdBuf$="admin" THEN target! = 3
IF cmdBuf$="Susi" THEN target! = 4
IF cmdBuf$="Calvin" THEN target! = 5
IF cmdBuf$="rabbit" THEN target! = 6
IF cmdBuf$="library" THEN target! = 7
IF cmdBuf$="ratt" THEN target! = 8
IF cmdBuf$="Tfive" THEN target! = 9
IF cmdBuf$="Hobbs" THEN target! = 10
IF target! = 0 THEN SOUND 150,3
LOCATE 27,6
COLOR 13
IF compStat!(target!,1) = 0 THEN GOTO LSelDone
' Oops - logged into a down system
SOUND 400,2
SOUND 500,2
SOUND 300,2
SOUND 600,2
PRINT "MORON!!  THAT COMPUTER IS CRASHED!!"
GOSUB LPause263a:GOSUB LPause263a:GOSUB LPause263a
COLOR 10
LOCATE 27,6
PRINT "YOUR COMPUTER IS TEMPORARILY LOCKED"
_DELAY (RND(1) + 1) * 13.132  ' lockout 13--26 s (orig: (RND*500000+500000)*F0042! iters)
LOCATE 27,6
PRINT "                                     "
SOUND 800,2
SOUND 1000,2
cmdBuf$=""
GOSUB LResetSel
GOTO LGameLoop

LSelDone:   ' LSelDone=L26a3
IF target! = 0 THEN PRINT "NO SUCH COMPUTER EXISTS, DIPSHIT!!"
IF target! = 0 THEN GOSUB LResetSel
IF target! > 0 THEN PRINT "                                       "
LOCATE 27,22
PRINT "         ";
COLOR 14
rejectP! = score! / 2500 + .07
IF RND <= rejectP! THEN
' Reject randomly
SOUND 100,2
SOUND 400,2
SOUND 100,2
SOUND 400,2
LOCATE 27,6
COLOR 14
PRINT "  TARGET REJECTED BY NETWORK   "
GOSUB LPause263b
LOCATE 27,6
SOUND 1000,1
PRINT "                             "
GOSUB LPause263b
LOCATE 27,6
SOUND 1000,1
PRINT "  TARGET REJECTED BY NETWORK "
LOCATE 27,6
SOUND 1000,1
PRINT "                             "
target! = 0
END IF
LOCATE 27,22
IF target! > 0 THEN PRINT cmdBuf$:ELSE PRINT "SKUA      "
cmdBuf$=""
GOTO LGameLoop

' PRINT command
LCmdPrint:   ' LCmdPrint=L28d7
IF target!=0 THEN GOTO LSelfPJam
RANDOMIZE TIMER
IF RND > .24 AND target! < 10 THEN GOSUB LAtkPJam
IF RND > .3 AND target! = 10 THEN GOSUB LAtkPJam
GOSUB LResetSel
cmdBuf$=""
LOCATE 27,6
PRINT "                       "
GOTO LGameLoop

' SEND MAIL command
LCmdMail:   ' LCmdMail=L29bd
IF target! = 0 THEN GOTO LSelfLock
RANDOMIZE TIMER
IF RND > .12 AND target! < 10 THEN GOSUB LAtkLock
IF RND > .2 AND target! = 10 THEN GOSUB LAtkLock
GOSUB LResetSel
cmdBuf$=""
LOCATE 27,5
PRINT "                       "
GOTO LGameLoop

' DEL command
LCmdDel:   ' LCmdDel=L2aa3
IF target! = 0 THEN GOTO LSelfErase
RANDOMIZE TIMER
IF target! < 10 AND RND > .4 THEN GOSUB LAtkErase
IF target! = 10 AND RND > .6 THEN GOSUB LAtkErase
GOSUB LResetSel
cmdBuf$=""
LOCATE 27,6
PRINT "                       "
GOTO LGameLoop

' FORMAT command
LCmdFmt:   ' LCmdFmt=L2b8d
IF target! = 0 THEN GOTO LLossScreen
RANDOMIZE TIMER
IF target! < 10 AND RND > .63 THEN GOSUB LAtkFmt
IF target! = 10 AND RND > .8 THEN hobbsFmt!=1: ELSE hobbsFmt! = 0
IF target! = 10 AND hobbsFmt! = 1 THEN GOSUB LAtkFmt
IF target! = 10 AND hobbsFmt! = 1 AND score! > 400 THEN GOSUB LVictory
IF target! = 10 AND hobbsFmt! = 1 AND score! > 400 THEN GOTO LFinalTally
GOSUB LResetSel
cmdBuf$=""
LOCATE 27,6
PRINT "                       "
GOTO LGameLoop

' Reset selection
LResetSel:   ' LResetSel=L2d76
target! = 0
LOCATE 27,22
COLOR 14
PRINT "SKUA     "
RETURN

END

' Update displayed timer
LUpdTimer:   ' LUpdTimer=L2dbb
minsLeft! = (gameEnd! - TIMER ) / 60
COLOR 13
LOCATE 29,46
PRINT USING "#.##";minsLeft!;
COLOR 15
RETURN

' Display a computer icon
LDrawIcon:   ' LDrawIcon=L2e2d
' --- Monitor body and outline ---
LINE (drawX!+1,drawY!+(-4))-(drawX!+49,drawY!+34),7,BF        ' Monitor body (gray fill)
LINE (drawX!,drawY!+(-5))-(drawX!+50,drawY!+35),0,B            ' Monitor outline
' --- Base / stand ---
LINE (drawX!+(-5),drawY!+41)-(drawX!+55,drawY!+60),0,B         ' Base outline  [FIXED: was +35]
LINE (drawX!+(-4),drawY!+42)-(drawX!+54,drawY!+59),7,BF        ' Base fill (gray)
' --- Front panel detail ---
LINE (drawX!+4,drawY!+28)-(drawX!+12,drawY!+31),0,B            ' Keyboard slot
LINE (drawX!+(-1),drawY!+47)-(drawX!+9,drawY!+51),0,B          ' Drive bay outline
' --- Lower trim / floppy drive bay ---
LINE (drawX!+15,drawY!+35)-(drawX!+35,drawY!+41),0,B           ' Drive bay frame outline
LINE (drawX!+16,drawY!+36)-(drawX!+34,drawY!+40),7,BF          ' Drive bay frame fill (gray)
' --- Power light box (right side of base) ---
LINE (drawX!+47,drawY!+48)-(drawX!+50,drawY!+51),0,BF          ' Power light box
PSET (drawX!+45,drawY!+49),10                                   ' Power indicator (bright green)
' --- Disk drive area ---
LINE (drawX!+20,drawY!+44)-(drawX!+42,drawY!+57),8,BF          ' Drive area fill (dark gray)
LINE (drawX!+19,drawY!+43)-(drawX!+43,drawY!+58),0,B           ' Drive area outline
LINE (drawX!+23,drawY!+47)-(drawX!+39,drawY!+48),0,BF          ' Drive slot 1
LINE (drawX!+26,drawY!+51)-(drawX!+36,drawY!+52),0,BF          ' Drive slot 2
' --- Screen area ---
LINE (drawX!+6,drawY!)-(drawX!+44,drawY!+24),iconScr!,BF         ' Screen content (color=iconScr!)
LINE (drawX!+41,drawY!+28)-(drawX!+44,drawY!+31),0,BF          ' Screen indicator box
PSET (drawX!+39,drawY!+30),14                                   ' Screen indicator (yellow)
LINE (drawX!+6,drawY!)-(drawX!+44,drawY!+24),0,B               ' Screen outline
RETURN

' Animate computer screen / status display
LAnimDmg:   ' LAnimDmg=L3522
' --- Redraw screen area with active colour (cyan = 9) ---
LINE (drawX!+6,drawY!)-(drawX!+44,drawY!+24),9,BF           ' Screen fill (cyan)
LINE (drawX!+41,drawY!+28)-(drawX!+44,drawY!+31),0,BF       ' Clear screen indicator box
LINE (drawX!+6,drawY!)-(drawX!+44,drawY!+24),0,B             ' Screen outline
' --- Status pixel: flicker between dark grey (8) and yellow (14) ---
IF RND(1) > 0.5 THEN drawClr! = 8 ELSE drawClr! = 14
PSET (drawX!+36,drawY!+54),drawClr!                            ' Activity indicator (drive area)
' --- Scan-line animation: random-length white lines across screen ---
scanYBot! = drawY! + 21
loopI! = drawY! + 3
WHILE loopI! <= scanYBot!
    loopJ! = RND(1) * 32 + 9
    LINE (drawX!+9,loopI!)-(drawX!+loopJ!,loopI!),15         ' White scan line
    loopI! = loopI! + 2
WEND
RETURN

' Al fixes a computer: alert tones, update damage counters, print score, redraw clean icon
LAlFix:   ' LAlFix=L376f
SOUND 800, 2                                           ' Alert beep (low tone)
SOUND 1200, 3                                          ' Alert beep (high tone)
dmgType! = compStat!(INT(alTarget!), 1)                        ' Read damage type of repaired computer
IF dmgType! = 1 THEN alFixLock! = alFixLock! + 1                ' Tally damage-type 1 fix
IF dmgType! = 2 THEN alFixEras! = alFixEras! + 1                ' Tally damage-type 2 fix
IF dmgType! = 3 THEN alFixFmt! = alFixFmt! + 1                ' Tally damage-type 3 fix
IF dmgType! = 4 THEN alFixPJam! = alFixPJam! + 1                ' Tally damage-type 4 fix
' Position at the row for this damage-type tally counter (rows 19-22 = types 1-4)
IF dmgType! < 4 THEN
    LOCATE INT(18 + dmgType!), 44
ELSE
    LOCATE 18, 44
END IF
COLOR 13                                               ' Magenta text
IF dmgType! = 1 THEN PRINT alFixLock!
IF dmgType! = 2 THEN PRINT alFixEras!
IF dmgType! = 3 THEN PRINT alFixFmt!
IF dmgType! = 4 THEN PRINT alFixPJam!
LOCATE INT(17 + alTarget!), 68                            ' Move to OK label column (row = computer's row)
COLOR 2                                                ' Green text
PRINT "O.K.       "                                    ' Print OK confirmation
compStat!(INT(alTarget!), 1) = 0                             ' Clear damage entry (0 = OK)
GOSUB LCalcScore
GOSUB LAlAnim                                            ' Al animation
LINE (drawX!+(-5),drawY!+(-5))-(drawX!+55,drawY!+60),3,BF  ' Erase old icon
GOSUB LDrawIcon                                            ' Redraw clean computer icon
RETURN

' Recalculate total damage score and display it
LCalcScore:   ' LCalcScore=L3a10
newScore! = 0
FOR loopJ! = 1 TO 9
    IF compStat!(loopJ!, 1) = 1 THEN newScore! = newScore! + 50
    IF compStat!(loopJ!, 1) = 2 THEN newScore! = newScore! + 100
    IF compStat!(loopJ!, 1) = 3 THEN newScore! = newScore! + 200
    IF compStat!(loopJ!, 1) = 4 THEN newScore! = newScore! + 60
NEXT loopJ!
' Hobbs (computer 10) scores at higher values
IF compStat!(10, 1) = 1 THEN newScore! = newScore! + 75
IF compStat!(10, 1) = 2 THEN newScore! = newScore! + 130
IF compStat!(10, 1) = 3 THEN newScore! = newScore! + 400
IF compStat!(10, 1) = 4 THEN newScore! = newScore! + 85
IF newScore! < 0 THEN newScore! = 0
LOCATE 29, 74
COLOR 13                                               ' Magenta text
PRINT "    ";
LOCATE 29, 74
PRINT newScore!;
score! = newScore!
RETURN

' Delay ~0.263 s per call -- converted from calibrated FOR loop (F0046!=26405 iters on orig. hw)
LPause263a:   ' LPause263a=L3c57
_DELAY 0.263
' Same duration -- falls through from LPause263a or called directly as LPause263b
LPause263b:   ' LPause263b=L3c90
_DELAY 0.263
RETURN

' Delay ~0.066 s per call -- converted from calibrated FOR loop (F004a!=6601 iters on orig. hw)
LPause066a:   ' LPause066a=L3cc9
_DELAY 0.066
' Same duration -- falls through from LPause066a or called directly as LPause066b
LPause066b:   ' LPause066b=L3d02
_DELAY 0.066
RETURN
' Apply damage to target computer: update repair time, notify, animate (type 1)
LAtkLock:   ' LAtkLock=L3d3b
IF TIMER > repairEnd! THEN repairEnd! = TIMER
repairEnd! = repairEnd! + 12 + RND(1) * 10                  ' Repair time: now + 12-22 s (random)
compStat!(INT(target!), 2) = repairEnd!                      ' Store repair time for target
LOCATE INT(17 + target!), 68
COLOR 14                                              ' Yellow text
PRINT "LAN LOCKED "
compStat!(INT(target!), 1) = 1                           ' Mark damage type 1
GOSUB LCalcScore                                          ' Recalculate score
drawY! = compStat!(INT(target!), 3)                      ' Load target Y screen position
drawX! = compStat!(INT(target!), 4)                      ' Load target X screen position
' Attack animation: 5-step flicker (black / white / black / white / yellow)
LINE (drawX!+6, drawY!)-(drawX!+44, drawY!+24), 0, BF
SOUND 200, 3
GOSUB LPause066a
LINE (drawX!+6, drawY!)-(drawX!+44, drawY!+24), 15, BF
SOUND 200, 3
GOSUB LPause066a
LINE (drawX!+6, drawY!)-(drawX!+44, drawY!+24), 0, BF
SOUND 200, 3
GOSUB LPause066a
LINE (drawX!+6, drawY!)-(drawX!+44, drawY!+24), 15, BF
SOUND 200, 3
GOSUB LPause066a
LINE (drawX!+6, drawY!)-(drawX!+44, drawY!+24), 14, BF    ' Yellow: locked state
GOSUB LPause066a
' Shrinking rectangle with descending tone (700 -> 160 Hz over 19 steps)
FOR loopJ! = 0 TO 18
    SOUND INT(700 - 30 * loopJ!), 1
    LINE (drawX!+6+loopJ!, drawY!+loopJ!/1.33)-(drawX!+44-loopJ!, drawY!+24-loopJ!/1.33), 0, B
NEXT loopJ!
' Draw locked-state indicator on computer icon
LINE (drawX!+21, drawY!+4)-(drawX!+30, drawY!+14), 13, B
LINE (drawX!+21, drawY!+8)-(drawX!+26, drawY!+14), 0, B
LINE (drawX!+26, drawY!+14)-(drawX!+26, drawY!+18), 13
PSET (drawX!+26, drawY!+21), 13
SOUND 100, 12
RETURN
' PRINTER JAM attack: type-4 damage, animates paper feeding then jamming
LAtkPJam:   ' LAtkPJam=L42d5
IF TIMER > repairEnd! THEN repairEnd! = TIMER
repairEnd! = repairEnd! + 16 + RND(1) * 15                  ' Repair time: now + 16-31 s
compStat!(INT(target!), 2) = repairEnd!                      ' Store repair time for target
LOCATE INT(17 + target!), 68
COLOR 9                                               ' Cyan text
PRINT "PRINTER JAM "
compStat!(INT(target!), 1) = 4                           ' Damage type 4
GOSUB LCalcScore                                          ' Recalculate score
drawY! = compStat!(INT(target!), 3)                      ' Load target Y screen position
drawX! = compStat!(INT(target!), 4)                      ' Load target X screen position
' Draw printer icon
LINE (drawX!-5, drawY!-5)-(drawX!+55, drawY!+60), 3, BF     ' Cyan body fill
LINE (drawX!+3, drawY!-4)-(drawX!+55, drawY!+18), 0, B      ' Housing frame outline
LINE (drawX!+4, drawY!-3)-(drawX!+54, drawY!+17), 7, BF     ' Grey top cover
LINE (drawX!-5, drawY!-3)-(drawX!-1, drawY!+12), 0, BF      ' Paper feed slot (black)
LINE (drawX!-4, drawY!-2)-(drawX!-2, drawY!+11), 8, BF      ' Slot depth (dark grey)
LINE (drawX!-1, drawY!)-(drawX!+3, drawY!+9), 0, B          ' Paper guide (left edge)
LINE (drawX!+6, drawY!)-(drawX!+51, drawY!+3), 0, BF        ' Output slot (top of body)
GOSUB LPause066a
' Paper frame 1 (y=2..12): blank sheet appears
LINE (drawX!+8, drawY!+2)-(drawX!+49, drawY!+12), 0, B      ' Paper outline
LINE (drawX!+9, drawY!+2)-(drawX!+48, drawY!+11), 15, BF    ' Paper fill (white)
GOSUB LPause066a
' NOTE: dmgType! (=Fa496!) reused as paper-scan Y and loop variable below -- not damage type here
FOR dmgType! = 3 TO 9 STEP 2
    paperLen! = RND(1) * 35 + 10
    LINE (drawX!+10, drawY!+dmgType!)-(drawX!+paperLen!, drawY!+dmgType!), 0
NEXT dmgType!
SOUND 200, 1
' Paper frame 2 (y=12..22)
LINE (drawX!+8, drawY!+12)-(drawX!+49, drawY!+22), 0, B
LINE (drawX!+9, drawY!+12)-(drawX!+48, drawY!+21), 15, BF
GOSUB LPause066a
FOR dmgType! = 11 TO 19 STEP 2
    paperLen! = RND(1) * 35 + 10
    LINE (drawX!+10, drawY!+dmgType!)-(drawX!+paperLen!, drawY!+dmgType!), 0
NEXT dmgType!
SOUND 200, 1
' Paper frame 3 (y=22..30)
LINE (drawX!+8, drawY!+23)-(drawX!+49, drawY!+30), 0, B
LINE (drawX!+9, drawY!+22)-(drawX!+48, drawY!+29), 15, BF
GOSUB LPause066a
FOR dmgType! = 21 TO 30 STEP 2
    paperLen! = RND(1) * 35 + 10
    LINE (drawX!+10, drawY!+dmgType!)-(drawX!+paperLen!, drawY!+dmgType!), 0
NEXT dmgType!
SOUND 200, 1
' Paper frame 4 (y=30..36)
LINE (drawX!+8, drawY!+30)-(drawX!+49, drawY!+36), 0, B
LINE (drawX!+9, drawY!+30)-(drawX!+48, drawY!+35), 15, BF
GOSUB LPause066a
FOR dmgType! = 31 TO 35 STEP 2
    paperLen! = RND(1) * 35 + 10
    LINE (drawX!+10, drawY!+dmgType!)-(drawX!+paperLen!, drawY!+dmgType!), 0
NEXT dmgType!
SOUND 200, 1
' Paper frame 5 (y=36..random): variable-length jammed page
jamH! = RND(1) * 23 + 37
LINE (drawX!+8, drawY!+36)-(drawX!+49, drawY!+jamH!+1), 0, B
LINE (drawX!+9, drawY!+36)-(drawX!+48, drawY!+jamH!), 15, BF
GOSUB LPause066a
jamLim! = jamH! - 1
dmgType! = 37
WHILE dmgType! <= jamLim!
    paperLen! = RND(1) * 35 + 10
    LINE (drawX!+10, drawY!+dmgType!)-(drawX!+paperLen!, drawY!+dmgType!), 0
    dmgType! = dmgType! + 2
WEND
SOUND 200, 1
' Descending alarm cascade: 700 Hz down to 100 Hz in -50 steps
FOR dmgType! = 700 TO 100 STEP -50
    SOUND INT(dmgType!), 1
NEXT dmgType!
' Jammed paper chaos: 30 random paper scrawls with creaking sound
FOR dmgType! = 1 TO 30
    paperLen! = RND(1) * 35 + 10
    chaosY! = RND(1) * 20 + 3
    LINE (drawX!+10, drawY!+chaosY!)-(drawX!+paperLen!, drawY!+chaosY!), 0
    SOUND 130, 1
NEXT dmgType!
RETURN
' ERASED attack: type-2 damage, flicker animation then red X painted across icon
LAtkErase:   ' LAtkErase=L5018
IF TIMER > repairEnd! THEN repairEnd! = TIMER
repairEnd! = repairEnd! + 30 + RND(1) * 15               ' Repair time: now + 30-45 s
compStat!(INT(target!), 2) = repairEnd!                   ' Store repair time for target
compStat!(INT(target!), 1) = 2                        ' Damage type 2 (ERASED)
GOSUB LCalcScore                                        ' Recalculate score
LOCATE INT(17 + target!), 68
COLOR 12                                              ' Light-red text
PRINT "ERASED     "
drawY! = compStat!(INT(target!), 3)                   ' Load target Y screen position
drawX! = compStat!(INT(target!), 4)                   ' Load target X screen position
' Flicker animation: 4 black/white cycles (LPause263b = 0.263 s each)
LINE (drawX!+6, drawY!)-(drawX!+44, drawY!+24), 0, BF
SOUND 200, 3
GOSUB LPause263b
LINE (drawX!+6, drawY!)-(drawX!+44, drawY!+24), 15, BF
SOUND 200, 3
GOSUB LPause263b
LINE (drawX!+6, drawY!)-(drawX!+44, drawY!+24), 0, BF
SOUND 200, 3
GOSUB LPause263b
LINE (drawX!+6, drawY!)-(drawX!+44, drawY!+24), 15, BF
SOUND 200, 3
GOSUB LPause263b
' 5th step: final black fill + long low-tone SOUND (no _DELAY -- SOUND itself blocks)
LINE (drawX!+6, drawY!)-(drawX!+44, drawY!+24), 0, BF
SOUND 100, 12
' Draw red X over icon: two crossing diagonal bands (color 4 = red)
' First arm: upper-left to lower-right
LINE (drawX!, drawY!-5)-(drawX!-5, drawY!), 4
LINE (drawX!-5, drawY!)-(drawX!+50, drawY!+60), 4
LINE (drawX!+50, drawY!+60)-(drawX!+55, drawY!+55), 4
LINE (drawX!+55, drawY!+55)-(drawX!, drawY!-5), 4
PAINT (drawX!, drawY!), 4, 4
' Second arm: upper-right to lower-left
LINE (drawX!+50, drawY!-5)-(drawX!+55, drawY!), 4
LINE (drawX!+55, drawY!)-(drawX!, drawY!+60), 4
LINE (drawX!-5, drawY!+55)-(drawX!+50, drawY!-5), 4
PAINT (drawX!, drawY!+55), 4, 4
PAINT (drawX!+50, drawY!), 4, 4
RETURN
' FORMAT C: attack -- type-3 damage, concentric circles then disk-wipe animation
LAtkFmt:   ' LAtkFmt=L56c4
  IF TIMER > repairEnd! THEN repairEnd! = TIMER
  repairEnd! = repairEnd! + 37 + RND(1) * 20              ' Repair time: now + 37-57 s
  compStat!(INT(target!), 2) = repairEnd!                  ' Store repair time for target
  compStat!(INT(target!), 1) = 3                           ' Damage type 3 (FORMAT C:)
  GOSUB LCalcScore                                         ' Recalculate score
  LOCATE INT(17 + target!), 68
  COLOR 13                                                 ' Magenta text
  PRINT "REFORMATTED"
  drawY! = compStat!(INT(target!), 3)                      ' Load target Y screen position
  drawX! = compStat!(INT(target!), 4)                      ' Load target X screen position
  GOSUB LDrawIcon
  GOSUB LPause066a
  ' --- 3 concentric black circles (disk destroy effect) ---
  circR! = 0                                               ' circR!=Fa4be!: circle color param (0=black)
  CIRCLE (drawX!+25, drawY!+27), 30, INT(circR!)           ' Outer ring
  SOUND 700, 1
  GOSUB LPause066a
  CIRCLE (drawX!+25, drawY!+27), 18, INT(circR!)           ' Middle ring
  SOUND 700, 1
  GOSUB LPause066a
  CIRCLE (drawX!+25, drawY!+27), 6, INT(circR!)            ' Inner ring
  SOUND 700, 1
  GOSUB LPause066a
  ' --- Black center crosshair lines, then pause ---
  LINE (drawX!+25, drawY!-4)-(drawX!+25, drawY!+59), 0    ' Vertical center line
  LINE (drawX!-5, drawY!+27)-(drawX!+55, drawY!+27), 0    ' Horizontal center line
  SOUND 700, 1
  GOSUB LPause263b
  ' --- Shrink loop: alternating circR!=14/0 circle animations (6 iters) ---
  ' NOTE: dmgType! (=Fa496!) reused as loop counter below -- not damage type here
  FOR dmgType! = 1 TO 6
    circR! = 14
    GOSUB LCircXhair                                            ' Circle animator (undecompiled)
    SOUND 1200, 1
    circR! = 0
    GOSUB LCircXhair
    SOUND 900, 1
  NEXT dmgType!
  circR! = 14
  GOSUB LCircXhair                                              ' Final circle pass
  GOSUB LPause066b
  GOSUB LPause263a
  ' --- Flash loop: yellow/magenta BF fills alternating 5 times ---
  ' NOTE: dmgType! reused again as loop counter
  FOR dmgType! = 1 TO 5
    LINE (drawX!-5, drawY!-5)-(drawX!+55, drawY!+60), 14, BF  ' Yellow fill
    GOSUB LDrawIcon
    SOUND 500, 1
    LINE (drawX!-5, drawY!-5)-(drawX!+55, drawY!+60), 5, BF   ' Magenta fill
    GOSUB LDrawIcon
    SOUND 900, 1
  NEXT dmgType!
  ' --- Black erase fill, then pause ---
  LINE (drawX!-5, drawY!-5)-(drawX!+55, drawY!+60), 0, BF
  GOSUB LPause263b
  ' --- White cross pattern (vertical bar + horizontal bar overlapping) ---
  LINE (drawX!+15, drawY!)-(drawX!+35, drawY!+58), 15, BF      ' Vertical white bar
  LINE (drawX!, drawY!+10)-(drawX!+50, drawY!+30), 15, BF      ' Horizontal white bar
  ' --- Green format-scan: random-height stubs sweep icon bottom (x: -4 to +54) ---
  ' NOTE: loopK! (=F003a!) used as scan column counter
  FOR loopK! = -4 TO 54
    fmtBarH! = 59 - RND(1) * 8                              ' fmtBarH!=Fa4c2!: random top y
    LINE (drawX!+loopK!, drawY!+59)-(drawX!+loopK!, drawY!+fmtBarH!), 2  ' Green scan bar
  NEXT loopK!
  ' --- Damage indicator marker (floppy-slot pattern at icon lower area) ---
  LINE (drawX!+13, drawY!+13)-(drawX!+13, drawY!+25), 0
  LINE (drawX!+13, drawY!+13)-(drawX!+19, drawY!+19), 0, B
  LINE (drawX!+15, drawY!+19)-(drawX!+18, drawY!+25), 0
  PSET (drawX!+21, drawY!+25), 0
  LINE (drawX!+26, drawY!+13)-(drawX!+26, drawY!+25), 0
  PSET (drawX!+29, drawY!+25), 0
  LINE (drawX!+33, drawY!+13)-(drawX!+33, drawY!+25), 0
  LINE (drawX!+33, drawY!+13)-(drawX!+39, drawY!+19), 0, B
  PSET (drawX!+38, drawY!+25), 0
  LINE (drawX!+20, drawY!+31)-(drawX!+27, drawY!+42), 0, B
  LINE (drawX!+27, drawY!+34)-(drawX!+27, drawY!+39), 15
  PSET (drawX!+31, drawY!+35), 0
  PSET (drawX!+31, drawY!+38), 0
RETURN
' Circle + crosshair animator: draw/erase 3 rings + center lines using circR! as color
LCircXhair:   ' LCircXhair=L61cb -- called from LAtkFmt shrink loop with circR! pre-set
  CIRCLE (drawX!+25, drawY!+27), 30, INT(circR!)   ' Outer ring (color 0=erase, 14=yellow)
  CIRCLE (drawX!+25, drawY!+27), 18, INT(circR!)   ' Middle ring
  CIRCLE (drawX!+25, drawY!+27), 6, INT(circR!)    ' Inner ring
  LINE (drawX!+25, drawY!-4)-(drawX!+25, drawY!+59), INT(circR!)  ' Vertical crosshair
  LINE (drawX!-5, drawY!+27)-(drawX!+55, drawY!+27), INT(circR!)  ' Horizontal crosshair
RETURN
' Al repairman draw + blink animation (drawn at drawX!, drawY!)
LAlAnim:   ' LAlAnim=L637d -- Draw Al and animate blinking (5 iterations)
' === INITIAL DRAW ===
' Background: cyan fill covering Al figure area
LINE (drawX!-5, drawY!-5)-(drawX!+55, drawY!+60), 3, BF
' Face: black circle outline + gray fill
CIRCLE (drawX!+25, drawY!+30), 20, 0
PAINT (drawX!+25, drawY!+30), 7, 0
' Collar: cyan filled area then black outline polygon
LINE (drawX!+3, drawY!+22)-(drawX!+45, drawY!), 3, BF
LINE (drawX!+22, drawY!-5)-(drawX!+26, drawY!-4), 0
LINE (drawX!+26, drawY!-4)-(drawX!+45, drawY!+22), 0
LINE (drawX!+22, drawY!-5)-(drawX!+10, drawY!+4), 0
LINE (drawX!+10, drawY!+4)-(drawX!+19, drawY!+2), 0
LINE (drawX!+19, drawY!+2)-(drawX!+21, drawY!+3), 0
LINE (drawX!+3, drawY!+22)-(drawX!+21, drawY!+3), 0
LINE (drawX!+3, drawY!+22)-(drawX!+45, drawY!+22), 0
' Collar badge: bright-blue fill + black box outline
LINE (drawX!+6, drawY!+19)-(drawX!+44, drawY!+21), 9, BF
LINE (drawX!+5, drawY!+18)-(drawX!+45, drawY!+22), 0, B
' Green shirt fill (floods interior of collar polygon)
PAINT (drawX!+25, drawY!), 2, 0
' Antenna interior diagonal
LINE (drawX!+3, drawY!+22)-(drawX!+24, drawY!+1), 0
' LED button (white circle r=2 filled + black border circle r=3)
CIRCLE (drawX!+9, drawY!+5), 2, 15
PAINT (drawX!+9, drawY!+5), 15, 15
CIRCLE (drawX!+9, drawY!+5), 3, 0
' Eyes: black pupils (r=2) filled, light-red outline (r=2), white highlights
CIRCLE (drawX!+20, drawY!+29), 2, 0
CIRCLE (drawX!+30, drawY!+29), 2, 0
PAINT (drawX!+20, drawY!+29), 0, 0
PAINT (drawX!+30, drawY!+29), 0, 0
CIRCLE (drawX!+20, drawY!+29), 2, 12
CIRCLE (drawX!+30, drawY!+29), 2, 12
PSET (drawX!+21, drawY!+28), 15
PSET (drawX!+31, drawY!+28), 15
' Nose dots (r=1 black circles)
CIRCLE (drawX!+24, drawY!+34), 1, 0
CIRCLE (drawX!+26, drawY!+34), 1, 0
' Mouth smile (two overlapping arcs: r=20 and r=19, center at y+60 for upward bow)
CIRCLE (drawX!+25, drawY!+60), 20, 0, 1.1, 2.0
CIRCLE (drawX!+25, drawY!+60), 19, 0, 1.1, 2.0
' Body/shirt/arms/legs: 73 black lines
LINE (drawX!+21, drawY!+22)-(drawX!+5, drawY!+30), 0
LINE (drawX!+29, drawY!+22)-(drawX!+44, drawY!+30), 0
LINE (drawX!+18, drawY!+22)-(drawX!+7, drawY!+28), 0
LINE (drawX!+31, drawY!+22)-(drawX!+45, drawY!+28), 0
LINE (drawX!+15, drawY!+22)-(drawX!+6, drawY!+27), 0
LINE (drawX!+35, drawY!+22)-(drawX!+46, drawY!+27), 0
LINE (drawX!+12, drawY!+22)-(drawX!+5, drawY!+30), 0
LINE (drawX!+38, drawY!+22)-(drawX!+43, drawY!+30), 0
LINE (drawX!+10, drawY!+22)-(drawX!+5, drawY!+30), 0
LINE (drawX!+40, drawY!+22)-(drawX!+44, drawY!+30), 0
LINE (drawX!+7, drawY!+22)-(drawX!+4, drawY!+30), 0
LINE (drawX!+42, drawY!+22)-(drawX!+47, drawY!+30), 0
LINE (drawX!+5, drawY!+22)-(drawX!+3, drawY!+30), 0
LINE (drawX!+44, drawY!+22)-(drawX!+47, drawY!+30), 0
LINE (drawX!+5, drawY!+22)-(drawX!+3, drawY!+39), 0
LINE (drawX!+44, drawY!+22)-(drawX!+46, drawY!+39), 0
LINE (drawX!+4, drawY!+22)-(drawX!+2, drawY!+40), 0
LINE (drawX!+45, drawY!+22)-(drawX!+48, drawY!+40), 0
LINE (drawX!+10, drawY!+22)-(drawX!+6, drawY!+41), 0
LINE (drawX!+39, drawY!+22)-(drawX!+44, drawY!+41), 0
LINE (drawX!+8, drawY!+22)-(drawX!+4, drawY!+43), 0
LINE (drawX!+37, drawY!+22)-(drawX!+45, drawY!+43), 0
LINE (drawX!+25, drawY!+46)-(drawX!+23, drawY!+57), 0
LINE (drawX!+22, drawY!+45)-(drawX!+21, drawY!+58), 0
LINE (drawX!+27, drawY!+46)-(drawX!+29, drawY!+57), 0
LINE (drawX!+28, drawY!+44)-(drawX!+25, drawY!+58), 0
LINE (drawX!+29, drawY!+45)-(drawX!+27, drawY!+59), 0
LINE (drawX!+23, drawY!+46)-(drawX!+23, drawY!+57), 0
LINE (drawX!+22, drawY!+45)-(drawX!+25, drawY!+58), 0
LINE (drawX!+21, drawY!+46)-(drawX!+24, drawY!+57), 0
LINE (drawX!+19, drawY!+44)-(drawX!+22, drawY!+58), 0
LINE (drawX!+17, drawY!+45)-(drawX!+21, drawY!+59), 0
LINE (drawX!+28, drawY!+37)-(drawX!+42, drawY!+46), 0
LINE (drawX!+22, drawY!+37)-(drawX!+8, drawY!+46), 0
LINE (drawX!+27, drawY!+38)-(drawX!+42, drawY!+48), 0
LINE (drawX!+22, drawY!+38)-(drawX!+8, drawY!+48), 0
LINE (drawX!+25, drawY!+46)-(drawX!+25, drawY!+57), 0
LINE (drawX!+22, drawY!+47)-(drawX!+21, drawY!+58), 0
LINE (drawX!+27, drawY!+47)-(drawX!+29, drawY!+57), 0
LINE (drawX!+28, drawY!+47)-(drawX!+29, drawY!+58), 0
LINE (drawX!+29, drawY!+47)-(drawX!+31, drawY!+59), 0
LINE (drawX!+22, drawY!+47)-(drawX!+23, drawY!+57), 0
LINE (drawX!+28, drawY!+47)-(drawX!+27, drawY!+57), 0
LINE (drawX!+28, drawY!+47)-(drawX!+30, drawY!+58), 0
LINE (drawX!+29, drawY!+47)-(drawX!+29, drawY!+59), 0
LINE (drawX!+18, drawY!+45)-(drawX!+19, drawY!+58), 0
LINE (drawX!+33, drawY!+45)-(drawX!+32, drawY!+57), 0
LINE (drawX!+16, drawY!+44)-(drawX!+17, drawY!+58), 0
LINE (drawX!+35, drawY!+44)-(drawX!+34, drawY!+59), 0
LINE (drawX!+14, drawY!+43)-(drawX!+15, drawY!+57), 0
LINE (drawX!+37, drawY!+43)-(drawX!+37, drawY!+57), 0
LINE (drawX!+12, drawY!+41)-(drawX!+13, drawY!+58), 0
LINE (drawX!+39, drawY!+41)-(drawX!+38, drawY!+59), 0
LINE (drawX!+10, drawY!+39)-(drawX!+9, drawY!+58), 0
LINE (drawX!+41, drawY!+39)-(drawX!+39, drawY!+59), 0
LINE (drawX!+8, drawY!+27)-(drawX!+9, drawY!+56), 0
LINE (drawX!+6, drawY!+25)-(drawX!+10, drawY!+58), 0
LINE (drawX!+43, drawY!+27)-(drawX!+35, drawY!+57), 0
LINE (drawX!+45, drawY!+26)-(drawX!+37, drawY!+58), 0
LINE (drawX!+18, drawY!+45)-(drawX!+23, drawY!+58), 0
LINE (drawX!+33, drawY!+45)-(drawX!+26, drawY!+57), 0
LINE (drawX!+16, drawY!+44)-(drawX!+21, drawY!+58), 0
LINE (drawX!+35, drawY!+44)-(drawX!+30, drawY!+59), 0
LINE (drawX!+14, drawY!+43)-(drawX!+19, drawY!+57), 0
LINE (drawX!+37, drawY!+43)-(drawX!+32, drawY!+57), 0
LINE (drawX!+12, drawY!+41)-(drawX!+18, drawY!+58), 0
LINE (drawX!+39, drawY!+41)-(drawX!+33, drawY!+59), 0
LINE (drawX!+10, drawY!+39)-(drawX!+15, drawY!+58), 0
LINE (drawX!+41, drawY!+39)-(drawX!+34, drawY!+59), 0
LINE (drawX!+8, drawY!+27)-(drawX!+11, drawY!+56), 0
LINE (drawX!+6, drawY!+25)-(drawX!+12, drawY!+58), 0
LINE (drawX!+43, drawY!+27)-(drawX!+34, drawY!+57), 0
LINE (drawX!+45, drawY!+26)-(drawX!+35, drawY!+58), 0
' === BLINK ANIMATION LOOP (5 iterations) ===
' NOTE: dmgType! (=Fa496!) reused as loop counter below -- not damage type here
FOR dmgType! = 1 TO 5
    SOUND INT(RND(1) * 500 + 40), 1
    ' Shift highlights right: draw at +21/+31, erase at +19/+29
    PSET (drawX!+21, drawY!+28), 15
    PSET (drawX!+31, drawY!+28), 15
    PSET (drawX!+19, drawY!+28), 0
    PSET (drawX!+29, drawY!+28), 0
    ' Close eyes: gray circles at outer eye positions
    CIRCLE (drawX!+14, drawY!+35), 3, 7
    PAINT (drawX!+14, drawY!+35), 7, 7
    CIRCLE (drawX!+37, drawY!+35), 3, 7
    PAINT (drawX!+37, drawY!+35), 7, 7
    ' Eyelid V-lines: gray chevron above eye area
    LINE (drawX!+25, drawY!+27)-(drawX!+18, drawY!+23), 7
    LINE (drawX!+25, drawY!+27)-(drawX!+32, drawY!+23), 7
    GOSUB LPause263b   ' Delay ~0.263 s (eyes closed)
    ' Shift highlights back left: erase at +21/+31, draw at +19/+29
    PSET (drawX!+21, drawY!+28), 0
    PSET (drawX!+31, drawY!+28), 0
    PSET (drawX!+19, drawY!+28), 15
    PSET (drawX!+29, drawY!+28), 15
    ' Erase eyelid V-lines with black
    LINE (drawX!+25, drawY!+27)-(drawX!+18, drawY!+23), 0
    LINE (drawX!+25, drawY!+27)-(drawX!+32, drawY!+23), 0
    ' Open eyes: magenta circles (color 5)
    CIRCLE (drawX!+14, drawY!+35), 3, 5
    PAINT (drawX!+14, drawY!+35), 5, 5
    CIRCLE (drawX!+37, drawY!+35), 3, 5
    PAINT (drawX!+37, drawY!+35), 5, 5
    GOSUB LPause263b   ' Delay ~0.263 s (eyes open)
NEXT dmgType!
RETURN
' Self-attack: player aimed PRINT (PRINTER JAM) at own machine (SKUA)
' Plays descending beep cascade 700->100 Hz step -30, sets 25 s repair timer
LSelfPJam:   ' LSelfPJam=L902f -- Player jammed own printer
' NOTE: dmgType! (=Fa496!) reused as descending SOUND freq below -- not damage type here
dmgType! = 700   ' start freq (DS:0xb4a6=700)
WHILE dmgType! >= 100   ' stop at 100 Hz (DS:0xb47a=100)
    SOUND INT(dmgType!), 1   ' 1 tick (~55 ms) per step; step = -30 (DS:0xb512=-30)
    dmgType! = dmgType! - 30
WEND
repairEnd! = TIMER + 25   ' 25 s lockout (DS:0xb4f6=25)
lockMsg$ = "YOU JAMMED YOUR OWN PRINTER, BUTTHEAD!"
rstMsg$ = "   YOUR COMPUTER IS NOW UNLOCKED      "
GOSUB LRepairUI   ' repair-wait UI loop (FUN_01a2_bab9)
GOSUB LResetSel   ' reset target display to SKUA (L2d76)
GOTO LGameLoop    ' back to main game loop (L1e78)
' Self-attack: player aimed LAN LOCK at own machine (SKUA)
' Single warning beep, 25 s repair timer, then wait-for-repair loop
LSelfLock:   ' LSelfLock=L90ad -- Player locked own LAN
SOUND 2000, 3   ' 2000 Hz, 3 ticks ~0.165 s (AX=0x7d0, DS:0xa624=3.0)
repairEnd! = TIMER + 25   ' 25 s lockout (DS:0xb4f6=25)
lockMsg$ = "YOUR COMPUTER IS LOCKED, ASSHOLE!"
rstMsg$ = "   YOUR COMPUTER IS NOW UNLOCKED     "
GOSUB LRepairUI   ' repair-wait UI loop (FUN_01a2_bab9)
GOSUB LResetSel   ' reset target display to SKUA (L2d76)
GOTO LGameLoop    ' back to main game loop (L1e78)
' Self-attack: player aimed DEL *.* (erase) at own machine (SKUA)
' Adds 45 s to existing repair timer (or starts fresh 45 s if already expired)
LSelfErase:   ' LSelfErase=L90f7 -- Player erased own directory (DEL *.* on SKUA)
SOUND 2000, 3   ' 2000 Hz, 3 ticks ~0.165 s (AX=0x7d0, DS:0xa624=3.0)
' If repair timer already expired, start fresh 45 s; else extend current by 45 s
IF TIMER > repairEnd! THEN
    repairEnd! = TIMER + 45   ' expired -- start fresh lockout (DS:0xb42a=45)
ELSE
    repairEnd! = repairEnd! + 45   ' still locked -- extend by 45 s more
END IF
lockMsg$ = "GOOD GOING, BOZO.  YOU ERASED YOUR DIRECTORY."
rstMsg$ = "  HAPPY AL HAS RESTORED YOUR DIRECTORY.      "
GOSUB LRepairUI   ' repair-wait UI loop (FUN_01a2_bab9)
GOSUB LResetSel   ' reset target display to SKUA (L2d76)
GOTO LGameLoop    ' back to main game loop (L1e78)
' Victory screen -- player successfully crashed the network
LVictory:   ' LVictory=L9170 -- Victory screen: network crashed, player wins
Fa44e! = 1   ' set victory flag (FLD {1.0} / FSTP [0xa44e])
GOSUB LPause263a
' Flash "VICTORY !!" text 4 times, alternating COLOR 10 (bright green) and 2 (green)
LOCATE 27, 6 : COLOR 10
SOUND 1200, 2 : PRINT "  ***** VICTORY !! *****     "
SOUND 1000, 2 : GOSUB LPause263a
LOCATE 27, 6 : PRINT "                          " : GOSUB LPause263a
LOCATE 27, 6 : COLOR 2
SOUND 1200, 2 : PRINT "  ***** VICTORY !! *****     "
SOUND 1000, 2 : GOSUB LPause263a
LOCATE 27, 6 : PRINT "                          " : GOSUB LPause263a
LOCATE 27, 6 : COLOR 10
SOUND 1200, 2 : PRINT "  ***** VICTORY !! *****     "
SOUND 1000, 2 : GOSUB LPause263a
LOCATE 27, 6 : PRINT "                          " : GOSUB LPause263a
LOCATE 27, 6 : COLOR 2
SOUND 1200, 2 : PRINT "  ***** VICTORY !! *****     "
SOUND 1000, 2 : GOSUB LPause263a : GOSUB LPause263a
' Victory fanfare
SOUND 1000, 5 : SOUND 700, 5 : SOUND 1000, 5 : SOUND 700, 5 : SOUND 1000, 5
CLS 0
GOSUB LPause263a
' Score panel background and border
LINE (50,150)-(590,400), 3, BF
LINE (48,148)-(592,402), 14, B
' Congratulations text -- panel draws at y=150-400; LOCATE rows are text-layer rows
LOCATE 2, 25 : COLOR 13 : GOSUB LPause263a
PRINT "C O N G R A T U L A T I O N S ! ! !"
LOCATE 4, 22 : COLOR 15
GOSUB LPause263a : GOSUB LPause263a : GOSUB LPause263a
PRINT "You have successfully "; : COLOR 12 : PRINT "CRASHED "; : COLOR 15 : PRINT "the network."
GOSUB LPause263a : GOSUB LPause263a
COLOR 10 : LOCATE 6, 18
PRINT "This victory increases your score by 2000 points."
_DELAY 2.367   ' 9 x LPause263a ~0.263 s (orig: FOR counter=1..9 CALL L3c57)
LOCATE 8, 29 : COLOR 2
PRINT "Evil Al "; : COLOR 14 : PRINT "is not happy."
GOSUB LPause263a
SOUND 110, 2 : SOUND 130, 3
GOSUB LPause263a : GOSUB LPause263a
drawX! = 300   ' DS:0xb154=300, fixed position for victory Al anim
drawY! = 330   ' DS:0xb710=330
GOSUB LAlAnim
GOSUB LPause263a : GOSUB LPause263a : GOSUB LPause263a
' Victory jingle
SOUND 80, 3 : SOUND 120, 3 : SOUND 80, 2 : SOUND 110, 2 : SOUND 130, 3
GOSUB LPause263a : GOSUB LPause263a
' Network crash graphic -- concentric rings then erased network nodes
CIRCLE (299,338), 3, 0   ' inner crash ring (DS:0xa624=3.0)
GOSUB LPause263a
CIRCLE (285,329), 5, 0   ' middle crash ring (DS:0xaf7c=5.0)
GOSUB LPause263a
CIRCLE (267,316), 8, 0   ' outer crash ring (DS:0xa614=8.0)
GOSUB LPause263a
' Antenna symbol
LINE (80,290)-(110,170), 0
LINE (110,170)-(140,290), 0
LINE (95,230)-(125,230), 0
GOSUB LPause263b
' Computer node A (x=150-195): box + screen divider + cyan side highlights
LINE (150,290)-(195,170), 0, B
LINE (150,230)-(195,230), 0
LINE (150,281)-(150,231), 3
LINE (195,179)-(195,229), 3
GOSUB LPause263b
' Computer node B (x=210-255)
LINE (210,290)-(255,170), 0, B
LINE (210,230)-(255,230), 0
LINE (210,281)-(210,231), 3
LINE (255,179)-(255,229), 3
GOSUB LPause263b
' Computer node C (x=270-315): divider line is higher (y=240 not y=230)
LINE (270,290)-(315,170), 0, B
LINE (270,240)-(315,240), 0
LINE (271,290)-(314,290), 3
LINE (271,170)-(314,170), 3
GOSUB LPause263b
' Computer node D (x=330-375): box outline only
LINE (330,290)-(375,170), 0, B
GOSUB LPause263b
' L-shaped element (x=390-435): vertical + 2 horizontal stubs
LINE (390,290)-(390,170), 0
LINE (390,290)-(435,290), 0
LINE (435,290)-(435,280), 0
GOSUB LPause263b
' Computer node E (x=455-500): box + divider + right cyan highlight
LINE (455,290)-(500,170), 0, B
LINE (455,230)-(500,230), 0
LINE (500,289)-(500,171), 3
GOSUB LPause263b
' Post with dot A (x=527)
LINE (527,170)-(527,275), 0
LINE (526,288)-(528,290), 0, B
GOSUB LPause263b
' Post with dot B (x=550)
LINE (550,170)-(550,275), 0
LINE (549,288)-(551,290), 0, B
_DELAY 1.052   ' 4 x LPause263a ~0.263 s (orig: FOR counter=1..4 CALL L3c57)
GOSUB Lbca2    ' end-of-game handler (FUN_01a2_bca2, not yet decompiled)
RETURN
' Draw bullseye target (3 ring pairs + crosshair) at screen center, color=INT(circR!)
' Called from loss screen (FUN_01a2_9c28) with circR!=12 (light red) or 14 (yellow)
LTargetXhair:   ' LTargetXhair=L9ae7 -- bullseye + crosshair at (320,240), color INT(circR!)
' 3 concentric ring pairs (two circles 1 px apart each to thicken the ring)
CIRCLE (320,240), 220, INT(circR!)   ' outer ring A (DS:0xb714=220)
CIRCLE (320,240), 221, INT(circR!)   ' outer ring B (DS:0xb718=221)
CIRCLE (320,240), 120, INT(circR!)   ' middle ring A (DS:0xaf74=120)
CIRCLE (320,240), 121, INT(circR!)   ' middle ring B (DS:0xb71c=121)
CIRCLE (320,240), 40, INT(circR!)    ' inner ring A (DS:0xa6b0=40)
CIRCLE (320,240), 41, INT(circR!)    ' inner ring B (DS:0xb3fa=41)
' Crosshair lines through screen center
LINE (320,20)-(320,460), INT(circR!)    ' vertical   (x=320, y 0x14..0x1cc)
LINE (100,240)-(540,240), INT(circR!)   ' horizontal (y=240, x 0x64..0x21c)
RETURN
' ============================================================
' FUN_01a2_9c28 = LLossScreen -- FORMAT C: self-attack + GAME OVER
' Entry LLossScreen: called (CALL) from FUN_01a2_19fa when
'   player attacks SKUA (their own machine) with FORMAT C:
' Entry LGameEnd=La58f: jumped (JMP) to from game loop
'   (FUN_01a2_19fa:01a2:1edb) when game ends normally
' Entry LFinalTally=Laba9: jumped to from multiple game-loop exits
' DOES NOT RETURN -- ends with GOTO L01a3 (game restart)
' ============================================================
LLossScreen:   ' LLossScreen=L9c28 -- FORMAT C: attack sequence
  SCREEN 12
  CLS 0
  SOUND 1600, 1
  LINE (0,0)-(640,480), 3, BF        ' cyan background
  _DELAY 0.263   ' LPause263a (9c79)
  ' SKUA computer figure -- 21 LINEs
  LINE (120,300)-(520,420), 0, B     ' outer case outline
  LINE (121,301)-(519,419), 7, BF   ' case fill gray
  LINE (140,20)-(500,260), 0, B      ' screen border
  LINE (141,21)-(499,259), 7, BF    ' screen fill gray
  LINE (271,261)-(369,299), 7, BF   ' strip between screen and body
  LINE (270,260)-(370,300), 0, B    ' strip border
  LINE (160,40)-(480,230), 0, BF    ' display area black
  LINE (280,310)-(440,410), 0, BF   ' lower body
  LINE (282,312)-(438,408), 8, BF   ' keyboard dark gray
  LINE (300,330)-(410,333), 0, BF   ' drive slot
  LINE (280,346)-(440,347), 0, B    ' separator line
  LINE (330,360)-(380,363), 0, BF   ' button area
  LINE (280,376)-(440,377), 0, B    ' lower separator
  LINE (394,385)-(398,388), 10, BF  ' green LED
  LINE (150,340)-(210,365), 0, B    ' left side detail
  LINE (460,237)-(480,253), 0, BF   ' right detail 1
  LINE (450,249)-(454,252), 10, BF  ' green LED
  LINE (160,237)-(190,250), 0, B    ' left upper detail
  LINE (480,357)-(500,370), 0, BF   ' right detail 2
  LINE (470,350)-(510,377), 0, B    ' right detail border
  LINE (474,367)-(477,370), 10, BF  ' green LED
  COLOR 7
  LOCATE 4, 23
  PRINT "Hi!  My name is SKUA"    ' DS:0xb720
  _DELAY 0.263   ' LPause263a
  LOCATE 6, 23
  PRINT "> format c:"             ' DS:0xb738
  LOCATE 7, 23
  PRINT "Oh, no......"            ' DS:0xb748
  ' circles (white, radius pairs) interleaved with dialog at (320,240)
  LOCATE 9, 23
  CIRCLE (320,240), 220, 15        ' outer ring A (DS:0xb714)
  CIRCLE (320,240), 221, 15        ' outer ring B (DS:0xb718)
  SOUND 1600, 1
  _DELAY 0.263   ' LPause263a
  CIRCLE (320,240), 120, 15        ' middle ring A (DS:0xaf74)
  PRINT "My mind is going....."   ' DS:0xb758 at row 9, col 23
  LOCATE 11, 23
  CIRCLE (320,240), 121, 15        ' middle ring B (DS:0xb71c)
  SOUND 1600, 1
  _DELAY 0.263   ' LPause263a
  CIRCLE (320,240), 40, 15         ' inner ring A (DS:0xa6b0)
  PRINT "I can feel it......"      ' DS:0xb772 at row 11, col 23
  LOCATE 13, 23
  CIRCLE (320,240), 41, 15         ' inner ring B (DS:0xb3fa)
  SOUND 1600, 1
  _DELAY 0.263   ' LPause263a
  LINE (320,20)-(320,460), 15      ' vertical crosshair
  LINE (100,240)-(540,240), 15     ' horizontal crosshair
  SOUND 1600, 1
  _DELAY 0.263   ' LPause263a
  ' bullseye flash loop: 5 iterations, PRINT "aaa"; at current row 13
  ' NOTE: dmgType! (=Fa496!) reused as loop counter below -- not damage type here
  FOR dmgType! = 1 TO 5
    PRINT "aaa";                   ' DS:0xb78a, no newline
    circR! = 12                    ' light-red bullseye
    GOSUB LTargetXhair
    SOUND 1200, 1
    circR! = 14                    ' yellow bullseye
    GOSUB LTargetXhair
    SOUND 800, 1
  NEXT dmgType!
  PRINT "rrrrgh!!!"               ' DS:0xb792 at current cursor
  circR! = 14
  GOSUB LTargetXhair
  ' descending alarm: 1000->100 step -50, SOUND INT(freq),1 each
  ' NOTE: dmgType! reused as descending freq variable here
  FOR dmgType! = 1000 TO 100 STEP -50
    SOUND INT(dmgType!), 1
  NEXT dmgType!
  ' color flash sequence -- SCREEN 12 between each fill clears screen
  SCREEN 12
  LINE (0,0)-(640,480), 7, BF    ' gray
  SCREEN 12
  SOUND 100, 4
  SCREEN 12
  LINE (0,0)-(640,480), 14, BF   ' yellow
  SCREEN 12
  SOUND 200, 3
  SCREEN 12
  LINE (0,0)-(640,480), 1, BF    ' dark blue
  SCREEN 12
  SOUND 500, 4
  SCREEN 12
  LINE (0,0)-(640,480), 15, BF   ' white
  SCREEN 12
  SOUND 300, 5
  SCREEN 12
  LINE (0,0)-(640,480), 7, BF    ' gray
  SCREEN 12
  LINE (0,0)-(640,480), 0, BF    ' black
  _DELAY 0.789   ' 3 x LPause263a
  LOCATE 5, 32
  PRINT "You stupid SHIT!!"               ' DS:0xb7a4
  _DELAY 1.052   ' 4 x LPause263a
  LOCATE 13, 22
  PRINT "You reformatted your own hard disk."  ' DS:0xb7ba
  _DELAY 1.052   ' 4 x LPause263a
  LOCATE 19, 29
  PRINT "Real smooth move, geek."         ' DS:0xb7e2
  ' 6 x LPause263a = _DELAY 1.578 s
  ' NOTE: dmgType! reused as delay loop counter here
  FOR dmgType! = 1 TO 6
    _DELAY 0.263
  NEXT dmgType!
  ' Set column offset and self-format flag (format C: path only)
  Fa4d2! = 15     ' column offset: INT(6+15)=21 for GAME OVER display
  Fa452! = 1      ' self-format penalty flag (will subtract 2000 at tally)

LGameEnd:   ' LGameEnd=La58f -- game-end score check (entry from game loop)
  IF score! > 1000 THEN GOSUB LVictory
  IF score! > 1000 THEN Fa44e! = 1
  IF score! <= 1000 THEN GOTO LGameOver
  GOTO LFinalTally

LGameOver:   ' La5e0 -- GAME OVER flash, 4 colors, row 27
  ' column = INT(6 + Fa4d2!): 21 first/format-C game, 6 subsequent
  LOCATE 27, INT(6 + Fa4d2!)
  COLOR 10
  PRINT "     GAME OVER !! "    ' DS:0xb7fe, green
  SOUND 500, 4
  _DELAY 0.263   ' LPause263a
  LOCATE 27, INT(6 + Fa4d2!)
  PRINT "                    "  ' DS:0xb814, 20 spaces
  _DELAY 0.263   ' LPause263a
  LOCATE 27, INT(6 + Fa4d2!)
  COLOR 13
  PRINT "     GAME OVER !!"     ' DS:0xb82c, magenta
  SOUND 500, 4
  _DELAY 0.263   ' LPause263a
  LOCATE 27, INT(6 + Fa4d2!)
  PRINT "                    "  ' DS:0xb814
  _DELAY 0.263   ' LPause263a
  LOCATE 27, INT(6 + Fa4d2!)
  COLOR 9
  PRINT "     GAME OVER !! "    ' DS:0xb7fe, light blue
  SOUND 500, 4
  _DELAY 0.263   ' LPause263a
  LOCATE 27, INT(6 + Fa4d2!)
  PRINT "                    "  ' DS:0xb814
  _DELAY 0.263   ' LPause263a
  LOCATE 27, INT(6 + Fa4d2!)
  COLOR 14
  PRINT "     GAME OVER !!"     ' DS:0xb82c, yellow
  SOUND 500, 4
  _DELAY 0.789   ' 3 x LPause263a
  IF score! < 60 THEN GOTO LTooFewPoints
  GOTO LFinalTally

LTooFewPoints:   ' La7db -- score < 60 path
  IF Fa4d2! <> 15 THEN GOTO LNotEnoughPts
  GOTO LYouLose   ' first-game: Fa4d2!=15, skip NOT ENOUGH, go direct to YOU LOSE

LNotEnoughPts:   ' La7f1 -- NOT ENOUGH POINTS flash (subsequent games, Fa4d2!=0)
  Fa4d2! = 0      ' DS:0xa64c=0 -- reset column offset
  _DELAY 0.263   ' LPause263a
  COLOR 10
  SOUND 800, 1
  LOCATE 27, 6
  PRINT "       NOT ENOUGH POINTS !!"  ' DS:0xb842
  LOCATE 27, 6
  PRINT "                           "  ' DS:0xb862, 27 spaces
  _DELAY 0.263   ' LPause263b (FUN_01a2_3c90)
  LOCATE 27, 6
  SOUND 800, 1
  PRINT "       NOT ENOUGH POINTS !!"
  _DELAY 0.263   ' LPause263a
  LOCATE 27, 6
  PRINT "                           "  ' 27 spaces
  _DELAY 0.263   ' LPause263b
  LOCATE 27, 6
  SOUND 800, 1
  PRINT "       NOT ENOUGH POINTS !!"
  _DELAY 0.263   ' LPause263a
  LOCATE 27, 6
  PRINT "                           "  ' 27 spaces
  _DELAY 0.526   ' 2 x LPause263a

LYouLose:   ' La980 -- YOU LOSE WEENIE flash x4
  SOUND 200, 3
  SOUND 120, 5
  COLOR 13
  LOCATE 27, INT(6 + Fa4d2!)     ' 21 first game, 6 subsequent
  PRINT " ***** YOU LOSE, WEENIE !!! *******"  ' DS:0xb8a2
  _DELAY 0.263   ' LPause263a
  LOCATE 27, INT(6 + Fa4d2!)
  PRINT "                                   "  ' DS:0xb8ca, 35 spaces
  _DELAY 0.263   ' LPause263a
  SOUND 200, 3
  SOUND 120, 5
  LOCATE 27, INT(6 + Fa4d2!)
  PRINT " ***** YOU LOSE, WEENIE !!! *******"
  _DELAY 0.263   ' LPause263a
  LOCATE 27, INT(6 + Fa4d2!)
  PRINT "                                   "
  _DELAY 0.263   ' LPause263a
  SOUND 200, 3
  SOUND 120, 5
  LOCATE 27, INT(6 + Fa4d2!)
  PRINT " ***** YOU LOSE, WEENIE !!! *******"
  _DELAY 0.263   ' LPause263a
  LOCATE 27, INT(6 + Fa4d2!)
  PRINT "                                   "
  _DELAY 0.263   ' LPause263a
  SOUND 200, 3
  SOUND 120, 5
  LOCATE 27, INT(6 + Fa4d2!)
  PRINT " ***** YOU LOSE, WEENIE !!! *******"
  _DELAY 1.052   ' 4 x LPause263a (La980 counter loop F003a! 1-4)
  Fa4d2! = 0     ' DS:0xa64c -- reset column offset for next game

LFinalTally:   ' Laba9 -- final score tally, history update, game reset
  ' Entered from: LGameEnd (win path), LGameOver (score>=60 loss),
  '               game loop (XREF 01a2:2003, 01a2:2d3e)
  CLS 0
  ' Score history arrays (indexed by Fa4d6! = player/session slot)
  ' Array A (DS base 0x9e2a): Fa4da! = high score for this slot
  ' Array B (DS base 0xa15a): Fa4de! = game count for this slot
  Fa4da! = hist_hiScore!(INT(slotNum!))   ' DS:0x9e2a + slot*4
  Fa4de! = hist_games!(INT(slotNum!))    ' DS:0xa15a + slot*4
  IF score! < 60 THEN Fa452! = 1   ' self-format or low-score penalty flag
  ' apply score bonuses/penalties
  IF Fa44e! = 1 THEN score! = score! + 2000   ' +2000 victory bonus
  IF Fa452! = 1 THEN score! = score! - 2000   ' -2000 format-C or low-score penalty
  ' update high score if beaten
  IF score! > Fa4da! THEN Fa4da! = score!
  ' running average: avg = (avg*(n-1) + score) / n
  Fa4e2! = Fa4e2! * Fa4de!
  Fa4de! = Fa4de! + 1
  Fa4e2! = (Fa4e2! + score!) / Fa4de!
  ' write updated history back to arrays before saving
  hist_hiScore!(INT(slotNum!)) = Fa4da!
  hist_games!(INT(slotNum!)) = Fa4de!
  hist_avg!(INT(slotNum!)) = Fa4e2!
  GOSUB Lb207          ' display score table (FUN_01a2_b207)
  GOSUB LSavePlayers   ' save player history to "players" file (FUN_01a2_b029)
  GOSUB Lbca2          ' end of game handler (FUN_01a2_bca2, not yet decompiled)
  ' reset victory and penalty flags for next game
  Fa44e! = 0   ' DS:0xa64c = 0
  Fa452! = 0   ' DS:0xa64c = 0
  ' clear compStat!(1..10, 1..4) for next game
  ' NOTE: dmgType! reused as outer loop (col 1-10) here
  FOR dmgType! = 1 TO 10
    FOR Fa4e6! = 1 TO 4
      compStat!(INT(dmgType!), INT(Fa4e6!)) = 0
    NEXT Fa4e6!
  NEXT dmgType!
  cmdBuf$ = ""   ' clear command buffer (Sa46e$=Sa46e$)
  GOTO LIntroGfx   ' restart game (LAB_01a2_01a3 = LIntroGfx)
' ============================================================
' FUN_01a2_ae3d = LLoadPlayers -- read player history from "players" file
' Called ONCE from ENTRY (01a2:01a0), immediately after RANDOMIZE TIMER,
'   before the L01a3 game-restart loop begins.
' Reads numPlayers! player slots; stores history into in-memory arrays
'   at DS:0x9c92 + per-field offset + INT(loopK!)*4.
' DS:0xb8fa = string descriptor {len=7, ptr=0xb8fe} = "players"
' Symmetric to LSavePlayers; handles missing file gracefully (first run).
' ============================================================
LLoadPlayers:   ' LLoadPlayers=Lae3d
  namesBuf$ = ""
  ON ERROR GOTO LLoadPlayersErr
  OPEN "players" FOR INPUT AS #1
  ON ERROR GOTO 0
  INPUT #1, numPlayers!   ' total player history slots (DS:0xa4ee)
  playersLim! = numPlayers!   ' save loop limit (DS:0xa4f2)
  ' NOTE: loopK! (=F003a!) reused as player-slot index here -- not a timing loop
  FOR loopK! = 1 TO playersLim!
    INPUT #1, compName$   ' player machine name
    namesBuf$ = namesBuf$ + compName$         ' accumulate all names (DS:0xa4f6)
    hist_namelen!(INT(loopK!)) = CSNG(LEN(compName$))   ' DS:0x9d5e+slot*4
    INPUT #1, histHiSc!
    hist_hiScore!(INT(loopK!)) = histHiSc!   ' DS:0x9e2a+slot*4
    INPUT #1, Fa4de!
    hist_games!(INT(loopK!)) = Fa4de!        ' DS:0xa15a+slot*4
    INPUT #1, Fa4fe!
    hist_f4!(INT(loopK!)) = Fa4fe!           ' DS:0x9ef6+slot*4
    INPUT #1, Fa502!
    hist_f5!(INT(loopK!)) = Fa502!           ' DS:0x9fc2+slot*4
    INPUT #1, Fa4e2!
    hist_avg!(INT(loopK!)) = Fa4e2!          ' DS:0xa08e+slot*4
  NEXT loopK!
  CLOSE #1
  GOTO LLoadPlayersDone
LLoadPlayersErr:   ' file not found on first run -- start fresh
  numPlayers! = 0
  namesBuf$ = ""
  RESUME LLoadPlayersDone
LLoadPlayersDone:
  RETURN
' ============================================================
' FUN_01a2_b029 = LSavePlayers -- write player history to "players" file
' Called from LFinalTally (01a2:ad87) after each game ends.
' Symmetric to LLoadPlayers: reads in-memory hist_* arrays -> PRINT #1 to file.
' DS:0xb8fa = "players"; OPEN mode arg=2 (OUTPUT), vs mode=1 (INPUT) in LLoadPlayers.
' SUB_0e71_764b(1) + SUB_0e71_7864 = PRINT #1 channel setup before each value.
' SUB_0e71_7fee = MID$() -- extract substring from namesBuf$
' Note: hist_namelen!, hist_hiScore!, hist_games!, hist_f4!, hist_f5!, hist_avg!
'   are unnamed QB arrays in DS; DIM statements are in ENTRY (raw ASM, not yet decompiled)
' ============================================================
LSavePlayers:   ' LSavePlayers=Lb029
  ' OPEN "players" FOR OUTPUT AS #1
  ' (SUB_0e71_4226: 0xb8fa="players" desc, type=1, 0xffff, mode=2)
  OPEN "players" FOR OUTPUT AS #1
  PRINT #1, numPlayers!   ' write slot count first (DS:0xa4ee=16)
  namePos! = 1            ' start position in namesBuf$ for MID$ extraction (DS:0xa506)
  saveLim! = numPlayers!  ' loop limit (DS:0xa50a = copy of numPlayers!)
  ' NOTE: loopK! (=F003a!) reused as player-slot write index below
  FOR loopK! = 1 TO saveLim!
    ' get name length from hist_namelen! array: DS:0x9d5e + INT(loopK!)*4
    nameLen! = hist_namelen!(INT(loopK!))   ' store in DS:0xa50e
    ' extract this slot's name from the accumulated namesBuf$ string
    compName$ = MID$(namesBuf$, INT(namePos!), INT(nameLen!))
    namePos! = namePos! + nameLen!           ' advance to next name
    PRINT #1, compName$                      ' write player name
    PRINT #1, hist_hiScore!(INT(loopK!))     ' high score  DS:0x9e2a+slot*4
    PRINT #1, hist_games!(INT(loopK!))       ' game count  DS:0xa15a+slot*4
    PRINT #1, hist_f4!(INT(loopK!))          ' field 4     DS:0x9ef6+slot*4
    PRINT #1, hist_f5!(INT(loopK!))          ' field 5     DS:0x9fc2+slot*4
    PRINT #1, hist_avg!(INT(loopK!))         ' running avg DS:0xa08e+slot*4
  NEXT loopK!
  ' CLOSE #1  (SUB_0e71_4452 with args 1, 1)
  CLOSE #1
  RETURN
' ============================================================
' FUN_01a2_b207 = Lb207 -- display player score table
' Called from: LIntroText (01a2:13e6), LFinalTally (01a2:ad84), FUN_01a2_b786 (01a2:baa9)
' Shows a 2-row header, loops numPlayers! slots printing name+score+games+won+lost+avg,
' then prints the champion line and draws border LINEs.
' SUB_0e71_82be = TAB() -- positions cursor to column n before each field
' FUN_0d75_0449 = QB float display pass-through (translated as PRINT directly)
' Column layout (colBase!=1 for left, 41 for right -- all 16 players use left here):
'   col colBase!     : slot# (bright white)
'   col colBase!+13  : hi-score / max score (cyan COLOR 9)
'   col colBase!+19  : games played (#, white COLOR 7)
'   col colBase!+24  : won (hist_f4!, magenta COLOR 13)
'   col colBase!+29  : lost (hist_f5!, light-red COLOR 12)
'   col colBase!+34  : avg score / mean (yellow COLOR 14)  <-- ends with PRINT (newline)
' Header strings (DS):
'   0xb906 = " #  name      max   |---games---| mean   #  name      max   |---games---| mean"
'   0xb958 = "         score  #   won  lost score               score  #   won  lost score"
' Champion line strings: 0xb9ba="Current champion player is " / 0xb9da=", with a mean score of"
' ============================================================
Lb207:   ' Lb207=Lb207
  namePos! = 1    ' reset start position in namesBuf$ (Fa506!, DS:0xa506)
  COLOR 3         ' cyan header text
  LOCATE 1, 1
  PRINT " #  name      max   |---games---| mean   #  name      max   |---games---| mean"
  PRINT "         score  #   won  lost score               score  #   won  lost score"
  PRINT ""        ' blank separator line (second empty PRINT from ASM)

  bestAvg! = -999999  ' Fa512! -- best avg seen (init very low; DS:0xb9ac=-999999)
  champSlot! = 0      ' Fa516! -- slot of best-avg player (DS:0xa64c=0)
  tableLimit! = numPlayers!   ' Fa51a! -- loop limit
  ' NOTE: loopK! (=F003a!) reused as player-slot loop counter below
  FOR loopK! = 1 TO tableLimit!

    ' Determine column base: left (1) for slots < 22, right (41) for slots >= 22.
    ' With numPlayers!=16 all slots use colBase!=1 (right path never triggers).
    IF loopK! < 22 THEN   ' DS:0xb4c6 = 22
      colBase! = 1        ' Fa51e! (DS:0xa550=1)
    ELSE
      colBase! = 41       ' Fa51e! (DS:0xb3fa=41)
    END IF

    ' Read history fields for this slot into temps
    hiScSlot! = hist_hiScore!(INT(loopK!))   ' Fa522! DS:0xa522  (stride 0x198)
    winsSlot! = hist_f4!(INT(loopK!))        ' Fa526! DS:0xa526  (stride 0x264 -- "won")
    lossSlot! = hist_f5!(INT(loopK!))        ' Fa52a! DS:0xa52a  (stride 0x330 -- "lost")
    Fa4de! = hist_games!(INT(loopK!))        ' games  DS:0xa4de  (stride 0x4c8)
    Fa4e2! = hist_avg!(INT(loopK!))          ' avg    DS:0xa4e2  (stride 0x3fc)

    ' Track champion: if this slot's avg beats the running best, update all three
    ' at once (ASM splits into two separate compares with name-save in between, but
    ' the condition is identical both times so collapsing is safe).
    IF Fa4e2! > bestAvg! THEN   ' first compare: DS:0xa512 vs DS:0xa4e2
      champSlot! = loopK!       ' Fa516! -- record who is best
      champName$ = MID$(namesBuf$, INT(namePos!), INT(nameLen!))   ' Sa52e$ DS:0xa52e
      bestAvg! = Fa4e2!         ' Fa512! -- raise the bar (second compare in ASM)
    END IF

    ' For right-column slots (>21 players): LOCATE to correct row on the right side.
    ' col=40 puts cursor just left of colBase!=41; TAB(41) below moves it there.
    IF loopK! > 21 THEN   ' DS:0xb45e = 21
      LOCATE INT(loopK! - 18), 40   ' row=loopK!+[0xb9b0=-18]; col=0x28=40
    END IF

    ' Read this slot's name length from hist_namelen! array (DS:0x9d5e stride 0xcc)
    nameLen! = hist_namelen!(INT(loopK!))   ' Fa50e! DS:0xa50e

    ' Print slot index (bright white) at column colBase! using TAB positioning
    COLOR 15
    PRINT TAB(INT(colBase!)); loopK!;   ' slot number; QB adds leading+trailing space
    ' Alignment: single-digit slots (1-9) get one extra space so the name column
    ' lines up regardless of slot-number width. DS:0xaf94=9
    IF loopK! > 9 THEN
      PRINT "";   ' no extra space for two-digit slot numbers
    ELSE
      PRINT " ";  ' extra space after single-digit slot number
    END IF

    ' Print player name (bright green) using MID$ into namesBuf$
    COLOR 10
    PRINT MID$(namesBuf$, INT(namePos!), INT(nameLen!));

    ' Print numeric score columns with color coding
    COLOR 9                                      ' light blue -- max/hi score
    PRINT TAB(INT(13 + colBase!)); hiScSlot!;    ' col 14 left / 54 right (DS:0xa678=13)
    COLOR 7                                      ' white -- games count
    PRINT TAB(INT(19 + colBase!)); Fa4de!;       ' col 20 left / 60 right (DS:0xb43a=19)
    COLOR 13                                     ' light magenta -- won (hist_f4)
    PRINT TAB(INT(24 + colBase!)); winsSlot!;    ' col 25 left / 65 right (DS:0xb456=24)
    COLOR 12                                     ' light red -- lost (hist_f5)
    PRINT TAB(INT(29 + colBase!)); lossSlot!;    ' col 30 left / 70 right (DS:0xb4ca=29)
    COLOR 14                                     ' yellow -- average/mean score
    PRINT TAB(INT(34 + colBase!)); Fa4e2!        ' col 35 left / 75 right; NEWLINE ends row

    namePos! = namePos! + nameLen!   ' advance to next name in namesBuf$ (DS:0xa506)
  NEXT loopK!

  ' After loop: print champion announcement line
  ' DS:0xb9ba = "Current champion player is "
  ' Sa52e$ = champName$ (set in loop when best avg was updated)
  ' DS:0xb9da = ", with a mean score of"
  LOCATE 26, 10   ' row=0x1a=26, col=0xa=10
  COLOR 2         ' green
  PRINT "Current champion player is ";
  COLOR 12        ' light red -- champion name
  PRINT champName$;   ' Sa52e$ DS:0xa52e
  COLOR 2
  PRINT ", with a mean score of";
  COLOR 13        ' light magenta -- champion avg
  PRINT bestAvg!  ' Fa512!; PRINT_float_newline ends with newline

  ' Draw decorative borders around the table
  LINE (0,0)-(639,460), 14, B        ' yellow outer border (full-screen height)
  LINE (320,0)-(320,392), 14         ' yellow vertical center divider (2-column layout)
  LINE (2,392)-(637,420), 11, B      ' cyan border below player list
  LINE (0,40)-(640,40), 14           ' yellow separator under header (y=40)
  LINE (2,422)-(637,458), 14, B      ' yellow border around champion area
  RETURN
' ============================================================
' FUN_01a2_b786 = Lb786 -- select or register player for this game session
' Called from: LIntroText (01a2:13e9); retry via b80c and b9ae self-JMPs
' Shows score table, asks for player slot#, selects existing or registers new.
' Prompt DS:0xb9f4 = "Enter player # (99 for new player):" (35 chars)
' Clear  DS:0xba1c = 51 spaces (used to blank the prompt row after input)
' Error  DS:0xba54 = "PLAYER FILE FULL.  USE EXISTING NAME." (37 chars)
' Name prompt DS:0xba7e = "Enter player name: " (19 chars)
' Max slots DS:0xb43e = 43.0; sound dur DS:0xa6b4 = 2.0
' INPUT for player#  uses SUB_0e71_7e1a + 77fc (float input) then FUN_0d75_0449
' INPUT for name     uses SUB_0e71_7e20 + 77fc (string input to Sa436$/playerName$)
' SUB_0e71_7fca = LEFT$(str, n) -- truncate to 9 chars max
' SUB_0e71_7cb1 = STRING_CONCAT; FUN_0d75_03c4 = CSNG (int-to-float for hist_namelen)
' On existing player exit: Fa4e2!=hist_avg![slotNum!], Fa536!=0, RETURN
' On new player: GOTO Lb207 (tail-call; Lb207 RETURN goes to our caller)
' ============================================================
Lb786:   ' Lb786=Lb786
  compName$ = ""     ' Sa432$ DS:0xa432 -- clear before each attempt (SET_STRING "" -> a432)
  LOCATE 28, 5       ' row=0x1c=28, col=0x5=5
  COLOR 15           ' bright white prompt text
  INPUT "Enter player # (99 for new player):"; slotNum!   ' Fa4d6! DS:0xa4d6
  ' Note: QB INPUT reads the string, QB runtime converts to float in slotNum!
  ' FUN_0d75_0449 at b7ed re-normalizes the float (translated as no-op in BASIC)

  ' Validate: slot must be >= 1  (JNC b80f: retry when slotNum! < 1)
  IF slotNum! < 1 THEN GOTO Lb786

  ' Clear the prompt row (DS:0xba1c = 51 spaces)
  LOCATE 28, 5
  PRINT "                                                   "   ' 51 spaces

  ' Route: existing slot (<=numPlayers!) vs new/overflow (>numPlayers!)
  IF slotNum! > numPlayers! THEN GOTO Lb786New   ' JMP b907

  ' ---------------------------------------------------------------
  ' Existing player path (b847-b903)
  ' Scan namesBuf$ for the selected slot to extract playerName$
  ' ---------------------------------------------------------------
Lb786Exist:   ' LAB_01a2_b847
  namePos! = 1          ' Fa506! -- reset to start of namesBuf$ (DS:0xa506)
  slotCopy! = slotNum!  ' Fa532! DS:0xa532 -- loop limit for name extraction
  ' NOTE: loopK! (=F003a!) reused as name-scan counter below
  FOR loopK! = 1 TO slotCopy!
    nameLen! = hist_namelen!(INT(loopK!))   ' Fa50e! DS:0xa50e (stride 0xcc from 0x9c92)
    playerName$ = MID$(namesBuf$, INT(namePos!), INT(nameLen!))   ' Sa436$ DS:0xa436
    namePos! = namePos! + nameLen!   ' advance past this name
  NEXT loopK!
  ' playerName$ now holds the name for the chosen slot (last iteration of loop)

  ' Load this player's historical average into Fa4e2! for LFinalTally scoring
  Fa4e2! = hist_avg!(INT(slotNum!))   ' DS:0xa08e + slot*4 (hist_avg stride 0x3fc)
  Fa536! = 0   ' DS:0xa536 -- 0 = existing player selected (cleared on normal exit)
  RETURN

  ' ---------------------------------------------------------------
  ' New player (overflow) path (b907+)
  ' ---------------------------------------------------------------
Lb786New:   ' LAB_01a2_b907
  ' If roster is at max capacity (43 slots), play error tones and retry
  IF numPlayers! >= 43 THEN   ' DS:0xb43e = 43.0
    SOUND 800, 2   ' DS:0xa6b4=2.0 dur; alternating high/low tones x3 pairs
    SOUND 400, 2
    SOUND 800, 2
    SOUND 400, 2
    SOUND 800, 2
    SOUND 400, 2
    LOCATE 28, 5
    PRINT "PLAYER FILE FULL.  USE EXISTING NAME."   ' DS:0xba54
    GOSUB LPause263a   ' FUN_01a2_3c57 -- ~0.263 s delay
    GOSUB LPause263a
    GOSUB LPause263a
    GOTO Lb786   ' retry
  END IF

  ' Clamp entered number to the next available slot (b9b1-b9d7)
  ' Any number >numPlayers! (e.g. the conventional "99") becomes numPlayers!+1
  IF slotNum! > numPlayers! THEN   ' JA b9c7
    slotNum! = numPlayers! + 1
  END IF
  ' If the slot is exactly one past the current count, expand the roster (b9d8-b9fd)
  IF slotNum! = numPlayers! + 1 THEN   ' JZ b9f3
    numPlayers! = slotNum!   ' Fa4ee! DS:0xa4ee -- increment count
  END IF

  ' Get the new player's computer name (9-char max)
  LOCATE 28, 5
  INPUT "Enter player name: "; playerName$   ' Sa436$ DS:0xa436; SUB_0e71_7e20
  IF LEN(playerName$) > 9 THEN              ' JG ba53: SUB_0e71_7fca = LEFT$
    playerName$ = LEFT$(playerName$, 9)
  END IF

  ' Append name to namesBuf$ and record its length in the history array
  namesBuf$ = namesBuf$ + playerName$          ' STRING_CONCAT -> Sa4f6$ DS:0xa4f6
  hist_namelen!(INT(slotNum!)) = CSNG(LEN(playerName$))   ' FUN_0d75_03c4 = CSNG; DS:0x9d5e+slot*4

  ' Redisplay the score table then return to our caller via Lb207's RETURN
  ' (JMP b207 = tail-call: Lb207 executes and its RETURN pops back to our caller)
  GOTO Lb207
LRepairUI:   ' LRepairUI=Lbab9 -- wait for player lockout timer, animating all computers
  LOCATE 27, 6
  COLOR 13
  PRINT lockMsg$   ' Sa4c6$; lockout error msg (set by caller before GOSUB)
LRepairWait:   ' LAB_01a2_baec -- outer loop: repeat until repairEnd! expires
  FOR compI! = 1 TO 10
    drawX! = compStat!(compI!, 4)        ' X screen coord (col j=4, offset 0xb0)
    drawY! = compStat!(compI!, 3)        ' Y screen coord (col j=3, offset 0x84)
    IF compStat!(compI!, 1) = 0 THEN    ' col j=1, offset 0x2c: 0 = undamaged (OK)
      GOSUB LAnimDmg                     ' animate healthy computer screen
    ELSE                                 ' damaged -- check if Al's repair time has elapsed
      curTime! = TIMER
      alTarget! = compI!
      IF compStat!(compI!, 2) < curTime! THEN GOSUB LAlFix   ' col j=2 repair due time
    END IF
  NEXT compI!
  IF TIMER < repairEnd! THEN GOTO LRepairWait   ' JNC bc01: exit when TIMER >= repairEnd!

  ' Lockout expired: alert tone, display ready message, reset input buffer
  SOUND 3000, 4
  LOCATE 27, 6
  COLOR 2
  PRINT rstMsg$   ' Sa4ca$; ready/OK message (set by caller before GOSUB)
  cmdBuf$ = ""    ' Sa46e$; clear command input accumulator
  GOSUB LPause263b
  GOSUB LPause263b
  GOSUB LPause263b
  LOCATE 27, 6
  PRINT "                                           "   ' 43 spaces (DS:0xba96) -- clear msg row
  RETURN
Lbca2:   ' Lbca2=Lbca2 -- end-of-game: show "hit any key" prompt, wait for keypress, ESC quits
  COLOR 15
  keyIn$ = ""   ' Sa242$; SET_STRING empty (DS:0xa73e) -> Sa242$ (DS:0xa242)
  LOCATE 30, 35
  PRINT "Hit any key to continue, or <Esc> to quit";   ' DS:0xbac6 (41 chars); semicolon=no newline
Lbca2Wait:   ' LAB_01a2_bce2 -- key-wait loop
  IF LEN(keyIn$) > 0 THEN   ' got a non-ESC key last iteration -- any key exits
    keyIn$ = ""
    RETURN
  END IF
  keyIn$ = INKEY$
  IF keyIn$ = CHR$(27) THEN END   ' ESC quits program (SUB_0e71_8453 = END runtime)
  GOTO Lbca2Wait

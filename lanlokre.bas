DIM compStat!(10,5)     ' compStat!=Fa246!  -- computer status array (10 computers x 5 attrs)

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
'   Fa4de!      =Fa4de!   game count from history array[INT(Fa4d6!)] (LFinalTally running avg)
'   Fa4e2!      =Fa4e2!   running average score (LFinalTally; avg_n=(avg*(n-1)+score)/n)
'   Fa4e6!      =Fa4e6!   compStat! column reset iterator (inner loop 1-4 in LFinalTally)
'
' STRING VARIABLES
'   keyIn$      =Sa242$   INKEY$ keyboard input buffer
'   cmdBuf$     =Sa46e$   command input accumulator
'   compNames$  =Sa42a$   packed computer-names string (10 chars each)
'   compName$   =Sa432$   current computer name temp
'   playerName$ =Sa436$   player machine name ("SKUA")
'   lockMsg$    =Sa4c6$   self-attack error message (shown while computer is locked)
'   rstMsg$     =Sa4ca$   self-attack restore message (shown when computer is unlocked)
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
'   Lbca2       =Lbca2   end-of-game handler (called from LVictory, not yet decompiled)
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

GOSUB Lae3d
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
GOSUB L637d

' Arrow animation
drawClr! = 63:GOSUB LDrawArrow
drawClr! = 13:GOSUB LClrArrow:GOSUB LDrawArrow
drawClr! = 12:GOSUB LClrArrow:GOSUB LDrawArrow
drawClr! = 13:GOSUB LClrArrow:GOSUB LDrawArrow:GOSUB LClrArrow
drawClr! = 4:GOSUB F0bcb

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
GOSUB L637d

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
IF minsLeft! < 0 THEN GOTO La58f
FOR compI!=1 to 10
drawX! = compStat!(compI!,4)
drawY! = compStat!(compI!,3)
IF compStat!(compI!,1) <> 0 THEN
ELSE
GOSUB LAnimDmg
GOTO LNextComp
dmgCount!=dmgCount!+1
curTime!=TIMER
alTarget!=compI!
IF compStat!(compI!,2) < curTime! THEN GOSUB LAlFix
LNextComp:   ' LNextComp=L1fb0
NEXT compI!
IF dmgCount! > 8 THEN GOSUB L9170
IF dmgCount! > 8 THEN GOTO Laba9
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
IF target!=0 THEN GOTO L902f
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
IF target! = 0 THEN GOTO L90ad
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
IF target! = 0 THEN GOTO L90f7
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
IF target! = 0 THEN GOTO L9c28
RANDOMIZE TIMER
IF target! < 10 AND RND > .63 THEN GOSUB L56c4
IF target! = 10 AND RND > .8 THEN hobbsFmt!=1: ELSE hobbsFmt! = 0
IF target! = 10 AND hobbsFmt! = 1 THEN GOSUB L56c4
IF target! = 10 AND hobbsFmt! = 1 AND score! > 400 THEN GOSUB L9170
IF target! = 10 AND hobbsFmt! = 1 AND score! > 400 THEN GOTO Laba9
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
GOSUB L637d                                            ' Al animation
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
    GOSUB L3c90   ' Delay ~0.263 s (eyes closed)
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
    GOSUB L3c90   ' Delay ~0.263 s (eyes open)
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
                             **************************************************************
                             *                          FUNCTION                          *
                             **************************************************************
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
                             **************************************************************
                             *                          FUNCTION                          *
                             **************************************************************
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
  Fa4da! = 0   ' = best score read from history array[INT(Fa4d6!)]
  Fa4de! = 0   ' = game count read from history array[INT(Fa4d6!)]
  ' (Note: actual array reads use [SI+0x9c92] indirect not shown here)
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
  ' (Note: updated Fa4da!, Fa4de!, Fa4e2! written back to arrays in original)
  GOSUB Lb207   ' display score table (FUN_01a2_b207)
  GOSUB Lb029   ' display end screen (FUN_01a2_b029)
  GOSUB Lbca2   ' end of game handler
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
  GOTO L01a3     ' restart game (LAB_01a2_01a3 = game start)
                             **************************************************************
                             *                          FUNCTION                          *
                             **************************************************************
                             undefined __cdecl16near FUN_01a2_ae3d()
                               assume DS = 0x1997
             undefined         <UNASSIGNED>   <RETURN>
                             FUN_01a2_ae3d                                   XREF[1]:     ENTRY:01a2:01a0(c)  
       01a2:ae3d b8 fa b8        MOV        AX,0xb8fa
       01a2:ae40 50              PUSH       AX
       01a2:ae41 b8 01 00        MOV        AX,0x1
       01a2:ae44 50              PUSH       AX
       01a2:ae45 b8 ff ff        MOV        AX,0xffff
       01a2:ae48 50              PUSH       AX
       01a2:ae49 b8 01 00        MOV        AX,0x1
       01a2:ae4c 50              PUSH       AX
       01a2:ae4d 9a 26 42        CALLF      SUB_0e71_4226
                 71 0e
       01a2:ae52 b8 01 00        MOV        AX,0x1
       01a2:ae55 50              PUSH       AX
       01a2:ae56 9a 6c 63        CALLF      SUB_0e71_636c
                 71 0e
       01a2:ae5b bb ee a4        MOV        BX,0xa4ee
       01a2:ae5e 1e              PUSH       DS
       01a2:ae5f 07              POP        ES
       01a2:ae60 06              PUSH       ES
       01a2:ae61 53              PUSH       BX
       01a2:ae62 9a 1a 7e        CALLF      SUB_0e71_7e1a
                 71 0e
       01a2:ae67 9a fc 77        CALLF      SUB_0e71_77fc
                 71 0e
       01a2:ae6c 90              NOP
       01a2:ae6d d9 06 ee a4     FLD        float ptr [0xa4ee]
       01a2:ae71 90              NOP
       01a2:ae72 d9 1e f2 a4     FSTP       float ptr [0xa4f2]
       01a2:ae76 90              NOP
       01a2:ae77 9b              WAIT
       01a2:ae78 90              NOP
       01a2:ae79 d9 06 50 a5     FLD        float ptr { 1.0 }
       01a2:ae7d e9 81 01        JMP        LAB_01a2_b001
                             LAB_01a2_ae80                                   XREF[1]:     01a2:b01b(j)  
       01a2:ae80 b8 01 00        MOV        AX,0x1
       01a2:ae83 50              PUSH       AX
       01a2:ae84 9a 6c 63        CALLF      SUB_0e71_636c
                 71 0e
       01a2:ae89 b8 32 a4        MOV        AX,0xa432
       01a2:ae8c 1e              PUSH       DS
       01a2:ae8d 50              PUSH       AX
       01a2:ae8e 33 c0           XOR        AX,AX
       01a2:ae90 50              PUSH       AX
       01a2:ae91 9a 20 7e        CALLF      SUB_0e71_7e20
                 71 0e
       01a2:ae96 9a fc 77        CALLF      SUB_0e71_77fc
                 71 0e
       01a2:ae9b b8 32 a4        MOV        AX,0xa432
       01a2:ae9e 50              PUSH       AX
       01a2:ae9f 9a 21 7f        CALLF      LEN
                 71 0e
       01a2:aea4 9a c4 03        CALLF      FUN_0d75_03c4                                    undefined FUN_0d75_03c4()
                 75 0d
       01a2:aea9 90              NOP
       01a2:aeaa d9 06 3a 00     FLD        float ptr [0x3a]
       01a2:aeae 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:aeb3 d1 e0           SHL        AX,0x1
       01a2:aeb5 d1 e0           SHL        AX,0x1
       01a2:aeb7 05 cc 00        ADD        AX,0xcc
       01a2:aeba 8b f0           MOV        SI,AX
       01a2:aebc 90              NOP
       01a2:aebd d9 9c 92 9c     FSTP       float ptr [SI + 0x9c92]
       01a2:aec1 90              NOP
       01a2:aec2 9b              WAIT
       01a2:aec3 b8 f6 a4        MOV        AX,0xa4f6
       01a2:aec6 50              PUSH       AX
       01a2:aec7 b8 32 a4        MOV        AX,0xa432
       01a2:aeca 50              PUSH       AX
       01a2:aecb 9a b1 7c        CALLF      STRING_CONCAT
                 71 0e
       01a2:aed0 50              PUSH       AX
       01a2:aed1 b8 f6 a4        MOV        AX,0xa4f6
       01a2:aed4 50              PUSH       AX
       01a2:aed5 9a 78 7c        CALLF      SET_STRING
                 71 0e
       01a2:aeda b8 01 00        MOV        AX,0x1
       01a2:aedd 50              PUSH       AX
       01a2:aede 9a 6c 63        CALLF      SUB_0e71_636c
                 71 0e
       01a2:aee3 bb fa a4        MOV        BX,0xa4fa
       01a2:aee6 1e              PUSH       DS
       01a2:aee7 07              POP        ES
       01a2:aee8 06              PUSH       ES
       01a2:aee9 53              PUSH       BX
       01a2:aeea 9a 1a 7e        CALLF      SUB_0e71_7e1a
                 71 0e
       01a2:aeef 9a fc 77        CALLF      SUB_0e71_77fc
                 71 0e
       01a2:aef4 90              NOP
       01a2:aef5 d9 06 fa a4     FLD        float ptr [0xa4fa]
       01a2:aef9 90              NOP
       01a2:aefa d9 06 3a 00     FLD        float ptr [0x3a]
       01a2:aefe 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:af03 d1 e0           SHL        AX,0x1
       01a2:af05 d1 e0           SHL        AX,0x1
       01a2:af07 05 98 01        ADD        AX,0x198
       01a2:af0a 8b f0           MOV        SI,AX
       01a2:af0c 90              NOP
       01a2:af0d d9 9c 92 9c     FSTP       float ptr [SI + 0x9c92]
       01a2:af11 90              NOP
       01a2:af12 9b              WAIT
       01a2:af13 b8 01 00        MOV        AX,0x1
       01a2:af16 50              PUSH       AX
       01a2:af17 9a 6c 63        CALLF      SUB_0e71_636c
                 71 0e
       01a2:af1c bb de a4        MOV        BX,0xa4de
       01a2:af1f 1e              PUSH       DS
       01a2:af20 07              POP        ES
       01a2:af21 06              PUSH       ES
       01a2:af22 53              PUSH       BX
       01a2:af23 9a 1a 7e        CALLF      SUB_0e71_7e1a
                 71 0e
       01a2:af28 9a fc 77        CALLF      SUB_0e71_77fc
                 71 0e
       01a2:af2d 90              NOP
       01a2:af2e d9 06 de a4     FLD        float ptr [0xa4de]
       01a2:af32 90              NOP
       01a2:af33 d9 06 3a 00     FLD        float ptr [0x3a]
       01a2:af37 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:af3c d1 e0           SHL        AX,0x1
       01a2:af3e d1 e0           SHL        AX,0x1
       01a2:af40 05 c8 04        ADD        AX,0x4c8
       01a2:af43 8b f0           MOV        SI,AX
       01a2:af45 90              NOP
       01a2:af46 d9 9c 92 9c     FSTP       float ptr [SI + 0x9c92]
       01a2:af4a 90              NOP
       01a2:af4b 9b              WAIT
       01a2:af4c b8 01 00        MOV        AX,0x1
       01a2:af4f 50              PUSH       AX
       01a2:af50 9a 6c 63        CALLF      SUB_0e71_636c
                 71 0e
       01a2:af55 bb fe a4        MOV        BX,0xa4fe
       01a2:af58 1e              PUSH       DS
       01a2:af59 07              POP        ES
       01a2:af5a 06              PUSH       ES
       01a2:af5b 53              PUSH       BX
       01a2:af5c 9a 1a 7e        CALLF      SUB_0e71_7e1a
                 71 0e
       01a2:af61 9a fc 77        CALLF      SUB_0e71_77fc
                 71 0e
       01a2:af66 90              NOP
       01a2:af67 d9 06 fe a4     FLD        float ptr [0xa4fe]
       01a2:af6b 90              NOP
       01a2:af6c d9 06 3a 00     FLD        float ptr [0x3a]
       01a2:af70 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:af75 d1 e0           SHL        AX,0x1
       01a2:af77 d1 e0           SHL        AX,0x1
       01a2:af79 05 64 02        ADD        AX,0x264
       01a2:af7c 8b f0           MOV        SI,AX
       01a2:af7e 90              NOP
       01a2:af7f d9 9c 92 9c     FSTP       float ptr [SI + 0x9c92]
       01a2:af83 90              NOP
       01a2:af84 9b              WAIT
       01a2:af85 b8 01 00        MOV        AX,0x1
       01a2:af88 50              PUSH       AX
       01a2:af89 9a 6c 63        CALLF      SUB_0e71_636c
                 71 0e
       01a2:af8e bb 02 a5        MOV        BX,0xa502
       01a2:af91 1e              PUSH       DS
       01a2:af92 07              POP        ES
       01a2:af93 06              PUSH       ES
       01a2:af94 53              PUSH       BX
       01a2:af95 9a 1a 7e        CALLF      SUB_0e71_7e1a
                 71 0e
       01a2:af9a 9a fc 77        CALLF      SUB_0e71_77fc
                 71 0e
       01a2:af9f 90              NOP
       01a2:afa0 d9 06 02 a5     FLD        float ptr [0xa502]
       01a2:afa4 90              NOP
       01a2:afa5 d9 06 3a 00     FLD        float ptr [0x3a]
       01a2:afa9 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:afae d1 e0           SHL        AX,0x1
       01a2:afb0 d1 e0           SHL        AX,0x1
       01a2:afb2 05 30 03        ADD        AX,0x330
       01a2:afb5 8b f0           MOV        SI,AX
       01a2:afb7 90              NOP
       01a2:afb8 d9 9c 92 9c     FSTP       float ptr [SI + 0x9c92]
       01a2:afbc 90              NOP
       01a2:afbd 9b              WAIT
       01a2:afbe b8 01 00        MOV        AX,0x1
       01a2:afc1 50              PUSH       AX
       01a2:afc2 9a 6c 63        CALLF      SUB_0e71_636c
                 71 0e
       01a2:afc7 bb e2 a4        MOV        BX,0xa4e2
       01a2:afca 1e              PUSH       DS
       01a2:afcb 07              POP        ES
       01a2:afcc 06              PUSH       ES
       01a2:afcd 53              PUSH       BX
       01a2:afce 9a 1a 7e        CALLF      SUB_0e71_7e1a
                 71 0e
       01a2:afd3 9a fc 77        CALLF      SUB_0e71_77fc
                 71 0e
       01a2:afd8 90              NOP
       01a2:afd9 d9 06 e2 a4     FLD        float ptr [0xa4e2]
       01a2:afdd 90              NOP
       01a2:afde d9 06 3a 00     FLD        float ptr [0x3a]
       01a2:afe2 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:afe7 d1 e0           SHL        AX,0x1
       01a2:afe9 d1 e0           SHL        AX,0x1
       01a2:afeb 05 fc 03        ADD        AX,0x3fc
       01a2:afee 8b f0           MOV        SI,AX
       01a2:aff0 90              NOP
       01a2:aff1 d9 9c 92 9c     FSTP       float ptr [SI + 0x9c92]
       01a2:aff5 90              NOP
       01a2:aff6 9b              WAIT
       01a2:aff7 90              NOP
       01a2:aff8 d9 06 3a 00     FLD        float ptr [0x3a]
       01a2:affc 90              NOP
       01a2:affd d8 06 50 a5     FADD       float ptr { 1.0 }
                             LAB_01a2_b001                                   XREF[1]:     01a2:ae7d(j)  
       01a2:b001 90              NOP
       01a2:b002 d9 1e 3a 00     FSTP       float ptr [0x3a]
       01a2:b006 90              NOP
       01a2:b007 9b              WAIT
       01a2:b008 90              NOP
       01a2:b009 d9 06 f2 a4     FLD        float ptr [0xa4f2]
       01a2:b00d 90              NOP
       01a2:b00e d9 06 3a 00     FLD        float ptr [0x3a]
       01a2:b012 90              NOP
       01a2:b013 9b              WAIT
       01a2:b014 9a 1d 04        CALLF      FPCOMPARE_2stack                                 undefined FPCOMPARE_2stack()
                 75 0d
       01a2:b019 77 03           JA         LAB_01a2_b01e
       01a2:b01b e9 62 fe        JMP        LAB_01a2_ae80
                             LAB_01a2_b01e                                   XREF[1]:     01a2:b019(j)  
       01a2:b01e b8 01 00        MOV        AX,0x1
       01a2:b021 50              PUSH       AX
       01a2:b022 50              PUSH       AX
       01a2:b023 9a 52 44        CALLF      SUB_0e71_4452
                 71 0e
       01a2:b028 c3              RET
                             **************************************************************
                             *                          FUNCTION                          *
                             **************************************************************
                             undefined __cdecl16near FUN_01a2_b029()
                               assume DS = 0x1997
             undefined         <UNASSIGNED>   <RETURN>
                             FUN_01a2_b029                                   XREF[1]:     FUN_01a2_9c28:01a2:ad87(c)  
       01a2:b029 b8 fa b8        MOV        AX,0xb8fa
       01a2:b02c 50              PUSH       AX
       01a2:b02d b8 01 00        MOV        AX,0x1
       01a2:b030 50              PUSH       AX
       01a2:b031 b8 ff ff        MOV        AX,0xffff
       01a2:b034 50              PUSH       AX
       01a2:b035 b8 02 00        MOV        AX,0x2
       01a2:b038 50              PUSH       AX
       01a2:b039 9a 26 42        CALLF      SUB_0e71_4226
                 71 0e
       01a2:b03e b8 01 00        MOV        AX,0x1
       01a2:b041 50              PUSH       AX
       01a2:b042 9a 4b 76        CALLF      SUB_0e71_764b
                 71 0e
       01a2:b047 9a 64 78        CALLF      SUB_0e71_7864
                 71 0e
       01a2:b04c ff 36 f0 a4     PUSH       word ptr [0xa4f0]
       01a2:b050 ff 36 ee a4     PUSH       word ptr [0xa4ee]
       01a2:b054 9a aa 76        CALLF      PRINT_float_newline
                 71 0e
       01a2:b059 90              NOP
       01a2:b05a d9 06 50 a5     FLD        float ptr { 1.0 }
       01a2:b05e 90              NOP
       01a2:b05f d9 1e 06 a5     FSTP       float ptr [0xa506]
       01a2:b063 90              NOP
       01a2:b064 9b              WAIT
       01a2:b065 90              NOP
       01a2:b066 d9 06 ee a4     FLD        float ptr [0xa4ee]
       01a2:b06a 90              NOP
       01a2:b06b d9 1e 0a a5     FSTP       float ptr [0xa50a]
       01a2:b06f 90              NOP
       01a2:b070 9b              WAIT
       01a2:b071 90              NOP
       01a2:b072 d9 06 50 a5     FLD        float ptr { 1.0 }
       01a2:b076 e9 66 01        JMP        LAB_01a2_b1df
       01a2:b079 90              ??         90h
                             LAB_01a2_b07a                                   XREF[1]:     01a2:b1f9(j)  
       01a2:b07a 90              NOP
       01a2:b07b d9 06 3a 00     FLD        float ptr [0x3a]
       01a2:b07f 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:b084 d1 e0           SHL        AX,0x1
       01a2:b086 d1 e0           SHL        AX,0x1
       01a2:b088 05 cc 00        ADD        AX,0xcc
       01a2:b08b 8b f0           MOV        SI,AX
       01a2:b08d 90              NOP
       01a2:b08e d9 84 92 9c     FLD        float ptr [SI + 0x9c92]
       01a2:b092 90              NOP
       01a2:b093 d9 1e 0e a5     FSTP       float ptr [0xa50e]
       01a2:b097 90              NOP
       01a2:b098 9b              WAIT
       01a2:b099 b8 f6 a4        MOV        AX,0xa4f6
       01a2:b09c 50              PUSH       AX
       01a2:b09d 90              NOP
       01a2:b09e d9 06 06 a5     FLD        float ptr [0xa506]
       01a2:b0a2 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:b0a7 50              PUSH       AX
       01a2:b0a8 90              NOP
       01a2:b0a9 d9 06 0e a5     FLD        float ptr [0xa50e]
       01a2:b0ad 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:b0b2 50              PUSH       AX
       01a2:b0b3 9a ee 7f        CALLF      MID$
                 71 0e
       01a2:b0b8 50              PUSH       AX
       01a2:b0b9 b8 32 a4        MOV        AX,0xa432
       01a2:b0bc 50              PUSH       AX
       01a2:b0bd 9a 78 7c        CALLF      SET_STRING
                 71 0e
       01a2:b0c2 90              NOP
       01a2:b0c3 d9 06 06 a5     FLD        float ptr [0xa506]
       01a2:b0c7 90              NOP
       01a2:b0c8 d8 06 0e a5     FADD       float ptr [0xa50e]
       01a2:b0cc 90              NOP
       01a2:b0cd d9 1e 06 a5     FSTP       float ptr [0xa506]
       01a2:b0d1 90              NOP
       01a2:b0d2 9b              WAIT
       01a2:b0d3 b8 01 00        MOV        AX,0x1
       01a2:b0d6 50              PUSH       AX
       01a2:b0d7 9a 4b 76        CALLF      SUB_0e71_764b
                 71 0e
       01a2:b0dc 9a 64 78        CALLF      SUB_0e71_7864
                 71 0e
       01a2:b0e1 b8 32 a4        MOV        AX,0xa432
       01a2:b0e4 50              PUSH       AX
       01a2:b0e5 9a c8 76        CALLF      PRINT_STR_NEWLINE
                 71 0e
       01a2:b0ea b8 01 00        MOV        AX,0x1
       01a2:b0ed 50              PUSH       AX
       01a2:b0ee 9a 4b 76        CALLF      SUB_0e71_764b
                 71 0e
       01a2:b0f3 9a 64 78        CALLF      SUB_0e71_7864
                 71 0e
       01a2:b0f8 90              NOP
       01a2:b0f9 d9 06 3a 00     FLD        float ptr [0x3a]
       01a2:b0fd 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:b102 d1 e0           SHL        AX,0x1
       01a2:b104 d1 e0           SHL        AX,0x1
       01a2:b106 05 98 01        ADD        AX,0x198
       01a2:b109 81 c0 92 9c     ADD        AX,0x9c92
       01a2:b10d 8b d8           MOV        BX,AX
       01a2:b10f ff 77 02        PUSH       word ptr [BX + 0x2]
       01a2:b112 ff 37           PUSH       word ptr [BX]
       01a2:b114 9a aa 76        CALLF      PRINT_float_newline
                 71 0e
       01a2:b119 b8 01 00        MOV        AX,0x1
       01a2:b11c 50              PUSH       AX
       01a2:b11d 9a 4b 76        CALLF      SUB_0e71_764b
                 71 0e
       01a2:b122 9a 64 78        CALLF      SUB_0e71_7864
                 71 0e
       01a2:b127 90              NOP
       01a2:b128 d9 06 3a 00     FLD        float ptr [0x3a]
       01a2:b12c 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:b131 d1 e0           SHL        AX,0x1
       01a2:b133 d1 e0           SHL        AX,0x1
       01a2:b135 05 c8 04        ADD        AX,0x4c8
       01a2:b138 81 c0 92 9c     ADD        AX,0x9c92
       01a2:b13c 8b d8           MOV        BX,AX
       01a2:b13e ff 77 02        PUSH       word ptr [BX + 0x2]
       01a2:b141 ff 37           PUSH       word ptr [BX]
       01a2:b143 9a aa 76        CALLF      PRINT_float_newline
                 71 0e
       01a2:b148 b8 01 00        MOV        AX,0x1
       01a2:b14b 50              PUSH       AX
       01a2:b14c 9a 4b 76        CALLF      SUB_0e71_764b
                 71 0e
       01a2:b151 9a 64 78        CALLF      SUB_0e71_7864
                 71 0e
       01a2:b156 90              NOP
       01a2:b157 d9 06 3a 00     FLD        float ptr [0x3a]
       01a2:b15b 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:b160 d1 e0           SHL        AX,0x1
       01a2:b162 d1 e0           SHL        AX,0x1
       01a2:b164 05 64 02        ADD        AX,0x264
       01a2:b167 81 c0 92 9c     ADD        AX,0x9c92
       01a2:b16b 8b d8           MOV        BX,AX
       01a2:b16d ff 77 02        PUSH       word ptr [BX + 0x2]
       01a2:b170 ff 37           PUSH       word ptr [BX]
       01a2:b172 9a aa 76        CALLF      PRINT_float_newline
                 71 0e
       01a2:b177 b8 01 00        MOV        AX,0x1
       01a2:b17a 50              PUSH       AX
       01a2:b17b 9a 4b 76        CALLF      SUB_0e71_764b
                 71 0e
       01a2:b180 9a 64 78        CALLF      SUB_0e71_7864
                 71 0e
       01a2:b185 90              NOP
       01a2:b186 d9 06 3a 00     FLD        float ptr [0x3a]
       01a2:b18a 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:b18f d1 e0           SHL        AX,0x1
       01a2:b191 d1 e0           SHL        AX,0x1
       01a2:b193 05 30 03        ADD        AX,0x330
       01a2:b196 81 c0 92 9c     ADD        AX,0x9c92
       01a2:b19a 8b d8           MOV        BX,AX
       01a2:b19c ff 77 02        PUSH       word ptr [BX + 0x2]
       01a2:b19f ff 37           PUSH       word ptr [BX]
       01a2:b1a1 9a aa 76        CALLF      PRINT_float_newline
                 71 0e
       01a2:b1a6 b8 01 00        MOV        AX,0x1
       01a2:b1a9 50              PUSH       AX
       01a2:b1aa 9a 4b 76        CALLF      SUB_0e71_764b
                 71 0e
       01a2:b1af 9a 64 78        CALLF      SUB_0e71_7864
                 71 0e
       01a2:b1b4 90              NOP
       01a2:b1b5 d9 06 3a 00     FLD        float ptr [0x3a]
       01a2:b1b9 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:b1be d1 e0           SHL        AX,0x1
       01a2:b1c0 d1 e0           SHL        AX,0x1
       01a2:b1c2 05 fc 03        ADD        AX,0x3fc
       01a2:b1c5 81 c0 92 9c     ADD        AX,0x9c92
       01a2:b1c9 8b d8           MOV        BX,AX
       01a2:b1cb ff 77 02        PUSH       word ptr [BX + 0x2]
       01a2:b1ce ff 37           PUSH       word ptr [BX]
       01a2:b1d0 9a aa 76        CALLF      PRINT_float_newline
                 71 0e
       01a2:b1d5 90              NOP
       01a2:b1d6 d9 06 3a 00     FLD        float ptr [0x3a]
       01a2:b1da 90              NOP
       01a2:b1db d8 06 50 a5     FADD       float ptr { 1.0 }
                             LAB_01a2_b1df                                   XREF[1]:     01a2:b076(j)  
       01a2:b1df 90              NOP
       01a2:b1e0 d9 1e 3a 00     FSTP       float ptr [0x3a]
       01a2:b1e4 90              NOP
       01a2:b1e5 9b              WAIT
       01a2:b1e6 90              NOP
       01a2:b1e7 d9 06 0a a5     FLD        float ptr [0xa50a]
       01a2:b1eb 90              NOP
       01a2:b1ec d9 06 3a 00     FLD        float ptr [0x3a]
       01a2:b1f0 90              NOP
       01a2:b1f1 9b              WAIT
       01a2:b1f2 9a 1d 04        CALLF      FPCOMPARE_2stack                                 undefined FPCOMPARE_2stack()
                 75 0d
       01a2:b1f7 77 03           JA         LAB_01a2_b1fc
       01a2:b1f9 e9 7e fe        JMP        LAB_01a2_b07a
                             LAB_01a2_b1fc                                   XREF[1]:     01a2:b1f7(j)  
       01a2:b1fc b8 01 00        MOV        AX,0x1
       01a2:b1ff 50              PUSH       AX
       01a2:b200 50              PUSH       AX
       01a2:b201 9a 52 44        CALLF      SUB_0e71_4452
                 71 0e
       01a2:b206 c3              RET
                             **************************************************************
                             *                          FUNCTION                          *
                             **************************************************************
                             undefined __cdecl16near FUN_01a2_b207()
                               assume DS = 0x1997
             undefined         <UNASSIGNED>   <RETURN>
                             FUN_01a2_b207                                   XREF[3]:     FUN_01a2_0d85:01a2:13e6(c), 
                                                                                          FUN_01a2_9c28:01a2:ad84(c), 
                                                                                          FUN_01a2_b786:01a2:baa9(c)  
       01a2:b207 90              NOP
       01a2:b208 d9 06 50 a5     FLD        float ptr { 1.0 }
       01a2:b20c 90              NOP
       01a2:b20d d9 1e 06 a5     FSTP       float ptr [0xa506]
       01a2:b211 90              NOP
       01a2:b212 9b              WAIT
       01a2:b213 b8 01 00        MOV        AX,0x1
       01a2:b216 50              PUSH       AX
       01a2:b217 b8 03 00        MOV        AX,0x3
       01a2:b21a 50              PUSH       AX
       01a2:b21b b8 02 00        MOV        AX,0x2
       01a2:b21e 50              PUSH       AX
       01a2:b21f 9a 86 61        CALLF      COLOR
                 71 0e
       01a2:b224 b8 01 00        MOV        AX,0x1
       01a2:b227 50              PUSH       AX
       01a2:b228 50              PUSH       AX
       01a2:b229 50              PUSH       AX
       01a2:b22a 50              PUSH       AX
       01a2:b22b b8 04 00        MOV        AX,0x4
       01a2:b22e 50              PUSH       AX
       01a2:b22f 9a b2 61        CALLF      LOCATE
                 71 0e
       01a2:b234 b8 06 b9        MOV        AX,0xb906
       01a2:b237 50              PUSH       AX
       01a2:b238 9a c8 76        CALLF      PRINT_STR_NEWLINE
                 71 0e
       01a2:b23d b8 58 b9        MOV        AX,0xb958
       01a2:b240 50              PUSH       AX
       01a2:b241 9a c3 76        CALLF      PRINT_STR_SEMICOLON
                 71 0e
       01a2:b246 b8 3e a7        MOV        AX,""
       01a2:b249 50              PUSH       AX
       01a2:b24a 9a c8 76        CALLF      PRINT_STR_NEWLINE
                 71 0e
       01a2:b24f b8 3e a7        MOV        AX,""
       01a2:b252 50              PUSH       AX
       01a2:b253 9a c8 76        CALLF      PRINT_STR_NEWLINE
                 71 0e
       01a2:b258 90              NOP
       01a2:b259 d9 06 ac b9     FLD        float ptr [0xb9ac]
       01a2:b25d 90              NOP
       01a2:b25e d9 1e 12 a5     FSTP       float ptr [0xa512]
       01a2:b262 90              NOP
       01a2:b263 9b              WAIT
       01a2:b264 90              NOP
       01a2:b265 d9 06 4c a6     FLD        float ptr { 0.0 }
       01a2:b269 90              NOP
       01a2:b26a d9 1e 16 a5     FSTP       float ptr [0xa516]
       01a2:b26e 90              NOP
       01a2:b26f 9b              WAIT
       01a2:b270 90              NOP
       01a2:b271 d9 06 ee a4     FLD        float ptr [0xa4ee]
       01a2:b275 90              NOP
       01a2:b276 d9 1e 1a a5     FSTP       float ptr [0xa51a]
       01a2:b27a 90              NOP
       01a2:b27b 9b              WAIT
       01a2:b27c 90              NOP
       01a2:b27d d9 06 50 a5     FLD        float ptr { 1.0 }
       01a2:b281 e9 96 03        JMP        LAB_01a2_b61a
                             LAB_01a2_b284                                   XREF[1]:     01a2:b634(j)  
       01a2:b284 90              NOP
       01a2:b285 d9 06 c6 b4     FLD        float ptr [0xb4c6]
       01a2:b289 90              NOP
       01a2:b28a d9 06 3a 00     FLD        float ptr [0x3a]
       01a2:b28e 90              NOP
       01a2:b28f 9b              WAIT
       01a2:b290 9a 1d 04        CALLF      FPCOMPARE_2stack                                 undefined FPCOMPARE_2stack()
                 75 0d
       01a2:b295 72 03           JC         LAB_01a2_b29a
       01a2:b297 e9 0f 00        JMP        LAB_01a2_b2a9
                             LAB_01a2_b29a                                   XREF[1]:     01a2:b295(j)  
       01a2:b29a 90              NOP
       01a2:b29b d9 06 50 a5     FLD        float ptr { 1.0 }
       01a2:b29f 90              NOP
       01a2:b2a0 d9 1e 1e a5     FSTP       float ptr [0xa51e]
       01a2:b2a4 90              NOP
       01a2:b2a5 9b              WAIT
       01a2:b2a6 e9 0c 00        JMP        LAB_01a2_b2b5
                             LAB_01a2_b2a9                                   XREF[1]:     01a2:b297(j)  
       01a2:b2a9 90              NOP
       01a2:b2aa d9 06 fa b3     FLD        float ptr [0xb3fa]
       01a2:b2ae 90              NOP
       01a2:b2af d9 1e 1e a5     FSTP       float ptr [0xa51e]
       01a2:b2b3 90              NOP
       01a2:b2b4 9b              WAIT
                             LAB_01a2_b2b5                                   XREF[1]:     01a2:b2a6(j)  
       01a2:b2b5 90              NOP
       01a2:b2b6 d9 06 3a 00     FLD        float ptr [0x3a]
       01a2:b2ba 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:b2bf d1 e0           SHL        AX,0x1
       01a2:b2c1 d1 e0           SHL        AX,0x1
       01a2:b2c3 05 98 01        ADD        AX,0x198
       01a2:b2c6 8b f0           MOV        SI,AX
       01a2:b2c8 90              NOP
       01a2:b2c9 d9 84 92 9c     FLD        float ptr [SI + 0x9c92]
       01a2:b2cd 90              NOP
       01a2:b2ce d9 1e 22 a5     FSTP       float ptr [0xa522]
       01a2:b2d2 90              NOP
       01a2:b2d3 9b              WAIT
       01a2:b2d4 90              NOP
       01a2:b2d5 d9 06 3a 00     FLD        float ptr [0x3a]
       01a2:b2d9 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:b2de d1 e0           SHL        AX,0x1
       01a2:b2e0 d1 e0           SHL        AX,0x1
       01a2:b2e2 05 64 02        ADD        AX,0x264
       01a2:b2e5 8b f0           MOV        SI,AX
       01a2:b2e7 90              NOP
       01a2:b2e8 d9 84 92 9c     FLD        float ptr [SI + 0x9c92]
       01a2:b2ec 90              NOP
       01a2:b2ed d9 1e 26 a5     FSTP       float ptr [0xa526]
       01a2:b2f1 90              NOP
       01a2:b2f2 9b              WAIT
       01a2:b2f3 90              NOP
       01a2:b2f4 d9 06 3a 00     FLD        float ptr [0x3a]
       01a2:b2f8 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:b2fd d1 e0           SHL        AX,0x1
       01a2:b2ff d1 e0           SHL        AX,0x1
       01a2:b301 05 30 03        ADD        AX,0x330
       01a2:b304 8b f0           MOV        SI,AX
       01a2:b306 90              NOP
       01a2:b307 d9 84 92 9c     FLD        float ptr [SI + 0x9c92]
       01a2:b30b 90              NOP
       01a2:b30c d9 1e 2a a5     FSTP       float ptr [0xa52a]
       01a2:b310 90              NOP
       01a2:b311 9b              WAIT
       01a2:b312 90              NOP
       01a2:b313 d9 06 3a 00     FLD        float ptr [0x3a]
       01a2:b317 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:b31c d1 e0           SHL        AX,0x1
       01a2:b31e d1 e0           SHL        AX,0x1
       01a2:b320 05 c8 04        ADD        AX,0x4c8
       01a2:b323 8b f0           MOV        SI,AX
       01a2:b325 90              NOP
       01a2:b326 d9 84 92 9c     FLD        float ptr [SI + 0x9c92]
       01a2:b32a 90              NOP
       01a2:b32b d9 1e de a4     FSTP       float ptr [0xa4de]
       01a2:b32f 90              NOP
       01a2:b330 9b              WAIT
       01a2:b331 90              NOP
       01a2:b332 d9 06 3a 00     FLD        float ptr [0x3a]
       01a2:b336 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:b33b d1 e0           SHL        AX,0x1
       01a2:b33d d1 e0           SHL        AX,0x1
       01a2:b33f 05 fc 03        ADD        AX,0x3fc
       01a2:b342 8b f0           MOV        SI,AX
       01a2:b344 90              NOP
       01a2:b345 d9 84 92 9c     FLD        float ptr [SI + 0x9c92]
       01a2:b349 90              NOP
       01a2:b34a d9 1e e2 a4     FSTP       float ptr [0xa4e2]
       01a2:b34e 90              NOP
       01a2:b34f 9b              WAIT
       01a2:b350 90              NOP
       01a2:b351 d9 06 12 a5     FLD        float ptr [0xa512]
       01a2:b355 90              NOP
       01a2:b356 d9 06 e2 a4     FLD        float ptr [0xa4e2]
       01a2:b35a 90              NOP
       01a2:b35b 9b              WAIT
       01a2:b35c 9a 1d 04        CALLF      FPCOMPARE_2stack                                 undefined FPCOMPARE_2stack()
                 75 0d
       01a2:b361 77 03           JA         LAB_01a2_b366
       01a2:b363 e9 0c 00        JMP        LAB_01a2_b372
                             LAB_01a2_b366                                   XREF[1]:     01a2:b361(j)  
       01a2:b366 90              NOP
       01a2:b367 d9 06 3a 00     FLD        float ptr [0x3a]
       01a2:b36b 90              NOP
       01a2:b36c d9 1e 16 a5     FSTP       float ptr [0xa516]
       01a2:b370 90              NOP
       01a2:b371 9b              WAIT
                             LAB_01a2_b372                                   XREF[1]:     01a2:b363(j)  
       01a2:b372 90              NOP
       01a2:b373 d9 06 5e b4     FLD        float ptr [0xb45e]
       01a2:b377 90              NOP
       01a2:b378 d9 06 3a 00     FLD        float ptr [0x3a]
       01a2:b37c 90              NOP
       01a2:b37d 9b              WAIT
       01a2:b37e 9a 1d 04        CALLF      FPCOMPARE_2stack                                 undefined FPCOMPARE_2stack()
                 75 0d
       01a2:b383 77 03           JA         LAB_01a2_b388
       01a2:b385 e9 25 00        JMP        LAB_01a2_b3ad
                             LAB_01a2_b388                                   XREF[1]:     01a2:b383(j)  
       01a2:b388 b8 01 00        MOV        AX,0x1
       01a2:b38b 50              PUSH       AX
       01a2:b38c 90              NOP
       01a2:b38d d9 06 3a 00     FLD        float ptr [0x3a]
       01a2:b391 90              NOP
       01a2:b392 d8 06 b0 b9     FADD       float ptr [0xb9b0]
       01a2:b396 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:b39b 50              PUSH       AX
       01a2:b39c b8 01 00        MOV        AX,0x1
       01a2:b39f 50              PUSH       AX
       01a2:b3a0 b8 28 00        MOV        AX,0x28
       01a2:b3a3 50              PUSH       AX
       01a2:b3a4 b8 04 00        MOV        AX,0x4
       01a2:b3a7 50              PUSH       AX
       01a2:b3a8 9a b2 61        CALLF      LOCATE
                 71 0e
                             LAB_01a2_b3ad                                   XREF[1]:     01a2:b385(j)  
       01a2:b3ad 90              NOP
       01a2:b3ae d9 06 3a 00     FLD        float ptr [0x3a]
       01a2:b3b2 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:b3b7 d1 e0           SHL        AX,0x1
       01a2:b3b9 d1 e0           SHL        AX,0x1
       01a2:b3bb 05 cc 00        ADD        AX,0xcc
       01a2:b3be 8b f0           MOV        SI,AX
       01a2:b3c0 90              NOP
       01a2:b3c1 d9 84 92 9c     FLD        float ptr [SI + 0x9c92]
       01a2:b3c5 90              NOP
       01a2:b3c6 d9 1e 0e a5     FSTP       float ptr [0xa50e]
       01a2:b3ca 90              NOP
       01a2:b3cb 9b              WAIT
       01a2:b3cc b8 01 00        MOV        AX,0x1
       01a2:b3cf 50              PUSH       AX
       01a2:b3d0 b8 0f 00        MOV        AX,0xf
       01a2:b3d3 50              PUSH       AX
       01a2:b3d4 b8 02 00        MOV        AX,0x2
       01a2:b3d7 50              PUSH       AX
       01a2:b3d8 9a 86 61        CALLF      COLOR
                 71 0e
       01a2:b3dd 90              NOP
       01a2:b3de d9 06 1e a5     FLD        float ptr [0xa51e]
       01a2:b3e2 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:b3e7 50              PUSH       AX
       01a2:b3e8 9a be 82        CALLF      SUB_0e71_82be
                 71 0e
       01a2:b3ed b8 3e a7        MOV        AX,""
       01a2:b3f0 50              PUSH       AX
       01a2:b3f1 9a c3 76        CALLF      PRINT_STR_SEMICOLON
                 71 0e
       01a2:b3f6 ff 36 3c 00     PUSH       word ptr [0x3c]
       01a2:b3fa ff 36 3a 00     PUSH       word ptr [0x3a]
       01a2:b3fe 9a a5 76        CALLF      PRINT_float_semicolon
                 71 0e
       01a2:b403 90              NOP
       01a2:b404 d9 06 94 af     FLD        float ptr { 9.0 }
       01a2:b408 90              NOP
       01a2:b409 d9 06 3a 00     FLD        float ptr [0x3a]
       01a2:b40d 90              NOP
       01a2:b40e 9b              WAIT
       01a2:b40f 9a 1d 04        CALLF      FPCOMPARE_2stack                                 undefined FPCOMPARE_2stack()
                 75 0d
       01a2:b414 77 03           JA         LAB_01a2_b419
       01a2:b416 e9 0c 00        JMP        LAB_01a2_b425
                             LAB_01a2_b419                                   XREF[1]:     01a2:b414(j)  
       01a2:b419 b8 3e a7        MOV        AX,""
       01a2:b41c 50              PUSH       AX
       01a2:b41d 9a c3 76        CALLF      PRINT_STR_SEMICOLON
                 71 0e
       01a2:b422 e9 09 00        JMP        LAB_01a2_b42e
                             LAB_01a2_b425                                   XREF[1]:     01a2:b416(j)  
       01a2:b425 b8 b4 b9        MOV        AX,0xb9b4
       01a2:b428 50              PUSH       AX
       01a2:b429 9a c3 76        CALLF      PRINT_STR_SEMICOLON
                 71 0e
                             LAB_01a2_b42e                                   XREF[1]:     01a2:b422(j)  
       01a2:b42e b8 01 00        MOV        AX,0x1
       01a2:b431 50              PUSH       AX
       01a2:b432 b8 0a 00        MOV        AX,0xa
       01a2:b435 50              PUSH       AX
       01a2:b436 b8 02 00        MOV        AX,0x2
       01a2:b439 50              PUSH       AX
       01a2:b43a 9a 86 61        CALLF      COLOR
                 71 0e
       01a2:b43f b8 f6 a4        MOV        AX,0xa4f6
       01a2:b442 50              PUSH       AX
       01a2:b443 90              NOP
       01a2:b444 d9 06 06 a5     FLD        float ptr [0xa506]
       01a2:b448 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:b44d 50              PUSH       AX
       01a2:b44e 90              NOP
       01a2:b44f d9 06 0e a5     FLD        float ptr [0xa50e]
       01a2:b453 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:b458 50              PUSH       AX
       01a2:b459 9a ee 7f        CALLF      MID$
                 71 0e
       01a2:b45e 50              PUSH       AX
       01a2:b45f 9a c3 76        CALLF      PRINT_STR_SEMICOLON
                 71 0e
       01a2:b464 90              NOP
       01a2:b465 d9 06 3a 00     FLD        float ptr [0x3a]
       01a2:b469 90              NOP
       01a2:b46a d9 06 16 a5     FLD        float ptr [0xa516]
       01a2:b46e 90              NOP
       01a2:b46f 9b              WAIT
       01a2:b470 9a 1d 04        CALLF      FPCOMPARE_2stack                                 undefined FPCOMPARE_2stack()
                 75 0d
       01a2:b475 74 03           JZ         LAB_01a2_b47a
       01a2:b477 e9 29 00        JMP        LAB_01a2_b4a3
                             LAB_01a2_b47a                                   XREF[1]:     01a2:b475(j)  
       01a2:b47a b8 f6 a4        MOV        AX,0xa4f6
       01a2:b47d 50              PUSH       AX
       01a2:b47e 90              NOP
       01a2:b47f d9 06 06 a5     FLD        float ptr [0xa506]
       01a2:b483 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:b488 50              PUSH       AX
       01a2:b489 90              NOP
       01a2:b48a d9 06 0e a5     FLD        float ptr [0xa50e]
       01a2:b48e 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:b493 50              PUSH       AX
       01a2:b494 9a ee 7f        CALLF      MID$
                 71 0e
       01a2:b499 50              PUSH       AX
       01a2:b49a b8 2e a5        MOV        AX,0xa52e
       01a2:b49d 50              PUSH       AX
       01a2:b49e 9a 78 7c        CALLF      SET_STRING
                 71 0e
                             LAB_01a2_b4a3                                   XREF[1]:     01a2:b477(j)  
       01a2:b4a3 90              NOP
       01a2:b4a4 d9 06 12 a5     FLD        float ptr [0xa512]
       01a2:b4a8 90              NOP
       01a2:b4a9 d9 06 e2 a4     FLD        float ptr [0xa4e2]
       01a2:b4ad 90              NOP
       01a2:b4ae 9b              WAIT
       01a2:b4af 9a 1d 04        CALLF      FPCOMPARE_2stack                                 undefined FPCOMPARE_2stack()
                 75 0d
       01a2:b4b4 77 03           JA         LAB_01a2_b4b9
       01a2:b4b6 e9 0c 00        JMP        LAB_01a2_b4c5
                             LAB_01a2_b4b9                                   XREF[1]:     01a2:b4b4(j)  
       01a2:b4b9 90              NOP
       01a2:b4ba d9 06 e2 a4     FLD        float ptr [0xa4e2]
       01a2:b4be 90              NOP
       01a2:b4bf d9 1e 12 a5     FSTP       float ptr [0xa512]
       01a2:b4c3 90              NOP
       01a2:b4c4 9b              WAIT
                             LAB_01a2_b4c5                                   XREF[1]:     01a2:b4b6(j)  
       01a2:b4c5 b8 01 00        MOV        AX,0x1
       01a2:b4c8 50              PUSH       AX
       01a2:b4c9 b8 09 00        MOV        AX,0x9
       01a2:b4cc 50              PUSH       AX
       01a2:b4cd b8 02 00        MOV        AX,0x2
       01a2:b4d0 50              PUSH       AX
       01a2:b4d1 9a 86 61        CALLF      COLOR
                 71 0e
       01a2:b4d6 90              NOP
       01a2:b4d7 d9 06 78 a6     FLD        float ptr [0xa678]
       01a2:b4db 90              NOP
       01a2:b4dc d8 06 1e a5     FADD       float ptr [0xa51e]
       01a2:b4e0 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:b4e5 50              PUSH       AX
       01a2:b4e6 9a be 82        CALLF      SUB_0e71_82be
                 71 0e
       01a2:b4eb b8 3e a7        MOV        AX,""
       01a2:b4ee 50              PUSH       AX
       01a2:b4ef 9a c3 76        CALLF      PRINT_STR_SEMICOLON
                 71 0e
       01a2:b4f4 ff 36 24 a5     PUSH       word ptr [0xa524]
       01a2:b4f8 ff 36 22 a5     PUSH       word ptr [0xa522]
       01a2:b4fc 9a a5 76        CALLF      PRINT_float_semicolon
                 71 0e
       01a2:b501 b8 01 00        MOV        AX,0x1
       01a2:b504 50              PUSH       AX
       01a2:b505 b8 07 00        MOV        AX,0x7
       01a2:b508 50              PUSH       AX
       01a2:b509 b8 02 00        MOV        AX,0x2
       01a2:b50c 50              PUSH       AX
       01a2:b50d 9a 86 61        CALLF      COLOR
                 71 0e
       01a2:b512 90              NOP
       01a2:b513 d9 06 1e a5     FLD        float ptr [0xa51e]
       01a2:b517 90              NOP
       01a2:b518 d8 06 3a b4     FADD       float ptr [0xb43a]
       01a2:b51c 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:b521 50              PUSH       AX
       01a2:b522 9a be 82        CALLF      SUB_0e71_82be
                 71 0e
       01a2:b527 b8 3e a7        MOV        AX,""
       01a2:b52a 50              PUSH       AX
       01a2:b52b 9a c3 76        CALLF      PRINT_STR_SEMICOLON
                 71 0e
       01a2:b530 ff 36 e0 a4     PUSH       word ptr [0xa4e0]
       01a2:b534 ff 36 de a4     PUSH       word ptr [0xa4de]
       01a2:b538 9a a5 76        CALLF      PRINT_float_semicolon
                 71 0e
       01a2:b53d b8 01 00        MOV        AX,0x1
       01a2:b540 50              PUSH       AX
       01a2:b541 b8 0d 00        MOV        AX,0xd
       01a2:b544 50              PUSH       AX
       01a2:b545 b8 02 00        MOV        AX,0x2
       01a2:b548 50              PUSH       AX
       01a2:b549 9a 86 61        CALLF      COLOR
                 71 0e
       01a2:b54e 90              NOP
       01a2:b54f d9 06 1e a5     FLD        float ptr [0xa51e]
       01a2:b553 90              NOP
       01a2:b554 d8 06 56 b4     FADD       float ptr [0xb456]
       01a2:b558 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:b55d 50              PUSH       AX
       01a2:b55e 9a be 82        CALLF      SUB_0e71_82be
                 71 0e
       01a2:b563 b8 3e a7        MOV        AX,""
       01a2:b566 50              PUSH       AX
       01a2:b567 9a c3 76        CALLF      PRINT_STR_SEMICOLON
                 71 0e
       01a2:b56c ff 36 28 a5     PUSH       word ptr [0xa528]
       01a2:b570 ff 36 26 a5     PUSH       word ptr [0xa526]
       01a2:b574 9a a5 76        CALLF      PRINT_float_semicolon
                 71 0e
       01a2:b579 b8 01 00        MOV        AX,0x1
       01a2:b57c 50              PUSH       AX
       01a2:b57d b8 0c 00        MOV        AX,0xc
       01a2:b580 50              PUSH       AX
       01a2:b581 b8 02 00        MOV        AX,0x2
       01a2:b584 50              PUSH       AX
       01a2:b585 9a 86 61        CALLF      COLOR
                 71 0e
       01a2:b58a 90              NOP
       01a2:b58b d9 06 1e a5     FLD        float ptr [0xa51e]
       01a2:b58f 90              NOP
       01a2:b590 d8 06 ca b4     FADD       float ptr [0xb4ca]
       01a2:b594 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:b599 50              PUSH       AX
       01a2:b59a 9a be 82        CALLF      SUB_0e71_82be
                 71 0e
       01a2:b59f b8 3e a7        MOV        AX,""
       01a2:b5a2 50              PUSH       AX
       01a2:b5a3 9a c3 76        CALLF      PRINT_STR_SEMICOLON
                 71 0e
       01a2:b5a8 ff 36 2c a5     PUSH       word ptr [0xa52c]
       01a2:b5ac ff 36 2a a5     PUSH       word ptr [0xa52a]
       01a2:b5b0 9a a5 76        CALLF      PRINT_float_semicolon
                 71 0e
       01a2:b5b5 b8 01 00        MOV        AX,0x1
       01a2:b5b8 50              PUSH       AX
       01a2:b5b9 b8 0e 00        MOV        AX,0xe
       01a2:b5bc 50              PUSH       AX
       01a2:b5bd b8 02 00        MOV        AX,0x2
       01a2:b5c0 50              PUSH       AX
       01a2:b5c1 9a 86 61        CALLF      COLOR
                 71 0e
       01a2:b5c6 90              NOP
       01a2:b5c7 d9 06 ee b3     FLD        float ptr [0xb3ee]
       01a2:b5cb 90              NOP
       01a2:b5cc d8 06 1e a5     FADD       float ptr [0xa51e]
       01a2:b5d0 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:b5d5 50              PUSH       AX
       01a2:b5d6 9a be 82        CALLF      SUB_0e71_82be
                 71 0e
       01a2:b5db b8 3e a7        MOV        AX,""
       01a2:b5de 50              PUSH       AX
       01a2:b5df 9a c3 76        CALLF      PRINT_STR_SEMICOLON
                 71 0e
       01a2:b5e4 90              NOP
       01a2:b5e5 d9 06 e2 a4     FLD        float ptr [0xa4e2]
       01a2:b5e9 90              NOP
       01a2:b5ea 9b              WAIT
       01a2:b5eb 9a 49 04        CALLF      FUN_0d75_0449                                    undefined FUN_0d75_0449()
                 75 0d
       01a2:b5f0 83 ec 04        SUB        SP,0x4
       01a2:b5f3 8b dc           MOV        BX,SP
       01a2:b5f5 90              NOP
       01a2:b5f6 d9 1f           FSTP       float ptr [BX]
       01a2:b5f8 90              NOP
       01a2:b5f9 9b              WAIT
       01a2:b5fa 9a aa 76        CALLF      PRINT_float_newline
                 71 0e
       01a2:b5ff 90              NOP
       01a2:b600 d9 06 06 a5     FLD        float ptr [0xa506]
       01a2:b604 90              NOP
       01a2:b605 d8 06 0e a5     FADD       float ptr [0xa50e]
       01a2:b609 90              NOP
       01a2:b60a d9 1e 06 a5     FSTP       float ptr [0xa506]
       01a2:b60e 90              NOP
       01a2:b60f 9b              WAIT
       01a2:b610 90              NOP
       01a2:b611 d9 06 3a 00     FLD        float ptr [0x3a]
       01a2:b615 90              NOP
       01a2:b616 d8 06 50 a5     FADD       float ptr { 1.0 }
                             LAB_01a2_b61a                                   XREF[1]:     01a2:b281(j)  
       01a2:b61a 90              NOP
       01a2:b61b d9 1e 3a 00     FSTP       float ptr [0x3a]
       01a2:b61f 90              NOP
       01a2:b620 9b              WAIT
       01a2:b621 90              NOP
       01a2:b622 d9 06 1a a5     FLD        float ptr [0xa51a]
       01a2:b626 90              NOP
       01a2:b627 d9 06 3a 00     FLD        float ptr [0x3a]
       01a2:b62b 90              NOP
       01a2:b62c 9b              WAIT
       01a2:b62d 9a 1d 04        CALLF      FPCOMPARE_2stack                                 undefined FPCOMPARE_2stack()
                 75 0d
       01a2:b632 77 03           JA         LAB_01a2_b637
       01a2:b634 e9 4d fc        JMP        LAB_01a2_b284
                             LAB_01a2_b637                                   XREF[1]:     01a2:b632(j)  
       01a2:b637 b8 01 00        MOV        AX,0x1
       01a2:b63a 50              PUSH       AX
       01a2:b63b b8 1a 00        MOV        AX,0x1a
       01a2:b63e 50              PUSH       AX
       01a2:b63f b8 01 00        MOV        AX,0x1
       01a2:b642 50              PUSH       AX
       01a2:b643 b8 0a 00        MOV        AX,0xa
       01a2:b646 50              PUSH       AX
       01a2:b647 b8 04 00        MOV        AX,0x4
       01a2:b64a 50              PUSH       AX
       01a2:b64b 9a b2 61        CALLF      LOCATE
                 71 0e
       01a2:b650 b8 01 00        MOV        AX,0x1
       01a2:b653 50              PUSH       AX
       01a2:b654 b8 02 00        MOV        AX,0x2
       01a2:b657 50              PUSH       AX
       01a2:b658 50              PUSH       AX
       01a2:b659 9a 86 61        CALLF      COLOR
                 71 0e
       01a2:b65e b8 ba b9        MOV        AX,0xb9ba
       01a2:b661 50              PUSH       AX
       01a2:b662 9a c3 76        CALLF      PRINT_STR_SEMICOLON
                 71 0e
       01a2:b667 b8 01 00        MOV        AX,0x1
       01a2:b66a 50              PUSH       AX
       01a2:b66b b8 0c 00        MOV        AX,0xc
       01a2:b66e 50              PUSH       AX
       01a2:b66f b8 02 00        MOV        AX,0x2
       01a2:b672 50              PUSH       AX
       01a2:b673 9a 86 61        CALLF      COLOR
                 71 0e
       01a2:b678 b8 2e a5        MOV        AX,0xa52e
       01a2:b67b 50              PUSH       AX
       01a2:b67c 9a c3 76        CALLF      PRINT_STR_SEMICOLON
                 71 0e
       01a2:b681 b8 01 00        MOV        AX,0x1
       01a2:b684 50              PUSH       AX
       01a2:b685 b8 02 00        MOV        AX,0x2
       01a2:b688 50              PUSH       AX
       01a2:b689 50              PUSH       AX
       01a2:b68a 9a 86 61        CALLF      COLOR
                 71 0e
       01a2:b68f b8 da b9        MOV        AX,0xb9da
       01a2:b692 50              PUSH       AX
       01a2:b693 9a c3 76        CALLF      PRINT_STR_SEMICOLON
                 71 0e
       01a2:b698 b8 01 00        MOV        AX,0x1
       01a2:b69b 50              PUSH       AX
       01a2:b69c b8 0d 00        MOV        AX,0xd
       01a2:b69f 50              PUSH       AX
       01a2:b6a0 b8 02 00        MOV        AX,0x2
       01a2:b6a3 50              PUSH       AX
       01a2:b6a4 9a 86 61        CALLF      COLOR
                 71 0e
       01a2:b6a9 ff 36 14 a5     PUSH       word ptr [0xa514]
       01a2:b6ad ff 36 12 a5     PUSH       word ptr [0xa512]
       01a2:b6b1 9a aa 76        CALLF      PRINT_float_newline
                 71 0e
       01a2:b6b6 33 c0           XOR        AX,AX
       01a2:b6b8 50              PUSH       AX
       01a2:b6b9 50              PUSH       AX
       01a2:b6ba 9a 91 5b        CALLF      GRAPHICS_SETPT1
                 71 0e
       01a2:b6bf b8 7f 02        MOV        AX,0x27f
       01a2:b6c2 50              PUSH       AX
       01a2:b6c3 b8 cc 01        MOV        AX,0x1cc
       01a2:b6c6 50              PUSH       AX
       01a2:b6c7 9a ab 5b        CALLF      GRAPHICS_SETPT2
                 71 0e
       01a2:b6cc b8 0e 00        MOV        AX,0xe
       01a2:b6cf 50              PUSH       AX
       01a2:b6d0 b8 ff ff        MOV        AX,0xffff
       01a2:b6d3 50              PUSH       AX
       01a2:b6d4 b8 01 00        MOV        AX,0x1
       01a2:b6d7 50              PUSH       AX
       01a2:b6d8 9a 80 10        CALLF      LINE
                 71 0e
       01a2:b6dd b8 40 01        MOV        AX,0x140
       01a2:b6e0 50              PUSH       AX
       01a2:b6e1 33 c0           XOR        AX,AX
       01a2:b6e3 50              PUSH       AX
       01a2:b6e4 9a 91 5b        CALLF      GRAPHICS_SETPT1
                 71 0e
       01a2:b6e9 b8 40 01        MOV        AX,0x140
       01a2:b6ec 50              PUSH       AX
       01a2:b6ed b8 88 01        MOV        AX,0x188
       01a2:b6f0 50              PUSH       AX
       01a2:b6f1 9a ab 5b        CALLF      GRAPHICS_SETPT2
                 71 0e
       01a2:b6f6 b8 0e 00        MOV        AX,0xe
       01a2:b6f9 50              PUSH       AX
       01a2:b6fa b8 ff ff        MOV        AX,0xffff
       01a2:b6fd 50              PUSH       AX
       01a2:b6fe 33 c0           XOR        AX,AX
       01a2:b700 50              PUSH       AX
       01a2:b701 9a 80 10        CALLF      LINE
                 71 0e
       01a2:b706 b8 02 00        MOV        AX,0x2
       01a2:b709 50              PUSH       AX
       01a2:b70a b8 88 01        MOV        AX,0x188
       01a2:b70d 50              PUSH       AX
       01a2:b70e 9a 91 5b        CALLF      GRAPHICS_SETPT1
                 71 0e
       01a2:b713 b8 7d 02        MOV        AX,0x27d
       01a2:b716 50              PUSH       AX
       01a2:b717 b8 a4 01        MOV        AX,0x1a4
       01a2:b71a 50              PUSH       AX
       01a2:b71b 9a ab 5b        CALLF      GRAPHICS_SETPT2
                 71 0e
       01a2:b720 b8 0b 00        MOV        AX,0xb
       01a2:b723 50              PUSH       AX
       01a2:b724 b8 ff ff        MOV        AX,0xffff
       01a2:b727 50              PUSH       AX
       01a2:b728 b8 01 00        MOV        AX,0x1
       01a2:b72b 50              PUSH       AX
       01a2:b72c 9a 80 10        CALLF      LINE
                 71 0e
       01a2:b731 33 c0           XOR        AX,AX
       01a2:b733 50              PUSH       AX
       01a2:b734 b8 28 00        MOV        AX,0x28
       01a2:b737 50              PUSH       AX
       01a2:b738 9a 91 5b        CALLF      GRAPHICS_SETPT1
                 71 0e
       01a2:b73d b8 80 02        MOV        AX,0x280
       01a2:b740 50              PUSH       AX
       01a2:b741 b8 28 00        MOV        AX,0x28
       01a2:b744 50              PUSH       AX
       01a2:b745 9a ab 5b        CALLF      GRAPHICS_SETPT2
                 71 0e
       01a2:b74a b8 0e 00        MOV        AX,0xe
       01a2:b74d 50              PUSH       AX
       01a2:b74e b8 ff ff        MOV        AX,0xffff
       01a2:b751 50              PUSH       AX
       01a2:b752 33 c0           XOR        AX,AX
       01a2:b754 50              PUSH       AX
       01a2:b755 9a 80 10        CALLF      LINE
                 71 0e
       01a2:b75a b8 02 00        MOV        AX,0x2
       01a2:b75d 50              PUSH       AX
       01a2:b75e b8 a6 01        MOV        AX,0x1a6
       01a2:b761 50              PUSH       AX
       01a2:b762 9a 91 5b        CALLF      GRAPHICS_SETPT1
                 71 0e
       01a2:b767 b8 7d 02        MOV        AX,0x27d
       01a2:b76a 50              PUSH       AX
       01a2:b76b b8 ca 01        MOV        AX,0x1ca
       01a2:b76e 50              PUSH       AX
       01a2:b76f 9a ab 5b        CALLF      GRAPHICS_SETPT2
                 71 0e
       01a2:b774 b8 0e 00        MOV        AX,0xe
       01a2:b777 50              PUSH       AX
       01a2:b778 b8 ff ff        MOV        AX,0xffff
       01a2:b77b 50              PUSH       AX
       01a2:b77c b8 01 00        MOV        AX,0x1
       01a2:b77f 50              PUSH       AX
       01a2:b780 9a 80 10        CALLF      LINE
                 71 0e
       01a2:b785 c3              RET
                             **************************************************************
                             *                          FUNCTION                          *
                             **************************************************************
                             undefined __cdecl16near FUN_01a2_b786()
                               assume DS = 0x1997
             undefined         <UNASSIGNED>   <RETURN>
                             FUN_01a2_b786                                   XREF[3]:     FUN_01a2_0d85:01a2:13e9(c), 
                                                                                          01a2:b80c(j), 01a2:b9ae(j)  
       01a2:b786 b8 3e a7        MOV        AX,""
       01a2:b789 50              PUSH       AX
       01a2:b78a b8 32 a4        MOV        AX,0xa432
       01a2:b78d 50              PUSH       AX
       01a2:b78e 9a 78 7c        CALLF      SET_STRING
                 71 0e
       01a2:b793 b8 01 00        MOV        AX,0x1
       01a2:b796 50              PUSH       AX
       01a2:b797 b8 1c 00        MOV        AX,0x1c
       01a2:b79a 50              PUSH       AX
       01a2:b79b b8 01 00        MOV        AX,0x1
       01a2:b79e 50              PUSH       AX
       01a2:b79f b8 05 00        MOV        AX,0x5
       01a2:b7a2 50              PUSH       AX
       01a2:b7a3 b8 04 00        MOV        AX,0x4
       01a2:b7a6 50              PUSH       AX
       01a2:b7a7 9a b2 61        CALLF      LOCATE
                 71 0e
       01a2:b7ac b8 01 00        MOV        AX,0x1
       01a2:b7af 50              PUSH       AX
       01a2:b7b0 b8 0f 00        MOV        AX,0xf
       01a2:b7b3 50              PUSH       AX
       01a2:b7b4 b8 02 00        MOV        AX,0x2
       01a2:b7b7 50              PUSH       AX
       01a2:b7b8 9a 86 61        CALLF      COLOR
                 71 0e
       01a2:b7bd b8 f4 b9        MOV        AX,0xb9f4
       01a2:b7c0 50              PUSH       AX
       01a2:b7c1 e8 00 00        CALL       LAB_01a2_b7c4
                             LAB_01a2_b7c4                                   XREF[1]:     01a2:b7c1(j)  
       01a2:b7c4 58              POP        AX
       01a2:b7c5 05 0d 00        ADD        AX,0xd
       01a2:b7c8 0e              PUSH       CS
       01a2:b7c9 50              PUSH       AX
       01a2:b7ca 9a e8 64        CALLF      SUB_0e71_64e8
                 71 0e
       01a2:b7cf eb 04           JMP        LAB_01a2_b7d5
       01a2:b7d1 02              ??         02h
       01a2:b7d2 00              ??         00h
       01a2:b7d3 00              ??         00h
       01a2:b7d4 04              ??         04h
                             LAB_01a2_b7d5                                   XREF[1]:     01a2:b7cf(j)  
       01a2:b7d5 bb d6 a4        MOV        BX,0xa4d6
       01a2:b7d8 1e              PUSH       DS
       01a2:b7d9 07              POP        ES
       01a2:b7da 06              PUSH       ES
       01a2:b7db 53              PUSH       BX
       01a2:b7dc 9a 1a 7e        CALLF      SUB_0e71_7e1a
                 71 0e
       01a2:b7e1 9a fc 77        CALLF      SUB_0e71_77fc
                 71 0e
       01a2:b7e6 90              NOP
       01a2:b7e7 d9 06 d6 a4     FLD        float ptr [0xa4d6]
       01a2:b7eb 90              NOP
       01a2:b7ec 9b              WAIT
       01a2:b7ed 9a 49 04        CALLF      FUN_0d75_0449                                    undefined FUN_0d75_0449()
                 75 0d
       01a2:b7f2 90              NOP
       01a2:b7f3 d9 1e d6 a4     FSTP       float ptr [0xa4d6]
       01a2:b7f7 90              NOP
       01a2:b7f8 9b              WAIT
       01a2:b7f9 90              NOP
       01a2:b7fa d9 06 50 a5     FLD        float ptr { 1.0 }
       01a2:b7fe 90              NOP
       01a2:b7ff d9 06 d6 a4     FLD        float ptr [0xa4d6]
       01a2:b803 90              NOP
       01a2:b804 9b              WAIT
       01a2:b805 9a 1d 04        CALLF      FPCOMPARE_2stack                                 undefined FPCOMPARE_2stack()
                 75 0d
       01a2:b80a 73 03           JNC        LAB_01a2_b80f
       01a2:b80c e9 77 ff        JMP        FUN_01a2_b786
                             LAB_01a2_b80f                                   XREF[1]:     01a2:b80a(j)  
       01a2:b80f b8 01 00        MOV        AX,0x1
       01a2:b812 50              PUSH       AX
       01a2:b813 b8 1c 00        MOV        AX,0x1c
       01a2:b816 50              PUSH       AX
       01a2:b817 b8 01 00        MOV        AX,0x1
       01a2:b81a 50              PUSH       AX
       01a2:b81b b8 05 00        MOV        AX,0x5
       01a2:b81e 50              PUSH       AX
       01a2:b81f b8 04 00        MOV        AX,0x4
       01a2:b822 50              PUSH       AX
       01a2:b823 9a b2 61        CALLF      LOCATE
                 71 0e
       01a2:b828 b8 1c ba        MOV        AX,0xba1c
       01a2:b82b 50              PUSH       AX
       01a2:b82c 9a c8 76        CALLF      PRINT_STR_NEWLINE
                 71 0e
       01a2:b831 90              NOP
       01a2:b832 d9 06 ee a4     FLD        float ptr [0xa4ee]
       01a2:b836 90              NOP
       01a2:b837 d9 06 d6 a4     FLD        float ptr [0xa4d6]
       01a2:b83b 90              NOP
       01a2:b83c 9b              WAIT
       01a2:b83d 9a 1d 04        CALLF      FPCOMPARE_2stack                                 undefined FPCOMPARE_2stack()
                 75 0d
       01a2:b842 76 03           JBE        LAB_01a2_b847
       01a2:b844 e9 c0 00        JMP        LAB_01a2_b907
                             LAB_01a2_b847                                   XREF[1]:     01a2:b842(j)  
       01a2:b847 90              NOP
       01a2:b848 d9 06 50 a5     FLD        float ptr { 1.0 }
       01a2:b84c 90              NOP
       01a2:b84d d9 1e 06 a5     FSTP       float ptr [0xa506]
       01a2:b851 90              NOP
       01a2:b852 9b              WAIT
       01a2:b853 90              NOP
       01a2:b854 d9 06 d6 a4     FLD        float ptr [0xa4d6]
       01a2:b858 90              NOP
       01a2:b859 d9 1e 32 a5     FSTP       float ptr [0xa532]
       01a2:b85d 90              NOP
       01a2:b85e 9b              WAIT
       01a2:b85f 90              NOP
       01a2:b860 d9 06 50 a5     FLD        float ptr { 1.0 }
       01a2:b864 e9 64 00        JMP        LAB_01a2_b8cb
       01a2:b867 90              ??         90h
                             LAB_01a2_b868                                   XREF[1]:     01a2:b8e3(j)  
       01a2:b868 90              NOP
       01a2:b869 d9 06 3a 00     FLD        float ptr [0x3a]
       01a2:b86d 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:b872 d1 e0           SHL        AX,0x1
       01a2:b874 d1 e0           SHL        AX,0x1
       01a2:b876 05 cc 00        ADD        AX,0xcc
       01a2:b879 8b f0           MOV        SI,AX
       01a2:b87b 90              NOP
       01a2:b87c d9 84 92 9c     FLD        float ptr [SI + 0x9c92]
       01a2:b880 90              NOP
       01a2:b881 d9 1e 0e a5     FSTP       float ptr [0xa50e]
       01a2:b885 90              NOP
       01a2:b886 9b              WAIT
       01a2:b887 b8 f6 a4        MOV        AX,0xa4f6
       01a2:b88a 50              PUSH       AX
       01a2:b88b 90              NOP
       01a2:b88c d9 06 06 a5     FLD        float ptr [0xa506]
       01a2:b890 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:b895 50              PUSH       AX
       01a2:b896 90              NOP
       01a2:b897 d9 06 0e a5     FLD        float ptr [0xa50e]
       01a2:b89b 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:b8a0 50              PUSH       AX
       01a2:b8a1 9a ee 7f        CALLF      MID$
                 71 0e
       01a2:b8a6 50              PUSH       AX
       01a2:b8a7 b8 36 a4        MOV        AX,0xa436
       01a2:b8aa 50              PUSH       AX
       01a2:b8ab 9a 78 7c        CALLF      SET_STRING
                 71 0e
       01a2:b8b0 90              NOP
       01a2:b8b1 d9 06 06 a5     FLD        float ptr [0xa506]
       01a2:b8b5 90              NOP
       01a2:b8b6 d8 06 0e a5     FADD       float ptr [0xa50e]
       01a2:b8ba 90              NOP
       01a2:b8bb d9 1e 06 a5     FSTP       float ptr [0xa506]
       01a2:b8bf 90              NOP
       01a2:b8c0 9b              WAIT
       01a2:b8c1 90              NOP
       01a2:b8c2 d9 06 3a 00     FLD        float ptr [0x3a]
       01a2:b8c6 90              NOP
       01a2:b8c7 d8 06 50 a5     FADD       float ptr { 1.0 }
                             LAB_01a2_b8cb                                   XREF[1]:     01a2:b864(j)  
       01a2:b8cb 90              NOP
       01a2:b8cc d9 1e 3a 00     FSTP       float ptr [0x3a]
       01a2:b8d0 90              NOP
       01a2:b8d1 9b              WAIT
       01a2:b8d2 90              NOP
       01a2:b8d3 d9 06 32 a5     FLD        float ptr [0xa532]
       01a2:b8d7 90              NOP
       01a2:b8d8 d9 06 3a 00     FLD        float ptr [0x3a]
       01a2:b8dc 90              NOP
       01a2:b8dd 9b              WAIT
       01a2:b8de 9a 1d 04        CALLF      FPCOMPARE_2stack                                 undefined FPCOMPARE_2stack()
                 75 0d
       01a2:b8e3 76 83           JBE        LAB_01a2_b868
       01a2:b8e5 90              NOP
       01a2:b8e6 d9 06 d6 a4     FLD        float ptr [0xa4d6]
       01a2:b8ea 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:b8ef d1 e0           SHL        AX,0x1
       01a2:b8f1 d1 e0           SHL        AX,0x1
       01a2:b8f3 05 fc 03        ADD        AX,0x3fc
       01a2:b8f6 8b f0           MOV        SI,AX
       01a2:b8f8 90              NOP
       01a2:b8f9 d9 84 92 9c     FLD        float ptr [SI + 0x9c92]
       01a2:b8fd 90              NOP
       01a2:b8fe d9 1e e2 a4     FSTP       float ptr [0xa4e2]
       01a2:b902 90              NOP
       01a2:b903 9b              WAIT
       01a2:b904 e9 a5 01        JMP        LAB_01a2_baac
                             LAB_01a2_b907                                   XREF[1]:     01a2:b844(j)  
       01a2:b907 90              NOP
       01a2:b908 d9 06 3e b4     FLD        float ptr [0xb43e]
       01a2:b90c 90              NOP
       01a2:b90d d9 06 ee a4     FLD        float ptr [0xa4ee]
       01a2:b911 90              NOP
       01a2:b912 9b              WAIT
       01a2:b913 9a 1d 04        CALLF      FPCOMPARE_2stack                                 undefined FPCOMPARE_2stack()
                 75 0d
       01a2:b918 73 03           JNC        LAB_01a2_b91d
       01a2:b91a e9 94 00        JMP        LAB_01a2_b9b1
                             LAB_01a2_b91d                                   XREF[1]:     01a2:b918(j)  
       01a2:b91d b8 20 03        MOV        AX,0x320
       01a2:b920 50              PUSH       AX
       01a2:b921 ff 36 b6 a6     PUSH       word ptr [0xa6b6]
       01a2:b925 ff 36 b4 a6     PUSH       word ptr { 2.0 }
       01a2:b929 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:b92e b8 90 01        MOV        AX,0x190
       01a2:b931 50              PUSH       AX
       01a2:b932 ff 36 b6 a6     PUSH       word ptr [0xa6b6]
       01a2:b936 ff 36 b4 a6     PUSH       word ptr { 2.0 }
       01a2:b93a 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:b93f b8 20 03        MOV        AX,0x320
       01a2:b942 50              PUSH       AX
       01a2:b943 ff 36 b6 a6     PUSH       word ptr [0xa6b6]
       01a2:b947 ff 36 b4 a6     PUSH       word ptr { 2.0 }
       01a2:b94b 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:b950 b8 90 01        MOV        AX,0x190
       01a2:b953 50              PUSH       AX
       01a2:b954 ff 36 b6 a6     PUSH       word ptr [0xa6b6]
       01a2:b958 ff 36 b4 a6     PUSH       word ptr { 2.0 }
       01a2:b95c 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:b961 b8 20 03        MOV        AX,0x320
       01a2:b964 50              PUSH       AX
       01a2:b965 ff 36 b6 a6     PUSH       word ptr [0xa6b6]
       01a2:b969 ff 36 b4 a6     PUSH       word ptr { 2.0 }
       01a2:b96d 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:b972 b8 90 01        MOV        AX,0x190
       01a2:b975 50              PUSH       AX
       01a2:b976 ff 36 b6 a6     PUSH       word ptr [0xa6b6]
       01a2:b97a ff 36 b4 a6     PUSH       word ptr { 2.0 }
       01a2:b97e 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:b983 b8 01 00        MOV        AX,0x1
       01a2:b986 50              PUSH       AX
       01a2:b987 b8 1c 00        MOV        AX,0x1c
       01a2:b98a 50              PUSH       AX
       01a2:b98b b8 01 00        MOV        AX,0x1
       01a2:b98e 50              PUSH       AX
       01a2:b98f b8 05 00        MOV        AX,0x5
       01a2:b992 50              PUSH       AX
       01a2:b993 b8 04 00        MOV        AX,0x4
       01a2:b996 50              PUSH       AX
       01a2:b997 9a b2 61        CALLF      LOCATE
                 71 0e
       01a2:b99c b8 54 ba        MOV        AX,0xba54
       01a2:b99f 50              PUSH       AX
       01a2:b9a0 9a c8 76        CALLF      PRINT_STR_NEWLINE
                 71 0e
       01a2:b9a5 e8 af 82        CALL       FUN_01a2_3c57                                    undefined FUN_01a2_3c57()
       01a2:b9a8 e8 ac 82        CALL       FUN_01a2_3c57                                    undefined FUN_01a2_3c57()
       01a2:b9ab e8 a9 82        CALL       FUN_01a2_3c57                                    undefined FUN_01a2_3c57()
       01a2:b9ae e9 d5 fd        JMP        FUN_01a2_b786
                             LAB_01a2_b9b1                                   XREF[1]:     01a2:b91a(j)  
       01a2:b9b1 90              NOP
       01a2:b9b2 d9 06 ee a4     FLD        float ptr [0xa4ee]
       01a2:b9b6 90              NOP
       01a2:b9b7 d9 06 d6 a4     FLD        float ptr [0xa4d6]
       01a2:b9bb 90              NOP
       01a2:b9bc 9b              WAIT
       01a2:b9bd 9a 1d 04        CALLF      FPCOMPARE_2stack                                 undefined FPCOMPARE_2stack()
                 75 0d
       01a2:b9c2 77 03           JA         LAB_01a2_b9c7
       01a2:b9c4 e9 11 00        JMP        LAB_01a2_b9d8
                             LAB_01a2_b9c7                                   XREF[1]:     01a2:b9c2(j)  
       01a2:b9c7 90              NOP
       01a2:b9c8 d9 06 ee a4     FLD        float ptr [0xa4ee]
       01a2:b9cc 90              NOP
       01a2:b9cd d8 06 50 a5     FADD       float ptr { 1.0 }
       01a2:b9d1 90              NOP
       01a2:b9d2 d9 1e d6 a4     FSTP       float ptr [0xa4d6]
       01a2:b9d6 90              NOP
       01a2:b9d7 9b              WAIT
                             LAB_01a2_b9d8                                   XREF[1]:     01a2:b9c4(j)  
       01a2:b9d8 90              NOP
       01a2:b9d9 d9 06 d6 a4     FLD        float ptr [0xa4d6]
       01a2:b9dd 90              NOP
       01a2:b9de d9 06 ee a4     FLD        float ptr [0xa4ee]
       01a2:b9e2 90              NOP
       01a2:b9e3 d8 06 50 a5     FADD       float ptr { 1.0 }
       01a2:b9e7 90              NOP
       01a2:b9e8 9b              WAIT
       01a2:b9e9 9a 1d 04        CALLF      FPCOMPARE_2stack                                 undefined FPCOMPARE_2stack()
                 75 0d
       01a2:b9ee 74 03           JZ         LAB_01a2_b9f3
       01a2:b9f0 e9 0c 00        JMP        LAB_01a2_b9ff
                             LAB_01a2_b9f3                                   XREF[1]:     01a2:b9ee(j)  
       01a2:b9f3 90              NOP
       01a2:b9f4 d9 06 d6 a4     FLD        float ptr [0xa4d6]
       01a2:b9f8 90              NOP
       01a2:b9f9 d9 1e ee a4     FSTP       float ptr [0xa4ee]
       01a2:b9fd 90              NOP
       01a2:b9fe 9b              WAIT
                             LAB_01a2_b9ff                                   XREF[1]:     01a2:b9f0(j)  
       01a2:b9ff b8 01 00        MOV        AX,0x1
       01a2:ba02 50              PUSH       AX
       01a2:ba03 b8 1c 00        MOV        AX,0x1c
       01a2:ba06 50              PUSH       AX
       01a2:ba07 b8 01 00        MOV        AX,0x1
       01a2:ba0a 50              PUSH       AX
       01a2:ba0b b8 05 00        MOV        AX,0x5
       01a2:ba0e 50              PUSH       AX
       01a2:ba0f b8 04 00        MOV        AX,0x4
       01a2:ba12 50              PUSH       AX
       01a2:ba13 9a b2 61        CALLF      LOCATE
                 71 0e
       01a2:ba18 b8 7e ba        MOV        AX,0xba7e
       01a2:ba1b 50              PUSH       AX
       01a2:ba1c e8 00 00        CALL       LAB_01a2_ba1f
                             LAB_01a2_ba1f                                   XREF[1]:     01a2:ba1c(j)  
       01a2:ba1f 58              POP        AX
       01a2:ba20 05 0d 00        ADD        AX,0xd
       01a2:ba23 0e              PUSH       CS
       01a2:ba24 50              PUSH       AX
       01a2:ba25 9a e8 64        CALLF      SUB_0e71_64e8
                 71 0e
       01a2:ba2a eb 04           JMP        LAB_01a2_ba30
       01a2:ba2c 02              ??         02h
       01a2:ba2d 00              ??         00h
       01a2:ba2e 01              ??         01h
       01a2:ba2f 03              ??         03h
                             LAB_01a2_ba30                                   XREF[1]:     01a2:ba2a(j)  
       01a2:ba30 b8 36 a4        MOV        AX,0xa436
       01a2:ba33 1e              PUSH       DS
       01a2:ba34 50              PUSH       AX
       01a2:ba35 33 c0           XOR        AX,AX
       01a2:ba37 50              PUSH       AX
       01a2:ba38 9a 20 7e        CALLF      SUB_0e71_7e20
                 71 0e
       01a2:ba3d 9a fc 77        CALLF      SUB_0e71_77fc
                 71 0e
       01a2:ba42 b8 36 a4        MOV        AX,0xa436
       01a2:ba45 50              PUSH       AX
       01a2:ba46 9a 21 7f        CALLF      LEN
                 71 0e
       01a2:ba4b 3d 09 00        CMP        AX,0x9
       01a2:ba4e 7f 03           JG         LAB_01a2_ba53
       01a2:ba50 e9 17 00        JMP        LAB_01a2_ba6a
                             LAB_01a2_ba53                                   XREF[1]:     01a2:ba4e(j)  
       01a2:ba53 b8 36 a4        MOV        AX,0xa436
       01a2:ba56 50              PUSH       AX
       01a2:ba57 b8 09 00        MOV        AX,0x9
       01a2:ba5a 50              PUSH       AX
       01a2:ba5b 9a ca 7f        CALLF      SUB_0e71_7fca
                 71 0e
       01a2:ba60 50              PUSH       AX
       01a2:ba61 b8 36 a4        MOV        AX,0xa436
       01a2:ba64 50              PUSH       AX
       01a2:ba65 9a 78 7c        CALLF      SET_STRING
                 71 0e
                             LAB_01a2_ba6a                                   XREF[1]:     01a2:ba50(j)  
       01a2:ba6a b8 f6 a4        MOV        AX,0xa4f6
       01a2:ba6d 50              PUSH       AX
       01a2:ba6e b8 36 a4        MOV        AX,0xa436
       01a2:ba71 50              PUSH       AX
       01a2:ba72 9a b1 7c        CALLF      STRING_CONCAT
                 71 0e
       01a2:ba77 50              PUSH       AX
       01a2:ba78 b8 f6 a4        MOV        AX,0xa4f6
       01a2:ba7b 50              PUSH       AX
       01a2:ba7c 9a 78 7c        CALLF      SET_STRING
                 71 0e
       01a2:ba81 b8 36 a4        MOV        AX,0xa436
       01a2:ba84 50              PUSH       AX
       01a2:ba85 9a 21 7f        CALLF      LEN
                 71 0e
       01a2:ba8a 9a c4 03        CALLF      FUN_0d75_03c4                                    undefined FUN_0d75_03c4()
                 75 0d
       01a2:ba8f 90              NOP
       01a2:ba90 d9 06 d6 a4     FLD        float ptr [0xa4d6]
       01a2:ba94 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:ba99 d1 e0           SHL        AX,0x1
       01a2:ba9b d1 e0           SHL        AX,0x1
       01a2:ba9d 05 cc 00        ADD        AX,0xcc
       01a2:baa0 8b f0           MOV        SI,AX
       01a2:baa2 90              NOP
       01a2:baa3 d9 9c 92 9c     FSTP       float ptr [SI + 0x9c92]
       01a2:baa7 90              NOP
       01a2:baa8 9b              WAIT
       01a2:baa9 e9 5b f7        JMP        FUN_01a2_b207                                    undefined FUN_01a2_b207()
                             -- Flow Override: CALL_RETURN (CALL_TERMINATOR)
                             LAB_01a2_baac                                   XREF[1]:     01a2:b904(j)  
       01a2:baac 90              NOP
       01a2:baad d9 06 4c a6     FLD        float ptr { 0.0 }
       01a2:bab1 90              NOP
       01a2:bab2 d9 1e 36 a5     FSTP       float ptr [0xa536]
       01a2:bab6 90              NOP
       01a2:bab7 9b              WAIT
       01a2:bab8 c3              RET
                             **************************************************************
                             *                          FUNCTION                          *
                             **************************************************************
LRepairUI:   ' LRepairUI=Lbab9 -- repair-wait UI: error msg, computer animation, unlock msg (FUN_01a2_bab9 not yet decompiled)
                             undefined __cdecl16near FUN_01a2_bab9()
                               assume DS = 0x1997
             undefined         <UNASSIGNED>   <RETURN>
                             FUN_01a2_bab9                                   XREF[3]:     FUN_01a2_902f:01a2:90a4(c),
                                                                                          FUN_01a2_90ad:01a2:90ee(c), 
                                                                                          FUN_01a2_90f7:01a2:9167(c)  
       01a2:bab9 b8 01 00        MOV        AX,0x1
       01a2:babc 50              PUSH       AX
       01a2:babd b8 1b 00        MOV        AX,0x1b
       01a2:bac0 50              PUSH       AX
       01a2:bac1 b8 01 00        MOV        AX,0x1
       01a2:bac4 50              PUSH       AX
       01a2:bac5 b8 06 00        MOV        AX,0x6
       01a2:bac8 50              PUSH       AX
       01a2:bac9 b8 04 00        MOV        AX,0x4
       01a2:bacc 50              PUSH       AX
       01a2:bacd 9a b2 61        CALLF      LOCATE
                 71 0e
       01a2:bad2 b8 01 00        MOV        AX,0x1
       01a2:bad5 50              PUSH       AX
       01a2:bad6 b8 0d 00        MOV        AX,0xd
       01a2:bad9 50              PUSH       AX
       01a2:bada b8 02 00        MOV        AX,0x2
       01a2:badd 50              PUSH       AX
       01a2:bade 9a 86 61        CALLF      COLOR
                 71 0e
       01a2:bae3 b8 c6 a4        MOV        AX,0xa4c6
       01a2:bae6 50              PUSH       AX
       01a2:bae7 9a c8 76        CALLF      PRINT_STR_NEWLINE
                 71 0e
                             LAB_01a2_baec                                   XREF[1]:     01a2:bbfe(j)  
       01a2:baec 9a 00 07        CALLF      TIMER                                            undefined TIMER()
                 71 0e
       01a2:baf1 8b f0           MOV        SI,AX
       01a2:baf3 90              NOP
       01a2:baf4 d9 04           FLD        float ptr [SI]
       01a2:baf6 90              NOP
       01a2:baf7 d9 1e 5e a4     FSTP       float ptr [0xa45e]
       01a2:bafb 90              NOP
       01a2:bafc 9b              WAIT
       01a2:bafd 90              NOP
       01a2:bafe d9 06 50 a5     FLD        float ptr { 1.0 }
       01a2:bb02 e9 c4 00        JMP        LAB_01a2_bbc9
       01a2:bb05 90              ??         90h
                             LAB_01a2_bb06                                   XREF[1]:     01a2:bbe3(j)  
       01a2:bb06 90              NOP
       01a2:bb07 d9 06 66 a4     FLD        float ptr [0xa466]
       01a2:bb0b 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:bb10 d1 e0           SHL        AX,0x1
       01a2:bb12 d1 e0           SHL        AX,0x1
       01a2:bb14 05 b0 00        ADD        AX,0xb0
       01a2:bb17 8b f0           MOV        SI,AX
       01a2:bb19 90              NOP
       01a2:bb1a d9 84 46 a2     FLD        float ptr [SI + Fa246!(i,j)]
       01a2:bb1e 90              NOP
       01a2:bb1f d9 1e 2e a2     FSTP       float ptr [0xa22e]
       01a2:bb23 90              NOP
       01a2:bb24 9b              WAIT
       01a2:bb25 90              NOP
       01a2:bb26 d9 06 66 a4     FLD        float ptr [0xa466]
       01a2:bb2a 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:bb2f d1 e0           SHL        AX,0x1
       01a2:bb31 d1 e0           SHL        AX,0x1
       01a2:bb33 05 84 00        ADD        AX,0x84
       01a2:bb36 8b f0           MOV        SI,AX
       01a2:bb38 90              NOP
       01a2:bb39 d9 84 46 a2     FLD        float ptr [SI + Fa246!(i,j)]
       01a2:bb3d 90              NOP
       01a2:bb3e d9 1e 32 a2     FSTP       float ptr [0xa232]
       01a2:bb42 90              NOP
       01a2:bb43 9b              WAIT
       01a2:bb44 90              NOP
       01a2:bb45 d9 06 4c a6     FLD        float ptr { 0.0 }
       01a2:bb49 90              NOP
       01a2:bb4a d9 06 66 a4     FLD        float ptr [0xa466]
       01a2:bb4e 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:bb53 d1 e0           SHL        AX,0x1
       01a2:bb55 d1 e0           SHL        AX,0x1
       01a2:bb57 05 2c 00        ADD        AX,0x2c
       01a2:bb5a 8b f0           MOV        SI,AX
       01a2:bb5c 90              NOP
       01a2:bb5d d9 84 46 a2     FLD        float ptr [SI + Fa246!(i,j)]
       01a2:bb61 90              NOP
       01a2:bb62 9b              WAIT
       01a2:bb63 9a 1d 04        CALLF      FPCOMPARE_2stack                                 undefined FPCOMPARE_2stack()
                 75 0d
       01a2:bb68 75 03           JNZ        LAB_01a2_bb6d
       01a2:bb6a e9 03 00        JMP        LAB_01a2_bb70
                             LAB_01a2_bb6d                                   XREF[1]:     01a2:bb68(j)  
       01a2:bb6d e9 06 00        JMP        LAB_01a2_bb76
                             LAB_01a2_bb70                                   XREF[1]:     01a2:bb6a(j)  
       01a2:bb70 e8 af 79        CALL       FUN_01a2_3522                                    undefined FUN_01a2_3522()
       01a2:bb73 e9 49 00        JMP        LAB_01a2_bbbf
                             LAB_01a2_bb76                                   XREF[1]:     01a2:bb6d(j)  
       01a2:bb76 9a 00 07        CALLF      TIMER                                            undefined TIMER()
                 71 0e
       01a2:bb7b 8b f0           MOV        SI,AX
       01a2:bb7d 90              NOP
       01a2:bb7e d9 04           FLD        float ptr [SI]
       01a2:bb80 90              NOP
       01a2:bb81 d9 1e 5e a4     FSTP       float ptr [0xa45e]
       01a2:bb85 90              NOP
       01a2:bb86 9b              WAIT
       01a2:bb87 90              NOP
       01a2:bb88 d9 06 66 a4     FLD        float ptr [0xa466]
       01a2:bb8c 90              NOP
       01a2:bb8d d9 1e 6a a4     FSTP       float ptr [0xa46a]
       01a2:bb91 90              NOP
       01a2:bb92 9b              WAIT
       01a2:bb93 90              NOP
       01a2:bb94 d9 06 5e a4     FLD        float ptr [0xa45e]
       01a2:bb98 90              NOP
       01a2:bb99 d9 06 6a a4     FLD        float ptr [0xa46a]
       01a2:bb9d 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:bba2 d1 e0           SHL        AX,0x1
       01a2:bba4 d1 e0           SHL        AX,0x1
       01a2:bba6 05 58 00        ADD        AX,0x58
       01a2:bba9 8b f0           MOV        SI,AX
       01a2:bbab 90              NOP
       01a2:bbac d9 84 46 a2     FLD        float ptr [SI + Fa246!(i,j)]
       01a2:bbb0 90              NOP
       01a2:bbb1 9b              WAIT
       01a2:bbb2 9a 1d 04        CALLF      FPCOMPARE_2stack                                 undefined FPCOMPARE_2stack()
                 75 0d
       01a2:bbb7 72 03           JC         LAB_01a2_bbbc
       01a2:bbb9 e9 03 00        JMP        LAB_01a2_bbbf
                             LAB_01a2_bbbc                                   XREF[1]:     01a2:bbb7(j)  
       01a2:bbbc e8 b0 7b        CALL       FUN_01a2_376f                                    undefined FUN_01a2_376f()
                             LAB_01a2_bbbf                                   XREF[2]:     01a2:bb73(j), 01a2:bbb9(j)  
       01a2:bbbf 90              NOP
       01a2:bbc0 d9 06 66 a4     FLD        float ptr [0xa466]
       01a2:bbc4 90              NOP
       01a2:bbc5 d8 06 50 a5     FADD       float ptr { 1.0 }
                             LAB_01a2_bbc9                                   XREF[1]:     01a2:bb02(j)  
       01a2:bbc9 90              NOP
       01a2:bbca d9 1e 66 a4     FSTP       float ptr [0xa466]
       01a2:bbce 90              NOP
       01a2:bbcf 9b              WAIT
       01a2:bbd0 90              NOP
       01a2:bbd1 d9 06 8c af     FLD        float ptr { 10.0 }
       01a2:bbd5 90              NOP
       01a2:bbd6 d9 06 66 a4     FLD        float ptr [0xa466]
       01a2:bbda 90              NOP
       01a2:bbdb 9b              WAIT
       01a2:bbdc 9a 1d 04        CALLF      FPCOMPARE_2stack                                 undefined FPCOMPARE_2stack()
                 75 0d
       01a2:bbe1 77 03           JA         LAB_01a2_bbe6
       01a2:bbe3 e9 20 ff        JMP        LAB_01a2_bb06
                             LAB_01a2_bbe6                                   XREF[1]:     01a2:bbe1(j)  
       01a2:bbe6 90              NOP
       01a2:bbe7 d9 06 ae a4     FLD        float ptr [0xa4ae]
       01a2:bbeb 9a 00 07        CALLF      TIMER                                            undefined TIMER()
                 71 0e
       01a2:bbf0 8b f0           MOV        SI,AX
       01a2:bbf2 90              NOP
       01a2:bbf3 d9 04           FLD        float ptr [SI]
       01a2:bbf5 90              NOP
       01a2:bbf6 9b              WAIT
       01a2:bbf7 9a 1d 04        CALLF      FPCOMPARE_2stack                                 undefined FPCOMPARE_2stack()
                 75 0d
       01a2:bbfc 73 03           JNC        LAB_01a2_bc01
       01a2:bbfe e9 eb fe        JMP        LAB_01a2_baec
                             LAB_01a2_bc01                                   XREF[1]:     01a2:bbfc(j)  
       01a2:bc01 b8 b8 0b        MOV        AX,0xbb8
       01a2:bc04 50              PUSH       AX
       01a2:bc05 ff 36 76 a6     PUSH       word ptr [0xa676]
       01a2:bc09 ff 36 74 a6     PUSH       word ptr { 4.0 }
       01a2:bc0d 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:bc12 b8 01 00        MOV        AX,0x1
       01a2:bc15 50              PUSH       AX
       01a2:bc16 b8 1b 00        MOV        AX,0x1b
       01a2:bc19 50              PUSH       AX
       01a2:bc1a b8 01 00        MOV        AX,0x1
       01a2:bc1d 50              PUSH       AX
       01a2:bc1e b8 06 00        MOV        AX,0x6
       01a2:bc21 50              PUSH       AX
       01a2:bc22 b8 04 00        MOV        AX,0x4
       01a2:bc25 50              PUSH       AX
       01a2:bc26 9a b2 61        CALLF      LOCATE
                 71 0e
       01a2:bc2b b8 01 00        MOV        AX,0x1
       01a2:bc2e 50              PUSH       AX
       01a2:bc2f b8 02 00        MOV        AX,0x2
       01a2:bc32 50              PUSH       AX
       01a2:bc33 50              PUSH       AX
       01a2:bc34 9a 86 61        CALLF      COLOR
                 71 0e
       01a2:bc39 b8 ca a4        MOV        AX,0xa4ca
       01a2:bc3c 50              PUSH       AX
       01a2:bc3d 9a c8 76        CALLF      PRINT_STR_NEWLINE
                 71 0e
       01a2:bc42 b8 3e a7        MOV        AX,""
       01a2:bc45 50              PUSH       AX
       01a2:bc46 b8 6e a4        MOV        AX,0xa46e
       01a2:bc49 50              PUSH       AX
       01a2:bc4a 9a 78 7c        CALLF      SET_STRING
                 71 0e
       01a2:bc4f 90              NOP
       01a2:bc50 d9 06 50 a5     FLD        float ptr { 1.0 }
       01a2:bc54 e9 0e 00        JMP        LAB_01a2_bc65
       01a2:bc57 90              ??         90h
                             LAB_01a2_bc58                                   XREF[1]:     01a2:bc7d(j)  
       01a2:bc58 e8 35 80        CALL       FUN_01a2_3c90                                    undefined FUN_01a2_3c90()
       01a2:bc5b 90              NOP
       01a2:bc5c d9 06 3a a5     FLD        float ptr [0xa53a]
       01a2:bc60 90              NOP
       01a2:bc61 d8 06 50 a5     FADD       float ptr { 1.0 }
                             LAB_01a2_bc65                                   XREF[1]:     01a2:bc54(j)  
       01a2:bc65 90              NOP
       01a2:bc66 d9 1e 3a a5     FSTP       float ptr [0xa53a]
       01a2:bc6a 90              NOP
       01a2:bc6b 9b              WAIT
       01a2:bc6c 90              NOP
       01a2:bc6d d9 06 24 a6     FLD        float ptr { 3.0 }
       01a2:bc71 90              NOP
       01a2:bc72 d9 06 3a a5     FLD        float ptr [0xa53a]
       01a2:bc76 90              NOP
       01a2:bc77 9b              WAIT
       01a2:bc78 9a 1d 04        CALLF      FPCOMPARE_2stack                                 undefined FPCOMPARE_2stack()
                 75 0d
       01a2:bc7d 76 d9           JBE        LAB_01a2_bc58
       01a2:bc7f b8 01 00        MOV        AX,0x1
       01a2:bc82 50              PUSH       AX
       01a2:bc83 b8 1b 00        MOV        AX,0x1b
       01a2:bc86 50              PUSH       AX
       01a2:bc87 b8 01 00        MOV        AX,0x1
       01a2:bc8a 50              PUSH       AX
       01a2:bc8b b8 06 00        MOV        AX,0x6
       01a2:bc8e 50              PUSH       AX
       01a2:bc8f b8 04 00        MOV        AX,0x4
       01a2:bc92 50              PUSH       AX
       01a2:bc93 9a b2 61        CALLF      LOCATE
                 71 0e
       01a2:bc98 b8 96 ba        MOV        AX,0xba96
       01a2:bc9b 50              PUSH       AX
       01a2:bc9c 9a c8 76        CALLF      PRINT_STR_NEWLINE
                 71 0e
       01a2:bca1 c3              RET
Lbca2:   ' Lbca2=Lbca2 -- end-of-game handler (FUN_01a2_bca2, not yet decompiled)
                             **************************************************************
                             *                          FUNCTION                          *
                             **************************************************************
                             undefined __cdecl16near FUN_01a2_bca2()
             undefined         <UNASSIGNED>   <RETURN>
                             FUN_01a2_bca2                                   XREF[3]:     FUN_01a2_0d85:01a2:13db(c), 
                                                                                          FUN_01a2_9170:01a2:9ae3(c), 
                                                                                          FUN_01a2_9c28:01a2:ad8a(c)  
       01a2:bca2 b8 01 00        MOV        AX,0x1
       01a2:bca5 50              PUSH       AX
       01a2:bca6 b8 0f 00        MOV        AX,0xf
       01a2:bca9 50              PUSH       AX
       01a2:bcaa b8 02 00        MOV        AX,0x2
       01a2:bcad 50              PUSH       AX
       01a2:bcae 9a 86 61        CALLF      COLOR
                 71 0e
       01a2:bcb3 b8 3e a7        MOV        AX,""
       01a2:bcb6 50              PUSH       AX
       01a2:bcb7 b8 42 a2        MOV        AX,0xa242
       01a2:bcba 50              PUSH       AX
       01a2:bcbb 9a 78 7c        CALLF      SET_STRING
                 71 0e
       01a2:bcc0 b8 01 00        MOV        AX,0x1
       01a2:bcc3 50              PUSH       AX
       01a2:bcc4 b8 1e 00        MOV        AX,0x1e
       01a2:bcc7 50              PUSH       AX
       01a2:bcc8 b8 01 00        MOV        AX,0x1
       01a2:bccb 50              PUSH       AX
       01a2:bccc b8 23 00        MOV        AX,0x23
       01a2:bccf 50              PUSH       AX
       01a2:bcd0 b8 04 00        MOV        AX,0x4
       01a2:bcd3 50              PUSH       AX
       01a2:bcd4 9a b2 61        CALLF      LOCATE
                 71 0e
       01a2:bcd9 b8 c6 ba        MOV        AX,0xbac6
       01a2:bcdc 50              PUSH       AX
       01a2:bcdd 9a c3 76        CALLF      PRINT_STR_SEMICOLON
                 71 0e
                             LAB_01a2_bce2                                   XREF[1]:     01a2:bd1e(j)  
       01a2:bce2 b8 42 a2        MOV        AX,0xa242
       01a2:bce5 50              PUSH       AX
       01a2:bce6 9a 21 7f        CALLF      LEN
                 71 0e
       01a2:bceb 0b c0           OR         AX,AX
       01a2:bced 74 03           JZ         LAB_01a2_bcf2
       01a2:bcef e9 2e 00        JMP        LAB_01a2_bd20
                             LAB_01a2_bcf2                                   XREF[1]:     01a2:bced(j)  
       01a2:bcf2 9a 30 7c        CALLF      INKEY$
                 71 0e
       01a2:bcf7 50              PUSH       AX
       01a2:bcf8 b8 42 a2        MOV        AX,0xa242
       01a2:bcfb 50              PUSH       AX
       01a2:bcfc 9a 78 7c        CALLF      SET_STRING
                 71 0e
       01a2:bd01 b8 1b 00        MOV        AX,0x1b
       01a2:bd04 50              PUSH       AX
       01a2:bd05 9a 2d 7d        CALLF      CHR$
                 71 0e
       01a2:bd0a 50              PUSH       AX
       01a2:bd0b b8 42 a2        MOV        AX,0xa242
       01a2:bd0e 50              PUSH       AX
       01a2:bd0f 9a ee 7c        CALLF      STRING_COMPARE
                 71 0e
       01a2:bd14 74 03           JZ         LAB_01a2_bd19
       01a2:bd16 e9 05 00        JMP        LAB_01a2_bd1e
                             LAB_01a2_bd19                                   XREF[1]:     01a2:bd14(j)  
       01a2:bd19 9a 23 00        CALLF      SUB_0e71_8453
                 b4 16
                             LAB_01a2_bd1e                                   XREF[1]:     01a2:bd16(j)  
       01a2:bd1e eb c2           JMP        LAB_01a2_bce2
                             LAB_01a2_bd20                                   XREF[1]:     01a2:bcef(j)  
       01a2:bd20 b8 3e a7        MOV        AX,""
       01a2:bd23 50              PUSH       AX
       01a2:bd24 b8 42 a2        MOV        AX,0xa242
       01a2:bd27 50              PUSH       AX
       01a2:bd28 9a 78 7c        CALLF      SET_STRING
                 71 0e
       01a2:bd2d c3              RET
       01a2:bd2e 00              ??         00h
       01a2:bd2f 00              ??         00h

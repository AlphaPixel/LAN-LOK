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
'   Fa44e!      (kept)    purpose unknown -- only set to 0 in decompiled code; used in stubs
'   Fa452!      (kept)    purpose unknown -- only set to 0 in decompiled code; used in stubs
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
'   LVictory    =L9170   victory screen: network crashed, player wins, 2000 bonus pts
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
                             **************************************************************
                             *                          FUNCTION                          *
                             **************************************************************
                             undefined __cdecl16near FUN_01a2_9ae7()
                               assume DS = 0x1997
             undefined         <UNASSIGNED>   <RETURN>
                             FUN_01a2_9ae7                                   XREF[3]:     FUN_01a2_9c28:01a2:a241(c), 
                                                                                          FUN_01a2_9c28:01a2:a261(c), 
                                                                                          FUN_01a2_9c28:01a2:a2a2(c)  
       01a2:9ae7 b8 40 01        MOV        AX,0x140
       01a2:9aea 50              PUSH       AX
       01a2:9aeb b8 f0 00        MOV        AX,0xf0
       01a2:9aee 50              PUSH       AX
       01a2:9aef 9a 91 5b        CALLF      GRAPHICS_SETPT1
                 71 0e
       01a2:9af4 ff 36 16 b7     PUSH       word ptr [0xb716]
       01a2:9af8 ff 36 14 b7     PUSH       word ptr [0xb714]
       01a2:9afc 90              NOP
       01a2:9afd d9 06 be a4     FLD        float ptr [0xa4be]
       01a2:9b01 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:9b06 50              PUSH       AX
       01a2:9b07 9a b4 0d        CALLF      CIRCLE
                 71 0e
       01a2:9b0c b8 40 01        MOV        AX,0x140
       01a2:9b0f 50              PUSH       AX
       01a2:9b10 b8 f0 00        MOV        AX,0xf0
       01a2:9b13 50              PUSH       AX
       01a2:9b14 9a 91 5b        CALLF      GRAPHICS_SETPT1
                 71 0e
       01a2:9b19 ff 36 1a b7     PUSH       word ptr [0xb71a]
       01a2:9b1d ff 36 18 b7     PUSH       word ptr [0xb718]
       01a2:9b21 90              NOP
       01a2:9b22 d9 06 be a4     FLD        float ptr [0xa4be]
       01a2:9b26 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:9b2b 50              PUSH       AX
       01a2:9b2c 9a b4 0d        CALLF      CIRCLE
                 71 0e
       01a2:9b31 b8 40 01        MOV        AX,0x140
       01a2:9b34 50              PUSH       AX
       01a2:9b35 b8 f0 00        MOV        AX,0xf0
       01a2:9b38 50              PUSH       AX
       01a2:9b39 9a 91 5b        CALLF      GRAPHICS_SETPT1
                 71 0e
       01a2:9b3e ff 36 76 af     PUSH       word ptr [0xaf76]
       01a2:9b42 ff 36 74 af     PUSH       word ptr { 120.0 }
       01a2:9b46 90              NOP
       01a2:9b47 d9 06 be a4     FLD        float ptr [0xa4be]
       01a2:9b4b 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:9b50 50              PUSH       AX
       01a2:9b51 9a b4 0d        CALLF      CIRCLE
                 71 0e
       01a2:9b56 b8 40 01        MOV        AX,0x140
       01a2:9b59 50              PUSH       AX
       01a2:9b5a b8 f0 00        MOV        AX,0xf0
       01a2:9b5d 50              PUSH       AX
       01a2:9b5e 9a 91 5b        CALLF      GRAPHICS_SETPT1
                 71 0e
       01a2:9b63 ff 36 1e b7     PUSH       word ptr [0xb71e]
       01a2:9b67 ff 36 1c b7     PUSH       word ptr [0xb71c]
       01a2:9b6b 90              NOP
       01a2:9b6c d9 06 be a4     FLD        float ptr [0xa4be]
       01a2:9b70 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:9b75 50              PUSH       AX
       01a2:9b76 9a b4 0d        CALLF      CIRCLE
                 71 0e
       01a2:9b7b b8 40 01        MOV        AX,0x140
       01a2:9b7e 50              PUSH       AX
       01a2:9b7f b8 f0 00        MOV        AX,0xf0
       01a2:9b82 50              PUSH       AX
       01a2:9b83 9a 91 5b        CALLF      GRAPHICS_SETPT1
                 71 0e
       01a2:9b88 ff 36 b2 a6     PUSH       word ptr [0xa6b2]
       01a2:9b8c ff 36 b0 a6     PUSH       word ptr [0xa6b0]
       01a2:9b90 90              NOP
       01a2:9b91 d9 06 be a4     FLD        float ptr [0xa4be]
       01a2:9b95 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:9b9a 50              PUSH       AX
       01a2:9b9b 9a b4 0d        CALLF      CIRCLE
                 71 0e
       01a2:9ba0 b8 40 01        MOV        AX,0x140
       01a2:9ba3 50              PUSH       AX
       01a2:9ba4 b8 f0 00        MOV        AX,0xf0
       01a2:9ba7 50              PUSH       AX
       01a2:9ba8 9a 91 5b        CALLF      GRAPHICS_SETPT1
                 71 0e
       01a2:9bad ff 36 fc b3     PUSH       word ptr [0xb3fc]
       01a2:9bb1 ff 36 fa b3     PUSH       word ptr [0xb3fa]
       01a2:9bb5 90              NOP
       01a2:9bb6 d9 06 be a4     FLD        float ptr [0xa4be]
       01a2:9bba 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:9bbf 50              PUSH       AX
       01a2:9bc0 9a b4 0d        CALLF      CIRCLE
                 71 0e
       01a2:9bc5 b8 40 01        MOV        AX,0x140
       01a2:9bc8 50              PUSH       AX
       01a2:9bc9 b8 14 00        MOV        AX,0x14
       01a2:9bcc 50              PUSH       AX
       01a2:9bcd 9a 91 5b        CALLF      GRAPHICS_SETPT1
                 71 0e
       01a2:9bd2 b8 40 01        MOV        AX,0x140
       01a2:9bd5 50              PUSH       AX
       01a2:9bd6 b8 cc 01        MOV        AX,0x1cc
       01a2:9bd9 50              PUSH       AX
       01a2:9bda 9a ab 5b        CALLF      GRAPHICS_SETPT2
                 71 0e
       01a2:9bdf 90              NOP
       01a2:9be0 d9 06 be a4     FLD        float ptr [0xa4be]
       01a2:9be4 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:9be9 50              PUSH       AX
       01a2:9bea b8 ff ff        MOV        AX,0xffff
       01a2:9bed 50              PUSH       AX
       01a2:9bee 33 c0           XOR        AX,AX
       01a2:9bf0 50              PUSH       AX
       01a2:9bf1 9a 80 10        CALLF      LINE
                 71 0e
       01a2:9bf6 b8 64 00        MOV        AX,0x64
       01a2:9bf9 50              PUSH       AX
       01a2:9bfa b8 f0 00        MOV        AX,0xf0
       01a2:9bfd 50              PUSH       AX
       01a2:9bfe 9a 91 5b        CALLF      GRAPHICS_SETPT1
                 71 0e
       01a2:9c03 b8 1c 02        MOV        AX,0x21c
       01a2:9c06 50              PUSH       AX
       01a2:9c07 b8 f0 00        MOV        AX,0xf0
       01a2:9c0a 50              PUSH       AX
       01a2:9c0b 9a ab 5b        CALLF      GRAPHICS_SETPT2
                 71 0e
       01a2:9c10 90              NOP
       01a2:9c11 d9 06 be a4     FLD        float ptr [0xa4be]
       01a2:9c15 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:9c1a 50              PUSH       AX
       01a2:9c1b b8 ff ff        MOV        AX,0xffff
       01a2:9c1e 50              PUSH       AX
       01a2:9c1f 33 c0           XOR        AX,AX
       01a2:9c21 50              PUSH       AX
       01a2:9c22 9a 80 10        CALLF      LINE
                 71 0e
       01a2:9c27 c3              RET
                             **************************************************************
                             *                          FUNCTION                          *
                             **************************************************************
                             undefined FUN_01a2_9c28()
                               assume DS = 0x1997
             undefined         <UNASSIGNED>   <RETURN>
                             FUN_01a2_9c28                                   XREF[1]:     FUN_01a2_19fa:01a2:2ba0(c)  
       01a2:9c28 b8 01 00        MOV        AX,0x1
       01a2:9c2b 50              PUSH       AX
       01a2:9c2c b8 0c 00        MOV        AX,0xc
       01a2:9c2f 50              PUSH       AX
       01a2:9c30 b8 02 00        MOV        AX,0x2
       01a2:9c33 50              PUSH       AX
       01a2:9c34 9a 46 66        CALLF      SCREEN
                 71 0e
       01a2:9c39 33 c0           XOR        AX,AX
       01a2:9c3b 50              PUSH       AX
       01a2:9c3c 9a 25 62        CALLF      CLS
                 71 0e
       01a2:9c41 b8 40 06        MOV        AX,0x640
       01a2:9c44 50              PUSH       AX
       01a2:9c45 ff 36 52 a5     PUSH       word ptr [0xa552]
       01a2:9c49 ff 36 50 a5     PUSH       word ptr { 1.0 }
       01a2:9c4d 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:9c52 33 c0           XOR        AX,AX
       01a2:9c54 50              PUSH       AX
       01a2:9c55 50              PUSH       AX
       01a2:9c56 9a 91 5b        CALLF      GRAPHICS_SETPT1
                 71 0e
       01a2:9c5b b8 80 02        MOV        AX,0x280
       01a2:9c5e 50              PUSH       AX
       01a2:9c5f b8 e0 01        MOV        AX,0x1e0
       01a2:9c62 50              PUSH       AX
       01a2:9c63 9a ab 5b        CALLF      GRAPHICS_SETPT2
                 71 0e
       01a2:9c68 b8 03 00        MOV        AX,0x3
       01a2:9c6b 50              PUSH       AX
       01a2:9c6c b8 ff ff        MOV        AX,0xffff
       01a2:9c6f 50              PUSH       AX
       01a2:9c70 b8 02 00        MOV        AX,0x2
       01a2:9c73 50              PUSH       AX
       01a2:9c74 9a 80 10        CALLF      LINE
                 71 0e
       01a2:9c79 e8 db 9f        CALL       FUN_01a2_3c57                                    undefined FUN_01a2_3c57()
       01a2:9c7c b8 78 00        MOV        AX,0x78
       01a2:9c7f 50              PUSH       AX
       01a2:9c80 b8 2c 01        MOV        AX,0x12c
       01a2:9c83 50              PUSH       AX
       01a2:9c84 9a 91 5b        CALLF      GRAPHICS_SETPT1
                 71 0e
       01a2:9c89 b8 08 02        MOV        AX,0x208
       01a2:9c8c 50              PUSH       AX
       01a2:9c8d b8 a4 01        MOV        AX,0x1a4
       01a2:9c90 50              PUSH       AX
       01a2:9c91 9a ab 5b        CALLF      GRAPHICS_SETPT2
                 71 0e
       01a2:9c96 33 c0           XOR        AX,AX
       01a2:9c98 50              PUSH       AX
       01a2:9c99 b8 ff ff        MOV        AX,0xffff
       01a2:9c9c 50              PUSH       AX
       01a2:9c9d b8 01 00        MOV        AX,0x1
       01a2:9ca0 50              PUSH       AX
       01a2:9ca1 9a 80 10        CALLF      LINE
                 71 0e
       01a2:9ca6 b8 79 00        MOV        AX,0x79
       01a2:9ca9 50              PUSH       AX
       01a2:9caa b8 2d 01        MOV        AX,0x12d
       01a2:9cad 50              PUSH       AX
       01a2:9cae 9a 91 5b        CALLF      GRAPHICS_SETPT1
                 71 0e
       01a2:9cb3 b8 07 02        MOV        AX,0x207
       01a2:9cb6 50              PUSH       AX
       01a2:9cb7 b8 a3 01        MOV        AX,0x1a3
       01a2:9cba 50              PUSH       AX
       01a2:9cbb 9a ab 5b        CALLF      GRAPHICS_SETPT2
                 71 0e
       01a2:9cc0 b8 07 00        MOV        AX,0x7
       01a2:9cc3 50              PUSH       AX
       01a2:9cc4 b8 ff ff        MOV        AX,0xffff
       01a2:9cc7 50              PUSH       AX
       01a2:9cc8 b8 02 00        MOV        AX,0x2
       01a2:9ccb 50              PUSH       AX
       01a2:9ccc 9a 80 10        CALLF      LINE
                 71 0e
       01a2:9cd1 b8 8c 00        MOV        AX,0x8c
       01a2:9cd4 50              PUSH       AX
       01a2:9cd5 b8 14 00        MOV        AX,0x14
       01a2:9cd8 50              PUSH       AX
       01a2:9cd9 9a 91 5b        CALLF      GRAPHICS_SETPT1
                 71 0e
       01a2:9cde b8 f4 01        MOV        AX,0x1f4
       01a2:9ce1 50              PUSH       AX
       01a2:9ce2 b8 04 01        MOV        AX,0x104
       01a2:9ce5 50              PUSH       AX
       01a2:9ce6 9a ab 5b        CALLF      GRAPHICS_SETPT2
                 71 0e
       01a2:9ceb 33 c0           XOR        AX,AX
       01a2:9ced 50              PUSH       AX
       01a2:9cee b8 ff ff        MOV        AX,0xffff
       01a2:9cf1 50              PUSH       AX
       01a2:9cf2 b8 01 00        MOV        AX,0x1
       01a2:9cf5 50              PUSH       AX
       01a2:9cf6 9a 80 10        CALLF      LINE
                 71 0e
       01a2:9cfb b8 8d 00        MOV        AX,0x8d
       01a2:9cfe 50              PUSH       AX
       01a2:9cff b8 15 00        MOV        AX,0x15
       01a2:9d02 50              PUSH       AX
       01a2:9d03 9a 91 5b        CALLF      GRAPHICS_SETPT1
                 71 0e
       01a2:9d08 b8 f3 01        MOV        AX,0x1f3
       01a2:9d0b 50              PUSH       AX
       01a2:9d0c b8 03 01        MOV        AX,0x103
       01a2:9d0f 50              PUSH       AX
       01a2:9d10 9a ab 5b        CALLF      GRAPHICS_SETPT2
                 71 0e
       01a2:9d15 b8 07 00        MOV        AX,0x7
       01a2:9d18 50              PUSH       AX
       01a2:9d19 b8 ff ff        MOV        AX,0xffff
       01a2:9d1c 50              PUSH       AX
       01a2:9d1d b8 02 00        MOV        AX,0x2
       01a2:9d20 50              PUSH       AX
       01a2:9d21 9a 80 10        CALLF      LINE
                 71 0e
       01a2:9d26 b8 0f 01        MOV        AX,0x10f
       01a2:9d29 50              PUSH       AX
       01a2:9d2a b8 05 01        MOV        AX,0x105
       01a2:9d2d 50              PUSH       AX
       01a2:9d2e 9a 91 5b        CALLF      GRAPHICS_SETPT1
                 71 0e
       01a2:9d33 b8 71 01        MOV        AX,0x171
       01a2:9d36 50              PUSH       AX
       01a2:9d37 b8 2b 01        MOV        AX,0x12b
       01a2:9d3a 50              PUSH       AX
       01a2:9d3b 9a ab 5b        CALLF      GRAPHICS_SETPT2
                 71 0e
       01a2:9d40 b8 07 00        MOV        AX,0x7
       01a2:9d43 50              PUSH       AX
       01a2:9d44 b8 ff ff        MOV        AX,0xffff
       01a2:9d47 50              PUSH       AX
       01a2:9d48 b8 02 00        MOV        AX,0x2
       01a2:9d4b 50              PUSH       AX
       01a2:9d4c 9a 80 10        CALLF      LINE
                 71 0e
       01a2:9d51 b8 0e 01        MOV        AX,0x10e
       01a2:9d54 50              PUSH       AX
       01a2:9d55 b8 04 01        MOV        AX,0x104
       01a2:9d58 50              PUSH       AX
       01a2:9d59 9a 91 5b        CALLF      GRAPHICS_SETPT1
                 71 0e
       01a2:9d5e b8 72 01        MOV        AX,0x172
       01a2:9d61 50              PUSH       AX
       01a2:9d62 b8 2c 01        MOV        AX,0x12c
       01a2:9d65 50              PUSH       AX
       01a2:9d66 9a ab 5b        CALLF      GRAPHICS_SETPT2
                 71 0e
       01a2:9d6b 33 c0           XOR        AX,AX
       01a2:9d6d 50              PUSH       AX
       01a2:9d6e b8 ff ff        MOV        AX,0xffff
       01a2:9d71 50              PUSH       AX
       01a2:9d72 b8 01 00        MOV        AX,0x1
       01a2:9d75 50              PUSH       AX
       01a2:9d76 9a 80 10        CALLF      LINE
                 71 0e
       01a2:9d7b b8 a0 00        MOV        AX,0xa0
       01a2:9d7e 50              PUSH       AX
       01a2:9d7f b8 28 00        MOV        AX,0x28
       01a2:9d82 50              PUSH       AX
       01a2:9d83 9a 91 5b        CALLF      GRAPHICS_SETPT1
                 71 0e
       01a2:9d88 b8 e0 01        MOV        AX,0x1e0
       01a2:9d8b 50              PUSH       AX
       01a2:9d8c b8 e6 00        MOV        AX,0xe6
       01a2:9d8f 50              PUSH       AX
       01a2:9d90 9a ab 5b        CALLF      GRAPHICS_SETPT2
                 71 0e
       01a2:9d95 33 c0           XOR        AX,AX
       01a2:9d97 50              PUSH       AX
       01a2:9d98 b8 ff ff        MOV        AX,0xffff
       01a2:9d9b 50              PUSH       AX
       01a2:9d9c b8 02 00        MOV        AX,0x2
       01a2:9d9f 50              PUSH       AX
       01a2:9da0 9a 80 10        CALLF      LINE
                 71 0e
       01a2:9da5 b8 18 01        MOV        AX,0x118
       01a2:9da8 50              PUSH       AX
       01a2:9da9 b8 36 01        MOV        AX,0x136
       01a2:9dac 50              PUSH       AX
       01a2:9dad 9a 91 5b        CALLF      GRAPHICS_SETPT1
                 71 0e
       01a2:9db2 b8 b8 01        MOV        AX,0x1b8
       01a2:9db5 50              PUSH       AX
       01a2:9db6 b8 9a 01        MOV        AX,0x19a
       01a2:9db9 50              PUSH       AX
       01a2:9dba 9a ab 5b        CALLF      GRAPHICS_SETPT2
                 71 0e
       01a2:9dbf 33 c0           XOR        AX,AX
       01a2:9dc1 50              PUSH       AX
       01a2:9dc2 b8 ff ff        MOV        AX,0xffff
       01a2:9dc5 50              PUSH       AX
       01a2:9dc6 b8 02 00        MOV        AX,0x2
       01a2:9dc9 50              PUSH       AX
       01a2:9dca 9a 80 10        CALLF      LINE
                 71 0e
       01a2:9dcf b8 1a 01        MOV        AX,0x11a
       01a2:9dd2 50              PUSH       AX
       01a2:9dd3 b8 38 01        MOV        AX,0x138
       01a2:9dd6 50              PUSH       AX
       01a2:9dd7 9a 91 5b        CALLF      GRAPHICS_SETPT1
                 71 0e
       01a2:9ddc b8 b6 01        MOV        AX,0x1b6
       01a2:9ddf 50              PUSH       AX
       01a2:9de0 b8 98 01        MOV        AX,0x198
       01a2:9de3 50              PUSH       AX
       01a2:9de4 9a ab 5b        CALLF      GRAPHICS_SETPT2
                 71 0e
       01a2:9de9 b8 08 00        MOV        AX,0x8
       01a2:9dec 50              PUSH       AX
       01a2:9ded b8 ff ff        MOV        AX,0xffff
       01a2:9df0 50              PUSH       AX
       01a2:9df1 b8 02 00        MOV        AX,0x2
       01a2:9df4 50              PUSH       AX
       01a2:9df5 9a 80 10        CALLF      LINE
                 71 0e
       01a2:9dfa b8 2c 01        MOV        AX,0x12c
       01a2:9dfd 50              PUSH       AX
       01a2:9dfe b8 4a 01        MOV        AX,0x14a
       01a2:9e01 50              PUSH       AX
       01a2:9e02 9a 91 5b        CALLF      GRAPHICS_SETPT1
                 71 0e
       01a2:9e07 b8 9a 01        MOV        AX,0x19a
       01a2:9e0a 50              PUSH       AX
       01a2:9e0b b8 4d 01        MOV        AX,0x14d
       01a2:9e0e 50              PUSH       AX
       01a2:9e0f 9a ab 5b        CALLF      GRAPHICS_SETPT2
                 71 0e
       01a2:9e14 33 c0           XOR        AX,AX
       01a2:9e16 50              PUSH       AX
       01a2:9e17 b8 ff ff        MOV        AX,0xffff
       01a2:9e1a 50              PUSH       AX
       01a2:9e1b b8 02 00        MOV        AX,0x2
       01a2:9e1e 50              PUSH       AX
       01a2:9e1f 9a 80 10        CALLF      LINE
                 71 0e
       01a2:9e24 b8 18 01        MOV        AX,0x118
       01a2:9e27 50              PUSH       AX
       01a2:9e28 b8 5a 01        MOV        AX,0x15a
       01a2:9e2b 50              PUSH       AX
       01a2:9e2c 9a 91 5b        CALLF      GRAPHICS_SETPT1
                 71 0e
       01a2:9e31 b8 b8 01        MOV        AX,0x1b8
       01a2:9e34 50              PUSH       AX
       01a2:9e35 b8 5b 01        MOV        AX,0x15b
       01a2:9e38 50              PUSH       AX
       01a2:9e39 9a ab 5b        CALLF      GRAPHICS_SETPT2
                 71 0e
       01a2:9e3e 33 c0           XOR        AX,AX
       01a2:9e40 50              PUSH       AX
       01a2:9e41 b8 ff ff        MOV        AX,0xffff
       01a2:9e44 50              PUSH       AX
       01a2:9e45 b8 01 00        MOV        AX,0x1
       01a2:9e48 50              PUSH       AX
       01a2:9e49 9a 80 10        CALLF      LINE
                 71 0e
       01a2:9e4e b8 4a 01        MOV        AX,0x14a
       01a2:9e51 50              PUSH       AX
       01a2:9e52 b8 68 01        MOV        AX,0x168
       01a2:9e55 50              PUSH       AX
       01a2:9e56 9a 91 5b        CALLF      GRAPHICS_SETPT1
                 71 0e
       01a2:9e5b b8 7c 01        MOV        AX,0x17c
       01a2:9e5e 50              PUSH       AX
       01a2:9e5f b8 6b 01        MOV        AX,0x16b
       01a2:9e62 50              PUSH       AX
       01a2:9e63 9a ab 5b        CALLF      GRAPHICS_SETPT2
                 71 0e
       01a2:9e68 33 c0           XOR        AX,AX
       01a2:9e6a 50              PUSH       AX
       01a2:9e6b b8 ff ff        MOV        AX,0xffff
       01a2:9e6e 50              PUSH       AX
       01a2:9e6f b8 02 00        MOV        AX,0x2
       01a2:9e72 50              PUSH       AX
       01a2:9e73 9a 80 10        CALLF      LINE
                 71 0e
       01a2:9e78 b8 18 01        MOV        AX,0x118
       01a2:9e7b 50              PUSH       AX
       01a2:9e7c b8 78 01        MOV        AX,0x178
       01a2:9e7f 50              PUSH       AX
       01a2:9e80 9a 91 5b        CALLF      GRAPHICS_SETPT1
                 71 0e
       01a2:9e85 b8 b8 01        MOV        AX,0x1b8
       01a2:9e88 50              PUSH       AX
       01a2:9e89 b8 79 01        MOV        AX,0x179
       01a2:9e8c 50              PUSH       AX
       01a2:9e8d 9a ab 5b        CALLF      GRAPHICS_SETPT2
                 71 0e
       01a2:9e92 33 c0           XOR        AX,AX
       01a2:9e94 50              PUSH       AX
       01a2:9e95 b8 ff ff        MOV        AX,0xffff
       01a2:9e98 50              PUSH       AX
       01a2:9e99 b8 01 00        MOV        AX,0x1
       01a2:9e9c 50              PUSH       AX
       01a2:9e9d 9a 80 10        CALLF      LINE
                 71 0e
       01a2:9ea2 b8 8a 01        MOV        AX,0x18a
       01a2:9ea5 50              PUSH       AX
       01a2:9ea6 b8 81 01        MOV        AX,0x181
       01a2:9ea9 50              PUSH       AX
       01a2:9eaa 9a 91 5b        CALLF      GRAPHICS_SETPT1
                 71 0e
       01a2:9eaf b8 8e 01        MOV        AX,0x18e
       01a2:9eb2 50              PUSH       AX
       01a2:9eb3 b8 84 01        MOV        AX,0x184
       01a2:9eb6 50              PUSH       AX
       01a2:9eb7 9a ab 5b        CALLF      GRAPHICS_SETPT2
                 71 0e
       01a2:9ebc b8 0a 00        MOV        AX,0xa
       01a2:9ebf 50              PUSH       AX
       01a2:9ec0 b8 ff ff        MOV        AX,0xffff
       01a2:9ec3 50              PUSH       AX
       01a2:9ec4 b8 02 00        MOV        AX,0x2
       01a2:9ec7 50              PUSH       AX
       01a2:9ec8 9a 80 10        CALLF      LINE
                 71 0e
       01a2:9ecd b8 96 00        MOV        AX,0x96
       01a2:9ed0 50              PUSH       AX
       01a2:9ed1 b8 54 01        MOV        AX,0x154
       01a2:9ed4 50              PUSH       AX
       01a2:9ed5 9a 91 5b        CALLF      GRAPHICS_SETPT1
                 71 0e
       01a2:9eda b8 d2 00        MOV        AX,0xd2
       01a2:9edd 50              PUSH       AX
       01a2:9ede b8 6d 01        MOV        AX,0x16d
       01a2:9ee1 50              PUSH       AX
       01a2:9ee2 9a ab 5b        CALLF      GRAPHICS_SETPT2
                 71 0e
       01a2:9ee7 33 c0           XOR        AX,AX
       01a2:9ee9 50              PUSH       AX
       01a2:9eea b8 ff ff        MOV        AX,0xffff
       01a2:9eed 50              PUSH       AX
       01a2:9eee b8 01 00        MOV        AX,0x1
       01a2:9ef1 50              PUSH       AX
       01a2:9ef2 9a 80 10        CALLF      LINE
                 71 0e
       01a2:9ef7 b8 cc 01        MOV        AX,0x1cc
       01a2:9efa 50              PUSH       AX
       01a2:9efb b8 ed 00        MOV        AX,0xed
       01a2:9efe 50              PUSH       AX
       01a2:9eff 9a 91 5b        CALLF      GRAPHICS_SETPT1
                 71 0e
       01a2:9f04 b8 e0 01        MOV        AX,0x1e0
       01a2:9f07 50              PUSH       AX
       01a2:9f08 b8 fd 00        MOV        AX,0xfd
       01a2:9f0b 50              PUSH       AX
       01a2:9f0c 9a ab 5b        CALLF      GRAPHICS_SETPT2
                 71 0e
       01a2:9f11 33 c0           XOR        AX,AX
       01a2:9f13 50              PUSH       AX
       01a2:9f14 b8 ff ff        MOV        AX,0xffff
       01a2:9f17 50              PUSH       AX
       01a2:9f18 b8 02 00        MOV        AX,0x2
       01a2:9f1b 50              PUSH       AX
       01a2:9f1c 9a 80 10        CALLF      LINE
                 71 0e
       01a2:9f21 b8 c2 01        MOV        AX,0x1c2
       01a2:9f24 50              PUSH       AX
       01a2:9f25 b8 f9 00        MOV        AX,0xf9
       01a2:9f28 50              PUSH       AX
       01a2:9f29 9a 91 5b        CALLF      GRAPHICS_SETPT1
                 71 0e
       01a2:9f2e b8 c6 01        MOV        AX,0x1c6
       01a2:9f31 50              PUSH       AX
       01a2:9f32 b8 fc 00        MOV        AX,0xfc
       01a2:9f35 50              PUSH       AX
       01a2:9f36 9a ab 5b        CALLF      GRAPHICS_SETPT2
                 71 0e
       01a2:9f3b b8 0a 00        MOV        AX,0xa
       01a2:9f3e 50              PUSH       AX
       01a2:9f3f b8 ff ff        MOV        AX,0xffff
       01a2:9f42 50              PUSH       AX
       01a2:9f43 b8 02 00        MOV        AX,0x2
       01a2:9f46 50              PUSH       AX
       01a2:9f47 9a 80 10        CALLF      LINE
                 71 0e
       01a2:9f4c b8 a0 00        MOV        AX,0xa0
       01a2:9f4f 50              PUSH       AX
       01a2:9f50 b8 ed 00        MOV        AX,0xed
       01a2:9f53 50              PUSH       AX
       01a2:9f54 9a 91 5b        CALLF      GRAPHICS_SETPT1
                 71 0e
       01a2:9f59 b8 be 00        MOV        AX,0xbe
       01a2:9f5c 50              PUSH       AX
       01a2:9f5d b8 fa 00        MOV        AX,0xfa
       01a2:9f60 50              PUSH       AX
       01a2:9f61 9a ab 5b        CALLF      GRAPHICS_SETPT2
                 71 0e
       01a2:9f66 33 c0           XOR        AX,AX
       01a2:9f68 50              PUSH       AX
       01a2:9f69 b8 ff ff        MOV        AX,0xffff
       01a2:9f6c 50              PUSH       AX
       01a2:9f6d b8 01 00        MOV        AX,0x1
       01a2:9f70 50              PUSH       AX
       01a2:9f71 9a 80 10        CALLF      LINE
                 71 0e
       01a2:9f76 b8 e0 01        MOV        AX,0x1e0
       01a2:9f79 50              PUSH       AX
       01a2:9f7a b8 65 01        MOV        AX,0x165
       01a2:9f7d 50              PUSH       AX
       01a2:9f7e 9a 91 5b        CALLF      GRAPHICS_SETPT1
                 71 0e
       01a2:9f83 b8 f4 01        MOV        AX,0x1f4
       01a2:9f86 50              PUSH       AX
       01a2:9f87 b8 72 01        MOV        AX,0x172
       01a2:9f8a 50              PUSH       AX
       01a2:9f8b 9a ab 5b        CALLF      GRAPHICS_SETPT2
                 71 0e
       01a2:9f90 33 c0           XOR        AX,AX
       01a2:9f92 50              PUSH       AX
       01a2:9f93 b8 ff ff        MOV        AX,0xffff
       01a2:9f96 50              PUSH       AX
       01a2:9f97 b8 02 00        MOV        AX,0x2
       01a2:9f9a 50              PUSH       AX
       01a2:9f9b 9a 80 10        CALLF      LINE
                 71 0e
       01a2:9fa0 b8 d6 01        MOV        AX,0x1d6
       01a2:9fa3 50              PUSH       AX
       01a2:9fa4 b8 5e 01        MOV        AX,0x15e
       01a2:9fa7 50              PUSH       AX
       01a2:9fa8 9a 91 5b        CALLF      GRAPHICS_SETPT1
                 71 0e
       01a2:9fad b8 fe 01        MOV        AX,0x1fe
       01a2:9fb0 50              PUSH       AX
       01a2:9fb1 b8 79 01        MOV        AX,0x179
       01a2:9fb4 50              PUSH       AX
       01a2:9fb5 9a ab 5b        CALLF      GRAPHICS_SETPT2
                 71 0e
       01a2:9fba 33 c0           XOR        AX,AX
       01a2:9fbc 50              PUSH       AX
       01a2:9fbd b8 ff ff        MOV        AX,0xffff
       01a2:9fc0 50              PUSH       AX
       01a2:9fc1 b8 01 00        MOV        AX,0x1
       01a2:9fc4 50              PUSH       AX
       01a2:9fc5 9a 80 10        CALLF      LINE
                 71 0e
       01a2:9fca b8 da 01        MOV        AX,0x1da
       01a2:9fcd 50              PUSH       AX
       01a2:9fce b8 6f 01        MOV        AX,0x16f
       01a2:9fd1 50              PUSH       AX
       01a2:9fd2 9a 91 5b        CALLF      GRAPHICS_SETPT1
                 71 0e
       01a2:9fd7 b8 dd 01        MOV        AX,0x1dd
       01a2:9fda 50              PUSH       AX
       01a2:9fdb b8 72 01        MOV        AX,0x172
       01a2:9fde 50              PUSH       AX
       01a2:9fdf 9a ab 5b        CALLF      GRAPHICS_SETPT2
                 71 0e
       01a2:9fe4 b8 0a 00        MOV        AX,0xa
       01a2:9fe7 50              PUSH       AX
       01a2:9fe8 b8 ff ff        MOV        AX,0xffff
       01a2:9feb 50              PUSH       AX
       01a2:9fec b8 02 00        MOV        AX,0x2
       01a2:9fef 50              PUSH       AX
       01a2:9ff0 9a 80 10        CALLF      LINE
                 71 0e
       01a2:9ff5 b8 01 00        MOV        AX,0x1
       01a2:9ff8 50              PUSH       AX
       01a2:9ff9 b8 07 00        MOV        AX,0x7
       01a2:9ffc 50              PUSH       AX
       01a2:9ffd b8 02 00        MOV        AX,0x2
       01a2:a000 50              PUSH       AX
       01a2:a001 9a 86 61        CALLF      COLOR
                 71 0e
       01a2:a006 b8 01 00        MOV        AX,0x1
       01a2:a009 50              PUSH       AX
       01a2:a00a b8 04 00        MOV        AX,0x4
       01a2:a00d 50              PUSH       AX
       01a2:a00e b8 01 00        MOV        AX,0x1
       01a2:a011 50              PUSH       AX
       01a2:a012 b8 17 00        MOV        AX,0x17
       01a2:a015 50              PUSH       AX
       01a2:a016 b8 04 00        MOV        AX,0x4
       01a2:a019 50              PUSH       AX
       01a2:a01a 9a b2 61        CALLF      LOCATE
                 71 0e
       01a2:a01f b8 20 b7        MOV        AX,0xb720
       01a2:a022 50              PUSH       AX
       01a2:a023 9a c8 76        CALLF      PRINT_STR_NEWLINE
                 71 0e
       01a2:a028 e8 2c 9c        CALL       FUN_01a2_3c57                                    undefined FUN_01a2_3c57()
       01a2:a02b b8 01 00        MOV        AX,0x1
       01a2:a02e 50              PUSH       AX
       01a2:a02f b8 06 00        MOV        AX,0x6
       01a2:a032 50              PUSH       AX
       01a2:a033 b8 01 00        MOV        AX,0x1
       01a2:a036 50              PUSH       AX
       01a2:a037 b8 17 00        MOV        AX,0x17
       01a2:a03a 50              PUSH       AX
       01a2:a03b b8 04 00        MOV        AX,0x4
       01a2:a03e 50              PUSH       AX
       01a2:a03f 9a b2 61        CALLF      LOCATE
                 71 0e
       01a2:a044 b8 38 b7        MOV        AX,0xb738
       01a2:a047 50              PUSH       AX
       01a2:a048 9a c8 76        CALLF      PRINT_STR_NEWLINE
                 71 0e
       01a2:a04d b8 01 00        MOV        AX,0x1
       01a2:a050 50              PUSH       AX
       01a2:a051 b8 07 00        MOV        AX,0x7
       01a2:a054 50              PUSH       AX
       01a2:a055 b8 01 00        MOV        AX,0x1
       01a2:a058 50              PUSH       AX
       01a2:a059 b8 17 00        MOV        AX,0x17
       01a2:a05c 50              PUSH       AX
       01a2:a05d b8 04 00        MOV        AX,0x4
       01a2:a060 50              PUSH       AX
       01a2:a061 9a b2 61        CALLF      LOCATE
                 71 0e
       01a2:a066 b8 48 b7        MOV        AX,0xb748
       01a2:a069 50              PUSH       AX
       01a2:a06a 9a c8 76        CALLF      PRINT_STR_NEWLINE
                 71 0e
       01a2:a06f b8 01 00        MOV        AX,0x1
       01a2:a072 50              PUSH       AX
       01a2:a073 b8 09 00        MOV        AX,0x9
       01a2:a076 50              PUSH       AX
       01a2:a077 b8 01 00        MOV        AX,0x1
       01a2:a07a 50              PUSH       AX
       01a2:a07b b8 17 00        MOV        AX,0x17
       01a2:a07e 50              PUSH       AX
       01a2:a07f b8 04 00        MOV        AX,0x4
       01a2:a082 50              PUSH       AX
       01a2:a083 9a b2 61        CALLF      LOCATE
                 71 0e
       01a2:a088 b8 40 01        MOV        AX,0x140
       01a2:a08b 50              PUSH       AX
       01a2:a08c b8 f0 00        MOV        AX,0xf0
       01a2:a08f 50              PUSH       AX
       01a2:a090 9a 91 5b        CALLF      GRAPHICS_SETPT1
                 71 0e
       01a2:a095 ff 36 16 b7     PUSH       word ptr [0xb716]
       01a2:a099 ff 36 14 b7     PUSH       word ptr [0xb714]
       01a2:a09d b8 0f 00        MOV        AX,0xf
       01a2:a0a0 50              PUSH       AX
       01a2:a0a1 9a b4 0d        CALLF      CIRCLE
                 71 0e
       01a2:a0a6 b8 40 01        MOV        AX,0x140
       01a2:a0a9 50              PUSH       AX
       01a2:a0aa b8 f0 00        MOV        AX,0xf0
       01a2:a0ad 50              PUSH       AX
       01a2:a0ae 9a 91 5b        CALLF      GRAPHICS_SETPT1
                 71 0e
       01a2:a0b3 ff 36 1a b7     PUSH       word ptr [0xb71a]
       01a2:a0b7 ff 36 18 b7     PUSH       word ptr [0xb718]
       01a2:a0bb b8 0f 00        MOV        AX,0xf
       01a2:a0be 50              PUSH       AX
       01a2:a0bf 9a b4 0d        CALLF      CIRCLE
                 71 0e
       01a2:a0c4 b8 40 06        MOV        AX,0x640
       01a2:a0c7 50              PUSH       AX
       01a2:a0c8 ff 36 52 a5     PUSH       word ptr [0xa552]
       01a2:a0cc ff 36 50 a5     PUSH       word ptr { 1.0 }
       01a2:a0d0 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:a0d5 e8 7f 9b        CALL       FUN_01a2_3c57                                    undefined FUN_01a2_3c57()
       01a2:a0d8 b8 40 01        MOV        AX,0x140
       01a2:a0db 50              PUSH       AX
       01a2:a0dc b8 f0 00        MOV        AX,0xf0
       01a2:a0df 50              PUSH       AX
       01a2:a0e0 9a 91 5b        CALLF      GRAPHICS_SETPT1
                 71 0e
       01a2:a0e5 ff 36 76 af     PUSH       word ptr [0xaf76]
       01a2:a0e9 ff 36 74 af     PUSH       word ptr { 120.0 }
       01a2:a0ed b8 0f 00        MOV        AX,0xf
       01a2:a0f0 50              PUSH       AX
       01a2:a0f1 9a b4 0d        CALLF      CIRCLE
                 71 0e
       01a2:a0f6 b8 58 b7        MOV        AX,0xb758
       01a2:a0f9 50              PUSH       AX
       01a2:a0fa 9a c8 76        CALLF      PRINT_STR_NEWLINE
                 71 0e
       01a2:a0ff b8 01 00        MOV        AX,0x1
       01a2:a102 50              PUSH       AX
       01a2:a103 b8 0b 00        MOV        AX,0xb
       01a2:a106 50              PUSH       AX
       01a2:a107 b8 01 00        MOV        AX,0x1
       01a2:a10a 50              PUSH       AX
       01a2:a10b b8 17 00        MOV        AX,0x17
       01a2:a10e 50              PUSH       AX
       01a2:a10f b8 04 00        MOV        AX,0x4
       01a2:a112 50              PUSH       AX
       01a2:a113 9a b2 61        CALLF      LOCATE
                 71 0e
       01a2:a118 b8 40 01        MOV        AX,0x140
       01a2:a11b 50              PUSH       AX
       01a2:a11c b8 f0 00        MOV        AX,0xf0
       01a2:a11f 50              PUSH       AX
       01a2:a120 9a 91 5b        CALLF      GRAPHICS_SETPT1
                 71 0e
       01a2:a125 ff 36 1e b7     PUSH       word ptr [0xb71e]
       01a2:a129 ff 36 1c b7     PUSH       word ptr [0xb71c]
       01a2:a12d b8 0f 00        MOV        AX,0xf
       01a2:a130 50              PUSH       AX
       01a2:a131 9a b4 0d        CALLF      CIRCLE
                 71 0e
       01a2:a136 b8 40 06        MOV        AX,0x640
       01a2:a139 50              PUSH       AX
       01a2:a13a ff 36 52 a5     PUSH       word ptr [0xa552]
       01a2:a13e ff 36 50 a5     PUSH       word ptr { 1.0 }
       01a2:a142 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:a147 e8 0d 9b        CALL       FUN_01a2_3c57                                    undefined FUN_01a2_3c57()
       01a2:a14a b8 40 01        MOV        AX,0x140
       01a2:a14d 50              PUSH       AX
       01a2:a14e b8 f0 00        MOV        AX,0xf0
       01a2:a151 50              PUSH       AX
       01a2:a152 9a 91 5b        CALLF      GRAPHICS_SETPT1
                 71 0e
       01a2:a157 ff 36 b2 a6     PUSH       word ptr [0xa6b2]
       01a2:a15b ff 36 b0 a6     PUSH       word ptr [0xa6b0]
       01a2:a15f b8 0f 00        MOV        AX,0xf
       01a2:a162 50              PUSH       AX
       01a2:a163 9a b4 0d        CALLF      CIRCLE
                 71 0e
       01a2:a168 b8 72 b7        MOV        AX,0xb772
       01a2:a16b 50              PUSH       AX
       01a2:a16c 9a c8 76        CALLF      PRINT_STR_NEWLINE
                 71 0e
       01a2:a171 b8 01 00        MOV        AX,0x1
       01a2:a174 50              PUSH       AX
       01a2:a175 b8 0d 00        MOV        AX,0xd
       01a2:a178 50              PUSH       AX
       01a2:a179 b8 01 00        MOV        AX,0x1
       01a2:a17c 50              PUSH       AX
       01a2:a17d b8 17 00        MOV        AX,0x17
       01a2:a180 50              PUSH       AX
       01a2:a181 b8 04 00        MOV        AX,0x4
       01a2:a184 50              PUSH       AX
       01a2:a185 9a b2 61        CALLF      LOCATE
                 71 0e
       01a2:a18a b8 40 01        MOV        AX,0x140
       01a2:a18d 50              PUSH       AX
       01a2:a18e b8 f0 00        MOV        AX,0xf0
       01a2:a191 50              PUSH       AX
       01a2:a192 9a 91 5b        CALLF      GRAPHICS_SETPT1
                 71 0e
       01a2:a197 ff 36 fc b3     PUSH       word ptr [0xb3fc]
       01a2:a19b ff 36 fa b3     PUSH       word ptr [0xb3fa]
       01a2:a19f b8 0f 00        MOV        AX,0xf
       01a2:a1a2 50              PUSH       AX
       01a2:a1a3 9a b4 0d        CALLF      CIRCLE
                 71 0e
       01a2:a1a8 b8 40 06        MOV        AX,0x640
       01a2:a1ab 50              PUSH       AX
       01a2:a1ac ff 36 52 a5     PUSH       word ptr [0xa552]
       01a2:a1b0 ff 36 50 a5     PUSH       word ptr { 1.0 }
       01a2:a1b4 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:a1b9 e8 9b 9a        CALL       FUN_01a2_3c57                                    undefined FUN_01a2_3c57()
       01a2:a1bc b8 40 01        MOV        AX,0x140
       01a2:a1bf 50              PUSH       AX
       01a2:a1c0 b8 14 00        MOV        AX,0x14
       01a2:a1c3 50              PUSH       AX
       01a2:a1c4 9a 91 5b        CALLF      GRAPHICS_SETPT1
                 71 0e
       01a2:a1c9 b8 40 01        MOV        AX,0x140
       01a2:a1cc 50              PUSH       AX
       01a2:a1cd b8 cc 01        MOV        AX,0x1cc
       01a2:a1d0 50              PUSH       AX
       01a2:a1d1 9a ab 5b        CALLF      GRAPHICS_SETPT2
                 71 0e
       01a2:a1d6 b8 0f 00        MOV        AX,0xf
       01a2:a1d9 50              PUSH       AX
       01a2:a1da b8 ff ff        MOV        AX,0xffff
       01a2:a1dd 50              PUSH       AX
       01a2:a1de 33 c0           XOR        AX,AX
       01a2:a1e0 50              PUSH       AX
       01a2:a1e1 9a 80 10        CALLF      LINE
                 71 0e
       01a2:a1e6 b8 64 00        MOV        AX,0x64
       01a2:a1e9 50              PUSH       AX
       01a2:a1ea b8 f0 00        MOV        AX,0xf0
       01a2:a1ed 50              PUSH       AX
       01a2:a1ee 9a 91 5b        CALLF      GRAPHICS_SETPT1
                 71 0e
       01a2:a1f3 b8 1c 02        MOV        AX,0x21c
       01a2:a1f6 50              PUSH       AX
       01a2:a1f7 b8 f0 00        MOV        AX,0xf0
       01a2:a1fa 50              PUSH       AX
       01a2:a1fb 9a ab 5b        CALLF      GRAPHICS_SETPT2
                 71 0e
       01a2:a200 b8 0f 00        MOV        AX,0xf
       01a2:a203 50              PUSH       AX
       01a2:a204 b8 ff ff        MOV        AX,0xffff
       01a2:a207 50              PUSH       AX
       01a2:a208 33 c0           XOR        AX,AX
       01a2:a20a 50              PUSH       AX
       01a2:a20b 9a 80 10        CALLF      LINE
                 71 0e
       01a2:a210 b8 40 06        MOV        AX,0x640
       01a2:a213 50              PUSH       AX
       01a2:a214 ff 36 52 a5     PUSH       word ptr [0xa552]
       01a2:a218 ff 36 50 a5     PUSH       word ptr { 1.0 }
       01a2:a21c 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:a221 e8 33 9a        CALL       FUN_01a2_3c57                                    undefined FUN_01a2_3c57()
       01a2:a224 90              NOP
       01a2:a225 d9 06 50 a5     FLD        float ptr { 1.0 }
       01a2:a229 e9 53 00        JMP        LAB_01a2_a27f
                             LAB_01a2_a22c                                   XREF[1]:     01a2:a297(j)  
       01a2:a22c b8 8a b7        MOV        AX,0xb78a
       01a2:a22f 50              PUSH       AX
       01a2:a230 9a c3 76        CALLF      PRINT_STR_SEMICOLON
                 71 0e
       01a2:a235 90              NOP
       01a2:a236 d9 06 7c a6     FLD        float ptr [0xa67c]
       01a2:a23a 90              NOP
       01a2:a23b d9 1e be a4     FSTP       float ptr [0xa4be]
       01a2:a23f 90              NOP
       01a2:a240 9b              WAIT
       01a2:a241 e8 a3 f8        CALL       FUN_01a2_9ae7                                    undefined FUN_01a2_9ae7()
       01a2:a244 b8 b0 04        MOV        AX,0x4b0
       01a2:a247 50              PUSH       AX
       01a2:a248 ff 36 52 a5     PUSH       word ptr [0xa552]
       01a2:a24c ff 36 50 a5     PUSH       word ptr { 1.0 }
       01a2:a250 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:a255 90              NOP
       01a2:a256 d9 06 5a b4     FLD        float ptr [0xb45a]
       01a2:a25a 90              NOP
       01a2:a25b d9 1e be a4     FSTP       float ptr [0xa4be]
       01a2:a25f 90              NOP
       01a2:a260 9b              WAIT
       01a2:a261 e8 83 f8        CALL       FUN_01a2_9ae7                                    undefined FUN_01a2_9ae7()
       01a2:a264 b8 20 03        MOV        AX,0x320
       01a2:a267 50              PUSH       AX
       01a2:a268 ff 36 52 a5     PUSH       word ptr [0xa552]
       01a2:a26c ff 36 50 a5     PUSH       word ptr { 1.0 }
       01a2:a270 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:a275 90              NOP
       01a2:a276 d9 06 96 a4     FLD        float ptr [0xa496]
       01a2:a27a 90              NOP
       01a2:a27b d8 06 50 a5     FADD       float ptr { 1.0 }
                             LAB_01a2_a27f                                   XREF[1]:     01a2:a229(j)  
       01a2:a27f 90              NOP
       01a2:a280 d9 1e 96 a4     FSTP       float ptr [0xa496]
       01a2:a284 90              NOP
       01a2:a285 9b              WAIT
       01a2:a286 90              NOP
       01a2:a287 d9 06 7c af     FLD        float ptr { 5.0 }
       01a2:a28b 90              NOP
       01a2:a28c d9 06 96 a4     FLD        float ptr [0xa496]
       01a2:a290 90              NOP
       01a2:a291 9b              WAIT
       01a2:a292 9a 1d 04        CALLF      FPCOMPARE_2stack                                 undefined FPCOMPARE_2stack()
                 75 0d
       01a2:a297 76 93           JBE        LAB_01a2_a22c
       01a2:a299 b8 92 b7        MOV        AX,0xb792
       01a2:a29c 50              PUSH       AX
       01a2:a29d 9a c8 76        CALLF      PRINT_STR_NEWLINE
                 71 0e
       01a2:a2a2 e8 42 f8        CALL       FUN_01a2_9ae7                                    undefined FUN_01a2_9ae7()
       01a2:a2a5 90              NOP
       01a2:a2a6 d9 06 a0 b7     FLD        float ptr [0xb7a0]
       01a2:a2aa e9 23 00        JMP        LAB_01a2_a2d0
       01a2:a2ad 90              ??         90h
                             LAB_01a2_a2ae                                   XREF[1]:     01a2:a2e8(j)  
       01a2:a2ae 90              NOP
       01a2:a2af d9 06 96 a4     FLD        float ptr [0xa496]
       01a2:a2b3 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:a2b8 50              PUSH       AX
       01a2:a2b9 ff 36 52 a5     PUSH       word ptr [0xa552]
       01a2:a2bd ff 36 50 a5     PUSH       word ptr { 1.0 }
       01a2:a2c1 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:a2c6 90              NOP
       01a2:a2c7 d9 06 96 a4     FLD        float ptr [0xa496]
       01a2:a2cb 90              NOP
       01a2:a2cc d8 06 d2 b4     FADD       float ptr [0xb4d2]
                             LAB_01a2_a2d0                                   XREF[1]:     01a2:a2aa(j)  
       01a2:a2d0 90              NOP
       01a2:a2d1 d9 1e 96 a4     FSTP       float ptr [0xa496]
       01a2:a2d5 90              NOP
       01a2:a2d6 9b              WAIT
       01a2:a2d7 90              NOP
       01a2:a2d8 d9 06 7a b4     FLD        float ptr [0xb47a]
       01a2:a2dc 90              NOP
       01a2:a2dd d9 06 96 a4     FLD        float ptr [0xa496]
       01a2:a2e1 90              NOP
       01a2:a2e2 9b              WAIT
       01a2:a2e3 9a 1d 04        CALLF      FPCOMPARE_2stack                                 undefined FPCOMPARE_2stack()
                 75 0d
       01a2:a2e8 73 c4           JNC        LAB_01a2_a2ae
       01a2:a2ea b8 01 00        MOV        AX,0x1
       01a2:a2ed 50              PUSH       AX
       01a2:a2ee b8 0c 00        MOV        AX,0xc
       01a2:a2f1 50              PUSH       AX
       01a2:a2f2 b8 02 00        MOV        AX,0x2
       01a2:a2f5 50              PUSH       AX
       01a2:a2f6 9a 46 66        CALLF      SCREEN
                 71 0e
       01a2:a2fb 33 c0           XOR        AX,AX
       01a2:a2fd 50              PUSH       AX
       01a2:a2fe 50              PUSH       AX
       01a2:a2ff 9a 91 5b        CALLF      GRAPHICS_SETPT1
                 71 0e
       01a2:a304 b8 80 02        MOV        AX,0x280
       01a2:a307 50              PUSH       AX
       01a2:a308 b8 e0 01        MOV        AX,0x1e0
       01a2:a30b 50              PUSH       AX
       01a2:a30c 9a ab 5b        CALLF      GRAPHICS_SETPT2
                 71 0e
       01a2:a311 b8 07 00        MOV        AX,0x7
       01a2:a314 50              PUSH       AX
       01a2:a315 b8 ff ff        MOV        AX,0xffff
       01a2:a318 50              PUSH       AX
       01a2:a319 b8 02 00        MOV        AX,0x2
       01a2:a31c 50              PUSH       AX
       01a2:a31d 9a 80 10        CALLF      LINE
                 71 0e
       01a2:a322 b8 01 00        MOV        AX,0x1
       01a2:a325 50              PUSH       AX
       01a2:a326 b8 0c 00        MOV        AX,0xc
       01a2:a329 50              PUSH       AX
       01a2:a32a b8 02 00        MOV        AX,0x2
       01a2:a32d 50              PUSH       AX
       01a2:a32e 9a 46 66        CALLF      SCREEN
                 71 0e
       01a2:a333 b8 64 00        MOV        AX,0x64
       01a2:a336 50              PUSH       AX
       01a2:a337 ff 36 76 a6     PUSH       word ptr [0xa676]
       01a2:a33b ff 36 74 a6     PUSH       word ptr { 4.0 }
       01a2:a33f 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:a344 b8 01 00        MOV        AX,0x1
       01a2:a347 50              PUSH       AX
       01a2:a348 b8 0c 00        MOV        AX,0xc
       01a2:a34b 50              PUSH       AX
       01a2:a34c b8 02 00        MOV        AX,0x2
       01a2:a34f 50              PUSH       AX
       01a2:a350 9a 46 66        CALLF      SCREEN
                 71 0e
       01a2:a355 33 c0           XOR        AX,AX
       01a2:a357 50              PUSH       AX
       01a2:a358 50              PUSH       AX
       01a2:a359 9a 91 5b        CALLF      GRAPHICS_SETPT1
                 71 0e
       01a2:a35e b8 80 02        MOV        AX,0x280
       01a2:a361 50              PUSH       AX
       01a2:a362 b8 e0 01        MOV        AX,0x1e0
       01a2:a365 50              PUSH       AX
       01a2:a366 9a ab 5b        CALLF      GRAPHICS_SETPT2
                 71 0e
       01a2:a36b b8 0e 00        MOV        AX,0xe
       01a2:a36e 50              PUSH       AX
       01a2:a36f b8 ff ff        MOV        AX,0xffff
       01a2:a372 50              PUSH       AX
       01a2:a373 b8 02 00        MOV        AX,0x2
       01a2:a376 50              PUSH       AX
       01a2:a377 9a 80 10        CALLF      LINE
                 71 0e
       01a2:a37c b8 01 00        MOV        AX,0x1
       01a2:a37f 50              PUSH       AX
       01a2:a380 b8 0c 00        MOV        AX,0xc
       01a2:a383 50              PUSH       AX
       01a2:a384 b8 02 00        MOV        AX,0x2
       01a2:a387 50              PUSH       AX
       01a2:a388 9a 46 66        CALLF      SCREEN
                 71 0e
       01a2:a38d b8 c8 00        MOV        AX,0xc8
       01a2:a390 50              PUSH       AX
       01a2:a391 ff 36 26 a6     PUSH       word ptr [0xa626]
       01a2:a395 ff 36 24 a6     PUSH       word ptr { 3.0 }
       01a2:a399 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:a39e b8 01 00        MOV        AX,0x1
       01a2:a3a1 50              PUSH       AX
       01a2:a3a2 b8 0c 00        MOV        AX,0xc
       01a2:a3a5 50              PUSH       AX
       01a2:a3a6 b8 02 00        MOV        AX,0x2
       01a2:a3a9 50              PUSH       AX
       01a2:a3aa 9a 46 66        CALLF      SCREEN
                 71 0e
       01a2:a3af 33 c0           XOR        AX,AX
       01a2:a3b1 50              PUSH       AX
       01a2:a3b2 50              PUSH       AX
       01a2:a3b3 9a 91 5b        CALLF      GRAPHICS_SETPT1
                 71 0e
       01a2:a3b8 b8 80 02        MOV        AX,0x280
       01a2:a3bb 50              PUSH       AX
       01a2:a3bc b8 e0 01        MOV        AX,0x1e0
       01a2:a3bf 50              PUSH       AX
       01a2:a3c0 9a ab 5b        CALLF      GRAPHICS_SETPT2
                 71 0e
       01a2:a3c5 b8 01 00        MOV        AX,0x1
       01a2:a3c8 50              PUSH       AX
       01a2:a3c9 b8 ff ff        MOV        AX,0xffff
       01a2:a3cc 50              PUSH       AX
       01a2:a3cd b8 02 00        MOV        AX,0x2
       01a2:a3d0 50              PUSH       AX
       01a2:a3d1 9a 80 10        CALLF      LINE
                 71 0e
       01a2:a3d6 b8 01 00        MOV        AX,0x1
       01a2:a3d9 50              PUSH       AX
       01a2:a3da b8 0c 00        MOV        AX,0xc
       01a2:a3dd 50              PUSH       AX
       01a2:a3de b8 02 00        MOV        AX,0x2
       01a2:a3e1 50              PUSH       AX
       01a2:a3e2 9a 46 66        CALLF      SCREEN
                 71 0e
       01a2:a3e7 b8 f4 01        MOV        AX,0x1f4
       01a2:a3ea 50              PUSH       AX
       01a2:a3eb ff 36 26 a6     PUSH       word ptr [0xa626]
       01a2:a3ef ff 36 24 a6     PUSH       word ptr { 3.0 }
       01a2:a3f3 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:a3f8 b8 01 00        MOV        AX,0x1
       01a2:a3fb 50              PUSH       AX
       01a2:a3fc b8 0c 00        MOV        AX,0xc
       01a2:a3ff 50              PUSH       AX
       01a2:a400 b8 02 00        MOV        AX,0x2
       01a2:a403 50              PUSH       AX
       01a2:a404 9a 46 66        CALLF      SCREEN
                 71 0e
       01a2:a409 33 c0           XOR        AX,AX
       01a2:a40b 50              PUSH       AX
       01a2:a40c 50              PUSH       AX
       01a2:a40d 9a 91 5b        CALLF      GRAPHICS_SETPT1
                 71 0e
       01a2:a412 b8 80 02        MOV        AX,0x280
       01a2:a415 50              PUSH       AX
       01a2:a416 b8 e0 01        MOV        AX,0x1e0
       01a2:a419 50              PUSH       AX
       01a2:a41a 9a ab 5b        CALLF      GRAPHICS_SETPT2
                 71 0e
       01a2:a41f b8 0f 00        MOV        AX,0xf
       01a2:a422 50              PUSH       AX
       01a2:a423 b8 ff ff        MOV        AX,0xffff
       01a2:a426 50              PUSH       AX
       01a2:a427 b8 02 00        MOV        AX,0x2
       01a2:a42a 50              PUSH       AX
       01a2:a42b 9a 80 10        CALLF      LINE
                 71 0e
       01a2:a430 b8 01 00        MOV        AX,0x1
       01a2:a433 50              PUSH       AX
       01a2:a434 b8 0c 00        MOV        AX,0xc
       01a2:a437 50              PUSH       AX
       01a2:a438 b8 02 00        MOV        AX,0x2
       01a2:a43b 50              PUSH       AX
       01a2:a43c 9a 46 66        CALLF      SCREEN
                 71 0e
       01a2:a441 b8 2c 01        MOV        AX,0x12c
       01a2:a444 50              PUSH       AX
       01a2:a445 ff 36 7e af     PUSH       word ptr [0xaf7e]
       01a2:a449 ff 36 7c af     PUSH       word ptr { 5.0 }
       01a2:a44d 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:a452 b8 01 00        MOV        AX,0x1
       01a2:a455 50              PUSH       AX
       01a2:a456 b8 0c 00        MOV        AX,0xc
       01a2:a459 50              PUSH       AX
       01a2:a45a b8 02 00        MOV        AX,0x2
       01a2:a45d 50              PUSH       AX
       01a2:a45e 9a 46 66        CALLF      SCREEN
                 71 0e
       01a2:a463 33 c0           XOR        AX,AX
       01a2:a465 50              PUSH       AX
       01a2:a466 50              PUSH       AX
       01a2:a467 9a 91 5b        CALLF      GRAPHICS_SETPT1
                 71 0e
       01a2:a46c b8 80 02        MOV        AX,0x280
       01a2:a46f 50              PUSH       AX
       01a2:a470 b8 e0 01        MOV        AX,0x1e0
       01a2:a473 50              PUSH       AX
       01a2:a474 9a ab 5b        CALLF      GRAPHICS_SETPT2
                 71 0e
       01a2:a479 b8 07 00        MOV        AX,0x7
       01a2:a47c 50              PUSH       AX
       01a2:a47d b8 ff ff        MOV        AX,0xffff
       01a2:a480 50              PUSH       AX
       01a2:a481 b8 02 00        MOV        AX,0x2
       01a2:a484 50              PUSH       AX
       01a2:a485 9a 80 10        CALLF      LINE
                 71 0e
       01a2:a48a b8 01 00        MOV        AX,0x1
       01a2:a48d 50              PUSH       AX
       01a2:a48e b8 0c 00        MOV        AX,0xc
       01a2:a491 50              PUSH       AX
       01a2:a492 b8 02 00        MOV        AX,0x2
       01a2:a495 50              PUSH       AX
       01a2:a496 9a 46 66        CALLF      SCREEN
                 71 0e
       01a2:a49b 33 c0           XOR        AX,AX
       01a2:a49d 50              PUSH       AX
       01a2:a49e 50              PUSH       AX
       01a2:a49f 9a 91 5b        CALLF      GRAPHICS_SETPT1
                 71 0e
       01a2:a4a4 b8 80 02        MOV        AX,0x280
       01a2:a4a7 50              PUSH       AX
       01a2:a4a8 b8 e0 01        MOV        AX,0x1e0
       01a2:a4ab 50              PUSH       AX
       01a2:a4ac 9a ab 5b        CALLF      GRAPHICS_SETPT2
                 71 0e
       01a2:a4b1 33 c0           XOR        AX,AX
       01a2:a4b3 50              PUSH       AX
       01a2:a4b4 b8 ff ff        MOV        AX,0xffff
       01a2:a4b7 50              PUSH       AX
       01a2:a4b8 b8 02 00        MOV        AX,0x2
       01a2:a4bb 50              PUSH       AX
       01a2:a4bc 9a 80 10        CALLF      LINE
                 71 0e
       01a2:a4c1 e8 93 97        CALL       FUN_01a2_3c57                                    undefined FUN_01a2_3c57()
       01a2:a4c4 e8 90 97        CALL       FUN_01a2_3c57                                    undefined FUN_01a2_3c57()
       01a2:a4c7 e8 8d 97        CALL       FUN_01a2_3c57                                    undefined FUN_01a2_3c57()
       01a2:a4ca b8 01 00        MOV        AX,0x1
       01a2:a4cd 50              PUSH       AX
       01a2:a4ce b8 05 00        MOV        AX,0x5
       01a2:a4d1 50              PUSH       AX
       01a2:a4d2 b8 01 00        MOV        AX,0x1
       01a2:a4d5 50              PUSH       AX
       01a2:a4d6 b8 20 00        MOV        AX,0x20
       01a2:a4d9 50              PUSH       AX
       01a2:a4da b8 04 00        MOV        AX,0x4
       01a2:a4dd 50              PUSH       AX
       01a2:a4de 9a b2 61        CALLF      LOCATE
                 71 0e
       01a2:a4e3 b8 a4 b7        MOV        AX,0xb7a4
       01a2:a4e6 50              PUSH       AX
       01a2:a4e7 9a c8 76        CALLF      PRINT_STR_NEWLINE
                 71 0e
       01a2:a4ec e8 68 97        CALL       FUN_01a2_3c57                                    undefined FUN_01a2_3c57()
       01a2:a4ef e8 65 97        CALL       FUN_01a2_3c57                                    undefined FUN_01a2_3c57()
       01a2:a4f2 e8 62 97        CALL       FUN_01a2_3c57                                    undefined FUN_01a2_3c57()
       01a2:a4f5 e8 5f 97        CALL       FUN_01a2_3c57                                    undefined FUN_01a2_3c57()
       01a2:a4f8 b8 01 00        MOV        AX,0x1
       01a2:a4fb 50              PUSH       AX
       01a2:a4fc b8 0d 00        MOV        AX,0xd
       01a2:a4ff 50              PUSH       AX
       01a2:a500 b8 01 00        MOV        AX,0x1
       01a2:a503 50              PUSH       AX
       01a2:a504 b8 16 00        MOV        AX,0x16
       01a2:a507 50              PUSH       AX
       01a2:a508 b8 04 00        MOV        AX,0x4
       01a2:a50b 50              PUSH       AX
       01a2:a50c 9a b2 61        CALLF      LOCATE
                 71 0e
       01a2:a511 b8 ba b7        MOV        AX,0xb7ba
       01a2:a514 50              PUSH       AX
       01a2:a515 9a c8 76        CALLF      PRINT_STR_NEWLINE
                 71 0e
       01a2:a51a e8 3a 97        CALL       FUN_01a2_3c57                                    undefined FUN_01a2_3c57()
       01a2:a51d e8 37 97        CALL       FUN_01a2_3c57                                    undefined FUN_01a2_3c57()
       01a2:a520 e8 34 97        CALL       FUN_01a2_3c57                                    undefined FUN_01a2_3c57()
       01a2:a523 e8 31 97        CALL       FUN_01a2_3c57                                    undefined FUN_01a2_3c57()
       01a2:a526 b8 01 00        MOV        AX,0x1
       01a2:a529 50              PUSH       AX
       01a2:a52a b8 13 00        MOV        AX,0x13
       01a2:a52d 50              PUSH       AX
       01a2:a52e b8 01 00        MOV        AX,0x1
       01a2:a531 50              PUSH       AX
       01a2:a532 b8 1d 00        MOV        AX,0x1d
       01a2:a535 50              PUSH       AX
       01a2:a536 b8 04 00        MOV        AX,0x4
       01a2:a539 50              PUSH       AX
       01a2:a53a 9a b2 61        CALLF      LOCATE
                 71 0e
       01a2:a53f b8 e2 b7        MOV        AX,0xb7e2
       01a2:a542 50              PUSH       AX
       01a2:a543 9a c8 76        CALLF      PRINT_STR_NEWLINE
                 71 0e
       01a2:a548 90              NOP
       01a2:a549 d9 06 50 a5     FLD        float ptr { 1.0 }
       01a2:a54d e9 0d 00        JMP        LAB_01a2_a55d
                             LAB_01a2_a550                                   XREF[1]:     01a2:a575(j)  
       01a2:a550 e8 04 97        CALL       FUN_01a2_3c57                                    undefined FUN_01a2_3c57()
       01a2:a553 90              NOP
       01a2:a554 d9 06 96 a4     FLD        float ptr [0xa496]
       01a2:a558 90              NOP
       01a2:a559 d8 06 50 a5     FADD       float ptr { 1.0 }
                             LAB_01a2_a55d                                   XREF[1]:     01a2:a54d(j)  
       01a2:a55d 90              NOP
       01a2:a55e d9 1e 96 a4     FSTP       float ptr [0xa496]
       01a2:a562 90              NOP
       01a2:a563 9b              WAIT
       01a2:a564 90              NOP
       01a2:a565 d9 06 80 af     FLD        float ptr { 6.0 }
       01a2:a569 90              NOP
       01a2:a56a d9 06 96 a4     FLD        float ptr [0xa496]
       01a2:a56e 90              NOP
       01a2:a56f 9b              WAIT
       01a2:a570 9a 1d 04        CALLF      FPCOMPARE_2stack                                 undefined FPCOMPARE_2stack()
                 75 0d
       01a2:a575 76 d9           JBE        LAB_01a2_a550
       01a2:a577 90              NOP
       01a2:a578 d9 06 0c a6     FLD        float ptr [0xa60c]
       01a2:a57c 90              NOP
       01a2:a57d d9 1e d2 a4     FSTP       float ptr [0xa4d2]
       01a2:a581 90              NOP
       01a2:a582 9b              WAIT
       01a2:a583 90              NOP
       01a2:a584 d9 06 50 a5     FLD        float ptr { 1.0 }
       01a2:a588 90              NOP
       01a2:a589 d9 1e 52 a4     FSTP       float ptr [0xa452]
       01a2:a58d 90              NOP
       01a2:a58e 9b              WAIT
                             LAB_01a2_a58f                                   XREF[1]:     FUN_01a2_19fa:01a2:1edb(j)  
       01a2:a58f 90              NOP
       01a2:a590 d9 06 a0 b7     FLD        float ptr [0xb7a0]
       01a2:a594 90              NOP
       01a2:a595 d9 06 56 a4     FLD        float ptr [0xa456]
       01a2:a599 90              NOP
       01a2:a59a 9b              WAIT
       01a2:a59b 9a 1d 04        CALLF      FPCOMPARE_2stack                                 undefined FPCOMPARE_2stack()
                 75 0d
       01a2:a5a0 77 03           JA         LAB_01a2_a5a5
       01a2:a5a2 e9 03 00        JMP        LAB_01a2_a5a8
                             LAB_01a2_a5a5                                   XREF[1]:     01a2:a5a0(j)  
       01a2:a5a5 e8 c8 eb        CALL       FUN_01a2_9170                                    undefined FUN_01a2_9170()
                             LAB_01a2_a5a8                                   XREF[1]:     01a2:a5a2(j)  
       01a2:a5a8 90              NOP
       01a2:a5a9 d9 06 a0 b7     FLD        float ptr [0xb7a0]
       01a2:a5ad 90              NOP
       01a2:a5ae d9 06 56 a4     FLD        float ptr [0xa456]
       01a2:a5b2 90              NOP
       01a2:a5b3 9b              WAIT
       01a2:a5b4 9a 1d 04        CALLF      FPCOMPARE_2stack                                 undefined FPCOMPARE_2stack()
                 75 0d
       01a2:a5b9 77 03           JA         LAB_01a2_a5be
       01a2:a5bb e9 0c 00        JMP        LAB_01a2_a5ca
                             LAB_01a2_a5be                                   XREF[1]:     01a2:a5b9(j)  
       01a2:a5be 90              NOP
       01a2:a5bf d9 06 50 a5     FLD        float ptr { 1.0 }
       01a2:a5c3 90              NOP
       01a2:a5c4 d9 1e 4e a4     FSTP       float ptr [0xa44e]
       01a2:a5c8 90              NOP
       01a2:a5c9 9b              WAIT
                             LAB_01a2_a5ca                                   XREF[1]:     01a2:a5bb(j)  
       01a2:a5ca 90              NOP
       01a2:a5cb d9 06 a0 b7     FLD        float ptr [0xb7a0]
       01a2:a5cf 90              NOP
       01a2:a5d0 d9 06 56 a4     FLD        float ptr [0xa456]
       01a2:a5d4 90              NOP
       01a2:a5d5 9b              WAIT
       01a2:a5d6 9a 1d 04        CALLF      FPCOMPARE_2stack                                 undefined FPCOMPARE_2stack()
                 75 0d
       01a2:a5db 76 03           JBE        LAB_01a2_a5e0
       01a2:a5dd e9 c9 05        JMP        LAB_01a2_aba9
                             LAB_01a2_a5e0                                   XREF[1]:     01a2:a5db(j)  
       01a2:a5e0 b8 01 00        MOV        AX,0x1
       01a2:a5e3 50              PUSH       AX
       01a2:a5e4 b8 1b 00        MOV        AX,0x1b
       01a2:a5e7 50              PUSH       AX
       01a2:a5e8 b8 01 00        MOV        AX,0x1
       01a2:a5eb 50              PUSH       AX
       01a2:a5ec 90              NOP
       01a2:a5ed d9 06 80 af     FLD        float ptr { 6.0 }
       01a2:a5f1 90              NOP
       01a2:a5f2 d8 06 d2 a4     FADD       float ptr [0xa4d2]
       01a2:a5f6 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:a5fb 50              PUSH       AX
       01a2:a5fc b8 04 00        MOV        AX,0x4
       01a2:a5ff 50              PUSH       AX
       01a2:a600 9a b2 61        CALLF      LOCATE
                 71 0e
       01a2:a605 b8 01 00        MOV        AX,0x1
       01a2:a608 50              PUSH       AX
       01a2:a609 b8 0a 00        MOV        AX,0xa
       01a2:a60c 50              PUSH       AX
       01a2:a60d b8 02 00        MOV        AX,0x2
       01a2:a610 50              PUSH       AX
       01a2:a611 9a 86 61        CALLF      COLOR
                 71 0e
       01a2:a616 b8 fe b7        MOV        AX,0xb7fe
       01a2:a619 50              PUSH       AX
       01a2:a61a 9a c8 76        CALLF      PRINT_STR_NEWLINE
                 71 0e
       01a2:a61f b8 f4 01        MOV        AX,0x1f4
       01a2:a622 50              PUSH       AX
       01a2:a623 ff 36 76 a6     PUSH       word ptr [0xa676]
       01a2:a627 ff 36 74 a6     PUSH       word ptr { 4.0 }
       01a2:a62b 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:a630 e8 24 96        CALL       FUN_01a2_3c57                                    undefined FUN_01a2_3c57()
       01a2:a633 b8 01 00        MOV        AX,0x1
       01a2:a636 50              PUSH       AX
       01a2:a637 b8 1b 00        MOV        AX,0x1b
       01a2:a63a 50              PUSH       AX
       01a2:a63b b8 01 00        MOV        AX,0x1
       01a2:a63e 50              PUSH       AX
       01a2:a63f 90              NOP
       01a2:a640 d9 06 80 af     FLD        float ptr { 6.0 }
       01a2:a644 90              NOP
       01a2:a645 d8 06 d2 a4     FADD       float ptr [0xa4d2]
       01a2:a649 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:a64e 50              PUSH       AX
       01a2:a64f b8 04 00        MOV        AX,0x4
       01a2:a652 50              PUSH       AX
       01a2:a653 9a b2 61        CALLF      LOCATE
                 71 0e
       01a2:a658 b8 14 b8        MOV        AX,0xb814
       01a2:a65b 50              PUSH       AX
       01a2:a65c 9a c8 76        CALLF      PRINT_STR_NEWLINE
                 71 0e
       01a2:a661 e8 f3 95        CALL       FUN_01a2_3c57                                    undefined FUN_01a2_3c57()
       01a2:a664 b8 01 00        MOV        AX,0x1
       01a2:a667 50              PUSH       AX
       01a2:a668 b8 1b 00        MOV        AX,0x1b
       01a2:a66b 50              PUSH       AX
       01a2:a66c b8 01 00        MOV        AX,0x1
       01a2:a66f 50              PUSH       AX
       01a2:a670 90              NOP
       01a2:a671 d9 06 80 af     FLD        float ptr { 6.0 }
       01a2:a675 90              NOP
       01a2:a676 d8 06 d2 a4     FADD       float ptr [0xa4d2]
       01a2:a67a 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:a67f 50              PUSH       AX
       01a2:a680 b8 04 00        MOV        AX,0x4
       01a2:a683 50              PUSH       AX
       01a2:a684 9a b2 61        CALLF      LOCATE
                 71 0e
       01a2:a689 b8 01 00        MOV        AX,0x1
       01a2:a68c 50              PUSH       AX
       01a2:a68d b8 0d 00        MOV        AX,0xd
       01a2:a690 50              PUSH       AX
       01a2:a691 b8 02 00        MOV        AX,0x2
       01a2:a694 50              PUSH       AX
       01a2:a695 9a 86 61        CALLF      COLOR
                 71 0e
       01a2:a69a b8 2c b8        MOV        AX,0xb82c
       01a2:a69d 50              PUSH       AX
       01a2:a69e 9a c8 76        CALLF      PRINT_STR_NEWLINE
                 71 0e
       01a2:a6a3 b8 f4 01        MOV        AX,0x1f4
       01a2:a6a6 50              PUSH       AX
       01a2:a6a7 ff 36 76 a6     PUSH       word ptr [0xa676]
       01a2:a6ab ff 36 74 a6     PUSH       word ptr { 4.0 }
       01a2:a6af 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:a6b4 e8 a0 95        CALL       FUN_01a2_3c57                                    undefined FUN_01a2_3c57()
       01a2:a6b7 b8 01 00        MOV        AX,0x1
       01a2:a6ba 50              PUSH       AX
       01a2:a6bb b8 1b 00        MOV        AX,0x1b
       01a2:a6be 50              PUSH       AX
       01a2:a6bf b8 01 00        MOV        AX,0x1
       01a2:a6c2 50              PUSH       AX
       01a2:a6c3 90              NOP
       01a2:a6c4 d9 06 80 af     FLD        float ptr { 6.0 }
       01a2:a6c8 90              NOP
       01a2:a6c9 d8 06 d2 a4     FADD       float ptr [0xa4d2]
       01a2:a6cd 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:a6d2 50              PUSH       AX
       01a2:a6d3 b8 04 00        MOV        AX,0x4
       01a2:a6d6 50              PUSH       AX
       01a2:a6d7 9a b2 61        CALLF      LOCATE
                 71 0e
       01a2:a6dc b8 14 b8        MOV        AX,0xb814
       01a2:a6df 50              PUSH       AX
       01a2:a6e0 9a c8 76        CALLF      PRINT_STR_NEWLINE
                 71 0e
       01a2:a6e5 e8 6f 95        CALL       FUN_01a2_3c57                                    undefined FUN_01a2_3c57()
       01a2:a6e8 b8 01 00        MOV        AX,0x1
       01a2:a6eb 50              PUSH       AX
       01a2:a6ec b8 1b 00        MOV        AX,0x1b
       01a2:a6ef 50              PUSH       AX
       01a2:a6f0 b8 01 00        MOV        AX,0x1
       01a2:a6f3 50              PUSH       AX
       01a2:a6f4 90              NOP
       01a2:a6f5 d9 06 80 af     FLD        float ptr { 6.0 }
       01a2:a6f9 90              NOP
       01a2:a6fa d8 06 d2 a4     FADD       float ptr [0xa4d2]
       01a2:a6fe 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:a703 50              PUSH       AX
       01a2:a704 b8 04 00        MOV        AX,0x4
       01a2:a707 50              PUSH       AX
       01a2:a708 9a b2 61        CALLF      LOCATE
                 71 0e
       01a2:a70d b8 01 00        MOV        AX,0x1
       01a2:a710 50              PUSH       AX
       01a2:a711 b8 09 00        MOV        AX,0x9
       01a2:a714 50              PUSH       AX
       01a2:a715 b8 02 00        MOV        AX,0x2
       01a2:a718 50              PUSH       AX
       01a2:a719 9a 86 61        CALLF      COLOR
                 71 0e
       01a2:a71e b8 fe b7        MOV        AX,0xb7fe
       01a2:a721 50              PUSH       AX
       01a2:a722 9a c8 76        CALLF      PRINT_STR_NEWLINE
                 71 0e
       01a2:a727 b8 f4 01        MOV        AX,0x1f4
       01a2:a72a 50              PUSH       AX
       01a2:a72b ff 36 76 a6     PUSH       word ptr [0xa676]
       01a2:a72f ff 36 74 a6     PUSH       word ptr { 4.0 }
       01a2:a733 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:a738 e8 1c 95        CALL       FUN_01a2_3c57                                    undefined FUN_01a2_3c57()
       01a2:a73b b8 01 00        MOV        AX,0x1
       01a2:a73e 50              PUSH       AX
       01a2:a73f b8 1b 00        MOV        AX,0x1b
       01a2:a742 50              PUSH       AX
       01a2:a743 b8 01 00        MOV        AX,0x1
       01a2:a746 50              PUSH       AX
       01a2:a747 90              NOP
       01a2:a748 d9 06 80 af     FLD        float ptr { 6.0 }
       01a2:a74c 90              NOP
       01a2:a74d d8 06 d2 a4     FADD       float ptr [0xa4d2]
       01a2:a751 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:a756 50              PUSH       AX
       01a2:a757 b8 04 00        MOV        AX,0x4
       01a2:a75a 50              PUSH       AX
       01a2:a75b 9a b2 61        CALLF      LOCATE
                 71 0e
       01a2:a760 b8 14 b8        MOV        AX,0xb814
       01a2:a763 50              PUSH       AX
       01a2:a764 9a c8 76        CALLF      PRINT_STR_NEWLINE
                 71 0e
       01a2:a769 e8 eb 94        CALL       FUN_01a2_3c57                                    undefined FUN_01a2_3c57()
       01a2:a76c b8 01 00        MOV        AX,0x1
       01a2:a76f 50              PUSH       AX
       01a2:a770 b8 1b 00        MOV        AX,0x1b
       01a2:a773 50              PUSH       AX
       01a2:a774 b8 01 00        MOV        AX,0x1
       01a2:a777 50              PUSH       AX
       01a2:a778 90              NOP
       01a2:a779 d9 06 80 af     FLD        float ptr { 6.0 }
       01a2:a77d 90              NOP
       01a2:a77e d8 06 d2 a4     FADD       float ptr [0xa4d2]
       01a2:a782 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:a787 50              PUSH       AX
       01a2:a788 b8 04 00        MOV        AX,0x4
       01a2:a78b 50              PUSH       AX
       01a2:a78c 9a b2 61        CALLF      LOCATE
                 71 0e
       01a2:a791 b8 01 00        MOV        AX,0x1
       01a2:a794 50              PUSH       AX
       01a2:a795 b8 0e 00        MOV        AX,0xe
       01a2:a798 50              PUSH       AX
       01a2:a799 b8 02 00        MOV        AX,0x2
       01a2:a79c 50              PUSH       AX
       01a2:a79d 9a 86 61        CALLF      COLOR
                 71 0e
       01a2:a7a2 b8 2c b8        MOV        AX,0xb82c
       01a2:a7a5 50              PUSH       AX
       01a2:a7a6 9a c8 76        CALLF      PRINT_STR_NEWLINE
                 71 0e
       01a2:a7ab b8 f4 01        MOV        AX,0x1f4
       01a2:a7ae 50              PUSH       AX
       01a2:a7af ff 36 76 a6     PUSH       word ptr [0xa676]
       01a2:a7b3 ff 36 74 a6     PUSH       word ptr { 4.0 }
       01a2:a7b7 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:a7bc e8 98 94        CALL       FUN_01a2_3c57                                    undefined FUN_01a2_3c57()
       01a2:a7bf e8 95 94        CALL       FUN_01a2_3c57                                    undefined FUN_01a2_3c57()
       01a2:a7c2 e8 92 94        CALL       FUN_01a2_3c57                                    undefined FUN_01a2_3c57()
       01a2:a7c5 90              NOP
       01a2:a7c6 d9 06 da b3     FLD        float ptr [0xb3da]
       01a2:a7ca 90              NOP
       01a2:a7cb d9 06 56 a4     FLD        float ptr [0xa456]
       01a2:a7cf 90              NOP
       01a2:a7d0 9b              WAIT
       01a2:a7d1 9a 1d 04        CALLF      FPCOMPARE_2stack                                 undefined FPCOMPARE_2stack()
                 75 0d
       01a2:a7d6 72 03           JC         LAB_01a2_a7db
       01a2:a7d8 e9 ce 03        JMP        LAB_01a2_aba9
                             LAB_01a2_a7db                                   XREF[1]:     01a2:a7d6(j)  
       01a2:a7db 90              NOP
       01a2:a7dc d9 06 0c a6     FLD        float ptr [0xa60c]
       01a2:a7e0 90              NOP
       01a2:a7e1 d9 06 d2 a4     FLD        float ptr [0xa4d2]
       01a2:a7e5 90              NOP
       01a2:a7e6 9b              WAIT
       01a2:a7e7 9a 1d 04        CALLF      FPCOMPARE_2stack                                 undefined FPCOMPARE_2stack()
                 75 0d
       01a2:a7ec 75 03           JNZ        LAB_01a2_a7f1
       01a2:a7ee e9 8f 01        JMP        LAB_01a2_a980
                             LAB_01a2_a7f1                                   XREF[1]:     01a2:a7ec(j)  
       01a2:a7f1 90              NOP
       01a2:a7f2 d9 06 4c a6     FLD        float ptr { 0.0 }
       01a2:a7f6 90              NOP
       01a2:a7f7 d9 1e d2 a4     FSTP       float ptr [0xa4d2]
       01a2:a7fb 90              NOP
       01a2:a7fc 9b              WAIT
       01a2:a7fd e8 57 94        CALL       FUN_01a2_3c57                                    undefined FUN_01a2_3c57()
       01a2:a800 b8 01 00        MOV        AX,0x1
       01a2:a803 50              PUSH       AX
       01a2:a804 b8 0a 00        MOV        AX,0xa
       01a2:a807 50              PUSH       AX
       01a2:a808 b8 02 00        MOV        AX,0x2
       01a2:a80b 50              PUSH       AX
       01a2:a80c 9a 86 61        CALLF      COLOR
                 71 0e
       01a2:a811 b8 20 03        MOV        AX,0x320
       01a2:a814 50              PUSH       AX
       01a2:a815 ff 36 52 a5     PUSH       word ptr [0xa552]
       01a2:a819 ff 36 50 a5     PUSH       word ptr { 1.0 }
       01a2:a81d 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:a822 b8 01 00        MOV        AX,0x1
       01a2:a825 50              PUSH       AX
       01a2:a826 b8 1b 00        MOV        AX,0x1b
       01a2:a829 50              PUSH       AX
       01a2:a82a b8 01 00        MOV        AX,0x1
       01a2:a82d 50              PUSH       AX
       01a2:a82e b8 06 00        MOV        AX,0x6
       01a2:a831 50              PUSH       AX
       01a2:a832 b8 04 00        MOV        AX,0x4
       01a2:a835 50              PUSH       AX
       01a2:a836 9a b2 61        CALLF      LOCATE
                 71 0e
       01a2:a83b b8 42 b8        MOV        AX,0xb842
       01a2:a83e 50              PUSH       AX
       01a2:a83f 9a c8 76        CALLF      PRINT_STR_NEWLINE
                 71 0e
       01a2:a844 e8 10 94        CALL       FUN_01a2_3c57                                    undefined FUN_01a2_3c57()
       01a2:a847 b8 01 00        MOV        AX,0x1
       01a2:a84a 50              PUSH       AX
       01a2:a84b b8 1b 00        MOV        AX,0x1b
       01a2:a84e 50              PUSH       AX
       01a2:a84f b8 01 00        MOV        AX,0x1
       01a2:a852 50              PUSH       AX
       01a2:a853 b8 06 00        MOV        AX,0x6
       01a2:a856 50              PUSH       AX
       01a2:a857 b8 04 00        MOV        AX,0x4
       01a2:a85a 50              PUSH       AX
       01a2:a85b 9a b2 61        CALLF      LOCATE
                 71 0e
       01a2:a860 b8 62 b8        MOV        AX,0xb862
       01a2:a863 50              PUSH       AX
       01a2:a864 9a c8 76        CALLF      PRINT_STR_NEWLINE
                 71 0e
       01a2:a869 e8 24 94        CALL       FUN_01a2_3c90                                    undefined FUN_01a2_3c90()
       01a2:a86c b8 01 00        MOV        AX,0x1
       01a2:a86f 50              PUSH       AX
       01a2:a870 b8 1b 00        MOV        AX,0x1b
       01a2:a873 50              PUSH       AX
       01a2:a874 b8 01 00        MOV        AX,0x1
       01a2:a877 50              PUSH       AX
       01a2:a878 b8 06 00        MOV        AX,0x6
       01a2:a87b 50              PUSH       AX
       01a2:a87c b8 04 00        MOV        AX,0x4
       01a2:a87f 50              PUSH       AX
       01a2:a880 9a b2 61        CALLF      LOCATE
                 71 0e
       01a2:a885 b8 20 03        MOV        AX,0x320
       01a2:a888 50              PUSH       AX
       01a2:a889 ff 36 52 a5     PUSH       word ptr [0xa552]
       01a2:a88d ff 36 50 a5     PUSH       word ptr { 1.0 }
       01a2:a891 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:a896 b8 42 b8        MOV        AX,0xb842
       01a2:a899 50              PUSH       AX
       01a2:a89a 9a c8 76        CALLF      PRINT_STR_NEWLINE
                 71 0e
       01a2:a89f e8 b5 93        CALL       FUN_01a2_3c57                                    undefined FUN_01a2_3c57()
       01a2:a8a2 b8 01 00        MOV        AX,0x1
       01a2:a8a5 50              PUSH       AX
       01a2:a8a6 b8 1b 00        MOV        AX,0x1b
       01a2:a8a9 50              PUSH       AX
       01a2:a8aa b8 01 00        MOV        AX,0x1
       01a2:a8ad 50              PUSH       AX
       01a2:a8ae b8 06 00        MOV        AX,0x6
       01a2:a8b1 50              PUSH       AX
       01a2:a8b2 b8 04 00        MOV        AX,0x4
       01a2:a8b5 50              PUSH       AX
       01a2:a8b6 9a b2 61        CALLF      LOCATE
                 71 0e
       01a2:a8bb b8 62 b8        MOV        AX,0xb862
       01a2:a8be 50              PUSH       AX
       01a2:a8bf 9a c8 76        CALLF      PRINT_STR_NEWLINE
                 71 0e
       01a2:a8c4 e8 c9 93        CALL       FUN_01a2_3c90                                    undefined FUN_01a2_3c90()
       01a2:a8c7 b8 01 00        MOV        AX,0x1
       01a2:a8ca 50              PUSH       AX
       01a2:a8cb b8 1b 00        MOV        AX,0x1b
       01a2:a8ce 50              PUSH       AX
       01a2:a8cf b8 01 00        MOV        AX,0x1
       01a2:a8d2 50              PUSH       AX
       01a2:a8d3 b8 06 00        MOV        AX,0x6
       01a2:a8d6 50              PUSH       AX
       01a2:a8d7 b8 04 00        MOV        AX,0x4
       01a2:a8da 50              PUSH       AX
       01a2:a8db 9a b2 61        CALLF      LOCATE
                 71 0e
       01a2:a8e0 b8 20 03        MOV        AX,0x320
       01a2:a8e3 50              PUSH       AX
       01a2:a8e4 ff 36 52 a5     PUSH       word ptr [0xa552]
       01a2:a8e8 ff 36 50 a5     PUSH       word ptr { 1.0 }
       01a2:a8ec 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:a8f1 b8 42 b8        MOV        AX,0xb842
       01a2:a8f4 50              PUSH       AX
       01a2:a8f5 9a c8 76        CALLF      PRINT_STR_NEWLINE
                 71 0e
       01a2:a8fa e8 5a 93        CALL       FUN_01a2_3c57                                    undefined FUN_01a2_3c57()
       01a2:a8fd b8 01 00        MOV        AX,0x1
       01a2:a900 50              PUSH       AX
       01a2:a901 b8 1b 00        MOV        AX,0x1b
       01a2:a904 50              PUSH       AX
       01a2:a905 b8 01 00        MOV        AX,0x1
       01a2:a908 50              PUSH       AX
       01a2:a909 b8 06 00        MOV        AX,0x6
       01a2:a90c 50              PUSH       AX
       01a2:a90d b8 04 00        MOV        AX,0x4
       01a2:a910 50              PUSH       AX
       01a2:a911 9a b2 61        CALLF      LOCATE
                 71 0e
       01a2:a916 b8 82 b8        MOV        AX,0xb882
       01a2:a919 50              PUSH       AX
       01a2:a91a 9a c8 76        CALLF      PRINT_STR_NEWLINE
                 71 0e
       01a2:a91f e8 6e 93        CALL       FUN_01a2_3c90                                    undefined FUN_01a2_3c90()
       01a2:a922 b8 01 00        MOV        AX,0x1
       01a2:a925 50              PUSH       AX
       01a2:a926 b8 1b 00        MOV        AX,0x1b
       01a2:a929 50              PUSH       AX
       01a2:a92a b8 01 00        MOV        AX,0x1
       01a2:a92d 50              PUSH       AX
       01a2:a92e b8 06 00        MOV        AX,0x6
       01a2:a931 50              PUSH       AX
       01a2:a932 b8 04 00        MOV        AX,0x4
       01a2:a935 50              PUSH       AX
       01a2:a936 9a b2 61        CALLF      LOCATE
                 71 0e
       01a2:a93b b8 20 03        MOV        AX,0x320
       01a2:a93e 50              PUSH       AX
       01a2:a93f ff 36 52 a5     PUSH       word ptr [0xa552]
       01a2:a943 ff 36 50 a5     PUSH       word ptr { 1.0 }
       01a2:a947 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:a94c b8 42 b8        MOV        AX,0xb842
       01a2:a94f 50              PUSH       AX
       01a2:a950 9a c8 76        CALLF      PRINT_STR_NEWLINE
                 71 0e
       01a2:a955 e8 ff 92        CALL       FUN_01a2_3c57                                    undefined FUN_01a2_3c57()
       01a2:a958 b8 01 00        MOV        AX,0x1
       01a2:a95b 50              PUSH       AX
       01a2:a95c b8 1b 00        MOV        AX,0x1b
       01a2:a95f 50              PUSH       AX
       01a2:a960 b8 01 00        MOV        AX,0x1
       01a2:a963 50              PUSH       AX
       01a2:a964 b8 06 00        MOV        AX,0x6
       01a2:a967 50              PUSH       AX
       01a2:a968 b8 04 00        MOV        AX,0x4
       01a2:a96b 50              PUSH       AX
       01a2:a96c 9a b2 61        CALLF      LOCATE
                 71 0e
       01a2:a971 b8 62 b8        MOV        AX,0xb862
       01a2:a974 50              PUSH       AX
       01a2:a975 9a c8 76        CALLF      PRINT_STR_NEWLINE
                 71 0e
       01a2:a97a e8 da 92        CALL       FUN_01a2_3c57                                    undefined FUN_01a2_3c57()
       01a2:a97d e8 d7 92        CALL       FUN_01a2_3c57                                    undefined FUN_01a2_3c57()
                             LAB_01a2_a980                                   XREF[1]:     01a2:a7ee(j)  
       01a2:a980 b8 c8 00        MOV        AX,0xc8
       01a2:a983 50              PUSH       AX
       01a2:a984 ff 36 26 a6     PUSH       word ptr [0xa626]
       01a2:a988 ff 36 24 a6     PUSH       word ptr { 3.0 }
       01a2:a98c 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:a991 b8 78 00        MOV        AX,0x78
       01a2:a994 50              PUSH       AX
       01a2:a995 ff 36 7e af     PUSH       word ptr [0xaf7e]
       01a2:a999 ff 36 7c af     PUSH       word ptr { 5.0 }
       01a2:a99d 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:a9a2 b8 01 00        MOV        AX,0x1
       01a2:a9a5 50              PUSH       AX
       01a2:a9a6 b8 0d 00        MOV        AX,0xd
       01a2:a9a9 50              PUSH       AX
       01a2:a9aa b8 02 00        MOV        AX,0x2
       01a2:a9ad 50              PUSH       AX
       01a2:a9ae 9a 86 61        CALLF      COLOR
                 71 0e
       01a2:a9b3 b8 01 00        MOV        AX,0x1
       01a2:a9b6 50              PUSH       AX
       01a2:a9b7 b8 1b 00        MOV        AX,0x1b
       01a2:a9ba 50              PUSH       AX
       01a2:a9bb b8 01 00        MOV        AX,0x1
       01a2:a9be 50              PUSH       AX
       01a2:a9bf 90              NOP
       01a2:a9c0 d9 06 80 af     FLD        float ptr { 6.0 }
       01a2:a9c4 90              NOP
       01a2:a9c5 d8 06 d2 a4     FADD       float ptr [0xa4d2]
       01a2:a9c9 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:a9ce 50              PUSH       AX
       01a2:a9cf b8 04 00        MOV        AX,0x4
       01a2:a9d2 50              PUSH       AX
       01a2:a9d3 9a b2 61        CALLF      LOCATE
                 71 0e
       01a2:a9d8 b8 a2 b8        MOV        AX,0xb8a2
       01a2:a9db 50              PUSH       AX
       01a2:a9dc 9a c8 76        CALLF      PRINT_STR_NEWLINE
                 71 0e
       01a2:a9e1 e8 73 92        CALL       FUN_01a2_3c57                                    undefined FUN_01a2_3c57()
       01a2:a9e4 b8 01 00        MOV        AX,0x1
       01a2:a9e7 50              PUSH       AX
       01a2:a9e8 b8 1b 00        MOV        AX,0x1b
       01a2:a9eb 50              PUSH       AX
       01a2:a9ec b8 01 00        MOV        AX,0x1
       01a2:a9ef 50              PUSH       AX
       01a2:a9f0 90              NOP
       01a2:a9f1 d9 06 80 af     FLD        float ptr { 6.0 }
       01a2:a9f5 90              NOP
       01a2:a9f6 d8 06 d2 a4     FADD       float ptr [0xa4d2]
       01a2:a9fa 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:a9ff 50              PUSH       AX
       01a2:aa00 b8 04 00        MOV        AX,0x4
       01a2:aa03 50              PUSH       AX
       01a2:aa04 9a b2 61        CALLF      LOCATE
                 71 0e
       01a2:aa09 b8 ca b8        MOV        AX,0xb8ca
       01a2:aa0c 50              PUSH       AX
       01a2:aa0d 9a c8 76        CALLF      PRINT_STR_NEWLINE
                 71 0e
       01a2:aa12 e8 42 92        CALL       FUN_01a2_3c57                                    undefined FUN_01a2_3c57()
       01a2:aa15 b8 c8 00        MOV        AX,0xc8
       01a2:aa18 50              PUSH       AX
       01a2:aa19 ff 36 26 a6     PUSH       word ptr [0xa626]
       01a2:aa1d ff 36 24 a6     PUSH       word ptr { 3.0 }
       01a2:aa21 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:aa26 b8 78 00        MOV        AX,0x78
       01a2:aa29 50              PUSH       AX
       01a2:aa2a ff 36 7e af     PUSH       word ptr [0xaf7e]
       01a2:aa2e ff 36 7c af     PUSH       word ptr { 5.0 }
       01a2:aa32 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:aa37 b8 01 00        MOV        AX,0x1
       01a2:aa3a 50              PUSH       AX
       01a2:aa3b b8 1b 00        MOV        AX,0x1b
       01a2:aa3e 50              PUSH       AX
       01a2:aa3f b8 01 00        MOV        AX,0x1
       01a2:aa42 50              PUSH       AX
       01a2:aa43 90              NOP
       01a2:aa44 d9 06 80 af     FLD        float ptr { 6.0 }
       01a2:aa48 90              NOP
       01a2:aa49 d8 06 d2 a4     FADD       float ptr [0xa4d2]
       01a2:aa4d 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:aa52 50              PUSH       AX
       01a2:aa53 b8 04 00        MOV        AX,0x4
       01a2:aa56 50              PUSH       AX
       01a2:aa57 9a b2 61        CALLF      LOCATE
                 71 0e
       01a2:aa5c b8 a2 b8        MOV        AX,0xb8a2
       01a2:aa5f 50              PUSH       AX
       01a2:aa60 9a c8 76        CALLF      PRINT_STR_NEWLINE
                 71 0e
       01a2:aa65 e8 ef 91        CALL       FUN_01a2_3c57                                    undefined FUN_01a2_3c57()
       01a2:aa68 b8 01 00        MOV        AX,0x1
       01a2:aa6b 50              PUSH       AX
       01a2:aa6c b8 1b 00        MOV        AX,0x1b
       01a2:aa6f 50              PUSH       AX
       01a2:aa70 b8 01 00        MOV        AX,0x1
       01a2:aa73 50              PUSH       AX
       01a2:aa74 90              NOP
       01a2:aa75 d9 06 80 af     FLD        float ptr { 6.0 }
       01a2:aa79 90              NOP
       01a2:aa7a d8 06 d2 a4     FADD       float ptr [0xa4d2]
       01a2:aa7e 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:aa83 50              PUSH       AX
       01a2:aa84 b8 04 00        MOV        AX,0x4
       01a2:aa87 50              PUSH       AX
       01a2:aa88 9a b2 61        CALLF      LOCATE
                 71 0e
       01a2:aa8d b8 ca b8        MOV        AX,0xb8ca
       01a2:aa90 50              PUSH       AX
       01a2:aa91 9a c8 76        CALLF      PRINT_STR_NEWLINE
                 71 0e
       01a2:aa96 e8 be 91        CALL       FUN_01a2_3c57                                    undefined FUN_01a2_3c57()
       01a2:aa99 b8 c8 00        MOV        AX,0xc8
       01a2:aa9c 50              PUSH       AX
       01a2:aa9d ff 36 26 a6     PUSH       word ptr [0xa626]
       01a2:aaa1 ff 36 24 a6     PUSH       word ptr { 3.0 }
       01a2:aaa5 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:aaaa b8 78 00        MOV        AX,0x78
       01a2:aaad 50              PUSH       AX
       01a2:aaae ff 36 7e af     PUSH       word ptr [0xaf7e]
       01a2:aab2 ff 36 7c af     PUSH       word ptr { 5.0 }
       01a2:aab6 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:aabb b8 01 00        MOV        AX,0x1
       01a2:aabe 50              PUSH       AX
       01a2:aabf b8 1b 00        MOV        AX,0x1b
       01a2:aac2 50              PUSH       AX
       01a2:aac3 b8 01 00        MOV        AX,0x1
       01a2:aac6 50              PUSH       AX
       01a2:aac7 90              NOP
       01a2:aac8 d9 06 80 af     FLD        float ptr { 6.0 }
       01a2:aacc 90              NOP
       01a2:aacd d8 06 d2 a4     FADD       float ptr [0xa4d2]
       01a2:aad1 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:aad6 50              PUSH       AX
       01a2:aad7 b8 04 00        MOV        AX,0x4
       01a2:aada 50              PUSH       AX
       01a2:aadb 9a b2 61        CALLF      LOCATE
                 71 0e
       01a2:aae0 b8 a2 b8        MOV        AX,0xb8a2
       01a2:aae3 50              PUSH       AX
       01a2:aae4 9a c8 76        CALLF      PRINT_STR_NEWLINE
                 71 0e
       01a2:aae9 e8 6b 91        CALL       FUN_01a2_3c57                                    undefined FUN_01a2_3c57()
       01a2:aaec b8 01 00        MOV        AX,0x1
       01a2:aaef 50              PUSH       AX
       01a2:aaf0 b8 1b 00        MOV        AX,0x1b
       01a2:aaf3 50              PUSH       AX
       01a2:aaf4 b8 01 00        MOV        AX,0x1
       01a2:aaf7 50              PUSH       AX
       01a2:aaf8 90              NOP
       01a2:aaf9 d9 06 80 af     FLD        float ptr { 6.0 }
       01a2:aafd 90              NOP
       01a2:aafe d8 06 d2 a4     FADD       float ptr [0xa4d2]
       01a2:ab02 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:ab07 50              PUSH       AX
       01a2:ab08 b8 04 00        MOV        AX,0x4
       01a2:ab0b 50              PUSH       AX
       01a2:ab0c 9a b2 61        CALLF      LOCATE
                 71 0e
       01a2:ab11 b8 ca b8        MOV        AX,0xb8ca
       01a2:ab14 50              PUSH       AX
       01a2:ab15 9a c8 76        CALLF      PRINT_STR_NEWLINE
                 71 0e
       01a2:ab1a e8 3a 91        CALL       FUN_01a2_3c57                                    undefined FUN_01a2_3c57()
       01a2:ab1d b8 c8 00        MOV        AX,0xc8
       01a2:ab20 50              PUSH       AX
       01a2:ab21 ff 36 26 a6     PUSH       word ptr [0xa626]
       01a2:ab25 ff 36 24 a6     PUSH       word ptr { 3.0 }
       01a2:ab29 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:ab2e b8 78 00        MOV        AX,0x78
       01a2:ab31 50              PUSH       AX
       01a2:ab32 ff 36 7e af     PUSH       word ptr [0xaf7e]
       01a2:ab36 ff 36 7c af     PUSH       word ptr { 5.0 }
       01a2:ab3a 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:ab3f b8 01 00        MOV        AX,0x1
       01a2:ab42 50              PUSH       AX
       01a2:ab43 b8 1b 00        MOV        AX,0x1b
       01a2:ab46 50              PUSH       AX
       01a2:ab47 b8 01 00        MOV        AX,0x1
       01a2:ab4a 50              PUSH       AX
       01a2:ab4b 90              NOP
       01a2:ab4c d9 06 80 af     FLD        float ptr { 6.0 }
       01a2:ab50 90              NOP
       01a2:ab51 d8 06 d2 a4     FADD       float ptr [0xa4d2]
       01a2:ab55 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:ab5a 50              PUSH       AX
       01a2:ab5b b8 04 00        MOV        AX,0x4
       01a2:ab5e 50              PUSH       AX
       01a2:ab5f 9a b2 61        CALLF      LOCATE
                 71 0e
       01a2:ab64 b8 a2 b8        MOV        AX,0xb8a2
       01a2:ab67 50              PUSH       AX
       01a2:ab68 9a c8 76        CALLF      PRINT_STR_NEWLINE
                 71 0e
       01a2:ab6d 90              NOP
       01a2:ab6e d9 06 50 a5     FLD        float ptr { 1.0 }
       01a2:ab72 e9 0e 00        JMP        LAB_01a2_ab83
       01a2:ab75 90              ??         90h
                             LAB_01a2_ab76                                   XREF[1]:     01a2:ab9b(j)  
       01a2:ab76 e8 de 90        CALL       FUN_01a2_3c57                                    undefined FUN_01a2_3c57()
       01a2:ab79 90              NOP
       01a2:ab7a d9 06 3a 00     FLD        float ptr [0x3a]
       01a2:ab7e 90              NOP
       01a2:ab7f d8 06 50 a5     FADD       float ptr { 1.0 }
                             LAB_01a2_ab83                                   XREF[1]:     01a2:ab72(j)  
       01a2:ab83 90              NOP
       01a2:ab84 d9 1e 3a 00     FSTP       float ptr [0x3a]
       01a2:ab88 90              NOP
       01a2:ab89 9b              WAIT
       01a2:ab8a 90              NOP
       01a2:ab8b d9 06 74 a6     FLD        float ptr { 4.0 }
       01a2:ab8f 90              NOP
       01a2:ab90 d9 06 3a 00     FLD        float ptr [0x3a]
       01a2:ab94 90              NOP
       01a2:ab95 9b              WAIT
       01a2:ab96 9a 1d 04        CALLF      FPCOMPARE_2stack                                 undefined FPCOMPARE_2stack()
                 75 0d
       01a2:ab9b 76 d9           JBE        LAB_01a2_ab76
       01a2:ab9d 90              NOP
       01a2:ab9e d9 06 4c a6     FLD        float ptr { 0.0 }
       01a2:aba2 90              NOP
       01a2:aba3 d9 1e d2 a4     FSTP       float ptr [0xa4d2]
       01a2:aba7 90              NOP
       01a2:aba8 9b              WAIT
                             LAB_01a2_aba9                                   XREF[4]:     FUN_01a2_19fa:01a2:2003(j), 
                                                                                          FUN_01a2_19fa:01a2:2d3e(j), 
                                                                                          01a2:a5dd(j), 01a2:a7d8(j)  
       01a2:aba9 33 c0           XOR        AX,AX
       01a2:abab 50              PUSH       AX
       01a2:abac 9a 25 62        CALLF      CLS
                 71 0e
       01a2:abb1 90              NOP
       01a2:abb2 d9 06 d6 a4     FLD        float ptr [0xa4d6]
       01a2:abb6 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:abbb d1 e0           SHL        AX,0x1
       01a2:abbd d1 e0           SHL        AX,0x1
       01a2:abbf 05 98 01        ADD        AX,0x198
       01a2:abc2 8b f0           MOV        SI,AX
       01a2:abc4 90              NOP
       01a2:abc5 d9 84 92 9c     FLD        float ptr [SI + 0x9c92]
       01a2:abc9 90              NOP
       01a2:abca d9 1e da a4     FSTP       float ptr [0xa4da]
       01a2:abce 90              NOP
       01a2:abcf 9b              WAIT
       01a2:abd0 90              NOP
       01a2:abd1 d9 06 d6 a4     FLD        float ptr [0xa4d6]
       01a2:abd5 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:abda d1 e0           SHL        AX,0x1
       01a2:abdc d1 e0           SHL        AX,0x1
       01a2:abde 05 c8 04        ADD        AX,0x4c8
       01a2:abe1 8b f0           MOV        SI,AX
       01a2:abe3 90              NOP
       01a2:abe4 d9 84 92 9c     FLD        float ptr [SI + 0x9c92]
       01a2:abe8 90              NOP
       01a2:abe9 d9 1e de a4     FSTP       float ptr [0xa4de]
       01a2:abed 90              NOP
       01a2:abee 9b              WAIT
       01a2:abef 90              NOP
       01a2:abf0 d9 06 da b3     FLD        float ptr [0xb3da]
       01a2:abf4 90              NOP
       01a2:abf5 d9 06 56 a4     FLD        float ptr [0xa456]
       01a2:abf9 90              NOP
       01a2:abfa 9b              WAIT
       01a2:abfb 9a 1d 04        CALLF      FPCOMPARE_2stack                                 undefined FPCOMPARE_2stack()
                 75 0d
       01a2:ac00 72 03           JC         LAB_01a2_ac05
       01a2:ac02 e9 0c 00        JMP        LAB_01a2_ac11
                             LAB_01a2_ac05                                   XREF[1]:     01a2:ac00(j)  
       01a2:ac05 90              NOP
       01a2:ac06 d9 06 50 a5     FLD        float ptr { 1.0 }
       01a2:ac0a 90              NOP
       01a2:ac0b d9 1e 52 a4     FSTP       float ptr [0xa452]
       01a2:ac0f 90              NOP
       01a2:ac10 9b              WAIT
                             LAB_01a2_ac11                                   XREF[1]:     01a2:ac02(j)  
       01a2:ac11 90              NOP
       01a2:ac12 d9 06 d6 a4     FLD        float ptr [0xa4d6]
       01a2:ac16 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:ac1b d1 e0           SHL        AX,0x1
       01a2:ac1d d1 e0           SHL        AX,0x1
       01a2:ac1f 05 64 02        ADD        AX,0x264
       01a2:ac22 8b f0           MOV        SI,AX
       01a2:ac24 90              NOP
       01a2:ac25 d9 84 92 9c     FLD        float ptr [SI + 0x9c92]
       01a2:ac29 90              NOP
       01a2:ac2a d8 06 4e a4     FADD       float ptr [0xa44e]
       01a2:ac2e 90              NOP
       01a2:ac2f d9 06 d6 a4     FLD        float ptr [0xa4d6]
       01a2:ac33 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:ac38 d1 e0           SHL        AX,0x1
       01a2:ac3a d1 e0           SHL        AX,0x1
       01a2:ac3c 05 64 02        ADD        AX,0x264
       01a2:ac3f 8b f0           MOV        SI,AX
       01a2:ac41 90              NOP
       01a2:ac42 d9 9c 92 9c     FSTP       float ptr [SI + 0x9c92]
       01a2:ac46 90              NOP
       01a2:ac47 9b              WAIT
       01a2:ac48 90              NOP
       01a2:ac49 d9 06 d6 a4     FLD        float ptr [0xa4d6]
       01a2:ac4d 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:ac52 d1 e0           SHL        AX,0x1
       01a2:ac54 d1 e0           SHL        AX,0x1
       01a2:ac56 05 30 03        ADD        AX,0x330
       01a2:ac59 8b f0           MOV        SI,AX
       01a2:ac5b 90              NOP
       01a2:ac5c d9 84 92 9c     FLD        float ptr [SI + 0x9c92]
       01a2:ac60 90              NOP
       01a2:ac61 d8 06 52 a4     FADD       float ptr [0xa452]
       01a2:ac65 90              NOP
       01a2:ac66 d9 06 d6 a4     FLD        float ptr [0xa4d6]
       01a2:ac6a 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:ac6f d1 e0           SHL        AX,0x1
       01a2:ac71 d1 e0           SHL        AX,0x1
       01a2:ac73 05 30 03        ADD        AX,0x330
       01a2:ac76 8b f0           MOV        SI,AX
       01a2:ac78 90              NOP
       01a2:ac79 d9 9c 92 9c     FSTP       float ptr [SI + 0x9c92]
       01a2:ac7d 90              NOP
       01a2:ac7e 9b              WAIT
       01a2:ac7f 90              NOP
       01a2:ac80 d9 06 50 a5     FLD        float ptr { 1.0 }
       01a2:ac84 90              NOP
       01a2:ac85 d9 06 4e a4     FLD        float ptr [0xa44e]
       01a2:ac89 90              NOP
       01a2:ac8a 9b              WAIT
       01a2:ac8b 9a 1d 04        CALLF      FPCOMPARE_2stack                                 undefined FPCOMPARE_2stack()
                 75 0d
       01a2:ac90 74 03           JZ         LAB_01a2_ac95
       01a2:ac92 e9 11 00        JMP        LAB_01a2_aca6
                             LAB_01a2_ac95                                   XREF[1]:     01a2:ac90(j)  
       01a2:ac95 90              NOP
       01a2:ac96 d9 06 56 a4     FLD        float ptr [0xa456]
       01a2:ac9a 90              NOP
       01a2:ac9b d8 06 f2 b8     FADD       float ptr [0xb8f2]
       01a2:ac9f 90              NOP
       01a2:aca0 d9 1e 56 a4     FSTP       float ptr [0xa456]
       01a2:aca4 90              NOP
       01a2:aca5 9b              WAIT
                             LAB_01a2_aca6                                   XREF[1]:     01a2:ac92(j)  
       01a2:aca6 90              NOP
       01a2:aca7 d9 06 50 a5     FLD        float ptr { 1.0 }
       01a2:acab 90              NOP
       01a2:acac d9 06 52 a4     FLD        float ptr [0xa452]
       01a2:acb0 90              NOP
       01a2:acb1 9b              WAIT
       01a2:acb2 9a 1d 04        CALLF      FPCOMPARE_2stack                                 undefined FPCOMPARE_2stack()
                 75 0d
       01a2:acb7 74 03           JZ         LAB_01a2_acbc
       01a2:acb9 e9 11 00        JMP        LAB_01a2_accd
                             LAB_01a2_acbc                                   XREF[1]:     01a2:acb7(j)  
       01a2:acbc 90              NOP
       01a2:acbd d9 06 56 a4     FLD        float ptr [0xa456]
       01a2:acc1 90              NOP
       01a2:acc2 d8 06 f6 b8     FADD       float ptr [0xb8f6]
       01a2:acc6 90              NOP
       01a2:acc7 d9 1e 56 a4     FSTP       float ptr [0xa456]
       01a2:accb 90              NOP
       01a2:accc 9b              WAIT
                             LAB_01a2_accd                                   XREF[1]:     01a2:acb9(j)  
       01a2:accd 90              NOP
       01a2:acce d9 06 da a4     FLD        float ptr [0xa4da]
       01a2:acd2 90              NOP
       01a2:acd3 d9 06 56 a4     FLD        float ptr [0xa456]
       01a2:acd7 90              NOP
       01a2:acd8 9b              WAIT
       01a2:acd9 9a 1d 04        CALLF      FPCOMPARE_2stack                                 undefined FPCOMPARE_2stack()
                 75 0d
       01a2:acde 77 03           JA         LAB_01a2_ace3
       01a2:ace0 e9 1f 00        JMP        LAB_01a2_ad02
                             LAB_01a2_ace3                                   XREF[1]:     01a2:acde(j)  
       01a2:ace3 90              NOP
       01a2:ace4 d9 06 56 a4     FLD        float ptr [0xa456]
       01a2:ace8 90              NOP
       01a2:ace9 d9 06 d6 a4     FLD        float ptr [0xa4d6]
       01a2:aced 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:acf2 d1 e0           SHL        AX,0x1
       01a2:acf4 d1 e0           SHL        AX,0x1
       01a2:acf6 05 98 01        ADD        AX,0x198
       01a2:acf9 8b f0           MOV        SI,AX
       01a2:acfb 90              NOP
       01a2:acfc d9 9c 92 9c     FSTP       float ptr [SI + 0x9c92]
       01a2:ad00 90              NOP
       01a2:ad01 9b              WAIT
                             LAB_01a2_ad02                                   XREF[1]:     01a2:ace0(j)  
       01a2:ad02 90              NOP
       01a2:ad03 d9 06 e2 a4     FLD        float ptr [0xa4e2]
       01a2:ad07 90              NOP
       01a2:ad08 d8 0e de a4     FMUL       float ptr [0xa4de]
       01a2:ad0c 90              NOP
       01a2:ad0d d9 1e e2 a4     FSTP       float ptr [0xa4e2]
       01a2:ad11 90              NOP
       01a2:ad12 9b              WAIT
       01a2:ad13 90              NOP
       01a2:ad14 d9 06 de a4     FLD        float ptr [0xa4de]
       01a2:ad18 90              NOP
       01a2:ad19 d8 06 50 a5     FADD       float ptr { 1.0 }
       01a2:ad1d 90              NOP
       01a2:ad1e d9 1e de a4     FSTP       float ptr [0xa4de]
       01a2:ad22 90              NOP
       01a2:ad23 9b              WAIT
       01a2:ad24 90              NOP
       01a2:ad25 d9 06 de a4     FLD        float ptr [0xa4de]
       01a2:ad29 90              NOP
       01a2:ad2a d9 06 d6 a4     FLD        float ptr [0xa4d6]
       01a2:ad2e 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:ad33 d1 e0           SHL        AX,0x1
       01a2:ad35 d1 e0           SHL        AX,0x1
       01a2:ad37 05 c8 04        ADD        AX,0x4c8
       01a2:ad3a 8b f0           MOV        SI,AX
       01a2:ad3c 90              NOP
       01a2:ad3d d9 9c 92 9c     FSTP       float ptr [SI + 0x9c92]
       01a2:ad41 90              NOP
       01a2:ad42 9b              WAIT
       01a2:ad43 90              NOP
       01a2:ad44 d9 06 e2 a4     FLD        float ptr [0xa4e2]
       01a2:ad48 90              NOP
       01a2:ad49 d8 06 56 a4     FADD       float ptr [0xa456]
       01a2:ad4d 90              NOP
       01a2:ad4e d9 1e e2 a4     FSTP       float ptr [0xa4e2]
       01a2:ad52 90              NOP
       01a2:ad53 9b              WAIT
       01a2:ad54 90              NOP
       01a2:ad55 d9 06 e2 a4     FLD        float ptr [0xa4e2]
       01a2:ad59 90              NOP
       01a2:ad5a d8 36 de a4     FDIV       float ptr [0xa4de]
       01a2:ad5e 90              NOP
       01a2:ad5f d9 1e e2 a4     FSTP       float ptr [0xa4e2]
       01a2:ad63 90              NOP
       01a2:ad64 9b              WAIT
       01a2:ad65 90              NOP
       01a2:ad66 d9 06 e2 a4     FLD        float ptr [0xa4e2]
       01a2:ad6a 90              NOP
       01a2:ad6b d9 06 d6 a4     FLD        float ptr [0xa4d6]
       01a2:ad6f 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:ad74 d1 e0           SHL        AX,0x1
       01a2:ad76 d1 e0           SHL        AX,0x1
       01a2:ad78 05 fc 03        ADD        AX,0x3fc
       01a2:ad7b 8b f0           MOV        SI,AX
       01a2:ad7d 90              NOP
       01a2:ad7e d9 9c 92 9c     FSTP       float ptr [SI + 0x9c92]
       01a2:ad82 90              NOP
       01a2:ad83 9b              WAIT
       01a2:ad84 e8 80 04        CALL       FUN_01a2_b207                                    undefined FUN_01a2_b207()
       01a2:ad87 e8 9f 02        CALL       FUN_01a2_b029                                    undefined FUN_01a2_b029()
       01a2:ad8a e8 15 0f        CALL       FUN_01a2_bca2                                    undefined FUN_01a2_bca2()
       01a2:ad8d 90              NOP
       01a2:ad8e d9 06 4c a6     FLD        float ptr { 0.0 }
       01a2:ad92 90              NOP
       01a2:ad93 d9 1e 4e a4     FSTP       float ptr [0xa44e]
       01a2:ad97 90              NOP
       01a2:ad98 9b              WAIT
       01a2:ad99 90              NOP
       01a2:ad9a d9 06 4c a6     FLD        float ptr { 0.0 }
       01a2:ad9e 90              NOP
       01a2:ad9f d9 1e 52 a4     FSTP       float ptr [0xa452]
       01a2:ada3 90              NOP
       01a2:ada4 9b              WAIT
       01a2:ada5 90              NOP
       01a2:ada6 d9 06 50 a5     FLD        float ptr { 1.0 }
       01a2:adaa e9 66 00        JMP        LAB_01a2_ae13
       01a2:adad 90              ??         90h
                             LAB_01a2_adae                                   XREF[1]:     01a2:ae2b(j)  
       01a2:adae 90              NOP
       01a2:adaf d9 06 50 a5     FLD        float ptr { 1.0 }
       01a2:adb3 e9 39 00        JMP        LAB_01a2_adef
                             LAB_01a2_adb6                                   XREF[1]:     01a2:ae07(j)  
       01a2:adb6 90              NOP
       01a2:adb7 d9 06 4c a6     FLD        float ptr { 0.0 }
       01a2:adbb 90              NOP
       01a2:adbc d9 06 e6 a4     FLD        float ptr [0xa4e6]
       01a2:adc0 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:adc5 be 0b 00        MOV        SI,0xb
       01a2:adc8 f7 ee           IMUL       SI
       01a2:adca 8b f0           MOV        SI,AX
       01a2:adcc 90              NOP
       01a2:adcd d9 06 ea a4     FLD        float ptr [0xa4ea]
       01a2:add1 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:add6 03 c6           ADD        AX,SI
       01a2:add8 8b f0           MOV        SI,AX
       01a2:adda d1 e6           SHL        SI,0x1
       01a2:addc d1 e6           SHL        SI,0x1
       01a2:adde 90              NOP
       01a2:addf d9 9c 46 a2     FSTP       float ptr [SI + Fa246!(i,j)]
       01a2:ade3 90              NOP
       01a2:ade4 9b              WAIT
       01a2:ade5 90              NOP
       01a2:ade6 d9 06 e6 a4     FLD        float ptr [0xa4e6]
       01a2:adea 90              NOP
       01a2:adeb d8 06 50 a5     FADD       float ptr { 1.0 }
                             LAB_01a2_adef                                   XREF[1]:     01a2:adb3(j)  
       01a2:adef 90              NOP
       01a2:adf0 d9 1e e6 a4     FSTP       float ptr [0xa4e6]
       01a2:adf4 90              NOP
       01a2:adf5 9b              WAIT
       01a2:adf6 90              NOP
       01a2:adf7 d9 06 74 a6     FLD        float ptr { 4.0 }
       01a2:adfb 90              NOP
       01a2:adfc d9 06 e6 a4     FLD        float ptr [0xa4e6]
       01a2:ae00 90              NOP
       01a2:ae01 9b              WAIT
       01a2:ae02 9a 1d 04        CALLF      FPCOMPARE_2stack                                 undefined FPCOMPARE_2stack()
                 75 0d
       01a2:ae07 76 ad           JBE        LAB_01a2_adb6
       01a2:ae09 90              NOP
       01a2:ae0a d9 06 ea a4     FLD        float ptr [0xa4ea]
       01a2:ae0e 90              NOP
       01a2:ae0f d8 06 50 a5     FADD       float ptr { 1.0 }
                             LAB_01a2_ae13                                   XREF[1]:     01a2:adaa(j)  
       01a2:ae13 90              NOP
       01a2:ae14 d9 1e ea a4     FSTP       float ptr [0xa4ea]
       01a2:ae18 90              NOP
       01a2:ae19 9b              WAIT
       01a2:ae1a 90              NOP
       01a2:ae1b d9 06 8c af     FLD        float ptr { 10.0 }
       01a2:ae1f 90              NOP
       01a2:ae20 d9 06 ea a4     FLD        float ptr [0xa4ea]
       01a2:ae24 90              NOP
       01a2:ae25 9b              WAIT
       01a2:ae26 9a 1d 04        CALLF      FPCOMPARE_2stack                                 undefined FPCOMPARE_2stack()
                 75 0d
       01a2:ae2b 76 81           JBE        LAB_01a2_adae
       01a2:ae2d b8 3e a7        MOV        AX,""
       01a2:ae30 50              PUSH       AX
       01a2:ae31 b8 6e a4        MOV        AX,0xa46e
       01a2:ae34 50              PUSH       AX
       01a2:ae35 9a 78 7c        CALLF      SET_STRING
                 71 0e
       01a2:ae3a e9 66 53        JMP        LAB_01a2_01a3
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

DIM Fa246!(10,5)

' Calibration block removed — QB64 runs too fast for the original timing loop.
' Original: 37700 iterations measured with TIMER to scale F0042!/F0046!/F004a!.
' All delay loops are now _DELAY with pre-computed wall-clock durations (see CLAUDE.md).

' Play first intro
CLS 0
COLOR 14
LOCATE 8,15
PRINT "               *****  LAN-LOK  *****"
GOSUB L3c57:GOSUB L3c57:GOSUB L3c57
COLOR 9
LOCATE 12,15
PRINT "          by Mark Chappell and Shane Maloney"
GOSUB L3c57:GOSUB L3c57:GOSUB L3c57
COLOR 12
LOCATE 16,14
PRINT "   Developed at Palmer Station, February-March 1991"
GOSUB L3c57:GOSUB L3c57:GOSUB L3c57

' Init for second intro
SCREEN 12
RANDOMIZE TIMER

GOSUB Lae3d
L01a3:
CLS 0

GOSUB L0b97
' Set background
LINE (0,0)-(640,444),3,BF
' Draw L
LINE (40,30)-(30,150),4:LINE (44,30)-(26,150),4:LINE (38,30)-(31,150),4:LINE (30,150)-(80,140),4:LINE (26,149)-(76,137),4

GOSUB L3c90
GOSUB L0b97

' Draw A
LINE (110,135)-(140,20),4:LINE (105,128)-(135,24),4:LINE (107,130)-(137,22),4:LINE (134,20)-(160,134),4
LINE (130,22)-(155,136),4:LINE (120,70)-(140,75),4:LINE (115,74)-(145,74),4:LINE (114,76)-(146,76),4

GOSUB L3c90
GOSUB L0b97

' Draw N
LINE (200,20)-(190,134),4:LINE (197,22)-(192,136),4:LINE (204,21)-(195,136),4:LINE (200,20)-(240,150),4
LINE (198,20)-(235,140),4:LINE (197,19)-(236,144),4:LINE (235,145)-(240,20),4:LINE (233,144)-(235,23),4

GOSUB L3c90
GOSUB L0b97

' Draw -
LINE (260,80)-(290,80),4:LINE (260,76)-(289,82),4:LINE (259,82)-(292,84),4

GOSUB L3c90
GOSUB L0b97

' Draw L
LINE (330,24)-(325,140),4:LINE (326,22)-(333,143),4:LINE (324,138)-(390,140),4:LINE (320,140)-(392,135),4:LINE (319,142)-(393,142),4

GOSUB L3c90
GOSUB L0b97

' Draw O
CIRCLE (440,78),65,4,,,1.5:CIRCLE (437,79),66,4,,,1.4:CIRCLE (433,77),63,4,,,1.3

GOSUB L3c90
GOSUB L0b97

' Draw K
LINE (520,20)-(535,143),4:LINE (522,21)-(534,142),4:LINE (518,23)-(530,140),4:LINE (520,80)-(570,24),4
LINE (518,82)-(574,23),4:LINE (517,85)-(570,20),4:LINE (517,74)-(575,144),4:LINE (516,70)-(580,145),4:LINE (515,72)-(583,142),4

' Draw (C)
FOR Fa226! = 15 TO 18
CIRCLE (600,80),Fa226!,1
NEXT Fa226!

FOR Fa226! = 8 TO 11
CIRCLE (600,80),Fa226!,1,0.5,5.8
NEXT Fa226!

GOSUB L3c57: GOSUB L3c57

' Text box 1
LINE (10,162)-(350,260),0,BF
COLOR 14
LOCATE 14,5
SOUND 1200,3
PRINT "Use your Computer skills"
LINE (260,170)-(330,250),14,BF

' Computer icon
Fa22a!=1.0
Fa22e!=270
Fa232!=180
GOSUB L2e2d

' Text box 2
Fa22a! = 0
GOSUB L3c57: GOSUB L3c57
SOUND 800,3
LINE (280,275)-(630,330),0,BF
Fa22e! = 410
Fa232! = 50
COLOR 12
LOCATE 19,50
PRINT "to defeat ";
COLOR 2
PRINT "`Evil Al'"		' Funny aside: The original DS memory address for this string is 0xa666 ...
LOCATE 20,38
GOSUB L3c57
SOUND 200,4

' Al animation
GOSUB L637d

' Arrow animation
Fa236! = 63:GOSUB L0bcb
Fa236! = 13:GOSUB L0d53:GOSUB L0bcb
Fa236! = 12:GOSUB L0d53:GOSUB L0bcb
Fa236! = 13:GOSUB L0d53:GOSUB L0bcb:GOSUB L0d53
Fa236! = 4:GOSUB F0bcb

GOSUB L3c57
SOUND 900,3
COLOR 10
PRINT "The noxious, noisome, nasty Network Narc"
GOSUB L3c57
GOSUB L3c57
GOTO L0d85     ' Continue the intro there

L0b97:         ' Random sound effect
Fa23a! = RND*600+40
SOUND Fa23a!,3
RETURN

L0bcb:    ' Draw the arrows
SOUND 100,2
LINE (520,270)-(470,200),Fa236!
LINE (520,270)-(490,270),Fa236!
LINE (470,200)-(490,270),Fa236!
PAINT (500,265),Fa236!,Fa236!
LINE (460,202)-(480,198),Fa236!
LINE (460,175)-(460,202),Fa236!
LINE (460,175)-(480,198),Fa236!
PAINT (463,185),Fa236!,Fa236!
RETURN

L0d53:  ' Clear the arrows
GOSUB L3d02
LINE (460,175)-(520,270),3,BF
GOSUB L3d02
RETURN

L0d85:		' Continue the intro

' Text box 3
LINE (10,370)-(630,410),0,BF
COLOR 11
LOCATE 25,4
FOR F003a! = 1 to 8
Fa23e! = RND * 1500 + 40
SOUND Fa23e!,1
NEXT F003a!

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
WHILE LEN(Sa242$)=0
Sa242$=INKEY$
WEND
Sa242$=""

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
Sa42a$="            lab     labstore    admin     Susi     Calvin    rabbit   library     ratt     Tfive     Hobbs             "
RANDOMIZE TIMER
FOR Fa226!=1 TO 5
Fa246!(Fa226!,3)=16
Fa246!(Fa226!,4) = Fa226! * 120 + -70
NEXT Fa226!
FOR Fa226!=6 TO 10
Fa246!(Fa226!,3)=127
Fa246!(Fa226!,4)=Fa226! * 120 + -670
NEXT Fa226!
SCREEN 12

' Cyan background
LINE (0,0)-(640,480),3,BF

' Computer terminals
Fa232! = 16
F003a! = 6
Fa42e! = 1
FOR Fa22e! = 50 TO 540 STEP 120
GOSUB L2e2d
LOCATE F003a!,Fa22e!/8
Sa432$=MID$(Sa42a$,10*Fa42e!,10)
PRINT Sa432$
Fa42e!=Fa42e!+1
NEXT Fa22e!
Fa232! = 127
F003a! = 13
FOR Fa22e!=50 TO 540 STEP 120
GOSUB L2e2d
LOCATE F003a!,Fa22e!/8
Sa432$=MID$(Sa42a$,10*Fa42e!,10)
PRINT Sa432$
Fa42e!=Fa42e!+1
NEXT Fa22e!

' Status window
Fa22a!=9
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
FOR F003a!=18 TO 27
LOCATE F003a!,68: PRINT "O.K."
NEXT F003a!
COLOR 12
LOCATE 29,56: PRINT Sa436$;"'s SCORE:";
LOCATE 29,74: PRINT 0;

' Al window
LINE (10,235)-(420,350),0,BF
LINE (12,237)-(418,348),14,B
Fa22e!=30
Fa232!=263
GOSUB L637d

Fa43a!=0
Fa43e!=0
Fa442!=0
Fa446!=0
LOCATE 16,15
COLOR 14
PRINT "Scoreboard for ";:COLOR 2: PRINT "Evil Al";:COLOR 14:PRINT ", Network Narc"
COLOR 3
LOCATE 18,17:PRINT "Printers unjammed:"
LOCATE 19,17:PRINT "Computers unlocked: "
LOCATE 20,17:PRINT "Erasures restored: "
LOCATE 21,17:PRINT "Hard disks reconstructed:  "
COLOR 13
LOCATE 18,44:PRINT Fa43a!
LOCATE 19,44:PRINT Fa43e!
LOCATE 20,14:PRINT Fa442!
LOCATE 21,14:PRINT Fa446!

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
Fa44a!=TIMER+300
Fa44e!=0
Fa452!=0
Fa456!=0

' Main game loop?
L1e78:
Fa45a!=0
Fa45e!=TIMER
COLOR 15:LOCATE 27,4:PRINT ">"
GOSUB L2dbb
IF Fa462! < 0 THEN GOTO La58f
FOR Fa466!=1 to 10
Fa22e! = Fa246!(Fa466!,4)
Fa232! = Fa246!(Fa466!,3)
IF Fa246!(Fa466!,1) <> 0 THEN
ELSE
GOSUB L3522
GOTO L1fb0
Fa45a!=Fa45a!+1
Fa45e!=TIMER
Fa46a!=Fa466!
IF Fa246!(Fa466!,2) < Fa45e! THEN GOSUB L376f
L1fb0:
NEXT Fa466!
IF Fa45a! > 8 THEN GOSUB L9170
IF Fa45a! > 8 THEN GOTO Laba9
IF TIMER > Fa29e! THEN Fa29e!=0
IF TIMER < Fa29e! THEN GOTO L1e78

' User input processing
Sa242$ = INKEY$
LOCATE 27,6
IF Sa242$=CHR$(13) THEN GOTO L210a
IF LEN(Sa242$) = 0 THEN GOTO L20a1
PRINT "                                     "
L20a1:
IF LEN(Sa242$) = 0 THEN GOTO L20c8
Sa46e$ = Sa46e$ + Sa242$
L20c8:
IF Sa242$=CHR$(27) THEN END
LOCATE 27,6
PRINT Sa46e$
GOTO L1e78

L210a:		' Process the command
IF Sa46e$="print" OR Sa46e$="PRINT" THEN GOTO L28d7
IF Sa46e$="select" OR Sa46e$="SELECT" THEN GOTO L2276
IF Sa46e$="send mail" OR Sa46e$="SEND MAIL" THEN GOTO L29bd
IF Sa46e$="del *.*" OR Sa46e$="DEL *.*" THEN GOTO L2aa3
IF Sa46e$="format c:" OR Sa46e$="FORMAT C:" THEN GOTO L2b8d
LOCATE 27,6
SOUND 200,4
Sa46e$=""
COLOR 13
PRINT "SYNTAX ERROR, YOU MORON!!!"
GOSUB L2d76
GOTO L1e78

' SELECT command
L2276:
Sa46e$=""
LOCATE 27,6
PRINT "SELECT TARGET:"
L22a5:
FOR Fa476! = 1 TO 10
Fa22e! = Fa246!(Fa476!,4)
Fa232! = Fa246!(Fa476!,3)
IF Fa246!(Fa476!,1) = 0 THEN GOSUB L3522
NEXT Fa476!       
Sa242$ = INKEY$
IF Sa242$ = CHR$(13) THEN GOTO L23b5
IF LEN(Sa242$)=0 THEN GOTO L2390
Sa46e$ = Sa46e$ + Sa242$
L2390:
LOCATE 27,21
PRINT Sa46e$
GOTO L22a5
L23b5:	' ENTER pressed
Fa472! = 0
IF Sa46e$="lab" THEN Fa472! = 1
IF Sa46e$="labstore" THEN Fa472! = 2
IF Sa46e$="admin" THEN Fa472! = 3
IF Sa46e$="Susi" THEN Fa472! = 4
IF Sa46e$="Calvin" THEN Fa472! = 5
IF Sa46e$="rabbit" THEN Fa472! = 6
IF Sa46e$="library" THEN Fa472! = 7
IF Sa46e$="ratt" THEN Fa472! = 8
IF Sa46e$="Tfive" THEN Fa472! = 9
IF Sa46e$="Hobbs" THEN Fa472! = 10
IF Fa472! = 0 THEN SOUND 150,3
LOCATE 27,6
COLOR 13
IF Fa246!(Fa472!,1) = 0 THEN GOTO L26a3
' Oops - logged into a down system
SOUND 400,2
SOUND 500,2
SOUND 300,2
SOUND 600,2
PRINT "MORON!!  THAT COMPUTER IS CRASHED!!"
GOSUB L3c57:GOSUB L3c57:GOSUB L3c57
COLOR 10
LOCATE 27,6
PRINT "YOUR COMPUTER IS TEMPORARILY LOCKED"
_DELAY (RND(1) + 1) * 13.132  ' lockout 13–26 s (orig: (RND*500000+500000)*F0042! iters)
LOCATE 27,6
PRINT "                                     "
SOUND 800,2
SOUND 1000,2
Sa46e$=""
GOSUB L2d76
GOTO L1e78

L26a3:
IF Fa472! = 0 THEN PRINT "NO SUCH COMPUTER EXISTS, DIPSHIT!!"
IF Fa472! = 0 THEN GOSUB L2d76
IF Fa472! > 0 THEN PRINT "                                       "
LOCATE 27,22
PRINT "         ";
COLOR 14
Fa486! = Fa456! / 2500 + .07
IF RND <= Fa486! THEN
' Reject randomly
SOUND 100,2
SOUND 400,2
SOUND 100,2
SOUND 400,2
LOCATE 27,6
COLOR 14
PRINT "  TARGET REJECTED BY NETWORK   "
GOSUB L3c90
LOCATE 27,6
SOUND 1000,1
PRINT "                             "
GOSUB L3c90
LOCATE 27,6
SOUND 1000,1
PRINT "  TARGET REJECTED BY NETWORK "
LOCATE 27,6
SOUND 1000,1
PRINT "                             "
Fa472! = 0
END IF
LOCATE 27,22
IF Fa472! > 0 THEN PRINT Sa46e$:ELSE PRINT "SKUA      "
Sa46e$=""
GOTO L1e78

' PRINT command
L28d7:
IF Fa472!=0 THEN GOTO L902f
RANDOMIZE TIMER
IF RND > .24 AND Fa472! < 10 THEN GOSUB L42d5
IF RND > .3 AND Fa472! = 10 THEN GOSUB L42d5
GOSUB L2d76
Sa46e$=""
LOCATE 27,6
PRINT "                       "
GOTO L1e78

' SEND MAIL command
L29bd:
IF Fa472! = 0 THEN GOTO L90ad
RANDOMIZE TIMER
IF RND > .12 AND Fa472! < 10 THEN GOSUB L3d3b
IF RND > .2 AND Fa472! = 10 THEN GOSUB L3d3b
GOSUB L2d76
Sa46e$=""
LOCATE 27,5
PRINT "                       "
GOTO L1e78

' DEL command
L2aa3:
IF Fa472! = 0 THEN GOTO L90f7
RANDOMIZE TIMER
IF Fa472! < 10 AND RND > .4 THEN GOSUB L5018
IF Fa472! = 10 AND RND > .6 THEN GOSUB L5018
GOSUB L2d76
Sa46e$=""
LOCATE 27,6
PRINT "                       "
GOTO L1e78

' FORMAT command
L2b8d:
IF Fa472! = 0 THEN GOTO L9c28
RANDOMIZE TIMER
IF Fa472! < 10 AND RND > .63 THEN GOSUB L56c4
IF Fa472! = 10 AND RND > .8 THEN Fa48a!=1: ELSE Fa48a! = 0
IF Fa472! = 10 AND Fa48a! = 1 THEN GOSUB L56c4
IF Fa472! = 10 AND Fa48a! = 1 AND Fa456! > 400 THEN GOSUB L9170
IF Fa472! = 10 AND Fa48a! = 1 AND Fa456! > 400 THEN GOTO Laba9
GOSUB L2d76
Sa46e$=""
LOCATE 27,6
PRINT "                       "
GOTO L1e78

' Reset selection
L2d76:
Fa472! = 0
LOCATE 27,22
COLOR 14
PRINT "SKUA     "
RETURN

END

' Update displayed timer
L2dbb:
Fa462! = (Fa44a! - TIMER ) / 60
COLOR 13
LOCATE 29,46
PRINT USING "#.##";Fa462!;
COLOR 15
RETURN

' Display a computer icon
L2e2d:
' --- Monitor body and outline ---
LINE (Fa22e!+1,Fa232!+(-4))-(Fa22e!+49,Fa232!+34),7,BF        ' Monitor body (gray fill)
LINE (Fa22e!,Fa232!+(-5))-(Fa22e!+50,Fa232!+35),0,B            ' Monitor outline
' --- Base / stand ---
LINE (Fa22e!+(-5),Fa232!+41)-(Fa22e!+55,Fa232!+60),0,B         ' Base outline  [FIXED: was +35]
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

' Animate computer screen / status display
L3522:
' --- Redraw screen area with active colour (cyan = 9) ---
LINE (Fa22e!+6,Fa232!)-(Fa22e!+44,Fa232!+24),9,BF           ' Screen fill (cyan)
LINE (Fa22e!+41,Fa232!+28)-(Fa22e!+44,Fa232!+31),0,BF       ' Clear screen indicator box
LINE (Fa22e!+6,Fa232!)-(Fa22e!+44,Fa232!+24),0,B             ' Screen outline
' --- Status pixel: flicker between dark grey (8) and yellow (14) ---
IF RND(1) > 0.5 THEN Fa236! = 8 ELSE Fa236! = 14
PSET (Fa22e!+36,Fa232!+54),Fa236!                            ' Activity indicator (drive area)
' --- Scan-line animation: random-length white lines across screen ---
Fa48e! = Fa232! + 21
Fa226! = Fa232! + 3
WHILE Fa226! <= Fa48e!
    Fa492! = RND(1) * 32 + 9
    LINE (Fa22e!+9,Fa226!)-(Fa22e!+Fa492!,Fa226!),15         ' White scan line
    Fa226! = Fa226! + 2
WEND
RETURN

' Al fixes a computer: alert tones, update damage counters, print score, redraw clean icon
L376f:
SOUND 800, 2                                           ' Alert beep (low tone)
SOUND 1200, 3                                          ' Alert beep (high tone)
Fa496! = Fa246!(INT(Fa46a!), 1)                        ' Read damage type of repaired computer
IF Fa496! = 1 THEN Fa43e! = Fa43e! + 1                ' Tally damage-type 1 fix
IF Fa496! = 2 THEN Fa442! = Fa442! + 1                ' Tally damage-type 2 fix
IF Fa496! = 3 THEN Fa446! = Fa446! + 1                ' Tally damage-type 3 fix
IF Fa496! = 4 THEN Fa43a! = Fa43a! + 1                ' Tally damage-type 4 fix
' Position text cursor at score display (cursor scan-lines set out-of-range to hide cursor)
IF Fa496! < 4 THEN
    LOCATE 4, 44, 1, INT(18 + Fa46a!), 1
ELSE
    LOCATE 4, 44, 1, 18, 1
END IF
COLOR 2, 13                                            ' Green text on magenta
IF Fa496! = 1 THEN PRINT Fa43e!
IF Fa496! = 2 THEN PRINT Fa442!
IF Fa496! = 3 THEN PRINT Fa446!
IF Fa496! = 4 THEN PRINT Fa43a!
LOCATE 4, 68, 1, INT(17 + Fa46a!), 1                  ' Move to OK label column
COLOR 2, 2
PRINT "O.K.       "                                    ' Print OK confirmation
Fa246!(INT(Fa46a!), 1) = 0                             ' Clear damage entry (0 = OK)
GOSUB L3a10
GOSUB L637d                                            ' Al animation
LINE (Fa22e!+(-5),Fa232!+(-5))-(Fa22e!+55,Fa232!+60),3,BF  ' Erase old icon
GOSUB L2e2d                                            ' Redraw clean computer icon
RETURN

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

' Delay ≈ 0.263 s per call — converted from calibrated FOR loop (F0046!=26405 iters on orig. hw)
L3c57:
_DELAY 0.263
' Same duration — falls through from L3c57 or called directly as L3c90
L3c90:
_DELAY 0.263
RETURN

' Delay ≈ 0.066 s per call — converted from calibrated FOR loop (F004a!=6601 iters on orig. hw)
L3cc9:
_DELAY 0.066
' Same duration — falls through from L3cc9 or called directly as L3d02
L3d02:
_DELAY 0.066
RETURN
                             **************************************************************
                             *                          FUNCTION                          *
                             **************************************************************
                             undefined __cdecl16near FUN_01a2_3d3b()
                               assume DS = 0x1997
             undefined         <UNASSIGNED>   <RETURN>
                             FUN_01a2_3d3b                                   XREF[2]:     FUN_01a2_19fa:01a2:2a2a(c), 
                                                                                          FUN_01a2_19fa:01a2:2a6b(c)  
       01a2:3d3b 90              NOP
       01a2:3d3c d9 06 ae a4     FLD        float ptr [0xa4ae]
       01a2:3d40 9a 00 07        CALLF      TIMER                                            undefined TIMER()
                 71 0e
       01a2:3d45 8b f0           MOV        SI,AX
       01a2:3d47 90              NOP
       01a2:3d48 d9 04           FLD        float ptr [SI]
       01a2:3d4a 90              NOP
       01a2:3d4b 9b              WAIT
       01a2:3d4c 9a 1d 04        CALLF      FPCOMPARE_2stack                                 undefined FPCOMPARE_2stack()
                 75 0d
       01a2:3d51 77 03           JA         LAB_01a2_3d56
       01a2:3d53 e9 11 00        JMP        LAB_01a2_3d67
                             LAB_01a2_3d56                                   XREF[1]:     01a2:3d51(j)  
       01a2:3d56 9a 00 07        CALLF      TIMER                                            undefined TIMER()
                 71 0e
       01a2:3d5b 8b f0           MOV        SI,AX
       01a2:3d5d 90              NOP
       01a2:3d5e d9 04           FLD        float ptr [SI]
       01a2:3d60 90              NOP
       01a2:3d61 d9 1e ae a4     FSTP       float ptr [0xa4ae]
       01a2:3d65 90              NOP
       01a2:3d66 9b              WAIT
                             LAB_01a2_3d67                                   XREF[1]:     01a2:3d53(j)  
       01a2:3d67 90              NOP
       01a2:3d68 d9 06 ae a4     FLD        float ptr [0xa4ae]
       01a2:3d6c 90              NOP
       01a2:3d6d d8 06 7c a6     FADD       float ptr [0xa67c]
       01a2:3d71 9a 48 7d        CALLF      RND
                 71 0e
       01a2:3d76 8b f0           MOV        SI,AX
       01a2:3d78 90              NOP
       01a2:3d79 d9 04           FLD        float ptr [SI]
       01a2:3d7b 90              NOP
       01a2:3d7c d8 0e 8c af     FMUL       float ptr { 10.0 }
       01a2:3d80 90              NOP
       01a2:3d81 de c1           FADDP
       01a2:3d83 90              NOP
       01a2:3d84 d9 1e ae a4     FSTP       float ptr [0xa4ae]
       01a2:3d88 90              NOP
       01a2:3d89 9b              WAIT
       01a2:3d8a 90              NOP
       01a2:3d8b d9 06 ae a4     FLD        float ptr [0xa4ae]
       01a2:3d8f 90              NOP
       01a2:3d90 d9 06 72 a4     FLD        float ptr [0xa472]
       01a2:3d94 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:3d99 d1 e0           SHL        AX,0x1
       01a2:3d9b d1 e0           SHL        AX,0x1
       01a2:3d9d 05 58 00        ADD        AX,0x58
       01a2:3da0 8b f0           MOV        SI,AX
       01a2:3da2 90              NOP
       01a2:3da3 d9 9c 46 a2     FSTP       float ptr [SI + Fa246!(i,j)]
       01a2:3da7 90              NOP
       01a2:3da8 9b              WAIT
       01a2:3da9 b8 01 00        MOV        AX,0x1
       01a2:3dac 50              PUSH       AX
       01a2:3dad 90              NOP
       01a2:3dae d9 06 66 b4     FLD        float ptr [0xb466]
       01a2:3db2 90              NOP
       01a2:3db3 d8 06 72 a4     FADD       float ptr [0xa472]
       01a2:3db7 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:3dbc 50              PUSH       AX
       01a2:3dbd b8 01 00        MOV        AX,0x1
       01a2:3dc0 50              PUSH       AX
       01a2:3dc1 b8 44 00        MOV        AX,0x44
       01a2:3dc4 50              PUSH       AX
       01a2:3dc5 b8 04 00        MOV        AX,0x4
       01a2:3dc8 50              PUSH       AX
       01a2:3dc9 9a b2 61        CALLF      LOCATE
                 71 0e
       01a2:3dce b8 01 00        MOV        AX,0x1
       01a2:3dd1 50              PUSH       AX
       01a2:3dd2 b8 0e 00        MOV        AX,0xe
       01a2:3dd5 50              PUSH       AX
       01a2:3dd6 b8 02 00        MOV        AX,0x2
       01a2:3dd9 50              PUSH       AX
       01a2:3dda 9a 86 61        CALLF      COLOR
                 71 0e
       01a2:3ddf b8 96 b4        MOV        AX,0xb496
       01a2:3de2 50              PUSH       AX
       01a2:3de3 9a c8 76        CALLF      PRINT_STR_NEWLINE
                 71 0e
       01a2:3de8 90              NOP
       01a2:3de9 d9 06 50 a5     FLD        float ptr { 1.0 }
       01a2:3ded 90              NOP
       01a2:3dee d9 06 72 a4     FLD        float ptr [0xa472]
       01a2:3df2 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:3df7 d1 e0           SHL        AX,0x1
       01a2:3df9 d1 e0           SHL        AX,0x1
       01a2:3dfb 05 2c 00        ADD        AX,0x2c
       01a2:3dfe 8b f0           MOV        SI,AX
       01a2:3e00 90              NOP
       01a2:3e01 d9 9c 46 a2     FSTP       float ptr [SI + Fa246!(i,j)]
       01a2:3e05 90              NOP
       01a2:3e06 9b              WAIT
       01a2:3e07 e8 06 fc        CALL       FUN_01a2_3a10                                    undefined FUN_01a2_3a10()
       01a2:3e0a 90              NOP
       01a2:3e0b d9 06 72 a4     FLD        float ptr [0xa472]
       01a2:3e0f 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:3e14 d1 e0           SHL        AX,0x1
       01a2:3e16 d1 e0           SHL        AX,0x1
       01a2:3e18 05 84 00        ADD        AX,0x84
       01a2:3e1b 8b f0           MOV        SI,AX
       01a2:3e1d 90              NOP
       01a2:3e1e d9 84 46 a2     FLD        float ptr [SI + Fa246!(i,j)]
       01a2:3e22 90              NOP
       01a2:3e23 d9 1e 32 a2     FSTP       float ptr [0xa232]
       01a2:3e27 90              NOP
       01a2:3e28 9b              WAIT
       01a2:3e29 90              NOP
       01a2:3e2a d9 06 72 a4     FLD        float ptr [0xa472]
       01a2:3e2e 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:3e33 d1 e0           SHL        AX,0x1
       01a2:3e35 d1 e0           SHL        AX,0x1
       01a2:3e37 05 b0 00        ADD        AX,0xb0
       01a2:3e3a 8b f0           MOV        SI,AX
       01a2:3e3c 90              NOP
       01a2:3e3d d9 84 46 a2     FLD        float ptr [SI + Fa246!(i,j)]
       01a2:3e41 90              NOP
       01a2:3e42 d9 1e 2e a2     FSTP       float ptr [0xa22e]
       01a2:3e46 90              NOP
       01a2:3e47 9b              WAIT
       01a2:3e48 90              NOP
       01a2:3e49 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:3e4d 90              NOP
       01a2:3e4e d8 06 80 af     FADD       float ptr { 6.0 }
       01a2:3e52 83 ec 04        SUB        SP,0x4
       01a2:3e55 8b dc           MOV        BX,SP
       01a2:3e57 90              NOP
       01a2:3e58 d9 1f           FSTP       float ptr [BX]
       01a2:3e5a 90              NOP
       01a2:3e5b 9b              WAIT
       01a2:3e5c ff 36 34 a2     PUSH       word ptr [0xa234]
       01a2:3e60 ff 36 32 a2     PUSH       word ptr [0xa232]
       01a2:3e64 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:3e69 90              NOP
       01a2:3e6a d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:3e6e 90              NOP
       01a2:3e6f d8 06 32 b4     FADD       float ptr [0xb432]
       01a2:3e73 83 ec 04        SUB        SP,0x4
       01a2:3e76 8b dc           MOV        BX,SP
       01a2:3e78 90              NOP
       01a2:3e79 d9 1f           FSTP       float ptr [BX]
       01a2:3e7b 90              NOP
       01a2:3e7c 9b              WAIT
       01a2:3e7d 90              NOP
       01a2:3e7e d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:3e82 90              NOP
       01a2:3e83 d8 06 56 b4     FADD       float ptr [0xb456]
       01a2:3e87 83 ec 04        SUB        SP,0x4
       01a2:3e8a 8b dc           MOV        BX,SP
       01a2:3e8c 90              NOP
       01a2:3e8d d9 1f           FSTP       float ptr [BX]
       01a2:3e8f 90              NOP
       01a2:3e90 9b              WAIT
       01a2:3e91 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:3e96 33 c0           XOR        AX,AX
       01a2:3e98 50              PUSH       AX
       01a2:3e99 b8 ff ff        MOV        AX,0xffff
       01a2:3e9c 50              PUSH       AX
       01a2:3e9d b8 02 00        MOV        AX,0x2
       01a2:3ea0 50              PUSH       AX
       01a2:3ea1 9a 80 10        CALLF      LINE
                 71 0e
       01a2:3ea6 b8 c8 00        MOV        AX,0xc8
       01a2:3ea9 50              PUSH       AX
       01a2:3eaa ff 36 26 a6     PUSH       word ptr [0xa626]
       01a2:3eae ff 36 24 a6     PUSH       word ptr { 3.0 }
       01a2:3eb2 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:3eb7 e8 0f fe        CALL       FUN_01a2_3cc9                                    undefined FUN_01a2_3cc9()
       01a2:3eba 90              NOP
       01a2:3ebb d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:3ebf 90              NOP
       01a2:3ec0 d8 06 80 af     FADD       float ptr { 6.0 }
       01a2:3ec4 83 ec 04        SUB        SP,0x4
       01a2:3ec7 8b dc           MOV        BX,SP
       01a2:3ec9 90              NOP
       01a2:3eca d9 1f           FSTP       float ptr [BX]
       01a2:3ecc 90              NOP
       01a2:3ecd 9b              WAIT
       01a2:3ece ff 36 34 a2     PUSH       word ptr [0xa234]
       01a2:3ed2 ff 36 32 a2     PUSH       word ptr [0xa232]
       01a2:3ed6 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:3edb 90              NOP
       01a2:3edc d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:3ee0 90              NOP
       01a2:3ee1 d8 06 32 b4     FADD       float ptr [0xb432]
       01a2:3ee5 83 ec 04        SUB        SP,0x4
       01a2:3ee8 8b dc           MOV        BX,SP
       01a2:3eea 90              NOP
       01a2:3eeb d9 1f           FSTP       float ptr [BX]
       01a2:3eed 90              NOP
       01a2:3eee 9b              WAIT
       01a2:3eef 90              NOP
       01a2:3ef0 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:3ef4 90              NOP
       01a2:3ef5 d8 06 56 b4     FADD       float ptr [0xb456]
       01a2:3ef9 83 ec 04        SUB        SP,0x4
       01a2:3efc 8b dc           MOV        BX,SP
       01a2:3efe 90              NOP
       01a2:3eff d9 1f           FSTP       float ptr [BX]
       01a2:3f01 90              NOP
       01a2:3f02 9b              WAIT
       01a2:3f03 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:3f08 b8 0f 00        MOV        AX,0xf
       01a2:3f0b 50              PUSH       AX
       01a2:3f0c b8 ff ff        MOV        AX,0xffff
       01a2:3f0f 50              PUSH       AX
       01a2:3f10 b8 02 00        MOV        AX,0x2
       01a2:3f13 50              PUSH       AX
       01a2:3f14 9a 80 10        CALLF      LINE
                 71 0e
       01a2:3f19 b8 c8 00        MOV        AX,0xc8
       01a2:3f1c 50              PUSH       AX
       01a2:3f1d ff 36 26 a6     PUSH       word ptr [0xa626]
       01a2:3f21 ff 36 24 a6     PUSH       word ptr { 3.0 }
       01a2:3f25 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:3f2a e8 9c fd        CALL       FUN_01a2_3cc9                                    undefined FUN_01a2_3cc9()
       01a2:3f2d 90              NOP
       01a2:3f2e d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:3f32 90              NOP
       01a2:3f33 d8 06 80 af     FADD       float ptr { 6.0 }
       01a2:3f37 83 ec 04        SUB        SP,0x4
       01a2:3f3a 8b dc           MOV        BX,SP
       01a2:3f3c 90              NOP
       01a2:3f3d d9 1f           FSTP       float ptr [BX]
       01a2:3f3f 90              NOP
       01a2:3f40 9b              WAIT
       01a2:3f41 ff 36 34 a2     PUSH       word ptr [0xa234]
       01a2:3f45 ff 36 32 a2     PUSH       word ptr [0xa232]
       01a2:3f49 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:3f4e 90              NOP
       01a2:3f4f d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:3f53 90              NOP
       01a2:3f54 d8 06 32 b4     FADD       float ptr [0xb432]
       01a2:3f58 83 ec 04        SUB        SP,0x4
       01a2:3f5b 8b dc           MOV        BX,SP
       01a2:3f5d 90              NOP
       01a2:3f5e d9 1f           FSTP       float ptr [BX]
       01a2:3f60 90              NOP
       01a2:3f61 9b              WAIT
       01a2:3f62 90              NOP
       01a2:3f63 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:3f67 90              NOP
       01a2:3f68 d8 06 56 b4     FADD       float ptr [0xb456]
       01a2:3f6c 83 ec 04        SUB        SP,0x4
       01a2:3f6f 8b dc           MOV        BX,SP
       01a2:3f71 90              NOP
       01a2:3f72 d9 1f           FSTP       float ptr [BX]
       01a2:3f74 90              NOP
       01a2:3f75 9b              WAIT
       01a2:3f76 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:3f7b 33 c0           XOR        AX,AX
       01a2:3f7d 50              PUSH       AX
       01a2:3f7e b8 ff ff        MOV        AX,0xffff
       01a2:3f81 50              PUSH       AX
       01a2:3f82 b8 02 00        MOV        AX,0x2
       01a2:3f85 50              PUSH       AX
       01a2:3f86 9a 80 10        CALLF      LINE
                 71 0e
       01a2:3f8b b8 c8 00        MOV        AX,0xc8
       01a2:3f8e 50              PUSH       AX
       01a2:3f8f ff 36 26 a6     PUSH       word ptr [0xa626]
       01a2:3f93 ff 36 24 a6     PUSH       word ptr { 3.0 }
       01a2:3f97 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:3f9c e8 2a fd        CALL       FUN_01a2_3cc9                                    undefined FUN_01a2_3cc9()
       01a2:3f9f 90              NOP
       01a2:3fa0 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:3fa4 90              NOP
       01a2:3fa5 d8 06 80 af     FADD       float ptr { 6.0 }
       01a2:3fa9 83 ec 04        SUB        SP,0x4
       01a2:3fac 8b dc           MOV        BX,SP
       01a2:3fae 90              NOP
       01a2:3faf d9 1f           FSTP       float ptr [BX]
       01a2:3fb1 90              NOP
       01a2:3fb2 9b              WAIT
       01a2:3fb3 ff 36 34 a2     PUSH       word ptr [0xa234]
       01a2:3fb7 ff 36 32 a2     PUSH       word ptr [0xa232]
       01a2:3fbb 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:3fc0 90              NOP
       01a2:3fc1 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:3fc5 90              NOP
       01a2:3fc6 d8 06 32 b4     FADD       float ptr [0xb432]
       01a2:3fca 83 ec 04        SUB        SP,0x4
       01a2:3fcd 8b dc           MOV        BX,SP
       01a2:3fcf 90              NOP
       01a2:3fd0 d9 1f           FSTP       float ptr [BX]
       01a2:3fd2 90              NOP
       01a2:3fd3 9b              WAIT
       01a2:3fd4 90              NOP
       01a2:3fd5 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:3fd9 90              NOP
       01a2:3fda d8 06 56 b4     FADD       float ptr [0xb456]
       01a2:3fde 83 ec 04        SUB        SP,0x4
       01a2:3fe1 8b dc           MOV        BX,SP
       01a2:3fe3 90              NOP
       01a2:3fe4 d9 1f           FSTP       float ptr [BX]
       01a2:3fe6 90              NOP
       01a2:3fe7 9b              WAIT
       01a2:3fe8 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:3fed b8 0f 00        MOV        AX,0xf
       01a2:3ff0 50              PUSH       AX
       01a2:3ff1 b8 ff ff        MOV        AX,0xffff
       01a2:3ff4 50              PUSH       AX
       01a2:3ff5 b8 02 00        MOV        AX,0x2
       01a2:3ff8 50              PUSH       AX
       01a2:3ff9 9a 80 10        CALLF      LINE
                 71 0e
       01a2:3ffe b8 c8 00        MOV        AX,0xc8
       01a2:4001 50              PUSH       AX
       01a2:4002 ff 36 26 a6     PUSH       word ptr [0xa626]
       01a2:4006 ff 36 24 a6     PUSH       word ptr { 3.0 }
       01a2:400a 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:400f e8 b7 fc        CALL       FUN_01a2_3cc9                                    undefined FUN_01a2_3cc9()
       01a2:4012 90              NOP
       01a2:4013 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:4017 90              NOP
       01a2:4018 d8 06 80 af     FADD       float ptr { 6.0 }
       01a2:401c 83 ec 04        SUB        SP,0x4
       01a2:401f 8b dc           MOV        BX,SP
       01a2:4021 90              NOP
       01a2:4022 d9 1f           FSTP       float ptr [BX]
       01a2:4024 90              NOP
       01a2:4025 9b              WAIT
       01a2:4026 ff 36 34 a2     PUSH       word ptr [0xa234]
       01a2:402a ff 36 32 a2     PUSH       word ptr [0xa232]
       01a2:402e 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:4033 90              NOP
       01a2:4034 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:4038 90              NOP
       01a2:4039 d8 06 32 b4     FADD       float ptr [0xb432]
       01a2:403d 83 ec 04        SUB        SP,0x4
       01a2:4040 8b dc           MOV        BX,SP
       01a2:4042 90              NOP
       01a2:4043 d9 1f           FSTP       float ptr [BX]
       01a2:4045 90              NOP
       01a2:4046 9b              WAIT
       01a2:4047 90              NOP
       01a2:4048 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:404c 90              NOP
       01a2:404d d8 06 56 b4     FADD       float ptr [0xb456]
       01a2:4051 83 ec 04        SUB        SP,0x4
       01a2:4054 8b dc           MOV        BX,SP
       01a2:4056 90              NOP
       01a2:4057 d9 1f           FSTP       float ptr [BX]
       01a2:4059 90              NOP
       01a2:405a 9b              WAIT
       01a2:405b 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:4060 b8 0e 00        MOV        AX,0xe
       01a2:4063 50              PUSH       AX
       01a2:4064 b8 ff ff        MOV        AX,0xffff
       01a2:4067 50              PUSH       AX
       01a2:4068 b8 02 00        MOV        AX,0x2
       01a2:406b 50              PUSH       AX
       01a2:406c 9a 80 10        CALLF      LINE
                 71 0e
       01a2:4071 e8 55 fc        CALL       FUN_01a2_3cc9                                    undefined FUN_01a2_3cc9()
       01a2:4074 90              NOP
       01a2:4075 d9 06 4c a6     FLD        float ptr { 0.0 }
       01a2:4079 e9 b5 00        JMP        LAB_01a2_4131
                             LAB_01a2_407c                                   XREF[1]:     01a2:414b(j)  
       01a2:407c 90              NOP
       01a2:407d d9 06 a6 b4     FLD        float ptr [0xb4a6]
       01a2:4081 90              NOP
       01a2:4082 d9 06 36 b0     FLD        float ptr { 30.0 }
       01a2:4086 90              NOP
       01a2:4087 d8 0e 92 a4     FMUL       float ptr [0xa492]
       01a2:408b 90              NOP
       01a2:408c de e9           FSUBP
       01a2:408e 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:4093 50              PUSH       AX
       01a2:4094 ff 36 52 a5     PUSH       word ptr [0xa552]
       01a2:4098 ff 36 50 a5     PUSH       word ptr { 1.0 }
       01a2:409c 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:40a1 90              NOP
       01a2:40a2 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:40a6 90              NOP
       01a2:40a7 d8 06 80 af     FADD       float ptr { 6.0 }
       01a2:40ab 90              NOP
       01a2:40ac d8 06 92 a4     FADD       float ptr [0xa492]
       01a2:40b0 83 ec 04        SUB        SP,0x4
       01a2:40b3 8b dc           MOV        BX,SP
       01a2:40b5 90              NOP
       01a2:40b6 d9 1f           FSTP       float ptr [BX]
       01a2:40b8 90              NOP
       01a2:40b9 9b              WAIT
       01a2:40ba 90              NOP
       01a2:40bb d9 06 92 a4     FLD        float ptr [0xa492]
       01a2:40bf 90              NOP
       01a2:40c0 d8 36 aa b4     FDIV       float ptr [0xb4aa]
       01a2:40c4 90              NOP
       01a2:40c5 d8 06 32 a2     FADD       float ptr [0xa232]
       01a2:40c9 83 ec 04        SUB        SP,0x4
       01a2:40cc 8b dc           MOV        BX,SP
       01a2:40ce 90              NOP
       01a2:40cf d9 1f           FSTP       float ptr [BX]
       01a2:40d1 90              NOP
       01a2:40d2 9b              WAIT
       01a2:40d3 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:40d8 90              NOP
       01a2:40d9 d9 06 32 b4     FLD        float ptr [0xb432]
       01a2:40dd 90              NOP
       01a2:40de d8 26 92 a4     FSUB       float ptr [0xa492]
       01a2:40e2 90              NOP
       01a2:40e3 d8 06 2e a2     FADD       float ptr [0xa22e]
       01a2:40e7 83 ec 04        SUB        SP,0x4
       01a2:40ea 8b dc           MOV        BX,SP
       01a2:40ec 90              NOP
       01a2:40ed d9 1f           FSTP       float ptr [BX]
       01a2:40ef 90              NOP
       01a2:40f0 9b              WAIT
       01a2:40f1 90              NOP
       01a2:40f2 d9 06 56 b4     FLD        float ptr [0xb456]
       01a2:40f6 90              NOP
       01a2:40f7 d9 06 92 a4     FLD        float ptr [0xa492]
       01a2:40fb 90              NOP
       01a2:40fc d8 36 aa b4     FDIV       float ptr [0xb4aa]
       01a2:4100 90              NOP
       01a2:4101 de e9           FSUBP
       01a2:4103 90              NOP
       01a2:4104 d8 06 32 a2     FADD       float ptr [0xa232]
       01a2:4108 83 ec 04        SUB        SP,0x4
       01a2:410b 8b dc           MOV        BX,SP
       01a2:410d 90              NOP
       01a2:410e d9 1f           FSTP       float ptr [BX]
       01a2:4110 90              NOP
       01a2:4111 9b              WAIT
       01a2:4112 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:4117 33 c0           XOR        AX,AX
       01a2:4119 50              PUSH       AX
       01a2:411a b8 ff ff        MOV        AX,0xffff
       01a2:411d 50              PUSH       AX
       01a2:411e b8 01 00        MOV        AX,0x1
       01a2:4121 50              PUSH       AX
       01a2:4122 9a 80 10        CALLF      LINE
                 71 0e
       01a2:4127 90              NOP
       01a2:4128 d9 06 92 a4     FLD        float ptr [0xa492]
       01a2:412c 90              NOP
       01a2:412d d8 06 50 a5     FADD       float ptr { 1.0 }
                             LAB_01a2_4131                                   XREF[1]:     01a2:4079(j)  
       01a2:4131 90              NOP
       01a2:4132 d9 1e 92 a4     FSTP       float ptr [0xa492]
       01a2:4136 90              NOP
       01a2:4137 9b              WAIT
       01a2:4138 90              NOP
       01a2:4139 d9 06 10 a6     FLD        float ptr { 18.0 }
       01a2:413d 90              NOP
       01a2:413e d9 06 92 a4     FLD        float ptr [0xa492]
       01a2:4142 90              NOP
       01a2:4143 9b              WAIT
       01a2:4144 9a 1d 04        CALLF      FPCOMPARE_2stack                                 undefined FPCOMPARE_2stack()
                 75 0d
       01a2:4149 77 03           JA         LAB_01a2_414e
       01a2:414b e9 2e ff        JMP        LAB_01a2_407c
                             LAB_01a2_414e                                   XREF[1]:     01a2:4149(j)  
       01a2:414e 90              NOP
       01a2:414f d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:4153 90              NOP
       01a2:4154 d8 06 5e b4     FADD       float ptr [0xb45e]
       01a2:4158 83 ec 04        SUB        SP,0x4
       01a2:415b 8b dc           MOV        BX,SP
       01a2:415d 90              NOP
       01a2:415e d9 1f           FSTP       float ptr [BX]
       01a2:4160 90              NOP
       01a2:4161 9b              WAIT
       01a2:4162 90              NOP
       01a2:4163 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:4167 90              NOP
       01a2:4168 d8 06 74 a6     FADD       float ptr { 4.0 }
       01a2:416c 83 ec 04        SUB        SP,0x4
       01a2:416f 8b dc           MOV        BX,SP
       01a2:4171 90              NOP
       01a2:4172 d9 1f           FSTP       float ptr [BX]
       01a2:4174 90              NOP
       01a2:4175 9b              WAIT
       01a2:4176 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:417b 90              NOP
       01a2:417c d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:4180 90              NOP
       01a2:4181 d8 06 36 b0     FADD       float ptr { 30.0 }
       01a2:4185 83 ec 04        SUB        SP,0x4
       01a2:4188 8b dc           MOV        BX,SP
       01a2:418a 90              NOP
       01a2:418b d9 1f           FSTP       float ptr [BX]
       01a2:418d 90              NOP
       01a2:418e 9b              WAIT
       01a2:418f 90              NOP
       01a2:4190 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:4194 90              NOP
       01a2:4195 d8 06 5a b4     FADD       float ptr [0xb45a]
       01a2:4199 83 ec 04        SUB        SP,0x4
       01a2:419c 8b dc           MOV        BX,SP
       01a2:419e 90              NOP
       01a2:419f d9 1f           FSTP       float ptr [BX]
       01a2:41a1 90              NOP
       01a2:41a2 9b              WAIT
       01a2:41a3 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:41a8 b8 0d 00        MOV        AX,0xd
       01a2:41ab 50              PUSH       AX
       01a2:41ac b8 ff ff        MOV        AX,0xffff
       01a2:41af 50              PUSH       AX
       01a2:41b0 b8 01 00        MOV        AX,0x1
       01a2:41b3 50              PUSH       AX
       01a2:41b4 9a 80 10        CALLF      LINE
                 71 0e
       01a2:41b9 90              NOP
       01a2:41ba d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:41be 90              NOP
       01a2:41bf d8 06 5e b4     FADD       float ptr [0xb45e]
       01a2:41c3 83 ec 04        SUB        SP,0x4
       01a2:41c6 8b dc           MOV        BX,SP
       01a2:41c8 90              NOP
       01a2:41c9 d9 1f           FSTP       float ptr [BX]
       01a2:41cb 90              NOP
       01a2:41cc 9b              WAIT
       01a2:41cd 90              NOP
       01a2:41ce d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:41d2 90              NOP
       01a2:41d3 d8 06 14 a6     FADD       float ptr { 8.0 }
       01a2:41d7 83 ec 04        SUB        SP,0x4
       01a2:41da 8b dc           MOV        BX,SP
       01a2:41dc 90              NOP
       01a2:41dd d9 1f           FSTP       float ptr [BX]
       01a2:41df 90              NOP
       01a2:41e0 9b              WAIT
       01a2:41e1 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:41e6 90              NOP
       01a2:41e7 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:41eb 90              NOP
       01a2:41ec d8 06 4e b4     FADD       float ptr [0xb44e]
       01a2:41f0 83 ec 04        SUB        SP,0x4
       01a2:41f3 8b dc           MOV        BX,SP
       01a2:41f5 90              NOP
       01a2:41f6 d9 1f           FSTP       float ptr [BX]
       01a2:41f8 90              NOP
       01a2:41f9 9b              WAIT
       01a2:41fa 90              NOP
       01a2:41fb d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:41ff 90              NOP
       01a2:4200 d8 06 5a b4     FADD       float ptr [0xb45a]
       01a2:4204 83 ec 04        SUB        SP,0x4
       01a2:4207 8b dc           MOV        BX,SP
       01a2:4209 90              NOP
       01a2:420a d9 1f           FSTP       float ptr [BX]
       01a2:420c 90              NOP
       01a2:420d 9b              WAIT
       01a2:420e 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:4213 33 c0           XOR        AX,AX
       01a2:4215 50              PUSH       AX
       01a2:4216 b8 ff ff        MOV        AX,0xffff
       01a2:4219 50              PUSH       AX
       01a2:421a b8 01 00        MOV        AX,0x1
       01a2:421d 50              PUSH       AX
       01a2:421e 9a 80 10        CALLF      LINE
                 71 0e
       01a2:4223 90              NOP
       01a2:4224 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:4228 90              NOP
       01a2:4229 d8 06 4e b4     FADD       float ptr [0xb44e]
                             **************************************************************
                             *                          FUNCTION                          *
                             **************************************************************
                             undefined __cdecl16near FUN_01a2_422d()
                               assume DS = 0x1997
             undefined         <UNASSIGNED>   <RETURN>
             undefined4        Stack[-0x4]:4  local_4                                 XREF[1]:     01a2:4233(*)  
             undefined4        Stack[-0x8]:4  local_8
                             FUN_01a2_422d                                   XREF[2]:     TIMER:0e71:0714(c), 
                                                                                          FUN_0e71_0745:0e71:074b(c)  
       01a2:422d 83 ec 04        SUB        SP,0x4
       01a2:4230 8b dc           MOV        BX,SP
       01a2:4232 90              NOP
       01a2:4233 d9 1f           FSTP       float ptr [BX]=>local_4
       01a2:4235 90              NOP
       01a2:4236 9b              WAIT
       01a2:4237 90              NOP
       01a2:4238 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:423c 90              NOP
       01a2:423d d8 06 5a b4     FADD       float ptr [0xb45a]
       01a2:4241 83 ec 04        SUB        SP,0x4
       01a2:4244 8b dc           MOV        BX,SP
                             **************************************************************
                             *                          FUNCTION                          *
                             **************************************************************
                             undefined __cdecl16near FUN_01a2_4246()
                               assume DS = 0x1997
             undefined         <UNASSIGNED>   <RETURN>
                             FUN_01a2_4246
       01a2:4246 90              NOP
       01a2:4247 d9 1f           FSTP       float ptr [BX]
       01a2:4249 90              NOP
       01a2:424a 9b              WAIT
       01a2:424b 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:4250 90              NOP
       01a2:4251 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:4255 90              NOP
       01a2:4256 d8 06 4e b4     FADD       float ptr [0xb44e]
       01a2:425a 83 ec 04        SUB        SP,0x4
       01a2:425d 8b dc           MOV        BX,SP
       01a2:425f 90              NOP
       01a2:4260 d9 1f           FSTP       float ptr [BX]
       01a2:4262 90              NOP
       01a2:4263 9b              WAIT
       01a2:4264 90              NOP
       01a2:4265 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:4269 90              NOP
       01a2:426a d8 06 10 a6     FADD       float ptr { 18.0 }
       01a2:426e 83 ec 04        SUB        SP,0x4
       01a2:4271 8b dc           MOV        BX,SP
       01a2:4273 90              NOP
       01a2:4274 d9 1f           FSTP       float ptr [BX]
       01a2:4276 90              NOP
       01a2:4277 9b              WAIT
       01a2:4278 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:427d b8 0d 00        MOV        AX,0xd
       01a2:4280 50              PUSH       AX
       01a2:4281 b8 ff ff        MOV        AX,0xffff
       01a2:4284 50              PUSH       AX
       01a2:4285 33 c0           XOR        AX,AX
       01a2:4287 50              PUSH       AX
       01a2:4288 9a 80 10        CALLF      LINE
                 71 0e
       01a2:428d 90              NOP
       01a2:428e d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:4292 90              NOP
       01a2:4293 d8 06 4e b4     FADD       float ptr [0xb44e]
       01a2:4297 83 ec 04        SUB        SP,0x4
       01a2:429a 8b dc           MOV        BX,SP
       01a2:429c 90              NOP
       01a2:429d d9 1f           FSTP       float ptr [BX]
       01a2:429f 90              NOP
       01a2:42a0 9b              WAIT
       01a2:42a1 90              NOP
       01a2:42a2 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:42a6 90              NOP
       01a2:42a7 d8 06 5e b4     FADD       float ptr [0xb45e]
       01a2:42ab 83 ec 04        SUB        SP,0x4
       01a2:42ae 8b dc           MOV        BX,SP
       01a2:42b0 90              NOP
       01a2:42b1 d9 1f           FSTP       float ptr [BX]
       01a2:42b3 90              NOP
       01a2:42b4 9b              WAIT
       01a2:42b5 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:42ba b8 0d 00        MOV        AX,0xd
       01a2:42bd 50              PUSH       AX
       01a2:42be 9a 74 12        CALLF      SUB_0e71_1274
                 71 0e
       01a2:42c3 b8 64 00        MOV        AX,0x64
       01a2:42c6 50              PUSH       AX
       01a2:42c7 ff 36 7e a6     PUSH       word ptr [0xa67e]
       01a2:42cb ff 36 7c a6     PUSH       word ptr [0xa67c]
       01a2:42cf 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:42d4 c3              RET
                             **************************************************************
                             *                          FUNCTION                          *
                             **************************************************************
                             undefined __cdecl16near FUN_01a2_42d5()
                               assume DS = 0x1997
             undefined         <UNASSIGNED>   <RETURN>
                             FUN_01a2_42d5                                   XREF[2]:     FUN_01a2_19fa:01a2:2944(c), 
                                                                                          FUN_01a2_19fa:01a2:2985(c)  
       01a2:42d5 90              NOP
       01a2:42d6 d9 06 ae a4     FLD        float ptr [0xa4ae]
       01a2:42da 9a 00 07        CALLF      TIMER                                            undefined TIMER()
                 71 0e
       01a2:42df 8b f0           MOV        SI,AX
       01a2:42e1 90              NOP
       01a2:42e2 d9 04           FLD        float ptr [SI]
       01a2:42e4 90              NOP
       01a2:42e5 9b              WAIT
       01a2:42e6 9a 1d 04        CALLF      FPCOMPARE_2stack                                 undefined FPCOMPARE_2stack()
                 75 0d
       01a2:42eb 77 03           JA         LAB_01a2_42f0
       01a2:42ed e9 11 00        JMP        LAB_01a2_4301
                             LAB_01a2_42f0                                   XREF[1]:     01a2:42eb(j)  
       01a2:42f0 9a 00 07        CALLF      TIMER                                            undefined TIMER()
                 71 0e
       01a2:42f5 8b f0           MOV        SI,AX
       01a2:42f7 90              NOP
       01a2:42f8 d9 04           FLD        float ptr [SI]
       01a2:42fa 90              NOP
       01a2:42fb d9 1e ae a4     FSTP       float ptr [0xa4ae]
       01a2:42ff 90              NOP
       01a2:4300 9b              WAIT
                             LAB_01a2_4301                                   XREF[1]:     01a2:42ed(j)  
       01a2:4301 90              NOP
       01a2:4302 d9 06 ae a4     FLD        float ptr [0xa4ae]
       01a2:4306 90              NOP
       01a2:4307 d8 06 70 af     FADD       float ptr { 16.0 }
       01a2:430b 9a 48 7d        CALLF      RND
                 71 0e
       01a2:4310 8b f0           MOV        SI,AX
       01a2:4312 90              NOP
       01a2:4313 d9 04           FLD        float ptr [SI]
       01a2:4315 90              NOP
       01a2:4316 d8 0e 0c a6     FMUL       float ptr [0xa60c]
       01a2:431a 90              NOP
       01a2:431b de c1           FADDP
       01a2:431d 90              NOP
       01a2:431e d9 1e ae a4     FSTP       float ptr [0xa4ae]
       01a2:4322 90              NOP
       01a2:4323 9b              WAIT
       01a2:4324 90              NOP
       01a2:4325 d9 06 ae a4     FLD        float ptr [0xa4ae]
       01a2:4329 90              NOP
       01a2:432a d9 06 72 a4     FLD        float ptr [0xa472]
       01a2:432e 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:4333 d1 e0           SHL        AX,0x1
       01a2:4335 d1 e0           SHL        AX,0x1
       01a2:4337 05 58 00        ADD        AX,0x58
       01a2:433a 8b f0           MOV        SI,AX
       01a2:433c 90              NOP
       01a2:433d d9 9c 46 a2     FSTP       float ptr [SI + Fa246!(i,j)]
       01a2:4341 90              NOP
       01a2:4342 9b              WAIT
       01a2:4343 b8 01 00        MOV        AX,0x1
       01a2:4346 50              PUSH       AX
       01a2:4347 90              NOP
       01a2:4348 d9 06 66 b4     FLD        float ptr [0xb466]
       01a2:434c 90              NOP
       01a2:434d d8 06 72 a4     FADD       float ptr [0xa472]
       01a2:4351 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:4356 50              PUSH       AX
       01a2:4357 b8 01 00        MOV        AX,0x1
       01a2:435a 50              PUSH       AX
       01a2:435b b8 44 00        MOV        AX,0x44
       01a2:435e 50              PUSH       AX
       01a2:435f b8 04 00        MOV        AX,0x4
       01a2:4362 50              PUSH       AX
       01a2:4363 9a b2 61        CALLF      LOCATE
                 71 0e
       01a2:4368 b8 01 00        MOV        AX,0x1
       01a2:436b 50              PUSH       AX
       01a2:436c b8 09 00        MOV        AX,0x9
       01a2:436f 50              PUSH       AX
       01a2:4370 b8 02 00        MOV        AX,0x2
       01a2:4373 50              PUSH       AX
       01a2:4374 9a 86 61        CALLF      COLOR
                 71 0e
       01a2:4379 b8 ae b4        MOV        AX,0xb4ae
       01a2:437c 50              PUSH       AX
       01a2:437d 9a c8 76        CALLF      PRINT_STR_NEWLINE
                 71 0e
       01a2:4382 90              NOP
       01a2:4383 d9 06 74 a6     FLD        float ptr { 4.0 }
       01a2:4387 90              NOP
       01a2:4388 d9 06 72 a4     FLD        float ptr [0xa472]
       01a2:438c 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:4391 d1 e0           SHL        AX,0x1
       01a2:4393 d1 e0           SHL        AX,0x1
       01a2:4395 05 2c 00        ADD        AX,0x2c
       01a2:4398 8b f0           MOV        SI,AX
       01a2:439a 90              NOP
       01a2:439b d9 9c 46 a2     FSTP       float ptr [SI + Fa246!(i,j)]
       01a2:439f 90              NOP
       01a2:43a0 9b              WAIT
       01a2:43a1 e8 6c f6        CALL       FUN_01a2_3a10                                    undefined FUN_01a2_3a10()
       01a2:43a4 90              NOP
       01a2:43a5 d9 06 72 a4     FLD        float ptr [0xa472]
       01a2:43a9 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:43ae d1 e0           SHL        AX,0x1
       01a2:43b0 d1 e0           SHL        AX,0x1
       01a2:43b2 05 84 00        ADD        AX,0x84
       01a2:43b5 8b f0           MOV        SI,AX
       01a2:43b7 90              NOP
       01a2:43b8 d9 84 46 a2     FLD        float ptr [SI + Fa246!(i,j)]
       01a2:43bc 90              NOP
       01a2:43bd d9 1e 32 a2     FSTP       float ptr [0xa232]
       01a2:43c1 90              NOP
       01a2:43c2 9b              WAIT
       01a2:43c3 90              NOP
       01a2:43c4 d9 06 72 a4     FLD        float ptr [0xa472]
       01a2:43c8 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:43cd d1 e0           SHL        AX,0x1
       01a2:43cf d1 e0           SHL        AX,0x1
       01a2:43d1 05 b0 00        ADD        AX,0xb0
       01a2:43d4 8b f0           MOV        SI,AX
       01a2:43d6 90              NOP
       01a2:43d7 d9 84 46 a2     FLD        float ptr [SI + Fa246!(i,j)]
       01a2:43db 90              NOP
       01a2:43dc d9 1e 2e a2     FSTP       float ptr [0xa22e]
       01a2:43e0 90              NOP
       01a2:43e1 9b              WAIT
       01a2:43e2 90              NOP
       01a2:43e3 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:43e7 90              NOP
       01a2:43e8 d8 06 f2 b3     FADD       float ptr [0xb3f2]
       01a2:43ec 83 ec 04        SUB        SP,0x4
       01a2:43ef 8b dc           MOV        BX,SP
       01a2:43f1 90              NOP
       01a2:43f2 d9 1f           FSTP       float ptr [BX]
       01a2:43f4 90              NOP
       01a2:43f5 9b              WAIT
       01a2:43f6 90              NOP
       01a2:43f7 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:43fb 90              NOP
       01a2:43fc d8 06 f2 b3     FADD       float ptr [0xb3f2]
       01a2:4400 83 ec 04        SUB        SP,0x4
       01a2:4403 8b dc           MOV        BX,SP
       01a2:4405 90              NOP
       01a2:4406 d9 1f           FSTP       float ptr [BX]
       01a2:4408 90              NOP
       01a2:4409 9b              WAIT
       01a2:440a 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:440f 90              NOP
       01a2:4410 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:4414 90              NOP
       01a2:4415 d8 06 fe b3     FADD       float ptr [0xb3fe]
       01a2:4419 83 ec 04        SUB        SP,0x4
       01a2:441c 8b dc           MOV        BX,SP
       01a2:441e 90              NOP
       01a2:441f d9 1f           FSTP       float ptr [BX]
       01a2:4421 90              NOP
       01a2:4422 9b              WAIT
       01a2:4423 90              NOP
       01a2:4424 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:4428 90              NOP
       01a2:4429 d8 06 da b3     FADD       float ptr [0xb3da]
       01a2:442d 83 ec 04        SUB        SP,0x4
       01a2:4430 8b dc           MOV        BX,SP
       01a2:4432 90              NOP
       01a2:4433 d9 1f           FSTP       float ptr [BX]
       01a2:4435 90              NOP
       01a2:4436 9b              WAIT
       01a2:4437 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:443c b8 03 00        MOV        AX,0x3
       01a2:443f 50              PUSH       AX
       01a2:4440 b8 ff ff        MOV        AX,0xffff
       01a2:4443 50              PUSH       AX
       01a2:4444 b8 02 00        MOV        AX,0x2
       01a2:4447 50              PUSH       AX
       01a2:4448 9a 80 10        CALLF      LINE
                 71 0e
       01a2:444d 90              NOP
       01a2:444e d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:4452 90              NOP
       01a2:4453 d8 06 24 a6     FADD       float ptr { 3.0 }
       01a2:4457 83 ec 04        SUB        SP,0x4
       01a2:445a 8b dc           MOV        BX,SP
       01a2:445c 90              NOP
       01a2:445d d9 1f           FSTP       float ptr [BX]
       01a2:445f 90              NOP
       01a2:4460 9b              WAIT
       01a2:4461 90              NOP
       01a2:4462 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:4466 90              NOP
       01a2:4467 d8 06 e6 b3     FADD       float ptr [0xb3e6]
       01a2:446b 83 ec 04        SUB        SP,0x4
       01a2:446e 8b dc           MOV        BX,SP
       01a2:4470 90              NOP
       01a2:4471 d9 1f           FSTP       float ptr [BX]
       01a2:4473 90              NOP
       01a2:4474 9b              WAIT
       01a2:4475 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:447a 90              NOP
       01a2:447b d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:447f 90              NOP
       01a2:4480 d8 06 fe b3     FADD       float ptr [0xb3fe]
       01a2:4484 83 ec 04        SUB        SP,0x4
       01a2:4487 8b dc           MOV        BX,SP
       01a2:4489 90              NOP
       01a2:448a d9 1f           FSTP       float ptr [BX]
       01a2:448c 90              NOP
       01a2:448d 9b              WAIT
       01a2:448e 90              NOP
       01a2:448f d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:4493 90              NOP
       01a2:4494 d8 06 10 a6     FADD       float ptr { 18.0 }
       01a2:4498 83 ec 04        SUB        SP,0x4
       01a2:449b 8b dc           MOV        BX,SP
       01a2:449d 90              NOP
       01a2:449e d9 1f           FSTP       float ptr [BX]
       01a2:44a0 90              NOP
       01a2:44a1 9b              WAIT
       01a2:44a2 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:44a7 33 c0           XOR        AX,AX
       01a2:44a9 50              PUSH       AX
       01a2:44aa b8 ff ff        MOV        AX,0xffff
       01a2:44ad 50              PUSH       AX
       01a2:44ae b8 01 00        MOV        AX,0x1
       01a2:44b1 50              PUSH       AX
       01a2:44b2 9a 80 10        CALLF      LINE
                 71 0e
       01a2:44b7 90              NOP
       01a2:44b8 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:44bc 90              NOP
       01a2:44bd d8 06 74 a6     FADD       float ptr { 4.0 }
       01a2:44c1 83 ec 04        SUB        SP,0x4
       01a2:44c4 8b dc           MOV        BX,SP
       01a2:44c6 90              NOP
       01a2:44c7 d9 1f           FSTP       float ptr [BX]
       01a2:44c9 90              NOP
       01a2:44ca 9b              WAIT
       01a2:44cb 90              NOP
       01a2:44cc d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:44d0 90              NOP
       01a2:44d1 d8 06 be b4     FADD       float ptr [0xb4be]
       01a2:44d5 83 ec 04        SUB        SP,0x4
       01a2:44d8 8b dc           MOV        BX,SP
       01a2:44da 90              NOP
       01a2:44db d9 1f           FSTP       float ptr [BX]
       01a2:44dd 90              NOP
       01a2:44de 9b              WAIT
       01a2:44df 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:44e4 90              NOP
       01a2:44e5 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:44e9 90              NOP
       01a2:44ea d8 06 06 b4     FADD       float ptr [0xb406]
       01a2:44ee 83 ec 04        SUB        SP,0x4
       01a2:44f1 8b dc           MOV        BX,SP
       01a2:44f3 90              NOP
       01a2:44f4 d9 1f           FSTP       float ptr [BX]
       01a2:44f6 90              NOP
       01a2:44f7 9b              WAIT
       01a2:44f8 90              NOP
       01a2:44f9 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:44fd 90              NOP
       01a2:44fe d8 06 66 b4     FADD       float ptr [0xb466]
       01a2:4502 83 ec 04        SUB        SP,0x4
       01a2:4505 8b dc           MOV        BX,SP
       01a2:4507 90              NOP
       01a2:4508 d9 1f           FSTP       float ptr [BX]
       01a2:450a 90              NOP
       01a2:450b 9b              WAIT
       01a2:450c 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:4511 b8 07 00        MOV        AX,0x7
       01a2:4514 50              PUSH       AX
       01a2:4515 b8 ff ff        MOV        AX,0xffff
       01a2:4518 50              PUSH       AX
       01a2:4519 b8 02 00        MOV        AX,0x2
       01a2:451c 50              PUSH       AX
       01a2:451d 9a 80 10        CALLF      LINE
                 71 0e
       01a2:4522 90              NOP
       01a2:4523 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:4527 90              NOP
       01a2:4528 d8 06 f2 b3     FADD       float ptr [0xb3f2]
       01a2:452c 83 ec 04        SUB        SP,0x4
       01a2:452f 8b dc           MOV        BX,SP
       01a2:4531 90              NOP
       01a2:4532 d9 1f           FSTP       float ptr [BX]
       01a2:4534 90              NOP
       01a2:4535 9b              WAIT
       01a2:4536 90              NOP
       01a2:4537 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:453b 90              NOP
       01a2:453c d8 06 be b4     FADD       float ptr [0xb4be]
       01a2:4540 83 ec 04        SUB        SP,0x4
       01a2:4543 8b dc           MOV        BX,SP
       01a2:4545 90              NOP
       01a2:4546 d9 1f           FSTP       float ptr [BX]
       01a2:4548 90              NOP
       01a2:4549 9b              WAIT
       01a2:454a 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:454f 90              NOP
       01a2:4550 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:4554 90              NOP
       01a2:4555 d8 06 16 b4     FADD       float ptr [0xb416]
       01a2:4559 83 ec 04        SUB        SP,0x4
       01a2:455c 8b dc           MOV        BX,SP
       01a2:455e 90              NOP
       01a2:455f d9 1f           FSTP       float ptr [BX]
       01a2:4561 90              NOP
       01a2:4562 9b              WAIT
       01a2:4563 90              NOP
       01a2:4564 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:4568 90              NOP
       01a2:4569 d8 06 7c a6     FADD       float ptr [0xa67c]
       01a2:456d 83 ec 04        SUB        SP,0x4
       01a2:4570 8b dc           MOV        BX,SP
       01a2:4572 90              NOP
       01a2:4573 d9 1f           FSTP       float ptr [BX]
       01a2:4575 90              NOP
       01a2:4576 9b              WAIT
       01a2:4577 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:457c 33 c0           XOR        AX,AX
       01a2:457e 50              PUSH       AX
       01a2:457f b8 ff ff        MOV        AX,0xffff
       01a2:4582 50              PUSH       AX
       01a2:4583 b8 02 00        MOV        AX,0x2
       01a2:4586 50              PUSH       AX
       01a2:4587 9a 80 10        CALLF      LINE
                 71 0e
       01a2:458c 90              NOP
       01a2:458d d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:4591 90              NOP
       01a2:4592 d8 06 e6 b3     FADD       float ptr [0xb3e6]
       01a2:4596 83 ec 04        SUB        SP,0x4
       01a2:4599 8b dc           MOV        BX,SP
       01a2:459b 90              NOP
       01a2:459c d9 1f           FSTP       float ptr [BX]
       01a2:459e 90              NOP
       01a2:459f 9b              WAIT
       01a2:45a0 90              NOP
       01a2:45a1 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:45a5 90              NOP
       01a2:45a6 d8 06 c2 b4     FADD       float ptr [0xb4c2]
       01a2:45aa 83 ec 04        SUB        SP,0x4
       01a2:45ad 8b dc           MOV        BX,SP
       01a2:45af 90              NOP
       01a2:45b0 d9 1f           FSTP       float ptr [BX]
       01a2:45b2 90              NOP
       01a2:45b3 9b              WAIT
       01a2:45b4 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:45b9 90              NOP
       01a2:45ba d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:45be 90              NOP
       01a2:45bf d8 06 c2 b4     FADD       float ptr [0xb4c2]
       01a2:45c3 83 ec 04        SUB        SP,0x4
       01a2:45c6 8b dc           MOV        BX,SP
       01a2:45c8 90              NOP
       01a2:45c9 d9 1f           FSTP       float ptr [BX]
       01a2:45cb 90              NOP
       01a2:45cc 9b              WAIT
       01a2:45cd 90              NOP
       01a2:45ce d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:45d2 90              NOP
       01a2:45d3 d8 06 20 a6     FADD       float ptr [0xa620]
       01a2:45d7 83 ec 04        SUB        SP,0x4
       01a2:45da 8b dc           MOV        BX,SP
       01a2:45dc 90              NOP
       01a2:45dd d9 1f           FSTP       float ptr [BX]
       01a2:45df 90              NOP
       01a2:45e0 9b              WAIT
       01a2:45e1 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:45e6 b8 08 00        MOV        AX,0x8
       01a2:45e9 50              PUSH       AX
       01a2:45ea b8 ff ff        MOV        AX,0xffff
       01a2:45ed 50              PUSH       AX
       01a2:45ee b8 02 00        MOV        AX,0x2
       01a2:45f1 50              PUSH       AX
       01a2:45f2 9a 80 10        CALLF      LINE
                 71 0e
       01a2:45f7 90              NOP
       01a2:45f8 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:45fc 90              NOP
       01a2:45fd d8 06 16 b4     FADD       float ptr [0xb416]
       01a2:4601 83 ec 04        SUB        SP,0x4
       01a2:4604 8b dc           MOV        BX,SP
       01a2:4606 90              NOP
       01a2:4607 d9 1f           FSTP       float ptr [BX]
       01a2:4609 90              NOP
       01a2:460a 9b              WAIT
       01a2:460b ff 36 34 a2     PUSH       word ptr [0xa234]
       01a2:460f ff 36 32 a2     PUSH       word ptr [0xa232]
       01a2:4613 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:4618 90              NOP
       01a2:4619 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:461d 90              NOP
       01a2:461e d8 06 24 a6     FADD       float ptr { 3.0 }
       01a2:4622 83 ec 04        SUB        SP,0x4
       01a2:4625 8b dc           MOV        BX,SP
       01a2:4627 90              NOP
       01a2:4628 d9 1f           FSTP       float ptr [BX]
       01a2:462a 90              NOP
       01a2:462b 9b              WAIT
       01a2:462c 90              NOP
       01a2:462d d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:4631 90              NOP
       01a2:4632 d8 06 94 af     FADD       float ptr { 9.0 }
       01a2:4636 83 ec 04        SUB        SP,0x4
       01a2:4639 8b dc           MOV        BX,SP
       01a2:463b 90              NOP
       01a2:463c d9 1f           FSTP       float ptr [BX]
       01a2:463e 90              NOP
       01a2:463f 9b              WAIT
       01a2:4640 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:4645 33 c0           XOR        AX,AX
       01a2:4647 50              PUSH       AX
       01a2:4648 b8 ff ff        MOV        AX,0xffff
       01a2:464b 50              PUSH       AX
       01a2:464c b8 01 00        MOV        AX,0x1
       01a2:464f 50              PUSH       AX
       01a2:4650 9a 80 10        CALLF      LINE
                 71 0e
       01a2:4655 90              NOP
       01a2:4656 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:465a 90              NOP
       01a2:465b d8 06 80 af     FADD       float ptr { 6.0 }
       01a2:465f 83 ec 04        SUB        SP,0x4
       01a2:4662 8b dc           MOV        BX,SP
       01a2:4664 90              NOP
       01a2:4665 d9 1f           FSTP       float ptr [BX]
       01a2:4667 90              NOP
       01a2:4668 9b              WAIT
       01a2:4669 ff 36 34 a2     PUSH       word ptr [0xa234]
       01a2:466d ff 36 32 a2     PUSH       word ptr [0xa232]
       01a2:4671 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:4676 90              NOP
       01a2:4677 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:467b 90              NOP
       01a2:467c d8 06 1e b4     FADD       float ptr [0xb41e]
       01a2:4680 83 ec 04        SUB        SP,0x4
       01a2:4683 8b dc           MOV        BX,SP
       01a2:4685 90              NOP
       01a2:4686 d9 1f           FSTP       float ptr [BX]
       01a2:4688 90              NOP
       01a2:4689 9b              WAIT
       01a2:468a 90              NOP
       01a2:468b d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:468f 90              NOP
       01a2:4690 d8 06 24 a6     FADD       float ptr { 3.0 }
       01a2:4694 83 ec 04        SUB        SP,0x4
       01a2:4697 8b dc           MOV        BX,SP
       01a2:4699 90              NOP
       01a2:469a d9 1f           FSTP       float ptr [BX]
       01a2:469c 90              NOP
       01a2:469d 9b              WAIT
       01a2:469e 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:46a3 33 c0           XOR        AX,AX
       01a2:46a5 50              PUSH       AX
       01a2:46a6 b8 ff ff        MOV        AX,0xffff
       01a2:46a9 50              PUSH       AX
       01a2:46aa b8 02 00        MOV        AX,0x2
       01a2:46ad 50              PUSH       AX
       01a2:46ae 9a 80 10        CALLF      LINE
                 71 0e
       01a2:46b3 e8 13 f6        CALL       FUN_01a2_3cc9                                    undefined FUN_01a2_3cc9()
       01a2:46b6 90              NOP
       01a2:46b7 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:46bb 90              NOP
       01a2:46bc d8 06 14 a6     FADD       float ptr { 8.0 }
       01a2:46c0 83 ec 04        SUB        SP,0x4
       01a2:46c3 8b dc           MOV        BX,SP
       01a2:46c5 90              NOP
       01a2:46c6 d9 1f           FSTP       float ptr [BX]
       01a2:46c8 90              NOP
       01a2:46c9 9b              WAIT
       01a2:46ca 90              NOP
       01a2:46cb d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:46cf 90              NOP
       01a2:46d0 d8 06 b4 a6     FADD       float ptr { 2.0 }
       01a2:46d4 83 ec 04        SUB        SP,0x4
       01a2:46d7 8b dc           MOV        BX,SP
       01a2:46d9 90              NOP
       01a2:46da d9 1f           FSTP       float ptr [BX]
       01a2:46dc 90              NOP
       01a2:46dd 9b              WAIT
       01a2:46de 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:46e3 90              NOP
       01a2:46e4 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:46e8 90              NOP
       01a2:46e9 d8 06 ea b3     FADD       float ptr [0xb3ea]
       01a2:46ed 83 ec 04        SUB        SP,0x4
       01a2:46f0 8b dc           MOV        BX,SP
       01a2:46f2 90              NOP
       01a2:46f3 d9 1f           FSTP       float ptr [BX]
       01a2:46f5 90              NOP
       01a2:46f6 9b              WAIT
       01a2:46f7 90              NOP
       01a2:46f8 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:46fc 90              NOP
       01a2:46fd d8 06 7c a6     FADD       float ptr [0xa67c]
       01a2:4701 83 ec 04        SUB        SP,0x4
       01a2:4704 8b dc           MOV        BX,SP
       01a2:4706 90              NOP
       01a2:4707 d9 1f           FSTP       float ptr [BX]
       01a2:4709 90              NOP
       01a2:470a 9b              WAIT
       01a2:470b 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:4710 33 c0           XOR        AX,AX
       01a2:4712 50              PUSH       AX
       01a2:4713 b8 ff ff        MOV        AX,0xffff
       01a2:4716 50              PUSH       AX
       01a2:4717 b8 01 00        MOV        AX,0x1
       01a2:471a 50              PUSH       AX
       01a2:471b 9a 80 10        CALLF      LINE
                 71 0e
       01a2:4720 90              NOP
       01a2:4721 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:4725 90              NOP
       01a2:4726 d8 06 94 af     FADD       float ptr { 9.0 }
       01a2:472a 83 ec 04        SUB        SP,0x4
       01a2:472d 8b dc           MOV        BX,SP
       01a2:472f 90              NOP
       01a2:4730 d9 1f           FSTP       float ptr [BX]
       01a2:4732 90              NOP
       01a2:4733 9b              WAIT
       01a2:4734 90              NOP
       01a2:4735 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:4739 90              NOP
       01a2:473a d8 06 b4 a6     FADD       float ptr { 2.0 }
       01a2:473e 83 ec 04        SUB        SP,0x4
       01a2:4741 8b dc           MOV        BX,SP
       01a2:4743 90              NOP
       01a2:4744 d9 1f           FSTP       float ptr [BX]
       01a2:4746 90              NOP
       01a2:4747 9b              WAIT
       01a2:4748 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:474d 90              NOP
       01a2:474e d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:4752 90              NOP
       01a2:4753 d8 06 26 b4     FADD       float ptr [0xb426]
       01a2:4757 83 ec 04        SUB        SP,0x4
       01a2:475a 8b dc           MOV        BX,SP
       01a2:475c 90              NOP
       01a2:475d d9 1f           FSTP       float ptr [BX]
       01a2:475f 90              NOP
       01a2:4760 9b              WAIT
       01a2:4761 90              NOP
       01a2:4762 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:4766 90              NOP
       01a2:4767 d8 06 20 a6     FADD       float ptr [0xa620]
       01a2:476b 83 ec 04        SUB        SP,0x4
       01a2:476e 8b dc           MOV        BX,SP
       01a2:4770 90              NOP
       01a2:4771 d9 1f           FSTP       float ptr [BX]
       01a2:4773 90              NOP
       01a2:4774 9b              WAIT
       01a2:4775 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:477a b8 0f 00        MOV        AX,0xf
       01a2:477d 50              PUSH       AX
       01a2:477e b8 ff ff        MOV        AX,0xffff
       01a2:4781 50              PUSH       AX
       01a2:4782 b8 02 00        MOV        AX,0x2
       01a2:4785 50              PUSH       AX
       01a2:4786 9a 80 10        CALLF      LINE
                 71 0e
       01a2:478b e8 3b f5        CALL       FUN_01a2_3cc9                                    undefined FUN_01a2_3cc9()
       01a2:478e 90              NOP
       01a2:478f d9 06 24 a6     FLD        float ptr { 3.0 }
       01a2:4793 e9 8e 00        JMP        LAB_01a2_4824
                             LAB_01a2_4796                                   XREF[1]:     01a2:483e(j)  
       01a2:4796 9a 48 7d        CALLF      RND
                 71 0e
       01a2:479b 8b f0           MOV        SI,AX
       01a2:479d 90              NOP
       01a2:479e d9 04           FLD        float ptr [SI]
       01a2:47a0 90              NOP
       01a2:47a1 d8 0e f6 b3     FMUL       float ptr [0xb3f6]
       01a2:47a5 90              NOP
       01a2:47a6 d8 06 8c af     FADD       float ptr { 10.0 }
       01a2:47aa 90              NOP
       01a2:47ab d9 1e b2 a4     FSTP       float ptr [0xa4b2]
       01a2:47af 90              NOP
       01a2:47b0 9b              WAIT
       01a2:47b1 90              NOP
       01a2:47b2 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:47b6 90              NOP
       01a2:47b7 d8 06 8c af     FADD       float ptr { 10.0 }
       01a2:47bb 83 ec 04        SUB        SP,0x4
       01a2:47be 8b dc           MOV        BX,SP
       01a2:47c0 90              NOP
       01a2:47c1 d9 1f           FSTP       float ptr [BX]
       01a2:47c3 90              NOP
       01a2:47c4 9b              WAIT
       01a2:47c5 90              NOP
       01a2:47c6 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:47ca 90              NOP
       01a2:47cb d8 06 96 a4     FADD       float ptr [0xa496]
       01a2:47cf 83 ec 04        SUB        SP,0x4
       01a2:47d2 8b dc           MOV        BX,SP
       01a2:47d4 90              NOP
       01a2:47d5 d9 1f           FSTP       float ptr [BX]
       01a2:47d7 90              NOP
       01a2:47d8 9b              WAIT
       01a2:47d9 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:47de 90              NOP
       01a2:47df d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:47e3 90              NOP
       01a2:47e4 d8 06 b2 a4     FADD       float ptr [0xa4b2]
       01a2:47e8 83 ec 04        SUB        SP,0x4
       01a2:47eb 8b dc           MOV        BX,SP
       01a2:47ed 90              NOP
       01a2:47ee d9 1f           FSTP       float ptr [BX]
       01a2:47f0 90              NOP
       01a2:47f1 9b              WAIT
       01a2:47f2 90              NOP
       01a2:47f3 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:47f7 90              NOP
       01a2:47f8 d8 06 96 a4     FADD       float ptr [0xa496]
       01a2:47fc 83 ec 04        SUB        SP,0x4
       01a2:47ff 8b dc           MOV        BX,SP
       01a2:4801 90              NOP
       01a2:4802 d9 1f           FSTP       float ptr [BX]
       01a2:4804 90              NOP
       01a2:4805 9b              WAIT
       01a2:4806 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:480b 33 c0           XOR        AX,AX
       01a2:480d 50              PUSH       AX
       01a2:480e b8 ff ff        MOV        AX,0xffff
       01a2:4811 50              PUSH       AX
       01a2:4812 33 c0           XOR        AX,AX
       01a2:4814 50              PUSH       AX
       01a2:4815 9a 80 10        CALLF      LINE
                 71 0e
       01a2:481a 90              NOP
       01a2:481b d9 06 96 a4     FLD        float ptr [0xa496]
       01a2:481f 90              NOP
       01a2:4820 d8 06 b4 a6     FADD       float ptr { 2.0 }
                             LAB_01a2_4824                                   XREF[1]:     01a2:4793(j)  
       01a2:4824 90              NOP
       01a2:4825 d9 1e 96 a4     FSTP       float ptr [0xa496]
       01a2:4829 90              NOP
       01a2:482a 9b              WAIT
       01a2:482b 90              NOP
       01a2:482c d9 06 94 af     FLD        float ptr { 9.0 }
       01a2:4830 90              NOP
       01a2:4831 d9 06 96 a4     FLD        float ptr [0xa496]
       01a2:4835 90              NOP
       01a2:4836 9b              WAIT
       01a2:4837 9a 1d 04        CALLF      FPCOMPARE_2stack                                 undefined FPCOMPARE_2stack()
                 75 0d
       01a2:483c 77 03           JA         LAB_01a2_4841
       01a2:483e e9 55 ff        JMP        LAB_01a2_4796
                             LAB_01a2_4841                                   XREF[1]:     01a2:483c(j)  
       01a2:4841 b8 c8 00        MOV        AX,0xc8
       01a2:4844 50              PUSH       AX
       01a2:4845 ff 36 52 a5     PUSH       word ptr [0xa552]
       01a2:4849 ff 36 50 a5     PUSH       word ptr { 1.0 }
       01a2:484d 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:4852 90              NOP
       01a2:4853 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:4857 90              NOP
       01a2:4858 d8 06 14 a6     FADD       float ptr { 8.0 }
       01a2:485c 83 ec 04        SUB        SP,0x4
       01a2:485f 8b dc           MOV        BX,SP
       01a2:4861 90              NOP
       01a2:4862 d9 1f           FSTP       float ptr [BX]
       01a2:4864 90              NOP
       01a2:4865 9b              WAIT
       01a2:4866 90              NOP
       01a2:4867 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:486b 90              NOP
       01a2:486c d8 06 7c a6     FADD       float ptr [0xa67c]
       01a2:4870 83 ec 04        SUB        SP,0x4
       01a2:4873 8b dc           MOV        BX,SP
       01a2:4875 90              NOP
       01a2:4876 d9 1f           FSTP       float ptr [BX]
       01a2:4878 90              NOP
       01a2:4879 9b              WAIT
       01a2:487a 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:487f 90              NOP
       01a2:4880 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:4884 90              NOP
       01a2:4885 d8 06 ea b3     FADD       float ptr [0xb3ea]
       01a2:4889 83 ec 04        SUB        SP,0x4
       01a2:488c 8b dc           MOV        BX,SP
       01a2:488e 90              NOP
       01a2:488f d9 1f           FSTP       float ptr [BX]
       01a2:4891 90              NOP
       01a2:4892 9b              WAIT
       01a2:4893 90              NOP
       01a2:4894 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:4898 90              NOP
       01a2:4899 d8 06 c6 b4     FADD       float ptr [0xb4c6]
       01a2:489d 83 ec 04        SUB        SP,0x4
       01a2:48a0 8b dc           MOV        BX,SP
       01a2:48a2 90              NOP
       01a2:48a3 d9 1f           FSTP       float ptr [BX]
       01a2:48a5 90              NOP
       01a2:48a6 9b              WAIT
       01a2:48a7 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:48ac 33 c0           XOR        AX,AX
       01a2:48ae 50              PUSH       AX
       01a2:48af b8 ff ff        MOV        AX,0xffff
       01a2:48b2 50              PUSH       AX
       01a2:48b3 b8 01 00        MOV        AX,0x1
       01a2:48b6 50              PUSH       AX
       01a2:48b7 9a 80 10        CALLF      LINE
                 71 0e
       01a2:48bc 90              NOP
       01a2:48bd d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:48c1 90              NOP
       01a2:48c2 d8 06 94 af     FADD       float ptr { 9.0 }
       01a2:48c6 83 ec 04        SUB        SP,0x4
       01a2:48c9 8b dc           MOV        BX,SP
       01a2:48cb 90              NOP
       01a2:48cc d9 1f           FSTP       float ptr [BX]
       01a2:48ce 90              NOP
       01a2:48cf 9b              WAIT
       01a2:48d0 90              NOP
       01a2:48d1 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:48d5 90              NOP
       01a2:48d6 d8 06 7c a6     FADD       float ptr [0xa67c]
       01a2:48da 83 ec 04        SUB        SP,0x4
       01a2:48dd 8b dc           MOV        BX,SP
       01a2:48df 90              NOP
       01a2:48e0 d9 1f           FSTP       float ptr [BX]
       01a2:48e2 90              NOP
       01a2:48e3 9b              WAIT
       01a2:48e4 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:48e9 90              NOP
       01a2:48ea d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:48ee 90              NOP
       01a2:48ef d8 06 26 b4     FADD       float ptr [0xb426]
       01a2:48f3 83 ec 04        SUB        SP,0x4
       01a2:48f6 8b dc           MOV        BX,SP
       01a2:48f8 90              NOP
       01a2:48f9 d9 1f           FSTP       float ptr [BX]
       01a2:48fb 90              NOP
       01a2:48fc 9b              WAIT
       01a2:48fd 90              NOP
       01a2:48fe d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:4902 90              NOP
       01a2:4903 d8 06 5e b4     FADD       float ptr [0xb45e]
       01a2:4907 83 ec 04        SUB        SP,0x4
       01a2:490a 8b dc           MOV        BX,SP
       01a2:490c 90              NOP
       01a2:490d d9 1f           FSTP       float ptr [BX]
       01a2:490f 90              NOP
       01a2:4910 9b              WAIT
       01a2:4911 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:4916 b8 0f 00        MOV        AX,0xf
       01a2:4919 50              PUSH       AX
       01a2:491a b8 ff ff        MOV        AX,0xffff
       01a2:491d 50              PUSH       AX
       01a2:491e b8 02 00        MOV        AX,0x2
       01a2:4921 50              PUSH       AX
       01a2:4922 9a 80 10        CALLF      LINE
                 71 0e
       01a2:4927 e8 9f f3        CALL       FUN_01a2_3cc9                                    undefined FUN_01a2_3cc9()
       01a2:492a 90              NOP
       01a2:492b d9 06 20 a6     FLD        float ptr [0xa620]
       01a2:492f e9 8e 00        JMP        LAB_01a2_49c0
                             LAB_01a2_4932                                   XREF[1]:     01a2:49da(j)  
       01a2:4932 9a 48 7d        CALLF      RND
                 71 0e
       01a2:4937 8b f0           MOV        SI,AX
       01a2:4939 90              NOP
       01a2:493a d9 04           FLD        float ptr [SI]
       01a2:493c 90              NOP
       01a2:493d d8 0e f6 b3     FMUL       float ptr [0xb3f6]
       01a2:4941 90              NOP
       01a2:4942 d8 06 8c af     FADD       float ptr { 10.0 }
       01a2:4946 90              NOP
       01a2:4947 d9 1e b2 a4     FSTP       float ptr [0xa4b2]
       01a2:494b 90              NOP
       01a2:494c 9b              WAIT
       01a2:494d 90              NOP
       01a2:494e d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:4952 90              NOP
       01a2:4953 d8 06 8c af     FADD       float ptr { 10.0 }
       01a2:4957 83 ec 04        SUB        SP,0x4
       01a2:495a 8b dc           MOV        BX,SP
       01a2:495c 90              NOP
       01a2:495d d9 1f           FSTP       float ptr [BX]
       01a2:495f 90              NOP
       01a2:4960 9b              WAIT
       01a2:4961 90              NOP
       01a2:4962 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:4966 90              NOP
       01a2:4967 d8 06 96 a4     FADD       float ptr [0xa496]
       01a2:496b 83 ec 04        SUB        SP,0x4
       01a2:496e 8b dc           MOV        BX,SP
       01a2:4970 90              NOP
       01a2:4971 d9 1f           FSTP       float ptr [BX]
       01a2:4973 90              NOP
       01a2:4974 9b              WAIT
       01a2:4975 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:497a 90              NOP
       01a2:497b d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:497f 90              NOP
       01a2:4980 d8 06 b2 a4     FADD       float ptr [0xa4b2]
       01a2:4984 83 ec 04        SUB        SP,0x4
       01a2:4987 8b dc           MOV        BX,SP
       01a2:4989 90              NOP
       01a2:498a d9 1f           FSTP       float ptr [BX]
       01a2:498c 90              NOP
       01a2:498d 9b              WAIT
       01a2:498e 90              NOP
       01a2:498f d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:4993 90              NOP
       01a2:4994 d8 06 96 a4     FADD       float ptr [0xa496]
       01a2:4998 83 ec 04        SUB        SP,0x4
       01a2:499b 8b dc           MOV        BX,SP
       01a2:499d 90              NOP
       01a2:499e d9 1f           FSTP       float ptr [BX]
       01a2:49a0 90              NOP
       01a2:49a1 9b              WAIT
       01a2:49a2 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:49a7 33 c0           XOR        AX,AX
       01a2:49a9 50              PUSH       AX
       01a2:49aa b8 ff ff        MOV        AX,0xffff
       01a2:49ad 50              PUSH       AX
       01a2:49ae 33 c0           XOR        AX,AX
       01a2:49b0 50              PUSH       AX
       01a2:49b1 9a 80 10        CALLF      LINE
                 71 0e
       01a2:49b6 90              NOP
       01a2:49b7 d9 06 96 a4     FLD        float ptr [0xa496]
       01a2:49bb 90              NOP
       01a2:49bc d8 06 b4 a6     FADD       float ptr { 2.0 }
                             LAB_01a2_49c0                                   XREF[1]:     01a2:492f(j)  
       01a2:49c0 90              NOP
       01a2:49c1 d9 1e 96 a4     FSTP       float ptr [0xa496]
       01a2:49c5 90              NOP
       01a2:49c6 9b              WAIT
       01a2:49c7 90              NOP
       01a2:49c8 d9 06 3a b4     FLD        float ptr [0xb43a]
       01a2:49cc 90              NOP
       01a2:49cd d9 06 96 a4     FLD        float ptr [0xa496]
       01a2:49d1 90              NOP
       01a2:49d2 9b              WAIT
       01a2:49d3 9a 1d 04        CALLF      FPCOMPARE_2stack                                 undefined FPCOMPARE_2stack()
                 75 0d
       01a2:49d8 77 03           JA         LAB_01a2_49dd
       01a2:49da e9 55 ff        JMP        LAB_01a2_4932
                             LAB_01a2_49dd                                   XREF[1]:     01a2:49d8(j)  
       01a2:49dd b8 c8 00        MOV        AX,0xc8
       01a2:49e0 50              PUSH       AX
       01a2:49e1 ff 36 52 a5     PUSH       word ptr [0xa552]
       01a2:49e5 ff 36 50 a5     PUSH       word ptr { 1.0 }
       01a2:49e9 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:49ee 90              NOP
       01a2:49ef d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:49f3 90              NOP
       01a2:49f4 d8 06 14 a6     FADD       float ptr { 8.0 }
       01a2:49f8 83 ec 04        SUB        SP,0x4
       01a2:49fb 8b dc           MOV        BX,SP
       01a2:49fd 90              NOP
       01a2:49fe d9 1f           FSTP       float ptr [BX]
       01a2:4a00 90              NOP
       01a2:4a01 9b              WAIT
       01a2:4a02 90              NOP
       01a2:4a03 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:4a07 90              NOP
       01a2:4a08 d8 06 46 b4     FADD       float ptr [0xb446]
       01a2:4a0c 83 ec 04        SUB        SP,0x4
       01a2:4a0f 8b dc           MOV        BX,SP
       01a2:4a11 90              NOP
       01a2:4a12 d9 1f           FSTP       float ptr [BX]
       01a2:4a14 90              NOP
       01a2:4a15 9b              WAIT
       01a2:4a16 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:4a1b 90              NOP
       01a2:4a1c d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:4a20 90              NOP
       01a2:4a21 d8 06 ea b3     FADD       float ptr [0xb3ea]
       01a2:4a25 83 ec 04        SUB        SP,0x4
       01a2:4a28 8b dc           MOV        BX,SP
       01a2:4a2a 90              NOP
       01a2:4a2b d9 1f           FSTP       float ptr [BX]
       01a2:4a2d 90              NOP
       01a2:4a2e 9b              WAIT
       01a2:4a2f 90              NOP
       01a2:4a30 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:4a34 90              NOP
       01a2:4a35 d8 06 36 b0     FADD       float ptr { 30.0 }
       01a2:4a39 83 ec 04        SUB        SP,0x4
       01a2:4a3c 8b dc           MOV        BX,SP
       01a2:4a3e 90              NOP
       01a2:4a3f d9 1f           FSTP       float ptr [BX]
       01a2:4a41 90              NOP
       01a2:4a42 9b              WAIT
       01a2:4a43 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:4a48 33 c0           XOR        AX,AX
       01a2:4a4a 50              PUSH       AX
       01a2:4a4b b8 ff ff        MOV        AX,0xffff
       01a2:4a4e 50              PUSH       AX
       01a2:4a4f b8 01 00        MOV        AX,0x1
       01a2:4a52 50              PUSH       AX
       01a2:4a53 9a 80 10        CALLF      LINE
                 71 0e
       01a2:4a58 90              NOP
       01a2:4a59 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:4a5d 90              NOP
       01a2:4a5e d8 06 94 af     FADD       float ptr { 9.0 }
       01a2:4a62 83 ec 04        SUB        SP,0x4
       01a2:4a65 8b dc           MOV        BX,SP
       01a2:4a67 90              NOP
       01a2:4a68 d9 1f           FSTP       float ptr [BX]
       01a2:4a6a 90              NOP
       01a2:4a6b 9b              WAIT
       01a2:4a6c 90              NOP
       01a2:4a6d d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:4a71 90              NOP
       01a2:4a72 d8 06 c6 b4     FADD       float ptr [0xb4c6]
       01a2:4a76 83 ec 04        SUB        SP,0x4
       01a2:4a79 8b dc           MOV        BX,SP
       01a2:4a7b 90              NOP
       01a2:4a7c d9 1f           FSTP       float ptr [BX]
       01a2:4a7e 90              NOP
       01a2:4a7f 9b              WAIT
       01a2:4a80 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:4a85 90              NOP
       01a2:4a86 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:4a8a 90              NOP
       01a2:4a8b d8 06 26 b4     FADD       float ptr [0xb426]
       01a2:4a8f 83 ec 04        SUB        SP,0x4
       01a2:4a92 8b dc           MOV        BX,SP
       01a2:4a94 90              NOP
       01a2:4a95 d9 1f           FSTP       float ptr [BX]
       01a2:4a97 90              NOP
       01a2:4a98 9b              WAIT
       01a2:4a99 90              NOP
       01a2:4a9a d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:4a9e 90              NOP
       01a2:4a9f d8 06 ca b4     FADD       float ptr [0xb4ca]
       01a2:4aa3 83 ec 04        SUB        SP,0x4
       01a2:4aa6 8b dc           MOV        BX,SP
       01a2:4aa8 90              NOP
       01a2:4aa9 d9 1f           FSTP       float ptr [BX]
       01a2:4aab 90              NOP
       01a2:4aac 9b              WAIT
       01a2:4aad 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:4ab2 b8 0f 00        MOV        AX,0xf
       01a2:4ab5 50              PUSH       AX
       01a2:4ab6 b8 ff ff        MOV        AX,0xffff
       01a2:4ab9 50              PUSH       AX
       01a2:4aba b8 02 00        MOV        AX,0x2
       01a2:4abd 50              PUSH       AX
       01a2:4abe 9a 80 10        CALLF      LINE
                 71 0e
       01a2:4ac3 e8 03 f2        CALL       FUN_01a2_3cc9                                    undefined FUN_01a2_3cc9()
       01a2:4ac6 90              NOP
       01a2:4ac7 d9 06 5e b4     FLD        float ptr [0xb45e]
       01a2:4acb e9 8e 00        JMP        LAB_01a2_4b5c
                             LAB_01a2_4ace                                   XREF[1]:     01a2:4b76(j)  
       01a2:4ace 9a 48 7d        CALLF      RND
                 71 0e
       01a2:4ad3 8b f0           MOV        SI,AX
       01a2:4ad5 90              NOP
       01a2:4ad6 d9 04           FLD        float ptr [SI]
       01a2:4ad8 90              NOP
       01a2:4ad9 d8 0e f6 b3     FMUL       float ptr [0xb3f6]
       01a2:4add 90              NOP
       01a2:4ade d8 06 8c af     FADD       float ptr { 10.0 }
       01a2:4ae2 90              NOP
       01a2:4ae3 d9 1e b2 a4     FSTP       float ptr [0xa4b2]
       01a2:4ae7 90              NOP
       01a2:4ae8 9b              WAIT
       01a2:4ae9 90              NOP
       01a2:4aea d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:4aee 90              NOP
       01a2:4aef d8 06 8c af     FADD       float ptr { 10.0 }
       01a2:4af3 83 ec 04        SUB        SP,0x4
       01a2:4af6 8b dc           MOV        BX,SP
       01a2:4af8 90              NOP
       01a2:4af9 d9 1f           FSTP       float ptr [BX]
       01a2:4afb 90              NOP
       01a2:4afc 9b              WAIT
       01a2:4afd 90              NOP
       01a2:4afe d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:4b02 90              NOP
       01a2:4b03 d8 06 96 a4     FADD       float ptr [0xa496]
       01a2:4b07 83 ec 04        SUB        SP,0x4
       01a2:4b0a 8b dc           MOV        BX,SP
       01a2:4b0c 90              NOP
       01a2:4b0d d9 1f           FSTP       float ptr [BX]
       01a2:4b0f 90              NOP
       01a2:4b10 9b              WAIT
       01a2:4b11 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:4b16 90              NOP
       01a2:4b17 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:4b1b 90              NOP
       01a2:4b1c d8 06 b2 a4     FADD       float ptr [0xa4b2]
       01a2:4b20 83 ec 04        SUB        SP,0x4
       01a2:4b23 8b dc           MOV        BX,SP
       01a2:4b25 90              NOP
       01a2:4b26 d9 1f           FSTP       float ptr [BX]
       01a2:4b28 90              NOP
       01a2:4b29 9b              WAIT
       01a2:4b2a 90              NOP
       01a2:4b2b d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:4b2f 90              NOP
       01a2:4b30 d8 06 96 a4     FADD       float ptr [0xa496]
       01a2:4b34 83 ec 04        SUB        SP,0x4
       01a2:4b37 8b dc           MOV        BX,SP
       01a2:4b39 90              NOP
       01a2:4b3a d9 1f           FSTP       float ptr [BX]
       01a2:4b3c 90              NOP
       01a2:4b3d 9b              WAIT
       01a2:4b3e 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:4b43 33 c0           XOR        AX,AX
       01a2:4b45 50              PUSH       AX
       01a2:4b46 b8 ff ff        MOV        AX,0xffff
       01a2:4b49 50              PUSH       AX
       01a2:4b4a 33 c0           XOR        AX,AX
       01a2:4b4c 50              PUSH       AX
       01a2:4b4d 9a 80 10        CALLF      LINE
                 71 0e
       01a2:4b52 90              NOP
       01a2:4b53 d9 06 96 a4     FLD        float ptr [0xa496]
       01a2:4b57 90              NOP
       01a2:4b58 d8 06 b4 a6     FADD       float ptr { 2.0 }
                             LAB_01a2_4b5c                                   XREF[1]:     01a2:4acb(j)  
       01a2:4b5c 90              NOP
       01a2:4b5d d9 1e 96 a4     FSTP       float ptr [0xa496]
       01a2:4b61 90              NOP
       01a2:4b62 9b              WAIT
       01a2:4b63 90              NOP
       01a2:4b64 d9 06 36 b0     FLD        float ptr { 30.0 }
       01a2:4b68 90              NOP
       01a2:4b69 d9 06 96 a4     FLD        float ptr [0xa496]
       01a2:4b6d 90              NOP
       01a2:4b6e 9b              WAIT
       01a2:4b6f 9a 1d 04        CALLF      FPCOMPARE_2stack                                 undefined FPCOMPARE_2stack()
                 75 0d
       01a2:4b74 77 03           JA         LAB_01a2_4b79
       01a2:4b76 e9 55 ff        JMP        LAB_01a2_4ace
                             LAB_01a2_4b79                                   XREF[1]:     01a2:4b74(j)  
       01a2:4b79 b8 c8 00        MOV        AX,0xc8
       01a2:4b7c 50              PUSH       AX
       01a2:4b7d ff 36 52 a5     PUSH       word ptr [0xa552]
       01a2:4b81 ff 36 50 a5     PUSH       word ptr { 1.0 }
       01a2:4b85 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:4b8a 90              NOP
       01a2:4b8b d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:4b8f 90              NOP
       01a2:4b90 d8 06 14 a6     FADD       float ptr { 8.0 }
       01a2:4b94 83 ec 04        SUB        SP,0x4
       01a2:4b97 8b dc           MOV        BX,SP
       01a2:4b99 90              NOP
       01a2:4b9a d9 1f           FSTP       float ptr [BX]
       01a2:4b9c 90              NOP
       01a2:4b9d 9b              WAIT
       01a2:4b9e 90              NOP
       01a2:4b9f d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:4ba3 90              NOP
       01a2:4ba4 d8 06 36 b0     FADD       float ptr { 30.0 }
       01a2:4ba8 83 ec 04        SUB        SP,0x4
       01a2:4bab 8b dc           MOV        BX,SP
       01a2:4bad 90              NOP
       01a2:4bae d9 1f           FSTP       float ptr [BX]
       01a2:4bb0 90              NOP
       01a2:4bb1 9b              WAIT
       01a2:4bb2 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:4bb7 90              NOP
       01a2:4bb8 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:4bbc 90              NOP
       01a2:4bbd d8 06 ea b3     FADD       float ptr [0xb3ea]
       01a2:4bc1 83 ec 04        SUB        SP,0x4
       01a2:4bc4 8b dc           MOV        BX,SP
       01a2:4bc6 90              NOP
       01a2:4bc7 d9 1f           FSTP       float ptr [BX]
       01a2:4bc9 90              NOP
       01a2:4bca 9b              WAIT
       01a2:4bcb 90              NOP
       01a2:4bcc d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:4bd0 90              NOP
       01a2:4bd1 d8 06 22 b4     FADD       float ptr [0xb422]
       01a2:4bd5 83 ec 04        SUB        SP,0x4
       01a2:4bd8 8b dc           MOV        BX,SP
       01a2:4bda 90              NOP
       01a2:4bdb d9 1f           FSTP       float ptr [BX]
       01a2:4bdd 90              NOP
       01a2:4bde 9b              WAIT
       01a2:4bdf 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:4be4 33 c0           XOR        AX,AX
       01a2:4be6 50              PUSH       AX
       01a2:4be7 b8 ff ff        MOV        AX,0xffff
       01a2:4bea 50              PUSH       AX
       01a2:4beb b8 01 00        MOV        AX,0x1
       01a2:4bee 50              PUSH       AX
       01a2:4bef 9a 80 10        CALLF      LINE
                 71 0e
       01a2:4bf4 90              NOP
       01a2:4bf5 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:4bf9 90              NOP
       01a2:4bfa d8 06 94 af     FADD       float ptr { 9.0 }
       01a2:4bfe 83 ec 04        SUB        SP,0x4
       01a2:4c01 8b dc           MOV        BX,SP
       01a2:4c03 90              NOP
       01a2:4c04 d9 1f           FSTP       float ptr [BX]
       01a2:4c06 90              NOP
       01a2:4c07 9b              WAIT
       01a2:4c08 90              NOP
       01a2:4c09 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:4c0d 90              NOP
       01a2:4c0e d8 06 36 b0     FADD       float ptr { 30.0 }
       01a2:4c12 83 ec 04        SUB        SP,0x4
       01a2:4c15 8b dc           MOV        BX,SP
       01a2:4c17 90              NOP
       01a2:4c18 d9 1f           FSTP       float ptr [BX]
       01a2:4c1a 90              NOP
       01a2:4c1b 9b              WAIT
       01a2:4c1c 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:4c21 90              NOP
       01a2:4c22 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:4c26 90              NOP
       01a2:4c27 d8 06 26 b4     FADD       float ptr [0xb426]
       01a2:4c2b 83 ec 04        SUB        SP,0x4
       01a2:4c2e 8b dc           MOV        BX,SP
       01a2:4c30 90              NOP
       01a2:4c31 d9 1f           FSTP       float ptr [BX]
       01a2:4c33 90              NOP
       01a2:4c34 9b              WAIT
       01a2:4c35 90              NOP
       01a2:4c36 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:4c3a 90              NOP
       01a2:4c3b d8 06 f6 b3     FADD       float ptr [0xb3f6]
       01a2:4c3f 83 ec 04        SUB        SP,0x4
       01a2:4c42 8b dc           MOV        BX,SP
       01a2:4c44 90              NOP
       01a2:4c45 d9 1f           FSTP       float ptr [BX]
       01a2:4c47 90              NOP
       01a2:4c48 9b              WAIT
       01a2:4c49 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:4c4e b8 0f 00        MOV        AX,0xf
       01a2:4c51 50              PUSH       AX
       01a2:4c52 b8 ff ff        MOV        AX,0xffff
       01a2:4c55 50              PUSH       AX
       01a2:4c56 b8 02 00        MOV        AX,0x2
       01a2:4c59 50              PUSH       AX
       01a2:4c5a 9a 80 10        CALLF      LINE
                 71 0e
       01a2:4c5f e8 67 f0        CALL       FUN_01a2_3cc9                                    undefined FUN_01a2_3cc9()
       01a2:4c62 90              NOP
       01a2:4c63 d9 06 12 b4     FLD        float ptr [0xb412]
       01a2:4c67 e9 8e 00        JMP        LAB_01a2_4cf8
                             LAB_01a2_4c6a                                   XREF[1]:     01a2:4d12(j)  
       01a2:4c6a 9a 48 7d        CALLF      RND
                 71 0e
       01a2:4c6f 8b f0           MOV        SI,AX
       01a2:4c71 90              NOP
       01a2:4c72 d9 04           FLD        float ptr [SI]
       01a2:4c74 90              NOP
       01a2:4c75 d8 0e f6 b3     FMUL       float ptr [0xb3f6]
       01a2:4c79 90              NOP
       01a2:4c7a d8 06 8c af     FADD       float ptr { 10.0 }
       01a2:4c7e 90              NOP
       01a2:4c7f d9 1e b2 a4     FSTP       float ptr [0xa4b2]
       01a2:4c83 90              NOP
       01a2:4c84 9b              WAIT
       01a2:4c85 90              NOP
       01a2:4c86 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:4c8a 90              NOP
       01a2:4c8b d8 06 8c af     FADD       float ptr { 10.0 }
       01a2:4c8f 83 ec 04        SUB        SP,0x4
       01a2:4c92 8b dc           MOV        BX,SP
       01a2:4c94 90              NOP
       01a2:4c95 d9 1f           FSTP       float ptr [BX]
       01a2:4c97 90              NOP
       01a2:4c98 9b              WAIT
       01a2:4c99 90              NOP
       01a2:4c9a d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:4c9e 90              NOP
       01a2:4c9f d8 06 96 a4     FADD       float ptr [0xa496]
       01a2:4ca3 83 ec 04        SUB        SP,0x4
       01a2:4ca6 8b dc           MOV        BX,SP
       01a2:4ca8 90              NOP
       01a2:4ca9 d9 1f           FSTP       float ptr [BX]
       01a2:4cab 90              NOP
       01a2:4cac 9b              WAIT
       01a2:4cad 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:4cb2 90              NOP
       01a2:4cb3 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:4cb7 90              NOP
       01a2:4cb8 d8 06 b2 a4     FADD       float ptr [0xa4b2]
       01a2:4cbc 83 ec 04        SUB        SP,0x4
       01a2:4cbf 8b dc           MOV        BX,SP
       01a2:4cc1 90              NOP
       01a2:4cc2 d9 1f           FSTP       float ptr [BX]
       01a2:4cc4 90              NOP
       01a2:4cc5 9b              WAIT
       01a2:4cc6 90              NOP
       01a2:4cc7 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:4ccb 90              NOP
       01a2:4ccc d8 06 96 a4     FADD       float ptr [0xa496]
       01a2:4cd0 83 ec 04        SUB        SP,0x4
       01a2:4cd3 8b dc           MOV        BX,SP
       01a2:4cd5 90              NOP
       01a2:4cd6 d9 1f           FSTP       float ptr [BX]
       01a2:4cd8 90              NOP
       01a2:4cd9 9b              WAIT
       01a2:4cda 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:4cdf 33 c0           XOR        AX,AX
       01a2:4ce1 50              PUSH       AX
       01a2:4ce2 b8 ff ff        MOV        AX,0xffff
       01a2:4ce5 50              PUSH       AX
       01a2:4ce6 33 c0           XOR        AX,AX
       01a2:4ce8 50              PUSH       AX
       01a2:4ce9 9a 80 10        CALLF      LINE
                 71 0e
       01a2:4cee 90              NOP
       01a2:4cef d9 06 96 a4     FLD        float ptr [0xa496]
       01a2:4cf3 90              NOP
       01a2:4cf4 d8 06 b4 a6     FADD       float ptr { 2.0 }
                             LAB_01a2_4cf8                                   XREF[1]:     01a2:4c67(j)  
       01a2:4cf8 90              NOP
       01a2:4cf9 d9 1e 96 a4     FSTP       float ptr [0xa496]
       01a2:4cfd 90              NOP
       01a2:4cfe 9b              WAIT
       01a2:4cff 90              NOP
       01a2:4d00 d9 06 f6 b3     FLD        float ptr [0xb3f6]
       01a2:4d04 90              NOP
       01a2:4d05 d9 06 96 a4     FLD        float ptr [0xa496]
       01a2:4d09 90              NOP
       01a2:4d0a 9b              WAIT
       01a2:4d0b 9a 1d 04        CALLF      FPCOMPARE_2stack                                 undefined FPCOMPARE_2stack()
                 75 0d
       01a2:4d10 77 03           JA         LAB_01a2_4d15
       01a2:4d12 e9 55 ff        JMP        LAB_01a2_4c6a
                             LAB_01a2_4d15                                   XREF[1]:     01a2:4d10(j)  
       01a2:4d15 b8 c8 00        MOV        AX,0xc8
       01a2:4d18 50              PUSH       AX
       01a2:4d19 ff 36 52 a5     PUSH       word ptr [0xa552]
       01a2:4d1d ff 36 50 a5     PUSH       word ptr { 1.0 }
       01a2:4d21 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:4d26 9a 48 7d        CALLF      RND
                 71 0e
       01a2:4d2b 8b f0           MOV        SI,AX
       01a2:4d2d 90              NOP
       01a2:4d2e d9 04           FLD        float ptr [SI]
       01a2:4d30 90              NOP
       01a2:4d31 d8 0e 46 b4     FMUL       float ptr [0xb446]
       01a2:4d35 90              NOP
       01a2:4d36 d8 06 ce b4     FADD       float ptr [0xb4ce]
       01a2:4d3a 90              NOP
       01a2:4d3b d9 1e b6 a4     FSTP       float ptr [0xa4b6]
       01a2:4d3f 90              NOP
       01a2:4d40 9b              WAIT
       01a2:4d41 90              NOP
       01a2:4d42 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:4d46 90              NOP
       01a2:4d47 d8 06 14 a6     FADD       float ptr { 8.0 }
       01a2:4d4b 83 ec 04        SUB        SP,0x4
       01a2:4d4e 8b dc           MOV        BX,SP
       01a2:4d50 90              NOP
       01a2:4d51 d9 1f           FSTP       float ptr [BX]
       01a2:4d53 90              NOP
       01a2:4d54 9b              WAIT
       01a2:4d55 90              NOP
       01a2:4d56 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:4d5a 90              NOP
       01a2:4d5b d8 06 22 b4     FADD       float ptr [0xb422]
       01a2:4d5f 83 ec 04        SUB        SP,0x4
       01a2:4d62 8b dc           MOV        BX,SP
       01a2:4d64 90              NOP
       01a2:4d65 d9 1f           FSTP       float ptr [BX]
       01a2:4d67 90              NOP
       01a2:4d68 9b              WAIT
       01a2:4d69 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:4d6e 90              NOP
       01a2:4d6f d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:4d73 90              NOP
       01a2:4d74 d8 06 ea b3     FADD       float ptr [0xb3ea]
       01a2:4d78 83 ec 04        SUB        SP,0x4
       01a2:4d7b 8b dc           MOV        BX,SP
       01a2:4d7d 90              NOP
       01a2:4d7e d9 1f           FSTP       float ptr [BX]
       01a2:4d80 90              NOP
       01a2:4d81 9b              WAIT
       01a2:4d82 90              NOP
       01a2:4d83 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:4d87 90              NOP
       01a2:4d88 d8 06 b6 a4     FADD       float ptr [0xa4b6]
       01a2:4d8c 90              NOP
       01a2:4d8d d8 06 50 a5     FADD       float ptr { 1.0 }
       01a2:4d91 83 ec 04        SUB        SP,0x4
       01a2:4d94 8b dc           MOV        BX,SP
       01a2:4d96 90              NOP
       01a2:4d97 d9 1f           FSTP       float ptr [BX]
       01a2:4d99 90              NOP
       01a2:4d9a 9b              WAIT
       01a2:4d9b 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:4da0 33 c0           XOR        AX,AX
       01a2:4da2 50              PUSH       AX
       01a2:4da3 b8 ff ff        MOV        AX,0xffff
       01a2:4da6 50              PUSH       AX
       01a2:4da7 b8 01 00        MOV        AX,0x1
       01a2:4daa 50              PUSH       AX
       01a2:4dab 9a 80 10        CALLF      LINE
                 71 0e
       01a2:4db0 90              NOP
       01a2:4db1 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:4db5 90              NOP
       01a2:4db6 d8 06 94 af     FADD       float ptr { 9.0 }
       01a2:4dba 83 ec 04        SUB        SP,0x4
       01a2:4dbd 8b dc           MOV        BX,SP
       01a2:4dbf 90              NOP
       01a2:4dc0 d9 1f           FSTP       float ptr [BX]
       01a2:4dc2 90              NOP
       01a2:4dc3 9b              WAIT
       01a2:4dc4 90              NOP
       01a2:4dc5 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:4dc9 90              NOP
       01a2:4dca d8 06 22 b4     FADD       float ptr [0xb422]
       01a2:4dce 83 ec 04        SUB        SP,0x4
       01a2:4dd1 8b dc           MOV        BX,SP
       01a2:4dd3 90              NOP
       01a2:4dd4 d9 1f           FSTP       float ptr [BX]
       01a2:4dd6 90              NOP
       01a2:4dd7 9b              WAIT
       01a2:4dd8 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:4ddd 90              NOP
       01a2:4dde d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:4de2 90              NOP
       01a2:4de3 d8 06 26 b4     FADD       float ptr [0xb426]
       01a2:4de7 83 ec 04        SUB        SP,0x4
       01a2:4dea 8b dc           MOV        BX,SP
       01a2:4dec 90              NOP
       01a2:4ded d9 1f           FSTP       float ptr [BX]
       01a2:4def 90              NOP
       01a2:4df0 9b              WAIT
       01a2:4df1 90              NOP
       01a2:4df2 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:4df6 90              NOP
       01a2:4df7 d8 06 b6 a4     FADD       float ptr [0xa4b6]
       01a2:4dfb 83 ec 04        SUB        SP,0x4
       01a2:4dfe 8b dc           MOV        BX,SP
       01a2:4e00 90              NOP
       01a2:4e01 d9 1f           FSTP       float ptr [BX]
       01a2:4e03 90              NOP
       01a2:4e04 9b              WAIT
       01a2:4e05 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:4e0a b8 0f 00        MOV        AX,0xf
       01a2:4e0d 50              PUSH       AX
       01a2:4e0e b8 ff ff        MOV        AX,0xffff
       01a2:4e11 50              PUSH       AX
       01a2:4e12 b8 02 00        MOV        AX,0x2
       01a2:4e15 50              PUSH       AX
       01a2:4e16 9a 80 10        CALLF      LINE
                 71 0e
       01a2:4e1b e8 ab ee        CALL       FUN_01a2_3cc9                                    undefined FUN_01a2_3cc9()
       01a2:4e1e 90              NOP
       01a2:4e1f d9 06 b6 a4     FLD        float ptr [0xa4b6]
       01a2:4e23 90              NOP
       01a2:4e24 d8 06 16 b4     FADD       float ptr [0xb416]
       01a2:4e28 90              NOP
       01a2:4e29 d9 1e ba a4     FSTP       float ptr [0xa4ba]
       01a2:4e2d 90              NOP
       01a2:4e2e 9b              WAIT
       01a2:4e2f 90              NOP
       01a2:4e30 d9 06 ce b4     FLD        float ptr [0xb4ce]
       01a2:4e34 e9 8f 00        JMP        LAB_01a2_4ec6
       01a2:4e37 90              ??         90h
                             LAB_01a2_4e38                                   XREF[1]:     01a2:4ee0(j)  
       01a2:4e38 9a 48 7d        CALLF      RND
                 71 0e
       01a2:4e3d 8b f0           MOV        SI,AX
       01a2:4e3f 90              NOP
       01a2:4e40 d9 04           FLD        float ptr [SI]
       01a2:4e42 90              NOP
       01a2:4e43 d8 0e f6 b3     FMUL       float ptr [0xb3f6]
       01a2:4e47 90              NOP
       01a2:4e48 d8 06 8c af     FADD       float ptr { 10.0 }
       01a2:4e4c 90              NOP
       01a2:4e4d d9 1e b2 a4     FSTP       float ptr [0xa4b2]
       01a2:4e51 90              NOP
       01a2:4e52 9b              WAIT
       01a2:4e53 90              NOP
       01a2:4e54 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:4e58 90              NOP
       01a2:4e59 d8 06 8c af     FADD       float ptr { 10.0 }
       01a2:4e5d 83 ec 04        SUB        SP,0x4
       01a2:4e60 8b dc           MOV        BX,SP
       01a2:4e62 90              NOP
       01a2:4e63 d9 1f           FSTP       float ptr [BX]
       01a2:4e65 90              NOP
       01a2:4e66 9b              WAIT
       01a2:4e67 90              NOP
       01a2:4e68 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:4e6c 90              NOP
       01a2:4e6d d8 06 96 a4     FADD       float ptr [0xa496]
       01a2:4e71 83 ec 04        SUB        SP,0x4
       01a2:4e74 8b dc           MOV        BX,SP
       01a2:4e76 90              NOP
       01a2:4e77 d9 1f           FSTP       float ptr [BX]
       01a2:4e79 90              NOP
       01a2:4e7a 9b              WAIT
       01a2:4e7b 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:4e80 90              NOP
       01a2:4e81 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:4e85 90              NOP
       01a2:4e86 d8 06 b2 a4     FADD       float ptr [0xa4b2]
       01a2:4e8a 83 ec 04        SUB        SP,0x4
       01a2:4e8d 8b dc           MOV        BX,SP
       01a2:4e8f 90              NOP
       01a2:4e90 d9 1f           FSTP       float ptr [BX]
       01a2:4e92 90              NOP
       01a2:4e93 9b              WAIT
       01a2:4e94 90              NOP
       01a2:4e95 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:4e99 90              NOP
       01a2:4e9a d8 06 96 a4     FADD       float ptr [0xa496]
       01a2:4e9e 83 ec 04        SUB        SP,0x4
       01a2:4ea1 8b dc           MOV        BX,SP
       01a2:4ea3 90              NOP
       01a2:4ea4 d9 1f           FSTP       float ptr [BX]
       01a2:4ea6 90              NOP
       01a2:4ea7 9b              WAIT
       01a2:4ea8 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:4ead 33 c0           XOR        AX,AX
       01a2:4eaf 50              PUSH       AX
       01a2:4eb0 b8 ff ff        MOV        AX,0xffff
       01a2:4eb3 50              PUSH       AX
       01a2:4eb4 33 c0           XOR        AX,AX
       01a2:4eb6 50              PUSH       AX
       01a2:4eb7 9a 80 10        CALLF      LINE
                 71 0e
       01a2:4ebc 90              NOP
       01a2:4ebd d9 06 96 a4     FLD        float ptr [0xa496]
       01a2:4ec1 90              NOP
       01a2:4ec2 d8 06 b4 a6     FADD       float ptr { 2.0 }
                             LAB_01a2_4ec6                                   XREF[1]:     01a2:4e34(j)  
       01a2:4ec6 90              NOP
       01a2:4ec7 d9 1e 96 a4     FSTP       float ptr [0xa496]
       01a2:4ecb 90              NOP
       01a2:4ecc 9b              WAIT
       01a2:4ecd 90              NOP
       01a2:4ece d9 06 ba a4     FLD        float ptr [0xa4ba]
       01a2:4ed2 90              NOP
       01a2:4ed3 d9 06 96 a4     FLD        float ptr [0xa496]
       01a2:4ed7 90              NOP
       01a2:4ed8 9b              WAIT
       01a2:4ed9 9a 1d 04        CALLF      FPCOMPARE_2stack                                 undefined FPCOMPARE_2stack()
                 75 0d
       01a2:4ede 77 03           JA         LAB_01a2_4ee3
       01a2:4ee0 e9 55 ff        JMP        LAB_01a2_4e38
                             LAB_01a2_4ee3                                   XREF[1]:     01a2:4ede(j)  
       01a2:4ee3 b8 c8 00        MOV        AX,0xc8
       01a2:4ee6 50              PUSH       AX
       01a2:4ee7 ff 36 52 a5     PUSH       word ptr [0xa552]
       01a2:4eeb ff 36 50 a5     PUSH       word ptr { 1.0 }
       01a2:4eef 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:4ef4 90              NOP
       01a2:4ef5 d9 06 a6 b4     FLD        float ptr [0xb4a6]
       01a2:4ef9 e9 22 00        JMP        LAB_01a2_4f1e
                             LAB_01a2_4efc                                   XREF[1]:     01a2:4f36(j)  
       01a2:4efc 90              NOP
       01a2:4efd d9 06 96 a4     FLD        float ptr [0xa496]
       01a2:4f01 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:4f06 50              PUSH       AX
       01a2:4f07 ff 36 52 a5     PUSH       word ptr [0xa552]
       01a2:4f0b ff 36 50 a5     PUSH       word ptr { 1.0 }
       01a2:4f0f 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:4f14 90              NOP
       01a2:4f15 d9 06 96 a4     FLD        float ptr [0xa496]
       01a2:4f19 90              NOP
       01a2:4f1a d8 06 d2 b4     FADD       float ptr [0xb4d2]
                             LAB_01a2_4f1e                                   XREF[1]:     01a2:4ef9(j)  
       01a2:4f1e 90              NOP
       01a2:4f1f d9 1e 96 a4     FSTP       float ptr [0xa496]
       01a2:4f23 90              NOP
       01a2:4f24 9b              WAIT
       01a2:4f25 90              NOP
       01a2:4f26 d9 06 7a b4     FLD        float ptr [0xb47a]
       01a2:4f2a 90              NOP
       01a2:4f2b d9 06 96 a4     FLD        float ptr [0xa496]
       01a2:4f2f 90              NOP
       01a2:4f30 9b              WAIT
       01a2:4f31 9a 1d 04        CALLF      FPCOMPARE_2stack                                 undefined FPCOMPARE_2stack()
                 75 0d
       01a2:4f36 73 c4           JNC        LAB_01a2_4efc
       01a2:4f38 90              NOP
       01a2:4f39 d9 06 50 a5     FLD        float ptr { 1.0 }
       01a2:4f3d e9 ba 00        JMP        LAB_01a2_4ffa
                             LAB_01a2_4f40                                   XREF[1]:     01a2:5014(j)  
       01a2:4f40 9a 48 7d        CALLF      RND
                 71 0e
       01a2:4f45 8b f0           MOV        SI,AX
       01a2:4f47 90              NOP
       01a2:4f48 d9 04           FLD        float ptr [SI]
       01a2:4f4a 90              NOP
       01a2:4f4b d8 0e f6 b3     FMUL       float ptr [0xb3f6]
       01a2:4f4f 90              NOP
       01a2:4f50 d8 06 8c af     FADD       float ptr { 10.0 }
       01a2:4f54 90              NOP
       01a2:4f55 d9 1e b2 a4     FSTP       float ptr [0xa4b2]
       01a2:4f59 90              NOP
       01a2:4f5a 9b              WAIT
       01a2:4f5b 9a 48 7d        CALLF      RND
                 71 0e
       01a2:4f60 8b f0           MOV        SI,AX
       01a2:4f62 90              NOP
       01a2:4f63 d9 04           FLD        float ptr [SI]
       01a2:4f65 90              NOP
       01a2:4f66 d8 0e 2e b4     FMUL       float ptr [0xb42e]
       01a2:4f6a 90              NOP
       01a2:4f6b d8 06 24 a6     FADD       float ptr { 3.0 }
       01a2:4f6f 90              NOP
       01a2:4f70 d9 1e 82 a4     FSTP       float ptr [0xa482]
       01a2:4f74 90              NOP
       01a2:4f75 9b              WAIT
       01a2:4f76 90              NOP
       01a2:4f77 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:4f7b 90              NOP
       01a2:4f7c d8 06 8c af     FADD       float ptr { 10.0 }
       01a2:4f80 83 ec 04        SUB        SP,0x4
       01a2:4f83 8b dc           MOV        BX,SP
       01a2:4f85 90              NOP
       01a2:4f86 d9 1f           FSTP       float ptr [BX]
       01a2:4f88 90              NOP
       01a2:4f89 9b              WAIT
       01a2:4f8a 90              NOP
       01a2:4f8b d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:4f8f 90              NOP
       01a2:4f90 d8 06 82 a4     FADD       float ptr [0xa482]
       01a2:4f94 83 ec 04        SUB        SP,0x4
       01a2:4f97 8b dc           MOV        BX,SP
       01a2:4f99 90              NOP
       01a2:4f9a d9 1f           FSTP       float ptr [BX]
       01a2:4f9c 90              NOP
       01a2:4f9d 9b              WAIT
       01a2:4f9e 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:4fa3 90              NOP
       01a2:4fa4 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:4fa8 90              NOP
       01a2:4fa9 d8 06 b2 a4     FADD       float ptr [0xa4b2]
       01a2:4fad 83 ec 04        SUB        SP,0x4
       01a2:4fb0 8b dc           MOV        BX,SP
       01a2:4fb2 90              NOP
       01a2:4fb3 d9 1f           FSTP       float ptr [BX]
       01a2:4fb5 90              NOP
       01a2:4fb6 9b              WAIT
       01a2:4fb7 90              NOP
       01a2:4fb8 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:4fbc 90              NOP
       01a2:4fbd d8 06 82 a4     FADD       float ptr [0xa482]
       01a2:4fc1 83 ec 04        SUB        SP,0x4
       01a2:4fc4 8b dc           MOV        BX,SP
       01a2:4fc6 90              NOP
       01a2:4fc7 d9 1f           FSTP       float ptr [BX]
       01a2:4fc9 90              NOP
       01a2:4fca 9b              WAIT
       01a2:4fcb 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:4fd0 33 c0           XOR        AX,AX
       01a2:4fd2 50              PUSH       AX
       01a2:4fd3 b8 ff ff        MOV        AX,0xffff
       01a2:4fd6 50              PUSH       AX
       01a2:4fd7 33 c0           XOR        AX,AX
       01a2:4fd9 50              PUSH       AX
       01a2:4fda 9a 80 10        CALLF      LINE
                 71 0e
       01a2:4fdf b8 82 00        MOV        AX,0x82
       01a2:4fe2 50              PUSH       AX
       01a2:4fe3 ff 36 52 a5     PUSH       word ptr [0xa552]
       01a2:4fe7 ff 36 50 a5     PUSH       word ptr { 1.0 }
       01a2:4feb 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:4ff0 90              NOP
       01a2:4ff1 d9 06 96 a4     FLD        float ptr [0xa496]
       01a2:4ff5 90              NOP
       01a2:4ff6 d8 06 50 a5     FADD       float ptr { 1.0 }
                             LAB_01a2_4ffa                                   XREF[1]:     01a2:4f3d(j)  
       01a2:4ffa 90              NOP
       01a2:4ffb d9 1e 96 a4     FSTP       float ptr [0xa496]
       01a2:4fff 90              NOP
       01a2:5000 9b              WAIT
       01a2:5001 90              NOP
       01a2:5002 d9 06 36 b0     FLD        float ptr { 30.0 }
       01a2:5006 90              NOP
       01a2:5007 d9 06 96 a4     FLD        float ptr [0xa496]
       01a2:500b 90              NOP
       01a2:500c 9b              WAIT
       01a2:500d 9a 1d 04        CALLF      FPCOMPARE_2stack                                 undefined FPCOMPARE_2stack()
                 75 0d
       01a2:5012 77 03           JA         LAB_01a2_5017
       01a2:5014 e9 29 ff        JMP        LAB_01a2_4f40
                             LAB_01a2_5017                                   XREF[1]:     01a2:5012(j)  
       01a2:5017 c3              RET
                             **************************************************************
                             *                          FUNCTION                          *
                             **************************************************************
                             undefined __cdecl16near FUN_01a2_5018()
                               assume DS = 0x1997
             undefined         <UNASSIGNED>   <RETURN>
                             FUN_01a2_5018                                   XREF[2]:     FUN_01a2_19fa:01a2:2b12(c), 
                                                                                          FUN_01a2_19fa:01a2:2b55(c)  
       01a2:5018 90              NOP
       01a2:5019 d9 06 ae a4     FLD        float ptr [0xa4ae]
       01a2:501d 9a 00 07        CALLF      TIMER                                            undefined TIMER()
                 71 0e
       01a2:5022 8b f0           MOV        SI,AX
       01a2:5024 90              NOP
       01a2:5025 d9 04           FLD        float ptr [SI]
       01a2:5027 90              NOP
       01a2:5028 9b              WAIT
       01a2:5029 9a 1d 04        CALLF      FPCOMPARE_2stack                                 undefined FPCOMPARE_2stack()
                 75 0d
       01a2:502e 77 03           JA         LAB_01a2_5033
       01a2:5030 e9 11 00        JMP        LAB_01a2_5044
                             LAB_01a2_5033                                   XREF[1]:     01a2:502e(j)  
       01a2:5033 9a 00 07        CALLF      TIMER                                            undefined TIMER()
                 71 0e
       01a2:5038 8b f0           MOV        SI,AX
       01a2:503a 90              NOP
       01a2:503b d9 04           FLD        float ptr [SI]
       01a2:503d 90              NOP
       01a2:503e d9 1e ae a4     FSTP       float ptr [0xa4ae]
       01a2:5042 90              NOP
       01a2:5043 9b              WAIT
                             LAB_01a2_5044                                   XREF[1]:     01a2:5030(j)  
       01a2:5044 90              NOP
       01a2:5045 d9 06 ae a4     FLD        float ptr [0xa4ae]
       01a2:5049 90              NOP
       01a2:504a d8 06 36 b0     FADD       float ptr { 30.0 }
       01a2:504e 9a 48 7d        CALLF      RND
                 71 0e
       01a2:5053 8b f0           MOV        SI,AX
       01a2:5055 90              NOP
       01a2:5056 d9 04           FLD        float ptr [SI]
       01a2:5058 90              NOP
       01a2:5059 d8 0e 0c a6     FMUL       float ptr [0xa60c]
       01a2:505d 90              NOP
       01a2:505e de c1           FADDP
       01a2:5060 90              NOP
       01a2:5061 d9 1e ae a4     FSTP       float ptr [0xa4ae]
       01a2:5065 90              NOP
       01a2:5066 9b              WAIT
       01a2:5067 90              NOP
       01a2:5068 d9 06 ae a4     FLD        float ptr [0xa4ae]
       01a2:506c 90              NOP
       01a2:506d d9 06 72 a4     FLD        float ptr [0xa472]
       01a2:5071 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:5076 d1 e0           SHL        AX,0x1
       01a2:5078 d1 e0           SHL        AX,0x1
       01a2:507a 05 58 00        ADD        AX,0x58
       01a2:507d 8b f0           MOV        SI,AX
       01a2:507f 90              NOP
       01a2:5080 d9 9c 46 a2     FSTP       float ptr [SI + Fa246!(i,j)]
       01a2:5084 90              NOP
       01a2:5085 9b              WAIT
       01a2:5086 90              NOP
       01a2:5087 d9 06 b4 a6     FLD        float ptr { 2.0 }
       01a2:508b 90              NOP
       01a2:508c d9 06 72 a4     FLD        float ptr [0xa472]
       01a2:5090 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:5095 d1 e0           SHL        AX,0x1
       01a2:5097 d1 e0           SHL        AX,0x1
       01a2:5099 05 2c 00        ADD        AX,0x2c
       01a2:509c 8b f0           MOV        SI,AX
       01a2:509e 90              NOP
       01a2:509f d9 9c 46 a2     FSTP       float ptr [SI + Fa246!(i,j)]
       01a2:50a3 90              NOP
       01a2:50a4 9b              WAIT
       01a2:50a5 e8 68 e9        CALL       FUN_01a2_3a10                                    undefined FUN_01a2_3a10()
       01a2:50a8 b8 01 00        MOV        AX,0x1
       01a2:50ab 50              PUSH       AX
       01a2:50ac 90              NOP
       01a2:50ad d9 06 66 b4     FLD        float ptr [0xb466]
       01a2:50b1 90              NOP
                             **************************************************************
                             *                          FUNCTION                          *
                             **************************************************************
                             undefined FUN_01a2_50b2()
                               assume DS = 0x1997
             undefined         <UNASSIGNED>   <RETURN>
                             FUN_01a2_50b2
       01a2:50b2 d8 06 72 a4     FADD       float ptr [0xa472]
       01a2:50b6 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:50bb 50              PUSH       AX
       01a2:50bc b8 01 00        MOV        AX,0x1
       01a2:50bf 50              PUSH       AX
       01a2:50c0 b8 44 00        MOV        AX,0x44
       01a2:50c3 50              PUSH       AX
       01a2:50c4 b8 04 00        MOV        AX,0x4
       01a2:50c7 50              PUSH       AX
       01a2:50c8 9a b2 61        CALLF      LOCATE
                 71 0e
       01a2:50cd b8 01 00        MOV        AX,0x1
       01a2:50d0 50              PUSH       AX
       01a2:50d1 b8 0c 00        MOV        AX,0xc
       01a2:50d4 50              PUSH       AX
       01a2:50d5 b8 02 00        MOV        AX,0x2
       01a2:50d8 50              PUSH       AX
       01a2:50d9 9a 86 61        CALLF      COLOR
                 71 0e
       01a2:50de b8 d6 b4        MOV        AX,0xb4d6
       01a2:50e1 50              PUSH       AX
       01a2:50e2 9a c8 76        CALLF      PRINT_STR_NEWLINE
                 71 0e
       01a2:50e7 90              NOP
       01a2:50e8 d9 06 72 a4     FLD        float ptr [0xa472]
       01a2:50ec 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:50f1 d1 e0           SHL        AX,0x1
       01a2:50f3 d1 e0           SHL        AX,0x1
       01a2:50f5 05 84 00        ADD        AX,0x84
       01a2:50f8 8b f0           MOV        SI,AX
       01a2:50fa 90              NOP
       01a2:50fb d9 84 46 a2     FLD        float ptr [SI + Fa246!(i,j)]
       01a2:50ff 90              NOP
       01a2:5100 d9 1e 32 a2     FSTP       float ptr [0xa232]
       01a2:5104 90              NOP
       01a2:5105 9b              WAIT
       01a2:5106 90              NOP
       01a2:5107 d9 06 72 a4     FLD        float ptr [0xa472]
       01a2:510b 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:5110 d1 e0           SHL        AX,0x1
       01a2:5112 d1 e0           SHL        AX,0x1
       01a2:5114 05 b0 00        ADD        AX,0xb0
       01a2:5117 8b f0           MOV        SI,AX
       01a2:5119 90              NOP
       01a2:511a d9 84 46 a2     FLD        float ptr [SI + Fa246!(i,j)]
       01a2:511e 90              NOP
       01a2:511f d9 1e 2e a2     FSTP       float ptr [0xa22e]
       01a2:5123 90              NOP
                             **************************************************************
                             *                          FUNCTION                          *
                             **************************************************************
                             undefined __cdecl16near FUN_01a2_5124()
                               assume DS = 0x1997
             undefined         <UNASSIGNED>   <RETURN>
             undefined4        Stack[-0x4]:4  local_4                                 XREF[1]:     01a2:5135(*)  
                             FUN_01a2_5124
       01a2:5124 9b              WAIT
       01a2:5125 90              NOP
       01a2:5126 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:512a 90              NOP
       01a2:512b d8 06 80 af     FADD       float ptr { 6.0 }
       01a2:512f 83 ec 04        SUB        SP,0x4
       01a2:5132 8b dc           MOV        BX,SP
       01a2:5134 90              NOP
       01a2:5135 d9 1f           FSTP       float ptr [BX]=>local_4
       01a2:5137 90              NOP
       01a2:5138 9b              WAIT
       01a2:5139 ff 36 34 a2     PUSH       word ptr [0xa234]
       01a2:513d ff 36 32 a2     PUSH       word ptr [0xa232]
       01a2:5141 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:5146 90              NOP
       01a2:5147 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:514b 90              NOP
       01a2:514c d8 06 32 b4     FADD       float ptr [0xb432]
       01a2:5150 83 ec 04        SUB        SP,0x4
       01a2:5153 8b dc           MOV        BX,SP
       01a2:5155 90              NOP
       01a2:5156 d9 1f           FSTP       float ptr [BX]
       01a2:5158 90              NOP
       01a2:5159 9b              WAIT
       01a2:515a 90              NOP
       01a2:515b d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:515f 90              NOP
       01a2:5160 d8 06 56 b4     FADD       float ptr [0xb456]
       01a2:5164 83 ec 04        SUB        SP,0x4
       01a2:5167 8b dc           MOV        BX,SP
       01a2:5169 90              NOP
       01a2:516a d9 1f           FSTP       float ptr [BX]
       01a2:516c 90              NOP
       01a2:516d 9b              WAIT
       01a2:516e 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:5173 33 c0           XOR        AX,AX
       01a2:5175 50              PUSH       AX
       01a2:5176 b8 ff ff        MOV        AX,0xffff
       01a2:5179 50              PUSH       AX
       01a2:517a b8 02 00        MOV        AX,0x2
       01a2:517d 50              PUSH       AX
       01a2:517e 9a 80 10        CALLF      LINE
                 71 0e
       01a2:5183 b8 c8 00        MOV        AX,0xc8
       01a2:5186 50              PUSH       AX
       01a2:5187 ff 36 26 a6     PUSH       word ptr [0xa626]
       01a2:518b ff 36 24 a6     PUSH       word ptr { 3.0 }
       01a2:518f 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:5194 e8 f9 ea        CALL       FUN_01a2_3c90                                    undefined FUN_01a2_3c90()
       01a2:5197 90              NOP
       01a2:5198 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:519c 90              NOP
       01a2:519d d8 06 80 af     FADD       float ptr { 6.0 }
       01a2:51a1 83 ec 04        SUB        SP,0x4
       01a2:51a4 8b dc           MOV        BX,SP
       01a2:51a6 90              NOP
       01a2:51a7 d9 1f           FSTP       float ptr [BX]
       01a2:51a9 90              NOP
       01a2:51aa 9b              WAIT
       01a2:51ab ff 36 34 a2     PUSH       word ptr [0xa234]
       01a2:51af ff 36 32 a2     PUSH       word ptr [0xa232]
       01a2:51b3 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:51b8 90              NOP
       01a2:51b9 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:51bd 90              NOP
       01a2:51be d8 06 32 b4     FADD       float ptr [0xb432]
       01a2:51c2 83 ec 04        SUB        SP,0x4
       01a2:51c5 8b dc           MOV        BX,SP
       01a2:51c7 90              NOP
       01a2:51c8 d9 1f           FSTP       float ptr [BX]
       01a2:51ca 90              NOP
       01a2:51cb 9b              WAIT
       01a2:51cc 90              NOP
       01a2:51cd d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:51d1 90              NOP
       01a2:51d2 d8 06 56 b4     FADD       float ptr [0xb456]
       01a2:51d6 83 ec 04        SUB        SP,0x4
       01a2:51d9 8b dc           MOV        BX,SP
       01a2:51db 90              NOP
       01a2:51dc d9 1f           FSTP       float ptr [BX]
       01a2:51de 90              NOP
       01a2:51df 9b              WAIT
       01a2:51e0 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:51e5 b8 0f 00        MOV        AX,0xf
       01a2:51e8 50              PUSH       AX
       01a2:51e9 b8 ff ff        MOV        AX,0xffff
       01a2:51ec 50              PUSH       AX
       01a2:51ed b8 02 00        MOV        AX,0x2
       01a2:51f0 50              PUSH       AX
       01a2:51f1 9a 80 10        CALLF      LINE
                 71 0e
       01a2:51f6 b8 c8 00        MOV        AX,0xc8
       01a2:51f9 50              PUSH       AX
       01a2:51fa ff 36 26 a6     PUSH       word ptr [0xa626]
       01a2:51fe ff 36 24 a6     PUSH       word ptr { 3.0 }
       01a2:5202 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:5207 e8 86 ea        CALL       FUN_01a2_3c90                                    undefined FUN_01a2_3c90()
       01a2:520a 90              NOP
       01a2:520b d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:520f 90              NOP
       01a2:5210 d8 06 80 af     FADD       float ptr { 6.0 }
       01a2:5214 83 ec 04        SUB        SP,0x4
       01a2:5217 8b dc           MOV        BX,SP
       01a2:5219 90              NOP
       01a2:521a d9 1f           FSTP       float ptr [BX]
       01a2:521c 90              NOP
       01a2:521d 9b              WAIT
       01a2:521e ff 36 34 a2     PUSH       word ptr [0xa234]
       01a2:5222 ff 36 32 a2     PUSH       word ptr [0xa232]
       01a2:5226 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:522b 90              NOP
       01a2:522c d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:5230 90              NOP
       01a2:5231 d8 06 32 b4     FADD       float ptr [0xb432]
       01a2:5235 83 ec 04        SUB        SP,0x4
       01a2:5238 8b dc           MOV        BX,SP
       01a2:523a 90              NOP
       01a2:523b d9 1f           FSTP       float ptr [BX]
       01a2:523d 90              NOP
       01a2:523e 9b              WAIT
       01a2:523f 90              NOP
       01a2:5240 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:5244 90              NOP
       01a2:5245 d8 06 56 b4     FADD       float ptr [0xb456]
       01a2:5249 83 ec 04        SUB        SP,0x4
       01a2:524c 8b dc           MOV        BX,SP
       01a2:524e 90              NOP
       01a2:524f d9 1f           FSTP       float ptr [BX]
       01a2:5251 90              NOP
       01a2:5252 9b              WAIT
       01a2:5253 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:5258 33 c0           XOR        AX,AX
       01a2:525a 50              PUSH       AX
       01a2:525b b8 ff ff        MOV        AX,0xffff
       01a2:525e 50              PUSH       AX
       01a2:525f b8 02 00        MOV        AX,0x2
       01a2:5262 50              PUSH       AX
       01a2:5263 9a 80 10        CALLF      LINE
                 71 0e
       01a2:5268 b8 c8 00        MOV        AX,0xc8
       01a2:526b 50              PUSH       AX
       01a2:526c ff 36 26 a6     PUSH       word ptr [0xa626]
       01a2:5270 ff 36 24 a6     PUSH       word ptr { 3.0 }
       01a2:5274 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:5279 e8 14 ea        CALL       FUN_01a2_3c90                                    undefined FUN_01a2_3c90()
       01a2:527c 90              NOP
       01a2:527d d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:5281 90              NOP
       01a2:5282 d8 06 80 af     FADD       float ptr { 6.0 }
       01a2:5286 83 ec 04        SUB        SP,0x4
       01a2:5289 8b dc           MOV        BX,SP
       01a2:528b 90              NOP
       01a2:528c d9 1f           FSTP       float ptr [BX]
       01a2:528e 90              NOP
       01a2:528f 9b              WAIT
       01a2:5290 ff 36 34 a2     PUSH       word ptr [0xa234]
       01a2:5294 ff 36 32 a2     PUSH       word ptr [0xa232]
       01a2:5298 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:529d 90              NOP
       01a2:529e d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:52a2 90              NOP
       01a2:52a3 d8 06 32 b4     FADD       float ptr [0xb432]
       01a2:52a7 83 ec 04        SUB        SP,0x4
       01a2:52aa 8b dc           MOV        BX,SP
       01a2:52ac 90              NOP
       01a2:52ad d9 1f           FSTP       float ptr [BX]
       01a2:52af 90              NOP
       01a2:52b0 9b              WAIT
       01a2:52b1 90              NOP
       01a2:52b2 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:52b6 90              NOP
       01a2:52b7 d8 06 56 b4     FADD       float ptr [0xb456]
       01a2:52bb 83 ec 04        SUB        SP,0x4
       01a2:52be 8b dc           MOV        BX,SP
       01a2:52c0 90              NOP
       01a2:52c1 d9 1f           FSTP       float ptr [BX]
       01a2:52c3 90              NOP
       01a2:52c4 9b              WAIT
       01a2:52c5 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:52ca b8 0f 00        MOV        AX,0xf
       01a2:52cd 50              PUSH       AX
       01a2:52ce b8 ff ff        MOV        AX,0xffff
       01a2:52d1 50              PUSH       AX
       01a2:52d2 b8 02 00        MOV        AX,0x2
       01a2:52d5 50              PUSH       AX
       01a2:52d6 9a 80 10        CALLF      LINE
                 71 0e
       01a2:52db b8 c8 00        MOV        AX,0xc8
       01a2:52de 50              PUSH       AX
       01a2:52df ff 36 26 a6     PUSH       word ptr [0xa626]
       01a2:52e3 ff 36 24 a6     PUSH       word ptr { 3.0 }
       01a2:52e7 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:52ec e8 a1 e9        CALL       FUN_01a2_3c90                                    undefined FUN_01a2_3c90()
       01a2:52ef 90              NOP
       01a2:52f0 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:52f4 90              NOP
       01a2:52f5 d8 06 80 af     FADD       float ptr { 6.0 }
       01a2:52f9 83 ec 04        SUB        SP,0x4
       01a2:52fc 8b dc           MOV        BX,SP
       01a2:52fe 90              NOP
       01a2:52ff d9 1f           FSTP       float ptr [BX]
       01a2:5301 90              NOP
       01a2:5302 9b              WAIT
       01a2:5303 ff 36 34 a2     PUSH       word ptr [0xa234]
       01a2:5307 ff 36 32 a2     PUSH       word ptr [0xa232]
       01a2:530b 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:5310 90              NOP
       01a2:5311 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:5315 90              NOP
       01a2:5316 d8 06 32 b4     FADD       float ptr [0xb432]
       01a2:531a 83 ec 04        SUB        SP,0x4
       01a2:531d 8b dc           MOV        BX,SP
       01a2:531f 90              NOP
       01a2:5320 d9 1f           FSTP       float ptr [BX]
       01a2:5322 90              NOP
       01a2:5323 9b              WAIT
       01a2:5324 90              NOP
       01a2:5325 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:5329 90              NOP
       01a2:532a d8 06 56 b4     FADD       float ptr [0xb456]
       01a2:532e 83 ec 04        SUB        SP,0x4
       01a2:5331 8b dc           MOV        BX,SP
       01a2:5333 90              NOP
       01a2:5334 d9 1f           FSTP       float ptr [BX]
       01a2:5336 90              NOP
       01a2:5337 9b              WAIT
       01a2:5338 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:533d 33 c0           XOR        AX,AX
       01a2:533f 50              PUSH       AX
       01a2:5340 b8 ff ff        MOV        AX,0xffff
       01a2:5343 50              PUSH       AX
       01a2:5344 b8 02 00        MOV        AX,0x2
       01a2:5347 50              PUSH       AX
       01a2:5348 9a 80 10        CALLF      LINE
                 71 0e
       01a2:534d b8 64 00        MOV        AX,0x64
       01a2:5350 50              PUSH       AX
       01a2:5351 ff 36 7e a6     PUSH       word ptr [0xa67e]
       01a2:5355 ff 36 7c a6     PUSH       word ptr [0xa67c]
       01a2:5359 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:535e ff 36 30 a2     PUSH       word ptr [0xa230]
       01a2:5362 ff 36 2e a2     PUSH       word ptr [0xa22e]
       01a2:5366 90              NOP
       01a2:5367 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:536b 90              NOP
       01a2:536c d8 06 f2 b3     FADD       float ptr [0xb3f2]
       01a2:5370 83 ec 04        SUB        SP,0x4
       01a2:5373 8b dc           MOV        BX,SP
       01a2:5375 90              NOP
       01a2:5376 d9 1f           FSTP       float ptr [BX]
       01a2:5378 90              NOP
       01a2:5379 9b              WAIT
       01a2:537a 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:537f 90              NOP
       01a2:5380 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:5384 90              NOP
       01a2:5385 d8 06 f2 b3     FADD       float ptr [0xb3f2]
       01a2:5389 83 ec 04        SUB        SP,0x4
       01a2:538c 8b dc           MOV        BX,SP
       01a2:538e 90              NOP
       01a2:538f d9 1f           FSTP       float ptr [BX]
       01a2:5391 90              NOP
       01a2:5392 9b              WAIT
       01a2:5393 ff 36 34 a2     PUSH       word ptr [0xa234]
       01a2:5397 ff 36 32 a2     PUSH       word ptr [0xa232]
       01a2:539b 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:53a0 b8 04 00        MOV        AX,0x4
       01a2:53a3 50              PUSH       AX
       01a2:53a4 b8 ff ff        MOV        AX,0xffff
       01a2:53a7 50              PUSH       AX
       01a2:53a8 33 c0           XOR        AX,AX
       01a2:53aa 50              PUSH       AX
       01a2:53ab 9a 80 10        CALLF      LINE
                 71 0e
       01a2:53b0 90              NOP
       01a2:53b1 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:53b5 90              NOP
       01a2:53b6 d8 06 f2 b3     FADD       float ptr [0xb3f2]
       01a2:53ba 83 ec 04        SUB        SP,0x4
       01a2:53bd 8b dc           MOV        BX,SP
       01a2:53bf 90              NOP
       01a2:53c0 d9 1f           FSTP       float ptr [BX]
       01a2:53c2 90              NOP
       01a2:53c3 9b              WAIT
       01a2:53c4 ff 36 34 a2     PUSH       word ptr [0xa234]
       01a2:53c8 ff 36 32 a2     PUSH       word ptr [0xa232]
       01a2:53cc 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:53d1 90              NOP
       01a2:53d2 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:53d6 90              NOP
       01a2:53d7 d8 06 54 a6     FADD       float ptr { 50.0 }
       01a2:53db 83 ec 04        SUB        SP,0x4
       01a2:53de 8b dc           MOV        BX,SP
       01a2:53e0 90              NOP
       01a2:53e1 d9 1f           FSTP       float ptr [BX]
       01a2:53e3 90              NOP
       01a2:53e4 9b              WAIT
       01a2:53e5 90              NOP
       01a2:53e6 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:53ea 90              NOP
       01a2:53eb d8 06 da b3     FADD       float ptr [0xb3da]
       01a2:53ef 83 ec 04        SUB        SP,0x4
       01a2:53f2 8b dc           MOV        BX,SP
       01a2:53f4 90              NOP
       01a2:53f5 d9 1f           FSTP       float ptr [BX]
       01a2:53f7 90              NOP
       01a2:53f8 9b              WAIT
       01a2:53f9 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:53fe b8 04 00        MOV        AX,0x4
       01a2:5401 50              PUSH       AX
       01a2:5402 b8 ff ff        MOV        AX,0xffff
       01a2:5405 50              PUSH       AX
       01a2:5406 33 c0           XOR        AX,AX
       01a2:5408 50              PUSH       AX
       01a2:5409 9a 80 10        CALLF      LINE
                 71 0e
       01a2:540e 90              NOP
       01a2:540f d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:5413 90              NOP
       01a2:5414 d8 06 54 a6     FADD       float ptr { 50.0 }
       01a2:5418 83 ec 04        SUB        SP,0x4
       01a2:541b 8b dc           MOV        BX,SP
       01a2:541d 90              NOP
       01a2:541e d9 1f           FSTP       float ptr [BX]
       01a2:5420 90              NOP
       01a2:5421 9b              WAIT
       01a2:5422 90              NOP
       01a2:5423 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:5427 90              NOP
       01a2:5428 d8 06 da b3     FADD       float ptr [0xb3da]
       01a2:542c 83 ec 04        SUB        SP,0x4
       01a2:542f 8b dc           MOV        BX,SP
       01a2:5431 90              NOP
       01a2:5432 d9 1f           FSTP       float ptr [BX]
       01a2:5434 90              NOP
       01a2:5435 9b              WAIT
       01a2:5436 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:543b 90              NOP
       01a2:543c d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:5440 90              NOP
       01a2:5441 d8 06 fe b3     FADD       float ptr [0xb3fe]
       01a2:5445 83 ec 04        SUB        SP,0x4
       01a2:5448 8b dc           MOV        BX,SP
       01a2:544a 90              NOP
       01a2:544b d9 1f           FSTP       float ptr [BX]
       01a2:544d 90              NOP
       01a2:544e 9b              WAIT
       01a2:544f 90              NOP
       01a2:5450 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:5454 90              NOP
       01a2:5455 d8 06 fe b3     FADD       float ptr [0xb3fe]
       01a2:5459 83 ec 04        SUB        SP,0x4
       01a2:545c 8b dc           MOV        BX,SP
       01a2:545e 90              NOP
       01a2:545f d9 1f           FSTP       float ptr [BX]
       01a2:5461 90              NOP
       01a2:5462 9b              WAIT
       01a2:5463 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:5468 b8 04 00        MOV        AX,0x4
       01a2:546b 50              PUSH       AX
       01a2:546c b8 ff ff        MOV        AX,0xffff
       01a2:546f 50              PUSH       AX
       01a2:5470 33 c0           XOR        AX,AX
       01a2:5472 50              PUSH       AX
       01a2:5473 9a 80 10        CALLF      LINE
                 71 0e
       01a2:5478 90              NOP
       01a2:5479 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:547d 90              NOP
       01a2:547e d8 06 fe b3     FADD       float ptr [0xb3fe]
       01a2:5482 83 ec 04        SUB        SP,0x4
       01a2:5485 8b dc           MOV        BX,SP
       01a2:5487 90              NOP
       01a2:5488 d9 1f           FSTP       float ptr [BX]
       01a2:548a 90              NOP
       01a2:548b 9b              WAIT
       01a2:548c 90              NOP
       01a2:548d d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:5491 90              NOP
       01a2:5492 d8 06 fe b3     FADD       float ptr [0xb3fe]
       01a2:5496 83 ec 04        SUB        SP,0x4
       01a2:5499 8b dc           MOV        BX,SP
       01a2:549b 90              NOP
       01a2:549c d9 1f           FSTP       float ptr [BX]
       01a2:549e 90              NOP
       01a2:549f 9b              WAIT
       01a2:54a0 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:54a5 ff 36 30 a2     PUSH       word ptr [0xa230]
       01a2:54a9 ff 36 2e a2     PUSH       word ptr [0xa22e]
       01a2:54ad 90              NOP
       01a2:54ae d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:54b2 90              NOP
       01a2:54b3 d8 06 f2 b3     FADD       float ptr [0xb3f2]
       01a2:54b7 83 ec 04        SUB        SP,0x4
       01a2:54ba 8b dc           MOV        BX,SP
       01a2:54bc 90              NOP
       01a2:54bd d9 1f           FSTP       float ptr [BX]
       01a2:54bf 90              NOP
       01a2:54c0 9b              WAIT
       01a2:54c1 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:54c6 b8 04 00        MOV        AX,0x4
       01a2:54c9 50              PUSH       AX
       01a2:54ca b8 ff ff        MOV        AX,0xffff
       01a2:54cd 50              PUSH       AX
       01a2:54ce 33 c0           XOR        AX,AX
       01a2:54d0 50              PUSH       AX
       01a2:54d1 9a 80 10        CALLF      LINE
                 71 0e
       01a2:54d6 ff 36 30 a2     PUSH       word ptr [0xa230]
       01a2:54da ff 36 2e a2     PUSH       word ptr [0xa22e]
       01a2:54de ff 36 34 a2     PUSH       word ptr [0xa234]
       01a2:54e2 ff 36 32 a2     PUSH       word ptr [0xa232]
       01a2:54e6 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:54eb b8 04 00        MOV        AX,0x4
       01a2:54ee 50              PUSH       AX
       01a2:54ef 50              PUSH       AX
       01a2:54f0 9a 35 17        CALLF      PAINT
                 71 0e
       01a2:54f5 90              NOP
       01a2:54f6 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:54fa 90              NOP
       01a2:54fb d8 06 54 a6     FADD       float ptr { 50.0 }
       01a2:54ff 83 ec 04        SUB        SP,0x4
       01a2:5502 8b dc           MOV        BX,SP
       01a2:5504 90              NOP
       01a2:5505 d9 1f           FSTP       float ptr [BX]
       01a2:5507 90              NOP
       01a2:5508 9b              WAIT
       01a2:5509 90              NOP
       01a2:550a d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:550e 90              NOP
       01a2:550f d8 06 f2 b3     FADD       float ptr [0xb3f2]
       01a2:5513 83 ec 04        SUB        SP,0x4
       01a2:5516 8b dc           MOV        BX,SP
       01a2:5518 90              NOP
       01a2:5519 d9 1f           FSTP       float ptr [BX]
       01a2:551b 90              NOP
       01a2:551c 9b              WAIT
       01a2:551d 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:5522 90              NOP
       01a2:5523 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:5527 90              NOP
       01a2:5528 d8 06 fe b3     FADD       float ptr [0xb3fe]
       01a2:552c 83 ec 04        SUB        SP,0x4
       01a2:552f 8b dc           MOV        BX,SP
       01a2:5531 90              NOP
       01a2:5532 d9 1f           FSTP       float ptr [BX]
       01a2:5534 90              NOP
       01a2:5535 9b              WAIT
       01a2:5536 ff 36 34 a2     PUSH       word ptr [0xa234]
       01a2:553a ff 36 32 a2     PUSH       word ptr [0xa232]
       01a2:553e 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:5543 b8 04 00        MOV        AX,0x4
       01a2:5546 50              PUSH       AX
       01a2:5547 b8 ff ff        MOV        AX,0xffff
       01a2:554a 50              PUSH       AX
       01a2:554b 33 c0           XOR        AX,AX
       01a2:554d 50              PUSH       AX
       01a2:554e 9a 80 10        CALLF      LINE
                 71 0e
       01a2:5553 90              NOP
       01a2:5554 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:5558 90              NOP
       01a2:5559 d8 06 fe b3     FADD       float ptr [0xb3fe]
       01a2:555d 83 ec 04        SUB        SP,0x4
       01a2:5560 8b dc           MOV        BX,SP
       01a2:5562 90              NOP
       01a2:5563 d9 1f           FSTP       float ptr [BX]
       01a2:5565 90              NOP
       01a2:5566 9b              WAIT
       01a2:5567 ff 36 34 a2     PUSH       word ptr [0xa234]
       01a2:556b ff 36 32 a2     PUSH       word ptr [0xa232]
       01a2:556f 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:5574 ff 36 30 a2     PUSH       word ptr [0xa230]
       01a2:5578 ff 36 2e a2     PUSH       word ptr [0xa22e]
       01a2:557c 90              NOP
       01a2:557d d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:5581 90              NOP
       01a2:5582 d8 06 da b3     FADD       float ptr [0xb3da]
       01a2:5586 83 ec 04        SUB        SP,0x4
       01a2:5589 8b dc           MOV        BX,SP
       01a2:558b 90              NOP
       01a2:558c d9 1f           FSTP       float ptr [BX]
       01a2:558e 90              NOP
       01a2:558f 9b              WAIT
       01a2:5590 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:5595 b8 04 00        MOV        AX,0x4
       01a2:5598 50              PUSH       AX
       01a2:5599 b8 ff ff        MOV        AX,0xffff
       01a2:559c 50              PUSH       AX
       01a2:559d 33 c0           XOR        AX,AX
       01a2:559f 50              PUSH       AX
       01a2:55a0 9a 80 10        CALLF      LINE
                 71 0e
       01a2:55a5 ff 36 30 a2     PUSH       word ptr [0xa230]
       01a2:55a9 ff 36 2e a2     PUSH       word ptr [0xa22e]
       01a2:55ad 90              NOP
       01a2:55ae d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:55b2 90              NOP
       01a2:55b3 d8 06 da b3     FADD       float ptr [0xb3da]
       01a2:55b7 83 ec 04        SUB        SP,0x4
       01a2:55ba 8b dc           MOV        BX,SP
       01a2:55bc 90              NOP
       01a2:55bd d9 1f           FSTP       float ptr [BX]
       01a2:55bf 90              NOP
       01a2:55c0 9b              WAIT
       01a2:55c1 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:55c6 90              NOP
       01a2:55c7 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:55cb 90              NOP
       01a2:55cc d8 06 f2 b3     FADD       float ptr [0xb3f2]
       01a2:55d0 83 ec 04        SUB        SP,0x4
       01a2:55d3 8b dc           MOV        BX,SP
       01a2:55d5 90              NOP
       01a2:55d6 d9 1f           FSTP       float ptr [BX]
       01a2:55d8 90              NOP
       01a2:55d9 9b              WAIT
       01a2:55da 90              NOP
       01a2:55db d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:55df 90              NOP
       01a2:55e0 d8 06 fe b3     FADD       float ptr [0xb3fe]
       01a2:55e4 83 ec 04        SUB        SP,0x4
       01a2:55e7 8b dc           MOV        BX,SP
       01a2:55e9 90              NOP
       01a2:55ea d9 1f           FSTP       float ptr [BX]
       01a2:55ec 90              NOP
       01a2:55ed 9b              WAIT
       01a2:55ee 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:55f3 b8 04 00        MOV        AX,0x4
       01a2:55f6 50              PUSH       AX
       01a2:55f7 b8 ff ff        MOV        AX,0xffff
       01a2:55fa 50              PUSH       AX
       01a2:55fb 33 c0           XOR        AX,AX
       01a2:55fd 50              PUSH       AX
       01a2:55fe 9a 80 10        CALLF      LINE
                 71 0e
       01a2:5603 90              NOP
       01a2:5604 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:5608 90              NOP
       01a2:5609 d8 06 f2 b3     FADD       float ptr [0xb3f2]
       01a2:560d 83 ec 04        SUB        SP,0x4
       01a2:5610 8b dc           MOV        BX,SP
       01a2:5612 90              NOP
       01a2:5613 d9 1f           FSTP       float ptr [BX]
       01a2:5615 90              NOP
       01a2:5616 9b              WAIT
       01a2:5617 90              NOP
       01a2:5618 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:561c 90              NOP
       01a2:561d d8 06 fe b3     FADD       float ptr [0xb3fe]
       01a2:5621 83 ec 04        SUB        SP,0x4
       01a2:5624 8b dc           MOV        BX,SP
       01a2:5626 90              NOP
       01a2:5627 d9 1f           FSTP       float ptr [BX]
       01a2:5629 90              NOP
       01a2:562a 9b              WAIT
       01a2:562b 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:5630 90              NOP
       01a2:5631 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:5635 90              NOP
       01a2:5636 d8 06 54 a6     FADD       float ptr { 50.0 }
       01a2:563a 83 ec 04        SUB        SP,0x4
       01a2:563d 8b dc           MOV        BX,SP
       01a2:563f 90              NOP
       01a2:5640 d9 1f           FSTP       float ptr [BX]
       01a2:5642 90              NOP
       01a2:5643 9b              WAIT
       01a2:5644 90              NOP
       01a2:5645 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:5649 90              NOP
       01a2:564a d8 06 f2 b3     FADD       float ptr [0xb3f2]
       01a2:564e 83 ec 04        SUB        SP,0x4
       01a2:5651 8b dc           MOV        BX,SP
       01a2:5653 90              NOP
       01a2:5654 d9 1f           FSTP       float ptr [BX]
       01a2:5656 90              NOP
       01a2:5657 9b              WAIT
       01a2:5658 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:565d b8 04 00        MOV        AX,0x4
       01a2:5660 50              PUSH       AX
       01a2:5661 b8 ff ff        MOV        AX,0xffff
       01a2:5664 50              PUSH       AX
       01a2:5665 33 c0           XOR        AX,AX
       01a2:5667 50              PUSH       AX
       01a2:5668 9a 80 10        CALLF      LINE
                 71 0e
       01a2:566d ff 36 30 a2     PUSH       word ptr [0xa230]
       01a2:5671 ff 36 2e a2     PUSH       word ptr [0xa22e]
       01a2:5675 90              NOP
       01a2:5676 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:567a 90              NOP
       01a2:567b d8 06 fe b3     FADD       float ptr [0xb3fe]
       01a2:567f 83 ec 04        SUB        SP,0x4
       01a2:5682 8b dc           MOV        BX,SP
       01a2:5684 90              NOP
       01a2:5685 d9 1f           FSTP       float ptr [BX]
       01a2:5687 90              NOP
       01a2:5688 9b              WAIT
       01a2:5689 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:568e b8 04 00        MOV        AX,0x4
       01a2:5691 50              PUSH       AX
       01a2:5692 50              PUSH       AX
       01a2:5693 9a 35 17        CALLF      PAINT
                 71 0e
       01a2:5698 90              NOP
       01a2:5699 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:569d 90              NOP
       01a2:569e d8 06 54 a6     FADD       float ptr { 50.0 }
       01a2:56a2 83 ec 04        SUB        SP,0x4
       01a2:56a5 8b dc           MOV        BX,SP
       01a2:56a7 90              NOP
       01a2:56a8 d9 1f           FSTP       float ptr [BX]
       01a2:56aa 90              NOP
       01a2:56ab 9b              WAIT
       01a2:56ac ff 36 34 a2     PUSH       word ptr [0xa234]
       01a2:56b0 ff 36 32 a2     PUSH       word ptr [0xa232]
       01a2:56b4 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:56b9 b8 04 00        MOV        AX,0x4
       01a2:56bc 50              PUSH       AX
       01a2:56bd 50              PUSH       AX
       01a2:56be 9a 35 17        CALLF      PAINT
                 71 0e
       01a2:56c3 c3              RET
                             **************************************************************
                             *                          FUNCTION                          *
                             **************************************************************
                             undefined __cdecl16near FUN_01a2_56c4()
                               assume DS = 0x1997
             undefined         <UNASSIGNED>   <RETURN>
                             FUN_01a2_56c4                                   XREF[2]:     FUN_01a2_19fa:01a2:2bfc(c), 
                                                                                          FUN_01a2_19fa:01a2:2c93(c)  
       01a2:56c4 90              NOP
       01a2:56c5 d9 06 ae a4     FLD        float ptr [0xa4ae]
       01a2:56c9 9a 00 07        CALLF      TIMER                                            undefined TIMER()
                 71 0e
       01a2:56ce 8b f0           MOV        SI,AX
       01a2:56d0 90              NOP
       01a2:56d1 d9 04           FLD        float ptr [SI]
       01a2:56d3 90              NOP
       01a2:56d4 9b              WAIT
       01a2:56d5 9a 1d 04        CALLF      FPCOMPARE_2stack                                 undefined FPCOMPARE_2stack()
                 75 0d
       01a2:56da 77 03           JA         LAB_01a2_56df
       01a2:56dc e9 11 00        JMP        LAB_01a2_56f0
                             LAB_01a2_56df                                   XREF[1]:     01a2:56da(j)  
       01a2:56df 9a 00 07        CALLF      TIMER                                            undefined TIMER()
                 71 0e
       01a2:56e4 8b f0           MOV        SI,AX
       01a2:56e6 90              NOP
       01a2:56e7 d9 04           FLD        float ptr [SI]
       01a2:56e9 90              NOP
       01a2:56ea d9 1e ae a4     FSTP       float ptr [0xa4ae]
       01a2:56ee 90              NOP
       01a2:56ef 9b              WAIT
                             LAB_01a2_56f0                                   XREF[1]:     01a2:56dc(j)  
       01a2:56f0 90              NOP
       01a2:56f1 d9 06 ae a4     FLD        float ptr [0xa4ae]
       01a2:56f5 90              NOP
       01a2:56f6 d8 06 ce b4     FADD       float ptr [0xb4ce]
       01a2:56fa 9a 48 7d        CALLF      RND
                 71 0e
       01a2:56ff 8b f0           MOV        SI,AX
       01a2:5701 90              NOP
       01a2:5702 d9 04           FLD        float ptr [SI]
       01a2:5704 90              NOP
       01a2:5705 d8 0e 2e b4     FMUL       float ptr [0xb42e]
       01a2:5709 90              NOP
       01a2:570a de c1           FADDP
       01a2:570c 90              NOP
       01a2:570d d9 1e ae a4     FSTP       float ptr [0xa4ae]
       01a2:5711 90              NOP
       01a2:5712 9b              WAIT
       01a2:5713 90              NOP
       01a2:5714 d9 06 ae a4     FLD        float ptr [0xa4ae]
       01a2:5718 90              NOP
       01a2:5719 d9 06 72 a4     FLD        float ptr [0xa472]
       01a2:571d 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:5722 d1 e0           SHL        AX,0x1
       01a2:5724 d1 e0           SHL        AX,0x1
       01a2:5726 05 58 00        ADD        AX,0x58
       01a2:5729 8b f0           MOV        SI,AX
       01a2:572b 90              NOP
       01a2:572c d9 9c 46 a2     FSTP       float ptr [SI + Fa246!(i,j)]
       01a2:5730 90              NOP
       01a2:5731 9b              WAIT
       01a2:5732 90              NOP
       01a2:5733 d9 06 24 a6     FLD        float ptr { 3.0 }
       01a2:5737 90              NOP
       01a2:5738 d9 06 72 a4     FLD        float ptr [0xa472]
       01a2:573c 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:5741 d1 e0           SHL        AX,0x1
       01a2:5743 d1 e0           SHL        AX,0x1
       01a2:5745 05 2c 00        ADD        AX,0x2c
       01a2:5748 8b f0           MOV        SI,AX
       01a2:574a 90              NOP
       01a2:574b d9 9c 46 a2     FSTP       float ptr [SI + Fa246!(i,j)]
       01a2:574f 90              NOP
       01a2:5750 9b              WAIT
       01a2:5751 e8 bc e2        CALL       FUN_01a2_3a10                                    undefined FUN_01a2_3a10()
       01a2:5754 b8 01 00        MOV        AX,0x1
       01a2:5757 50              PUSH       AX
       01a2:5758 90              NOP
       01a2:5759 d9 06 66 b4     FLD        float ptr [0xb466]
       01a2:575d 90              NOP
       01a2:575e d8 06 72 a4     FADD       float ptr [0xa472]
       01a2:5762 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:5767 50              PUSH       AX
       01a2:5768 b8 01 00        MOV        AX,0x1
       01a2:576b 50              PUSH       AX
       01a2:576c b8 44 00        MOV        AX,0x44
       01a2:576f 50              PUSH       AX
       01a2:5770 b8 04 00        MOV        AX,0x4
       01a2:5773 50              PUSH       AX
       01a2:5774 9a b2 61        CALLF      LOCATE
                 71 0e
       01a2:5779 b8 01 00        MOV        AX,0x1
       01a2:577c 50              PUSH       AX
       01a2:577d b8 0d 00        MOV        AX,0xd
       01a2:5780 50              PUSH       AX
       01a2:5781 b8 02 00        MOV        AX,0x2
       01a2:5784 50              PUSH       AX
       01a2:5785 9a 86 61        CALLF      COLOR
                 71 0e
       01a2:578a b8 e6 b4        MOV        AX,0xb4e6
       01a2:578d 50              PUSH       AX
       01a2:578e 9a c8 76        CALLF      PRINT_STR_NEWLINE
                 71 0e
       01a2:5793 90              NOP
       01a2:5794 d9 06 72 a4     FLD        float ptr [0xa472]
       01a2:5798 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:579d d1 e0           SHL        AX,0x1
       01a2:579f d1 e0           SHL        AX,0x1
       01a2:57a1 05 84 00        ADD        AX,0x84
       01a2:57a4 8b f0           MOV        SI,AX
       01a2:57a6 90              NOP
       01a2:57a7 d9 84 46 a2     FLD        float ptr [SI + Fa246!(i,j)]
       01a2:57ab 90              NOP
       01a2:57ac d9 1e 32 a2     FSTP       float ptr [0xa232]
       01a2:57b0 90              NOP
       01a2:57b1 9b              WAIT
       01a2:57b2 90              NOP
       01a2:57b3 d9 06 72 a4     FLD        float ptr [0xa472]
       01a2:57b7 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:57bc d1 e0           SHL        AX,0x1
       01a2:57be d1 e0           SHL        AX,0x1
       01a2:57c0 05 b0 00        ADD        AX,0xb0
       01a2:57c3 8b f0           MOV        SI,AX
       01a2:57c5 90              NOP
       01a2:57c6 d9 84 46 a2     FLD        float ptr [SI + Fa246!(i,j)]
       01a2:57ca 90              NOP
       01a2:57cb d9 1e 2e a2     FSTP       float ptr [0xa22e]
       01a2:57cf 90              NOP
       01a2:57d0 9b              WAIT
       01a2:57d1 e8 59 d6        CALL       FUN_01a2_2e2d                                    undefined FUN_01a2_2e2d()
       01a2:57d4 e8 f2 e4        CALL       FUN_01a2_3cc9                                    undefined FUN_01a2_3cc9()
       01a2:57d7 90              NOP
       01a2:57d8 d9 06 4c a6     FLD        float ptr { 0.0 }
       01a2:57dc 90              NOP
       01a2:57dd d9 1e be a4     FSTP       float ptr [0xa4be]
       01a2:57e1 90              NOP
       01a2:57e2 9b              WAIT
       01a2:57e3 90              NOP
       01a2:57e4 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:57e8 90              NOP
       01a2:57e9 d8 06 f6 b4     FADD       float ptr [0xb4f6]
       01a2:57ed 83 ec 04        SUB        SP,0x4
       01a2:57f0 8b dc           MOV        BX,SP
       01a2:57f2 90              NOP
       01a2:57f3 d9 1f           FSTP       float ptr [BX]
       01a2:57f5 90              NOP
       01a2:57f6 9b              WAIT
       01a2:57f7 90              NOP
       01a2:57f8 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:57fc 90              NOP
       01a2:57fd d8 06 24 b0     FADD       float ptr { 27.0 }
       01a2:5801 83 ec 04        SUB        SP,0x4
       01a2:5804 8b dc           MOV        BX,SP
       01a2:5806 90              NOP
       01a2:5807 d9 1f           FSTP       float ptr [BX]
       01a2:5809 90              NOP
       01a2:580a 9b              WAIT
       01a2:580b 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:5810 ff 36 38 b0     PUSH       word ptr [0xb038]
       01a2:5814 ff 36 36 b0     PUSH       word ptr { 30.0 }
       01a2:5818 90              NOP
       01a2:5819 d9 06 be a4     FLD        float ptr [0xa4be]
       01a2:581d 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:5822 50              PUSH       AX
       01a2:5823 9a b4 0d        CALLF      CIRCLE
                 71 0e
       01a2:5828 b8 bc 02        MOV        AX,0x2bc
       01a2:582b 50              PUSH       AX
       01a2:582c ff 36 52 a5     PUSH       word ptr [0xa552]
       01a2:5830 ff 36 50 a5     PUSH       word ptr { 1.0 }
       01a2:5834 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:5839 e8 8d e4        CALL       FUN_01a2_3cc9                                    undefined FUN_01a2_3cc9()
       01a2:583c 90              NOP
       01a2:583d d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:5841 90              NOP
       01a2:5842 d8 06 f6 b4     FADD       float ptr [0xb4f6]
       01a2:5846 83 ec 04        SUB        SP,0x4
       01a2:5849 8b dc           MOV        BX,SP
       01a2:584b 90              NOP
       01a2:584c d9 1f           FSTP       float ptr [BX]
       01a2:584e 90              NOP
       01a2:584f 9b              WAIT
       01a2:5850 90              NOP
       01a2:5851 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:5855 90              NOP
       01a2:5856 d8 06 24 b0     FADD       float ptr { 27.0 }
       01a2:585a 83 ec 04        SUB        SP,0x4
       01a2:585d 8b dc           MOV        BX,SP
       01a2:585f 90              NOP
       01a2:5860 d9 1f           FSTP       float ptr [BX]
       01a2:5862 90              NOP
       01a2:5863 9b              WAIT
       01a2:5864 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:5869 ff 36 12 a6     PUSH       word ptr [0xa612]
       01a2:586d ff 36 10 a6     PUSH       word ptr { 18.0 }
       01a2:5871 90              NOP
       01a2:5872 d9 06 be a4     FLD        float ptr [0xa4be]
       01a2:5876 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:587b 50              PUSH       AX
       01a2:587c 9a b4 0d        CALLF      CIRCLE
                 71 0e
       01a2:5881 b8 bc 02        MOV        AX,0x2bc
       01a2:5884 50              PUSH       AX
       01a2:5885 ff 36 52 a5     PUSH       word ptr [0xa552]
       01a2:5889 ff 36 50 a5     PUSH       word ptr { 1.0 }
       01a2:588d 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:5892 e8 34 e4        CALL       FUN_01a2_3cc9                                    undefined FUN_01a2_3cc9()
       01a2:5895 90              NOP
       01a2:5896 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:589a 90              NOP
       01a2:589b d8 06 f6 b4     FADD       float ptr [0xb4f6]
       01a2:589f 83 ec 04        SUB        SP,0x4
       01a2:58a2 8b dc           MOV        BX,SP
       01a2:58a4 90              NOP
       01a2:58a5 d9 1f           FSTP       float ptr [BX]
       01a2:58a7 90              NOP
       01a2:58a8 9b              WAIT
       01a2:58a9 90              NOP
       01a2:58aa d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:58ae 90              NOP
       01a2:58af d8 06 24 b0     FADD       float ptr { 27.0 }
       01a2:58b3 83 ec 04        SUB        SP,0x4
       01a2:58b6 8b dc           MOV        BX,SP
       01a2:58b8 90              NOP
       01a2:58b9 d9 1f           FSTP       float ptr [BX]
       01a2:58bb 90              NOP
       01a2:58bc 9b              WAIT
       01a2:58bd 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:58c2 ff 36 82 af     PUSH       word ptr [0xaf82]
       01a2:58c6 ff 36 80 af     PUSH       word ptr { 6.0 }
       01a2:58ca 90              NOP
       01a2:58cb d9 06 be a4     FLD        float ptr [0xa4be]
       01a2:58cf 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:58d4 50              PUSH       AX
       01a2:58d5 9a b4 0d        CALLF      CIRCLE
                 71 0e
       01a2:58da b8 bc 02        MOV        AX,0x2bc
       01a2:58dd 50              PUSH       AX
       01a2:58de ff 36 52 a5     PUSH       word ptr [0xa552]
       01a2:58e2 ff 36 50 a5     PUSH       word ptr { 1.0 }
       01a2:58e6 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:58eb e8 db e3        CALL       FUN_01a2_3cc9                                    undefined FUN_01a2_3cc9()
       01a2:58ee 90              NOP
       01a2:58ef d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:58f3 90              NOP
       01a2:58f4 d8 06 f6 b4     FADD       float ptr [0xb4f6]
       01a2:58f8 83 ec 04        SUB        SP,0x4
       01a2:58fb 8b dc           MOV        BX,SP
       01a2:58fd 90              NOP
       01a2:58fe d9 1f           FSTP       float ptr [BX]
       01a2:5900 90              NOP
       01a2:5901 9b              WAIT
       01a2:5902 90              NOP
       01a2:5903 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:5907 90              NOP
       01a2:5908 d8 06 e6 b3     FADD       float ptr [0xb3e6]
       01a2:590c 83 ec 04        SUB        SP,0x4
       01a2:590f 8b dc           MOV        BX,SP
       01a2:5911 90              NOP
       01a2:5912 d9 1f           FSTP       float ptr [BX]
       01a2:5914 90              NOP
       01a2:5915 9b              WAIT
       01a2:5916 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:591b 90              NOP
       01a2:591c d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:5920 90              NOP
       01a2:5921 d8 06 f6 b4     FADD       float ptr [0xb4f6]
       01a2:5925 83 ec 04        SUB        SP,0x4
       01a2:5928 8b dc           MOV        BX,SP
       01a2:592a 90              NOP
       01a2:592b d9 1f           FSTP       float ptr [BX]
       01a2:592d 90              NOP
       01a2:592e 9b              WAIT
       01a2:592f 90              NOP
       01a2:5930 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:5934 90              NOP
       01a2:5935 d8 06 0a b4     FADD       float ptr [0xb40a]
       01a2:5939 83 ec 04        SUB        SP,0x4
       01a2:593c 8b dc           MOV        BX,SP
       01a2:593e 90              NOP
       01a2:593f d9 1f           FSTP       float ptr [BX]
       01a2:5941 90              NOP
       01a2:5942 9b              WAIT
       01a2:5943 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:5948 90              NOP
       01a2:5949 d9 06 be a4     FLD        float ptr [0xa4be]
       01a2:594d 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:5952 50              PUSH       AX
       01a2:5953 b8 ff ff        MOV        AX,0xffff
       01a2:5956 50              PUSH       AX
       01a2:5957 33 c0           XOR        AX,AX
       01a2:5959 50              PUSH       AX
       01a2:595a 9a 80 10        CALLF      LINE
                 71 0e
       01a2:595f 90              NOP
       01a2:5960 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:5964 90              NOP
       01a2:5965 d8 06 f2 b3     FADD       float ptr [0xb3f2]
       01a2:5969 83 ec 04        SUB        SP,0x4
       01a2:596c 8b dc           MOV        BX,SP
       01a2:596e 90              NOP
       01a2:596f d9 1f           FSTP       float ptr [BX]
       01a2:5971 90              NOP
       01a2:5972 9b              WAIT
       01a2:5973 90              NOP
       01a2:5974 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:5978 90              NOP
       01a2:5979 d8 06 24 b0     FADD       float ptr { 27.0 }
       01a2:597d 83 ec 04        SUB        SP,0x4
       01a2:5980 8b dc           MOV        BX,SP
       01a2:5982 90              NOP
       01a2:5983 d9 1f           FSTP       float ptr [BX]
       01a2:5985 90              NOP
       01a2:5986 9b              WAIT
       01a2:5987 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:598c 90              NOP
       01a2:598d d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:5991 90              NOP
       01a2:5992 d8 06 fe b3     FADD       float ptr [0xb3fe]
       01a2:5996 83 ec 04        SUB        SP,0x4
       01a2:5999 8b dc           MOV        BX,SP
       01a2:599b 90              NOP
       01a2:599c d9 1f           FSTP       float ptr [BX]
       01a2:599e 90              NOP
       01a2:599f 9b              WAIT
       01a2:59a0 90              NOP
       01a2:59a1 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:59a5 90              NOP
       01a2:59a6 d8 06 24 b0     FADD       float ptr { 27.0 }
       01a2:59aa 83 ec 04        SUB        SP,0x4
       01a2:59ad 8b dc           MOV        BX,SP
       01a2:59af 90              NOP
       01a2:59b0 d9 1f           FSTP       float ptr [BX]
       01a2:59b2 90              NOP
       01a2:59b3 9b              WAIT
       01a2:59b4 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:59b9 90              NOP
       01a2:59ba d9 06 be a4     FLD        float ptr [0xa4be]
       01a2:59be 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:59c3 50              PUSH       AX
       01a2:59c4 b8 ff ff        MOV        AX,0xffff
       01a2:59c7 50              PUSH       AX
       01a2:59c8 33 c0           XOR        AX,AX
       01a2:59ca 50              PUSH       AX
       01a2:59cb 9a 80 10        CALLF      LINE
                 71 0e
       01a2:59d0 b8 bc 02        MOV        AX,0x2bc
       01a2:59d3 50              PUSH       AX
       01a2:59d4 ff 36 52 a5     PUSH       word ptr [0xa552]
       01a2:59d8 ff 36 50 a5     PUSH       word ptr { 1.0 }
       01a2:59dc 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:59e1 e8 ac e2        CALL       FUN_01a2_3c90                                    undefined FUN_01a2_3c90()
       01a2:59e4 90              NOP
       01a2:59e5 d9 06 50 a5     FLD        float ptr { 1.0 }
       01a2:59e9 e9 4a 00        JMP        LAB_01a2_5a36
                             LAB_01a2_59ec                                   XREF[1]:     01a2:5a4e(j)  
       01a2:59ec 90              NOP
       01a2:59ed d9 06 5a b4     FLD        float ptr [0xb45a]
       01a2:59f1 90              NOP
       01a2:59f2 d9 1e be a4     FSTP       float ptr [0xa4be]
       01a2:59f6 90              NOP
       01a2:59f7 9b              WAIT
       01a2:59f8 e8 d0 07        CALL       FUN_01a2_61cb                                    undefined FUN_01a2_61cb()
       01a2:59fb b8 b0 04        MOV        AX,0x4b0
       01a2:59fe 50              PUSH       AX
       01a2:59ff ff 36 52 a5     PUSH       word ptr [0xa552]
       01a2:5a03 ff 36 50 a5     PUSH       word ptr { 1.0 }
       01a2:5a07 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:5a0c 90              NOP
       01a2:5a0d d9 06 4c a6     FLD        float ptr { 0.0 }
       01a2:5a11 90              NOP
       01a2:5a12 d9 1e be a4     FSTP       float ptr [0xa4be]
       01a2:5a16 90              NOP
       01a2:5a17 9b              WAIT
       01a2:5a18 e8 b0 07        CALL       FUN_01a2_61cb                                    undefined FUN_01a2_61cb()
       01a2:5a1b b8 84 03        MOV        AX,0x384
       01a2:5a1e 50              PUSH       AX
       01a2:5a1f ff 36 52 a5     PUSH       word ptr [0xa552]
       01a2:5a23 ff 36 50 a5     PUSH       word ptr { 1.0 }
       01a2:5a27 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:5a2c 90              NOP
       01a2:5a2d d9 06 96 a4     FLD        float ptr [0xa496]
       01a2:5a31 90              NOP
       01a2:5a32 d8 06 50 a5     FADD       float ptr { 1.0 }
                             LAB_01a2_5a36                                   XREF[1]:     01a2:59e9(j)  
       01a2:5a36 90              NOP
       01a2:5a37 d9 1e 96 a4     FSTP       float ptr [0xa496]
       01a2:5a3b 90              NOP
       01a2:5a3c 9b              WAIT
       01a2:5a3d 90              NOP
       01a2:5a3e d9 06 80 af     FLD        float ptr { 6.0 }
       01a2:5a42 90              NOP
       01a2:5a43 d9 06 96 a4     FLD        float ptr [0xa496]
       01a2:5a47 90              NOP
       01a2:5a48 9b              WAIT
       01a2:5a49 9a 1d 04        CALLF      FPCOMPARE_2stack                                 undefined FPCOMPARE_2stack()
                 75 0d
       01a2:5a4e 76 9c           JBE        LAB_01a2_59ec
       01a2:5a50 90              NOP
       01a2:5a51 d9 06 5a b4     FLD        float ptr [0xb45a]
       01a2:5a55 90              NOP
       01a2:5a56 d9 1e be a4     FSTP       float ptr [0xa4be]
       01a2:5a5a 90              NOP
       01a2:5a5b 9b              WAIT
       01a2:5a5c e8 6c 07        CALL       FUN_01a2_61cb                                    undefined FUN_01a2_61cb()
       01a2:5a5f e8 a0 e2        CALL       FUN_01a2_3d02                                    undefined FUN_01a2_3d02()
       01a2:5a62 e8 f2 e1        CALL       FUN_01a2_3c57                                    undefined FUN_01a2_3c57()
       01a2:5a65 90              NOP
       01a2:5a66 d9 06 50 a5     FLD        float ptr { 1.0 }
       01a2:5a6a e9 09 01        JMP        LAB_01a2_5b76
       01a2:5a6d 90              ??         90h
                             LAB_01a2_5a6e                                   XREF[1]:     01a2:5b90(j)  
       01a2:5a6e 90              NOP
       01a2:5a6f d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:5a73 90              NOP
       01a2:5a74 d8 06 f2 b3     FADD       float ptr [0xb3f2]
       01a2:5a78 83 ec 04        SUB        SP,0x4
       01a2:5a7b 8b dc           MOV        BX,SP
       01a2:5a7d 90              NOP
       01a2:5a7e d9 1f           FSTP       float ptr [BX]
       01a2:5a80 90              NOP
       01a2:5a81 9b              WAIT
       01a2:5a82 90              NOP
       01a2:5a83 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:5a87 90              NOP
       01a2:5a88 d8 06 f2 b3     FADD       float ptr [0xb3f2]
       01a2:5a8c 83 ec 04        SUB        SP,0x4
       01a2:5a8f 8b dc           MOV        BX,SP
       01a2:5a91 90              NOP
       01a2:5a92 d9 1f           FSTP       float ptr [BX]
       01a2:5a94 90              NOP
       01a2:5a95 9b              WAIT
       01a2:5a96 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:5a9b 90              NOP
       01a2:5a9c d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:5aa0 90              NOP
       01a2:5aa1 d8 06 fe b3     FADD       float ptr [0xb3fe]
       01a2:5aa5 83 ec 04        SUB        SP,0x4
       01a2:5aa8 8b dc           MOV        BX,SP
       01a2:5aaa 90              NOP
       01a2:5aab d9 1f           FSTP       float ptr [BX]
       01a2:5aad 90              NOP
       01a2:5aae 9b              WAIT
       01a2:5aaf 90              NOP
       01a2:5ab0 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:5ab4 90              NOP
       01a2:5ab5 d8 06 da b3     FADD       float ptr [0xb3da]
       01a2:5ab9 83 ec 04        SUB        SP,0x4
       01a2:5abc 8b dc           MOV        BX,SP
       01a2:5abe 90              NOP
       01a2:5abf d9 1f           FSTP       float ptr [BX]
       01a2:5ac1 90              NOP
       01a2:5ac2 9b              WAIT
       01a2:5ac3 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:5ac8 b8 0e 00        MOV        AX,0xe
       01a2:5acb 50              PUSH       AX
       01a2:5acc b8 ff ff        MOV        AX,0xffff
       01a2:5acf 50              PUSH       AX
       01a2:5ad0 b8 02 00        MOV        AX,0x2
       01a2:5ad3 50              PUSH       AX
       01a2:5ad4 9a 80 10        CALLF      LINE
                 71 0e
       01a2:5ad9 e8 51 d3        CALL       FUN_01a2_2e2d                                    undefined FUN_01a2_2e2d()
       01a2:5adc b8 f4 01        MOV        AX,0x1f4
       01a2:5adf 50              PUSH       AX
       01a2:5ae0 ff 36 52 a5     PUSH       word ptr [0xa552]
       01a2:5ae4 ff 36 50 a5     PUSH       word ptr { 1.0 }
       01a2:5ae8 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:5aed 90              NOP
       01a2:5aee d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:5af2 90              NOP
       01a2:5af3 d8 06 f2 b3     FADD       float ptr [0xb3f2]
       01a2:5af7 83 ec 04        SUB        SP,0x4
       01a2:5afa 8b dc           MOV        BX,SP
       01a2:5afc 90              NOP
       01a2:5afd d9 1f           FSTP       float ptr [BX]
       01a2:5aff 90              NOP
       01a2:5b00 9b              WAIT
       01a2:5b01 90              NOP
       01a2:5b02 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:5b06 90              NOP
       01a2:5b07 d8 06 f2 b3     FADD       float ptr [0xb3f2]
       01a2:5b0b 83 ec 04        SUB        SP,0x4
       01a2:5b0e 8b dc           MOV        BX,SP
       01a2:5b10 90              NOP
       01a2:5b11 d9 1f           FSTP       float ptr [BX]
       01a2:5b13 90              NOP
       01a2:5b14 9b              WAIT
       01a2:5b15 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:5b1a 90              NOP
       01a2:5b1b d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:5b1f 90              NOP
       01a2:5b20 d8 06 fe b3     FADD       float ptr [0xb3fe]
       01a2:5b24 83 ec 04        SUB        SP,0x4
       01a2:5b27 8b dc           MOV        BX,SP
       01a2:5b29 90              NOP
       01a2:5b2a d9 1f           FSTP       float ptr [BX]
       01a2:5b2c 90              NOP
       01a2:5b2d 9b              WAIT
       01a2:5b2e 90              NOP
       01a2:5b2f d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:5b33 90              NOP
       01a2:5b34 d8 06 da b3     FADD       float ptr [0xb3da]
       01a2:5b38 83 ec 04        SUB        SP,0x4
       01a2:5b3b 8b dc           MOV        BX,SP
       01a2:5b3d 90              NOP
       01a2:5b3e d9 1f           FSTP       float ptr [BX]
       01a2:5b40 90              NOP
       01a2:5b41 9b              WAIT
       01a2:5b42 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:5b47 b8 05 00        MOV        AX,0x5
       01a2:5b4a 50              PUSH       AX
       01a2:5b4b b8 ff ff        MOV        AX,0xffff
       01a2:5b4e 50              PUSH       AX
       01a2:5b4f b8 02 00        MOV        AX,0x2
       01a2:5b52 50              PUSH       AX
       01a2:5b53 9a 80 10        CALLF      LINE
                 71 0e
       01a2:5b58 e8 d2 d2        CALL       FUN_01a2_2e2d                                    undefined FUN_01a2_2e2d()
       01a2:5b5b b8 84 03        MOV        AX,0x384
       01a2:5b5e 50              PUSH       AX
       01a2:5b5f ff 36 52 a5     PUSH       word ptr [0xa552]
       01a2:5b63 ff 36 50 a5     PUSH       word ptr { 1.0 }
       01a2:5b67 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:5b6c 90              NOP
       01a2:5b6d d9 06 96 a4     FLD        float ptr [0xa496]
       01a2:5b71 90              NOP
       01a2:5b72 d8 06 50 a5     FADD       float ptr { 1.0 }
                             LAB_01a2_5b76                                   XREF[1]:     01a2:5a6a(j)  
       01a2:5b76 90              NOP
       01a2:5b77 d9 1e 96 a4     FSTP       float ptr [0xa496]
       01a2:5b7b 90              NOP
       01a2:5b7c 9b              WAIT
       01a2:5b7d 90              NOP
       01a2:5b7e d9 06 7c af     FLD        float ptr { 5.0 }
       01a2:5b82 90              NOP
       01a2:5b83 d9 06 96 a4     FLD        float ptr [0xa496]
       01a2:5b87 90              NOP
       01a2:5b88 9b              WAIT
       01a2:5b89 9a 1d 04        CALLF      FPCOMPARE_2stack                                 undefined FPCOMPARE_2stack()
                 75 0d
       01a2:5b8e 77 03           JA         LAB_01a2_5b93
       01a2:5b90 e9 db fe        JMP        LAB_01a2_5a6e
                             LAB_01a2_5b93                                   XREF[1]:     01a2:5b8e(j)  
       01a2:5b93 90              NOP
       01a2:5b94 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:5b98 90              NOP
       01a2:5b99 d8 06 f2 b3     FADD       float ptr [0xb3f2]
       01a2:5b9d 83 ec 04        SUB        SP,0x4
       01a2:5ba0 8b dc           MOV        BX,SP
       01a2:5ba2 90              NOP
       01a2:5ba3 d9 1f           FSTP       float ptr [BX]
       01a2:5ba5 90              NOP
       01a2:5ba6 9b              WAIT
       01a2:5ba7 90              NOP
       01a2:5ba8 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:5bac 90              NOP
       01a2:5bad d8 06 f2 b3     FADD       float ptr [0xb3f2]
       01a2:5bb1 83 ec 04        SUB        SP,0x4
       01a2:5bb4 8b dc           MOV        BX,SP
       01a2:5bb6 90              NOP
       01a2:5bb7 d9 1f           FSTP       float ptr [BX]
       01a2:5bb9 90              NOP
       01a2:5bba 9b              WAIT
       01a2:5bbb 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:5bc0 90              NOP
       01a2:5bc1 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:5bc5 90              NOP
       01a2:5bc6 d8 06 fe b3     FADD       float ptr [0xb3fe]
       01a2:5bca 83 ec 04        SUB        SP,0x4
       01a2:5bcd 8b dc           MOV        BX,SP
       01a2:5bcf 90              NOP
       01a2:5bd0 d9 1f           FSTP       float ptr [BX]
       01a2:5bd2 90              NOP
       01a2:5bd3 9b              WAIT
       01a2:5bd4 90              NOP
       01a2:5bd5 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:5bd9 90              NOP
       01a2:5bda d8 06 da b3     FADD       float ptr [0xb3da]
       01a2:5bde 83 ec 04        SUB        SP,0x4
       01a2:5be1 8b dc           MOV        BX,SP
       01a2:5be3 90              NOP
       01a2:5be4 d9 1f           FSTP       float ptr [BX]
       01a2:5be6 90              NOP
       01a2:5be7 9b              WAIT
       01a2:5be8 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:5bed 33 c0           XOR        AX,AX
       01a2:5bef 50              PUSH       AX
       01a2:5bf0 b8 ff ff        MOV        AX,0xffff
       01a2:5bf3 50              PUSH       AX
       01a2:5bf4 b8 02 00        MOV        AX,0x2
       01a2:5bf7 50              PUSH       AX
       01a2:5bf8 9a 80 10        CALLF      LINE
                 71 0e
       01a2:5bfd e8 90 e0        CALL       FUN_01a2_3c90                                    undefined FUN_01a2_3c90()
       01a2:5c00 90              NOP
       01a2:5c01 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:5c05 90              NOP
       01a2:5c06 d8 06 0c a6     FADD       float ptr [0xa60c]
       01a2:5c0a 83 ec 04        SUB        SP,0x4
       01a2:5c0d 8b dc           MOV        BX,SP
       01a2:5c0f 90              NOP
       01a2:5c10 d9 1f           FSTP       float ptr [BX]
       01a2:5c12 90              NOP
       01a2:5c13 9b              WAIT
       01a2:5c14 ff 36 34 a2     PUSH       word ptr [0xa234]
       01a2:5c18 ff 36 32 a2     PUSH       word ptr [0xa232]
       01a2:5c1c 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:5c21 90              NOP
       01a2:5c22 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:5c26 90              NOP
       01a2:5c27 d8 06 f6 b3     FADD       float ptr [0xb3f6]
       01a2:5c2b 83 ec 04        SUB        SP,0x4
       01a2:5c2e 8b dc           MOV        BX,SP
       01a2:5c30 90              NOP
       01a2:5c31 d9 1f           FSTP       float ptr [BX]
       01a2:5c33 90              NOP
       01a2:5c34 9b              WAIT
       01a2:5c35 90              NOP
       01a2:5c36 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:5c3a 90              NOP
       01a2:5c3b d8 06 42 b4     FADD       float ptr [0xb442]
       01a2:5c3f 83 ec 04        SUB        SP,0x4
       01a2:5c42 8b dc           MOV        BX,SP
       01a2:5c44 90              NOP
       01a2:5c45 d9 1f           FSTP       float ptr [BX]
       01a2:5c47 90              NOP
       01a2:5c48 9b              WAIT
       01a2:5c49 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:5c4e b8 0f 00        MOV        AX,0xf
       01a2:5c51 50              PUSH       AX
       01a2:5c52 b8 ff ff        MOV        AX,0xffff
       01a2:5c55 50              PUSH       AX
       01a2:5c56 b8 02 00        MOV        AX,0x2
       01a2:5c59 50              PUSH       AX
       01a2:5c5a 9a 80 10        CALLF      LINE
                 71 0e
       01a2:5c5f ff 36 30 a2     PUSH       word ptr [0xa230]
       01a2:5c63 ff 36 2e a2     PUSH       word ptr [0xa22e]
       01a2:5c67 90              NOP
       01a2:5c68 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:5c6c 90              NOP
       01a2:5c6d d8 06 8c af     FADD       float ptr { 10.0 }
       01a2:5c71 83 ec 04        SUB        SP,0x4
       01a2:5c74 8b dc           MOV        BX,SP
       01a2:5c76 90              NOP
       01a2:5c77 d9 1f           FSTP       float ptr [BX]
       01a2:5c79 90              NOP
       01a2:5c7a 9b              WAIT
       01a2:5c7b 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:5c80 90              NOP
       01a2:5c81 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:5c85 90              NOP
       01a2:5c86 d8 06 54 a6     FADD       float ptr { 50.0 }
       01a2:5c8a 83 ec 04        SUB        SP,0x4
       01a2:5c8d 8b dc           MOV        BX,SP
       01a2:5c8f 90              NOP
       01a2:5c90 d9 1f           FSTP       float ptr [BX]
       01a2:5c92 90              NOP
       01a2:5c93 9b              WAIT
       01a2:5c94 90              NOP
       01a2:5c95 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:5c99 90              NOP
       01a2:5c9a d8 06 36 b0     FADD       float ptr { 30.0 }
       01a2:5c9e 83 ec 04        SUB        SP,0x4
       01a2:5ca1 8b dc           MOV        BX,SP
       01a2:5ca3 90              NOP
       01a2:5ca4 d9 1f           FSTP       float ptr [BX]
       01a2:5ca6 90              NOP
       01a2:5ca7 9b              WAIT
       01a2:5ca8 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:5cad b8 0f 00        MOV        AX,0xf
       01a2:5cb0 50              PUSH       AX
       01a2:5cb1 b8 ff ff        MOV        AX,0xffff
       01a2:5cb4 50              PUSH       AX
       01a2:5cb5 b8 02 00        MOV        AX,0x2
       01a2:5cb8 50              PUSH       AX
       01a2:5cb9 9a 80 10        CALLF      LINE
                 71 0e
       01a2:5cbe 90              NOP
       01a2:5cbf d9 06 e6 b3     FLD        float ptr [0xb3e6]
       01a2:5cc3 e9 92 00        JMP        LAB_01a2_5d58
                             LAB_01a2_5cc6                                   XREF[1]:     01a2:5d72(j)  
       01a2:5cc6 90              NOP
       01a2:5cc7 d9 06 0a b4     FLD        float ptr [0xb40a]
       01a2:5ccb 9a 48 7d        CALLF      RND
                 71 0e
       01a2:5cd0 8b f0           MOV        SI,AX
       01a2:5cd2 90              NOP
       01a2:5cd3 d9 04           FLD        float ptr [SI]
       01a2:5cd5 90              NOP
       01a2:5cd6 d8 0e 14 a6     FMUL       float ptr { 8.0 }
       01a2:5cda 90              NOP
       01a2:5cdb de e9           FSUBP
       01a2:5cdd 90              NOP
       01a2:5cde d9 1e c2 a4     FSTP       float ptr [0xa4c2]
       01a2:5ce2 90              NOP
       01a2:5ce3 9b              WAIT
       01a2:5ce4 90              NOP
       01a2:5ce5 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:5ce9 90              NOP
       01a2:5cea d8 06 3a 00     FADD       float ptr [0x3a]
       01a2:5cee 83 ec 04        SUB        SP,0x4
       01a2:5cf1 8b dc           MOV        BX,SP
       01a2:5cf3 90              NOP
       01a2:5cf4 d9 1f           FSTP       float ptr [BX]
       01a2:5cf6 90              NOP
       01a2:5cf7 9b              WAIT
       01a2:5cf8 90              NOP
       01a2:5cf9 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:5cfd 90              NOP
       01a2:5cfe d8 06 0a b4     FADD       float ptr [0xb40a]
       01a2:5d02 83 ec 04        SUB        SP,0x4
       01a2:5d05 8b dc           MOV        BX,SP
       01a2:5d07 90              NOP
       01a2:5d08 d9 1f           FSTP       float ptr [BX]
       01a2:5d0a 90              NOP
       01a2:5d0b 9b              WAIT
       01a2:5d0c 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:5d11 90              NOP
       01a2:5d12 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:5d16 90              NOP
       01a2:5d17 d8 06 3a 00     FADD       float ptr [0x3a]
       01a2:5d1b 83 ec 04        SUB        SP,0x4
       01a2:5d1e 8b dc           MOV        BX,SP
       01a2:5d20 90              NOP
       01a2:5d21 d9 1f           FSTP       float ptr [BX]
       01a2:5d23 90              NOP
       01a2:5d24 9b              WAIT
       01a2:5d25 90              NOP
       01a2:5d26 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:5d2a 90              NOP
       01a2:5d2b d8 06 c2 a4     FADD       float ptr [0xa4c2]
       01a2:5d2f 83 ec 04        SUB        SP,0x4
       01a2:5d32 8b dc           MOV        BX,SP
       01a2:5d34 90              NOP
       01a2:5d35 d9 1f           FSTP       float ptr [BX]
       01a2:5d37 90              NOP
       01a2:5d38 9b              WAIT
       01a2:5d39 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:5d3e b8 02 00        MOV        AX,0x2
       01a2:5d41 50              PUSH       AX
       01a2:5d42 b8 ff ff        MOV        AX,0xffff
       01a2:5d45 50              PUSH       AX
       01a2:5d46 33 c0           XOR        AX,AX
       01a2:5d48 50              PUSH       AX
       01a2:5d49 9a 80 10        CALLF      LINE
                 71 0e
       01a2:5d4e 90              NOP
       01a2:5d4f d9 06 3a 00     FLD        float ptr [0x3a]
       01a2:5d53 90              NOP
       01a2:5d54 d8 06 50 a5     FADD       float ptr { 1.0 }
                             LAB_01a2_5d58                                   XREF[1]:     01a2:5cc3(j)  
       01a2:5d58 90              NOP
       01a2:5d59 d9 1e 3a 00     FSTP       float ptr [0x3a]
       01a2:5d5d 90              NOP
       01a2:5d5e 9b              WAIT
       01a2:5d5f 90              NOP
       01a2:5d60 d9 06 06 b4     FLD        float ptr [0xb406]
       01a2:5d64 90              NOP
       01a2:5d65 d9 06 3a 00     FLD        float ptr [0x3a]
       01a2:5d69 90              NOP
       01a2:5d6a 9b              WAIT
       01a2:5d6b 9a 1d 04        CALLF      FPCOMPARE_2stack                                 undefined FPCOMPARE_2stack()
                 75 0d
       01a2:5d70 77 03           JA         LAB_01a2_5d75
       01a2:5d72 e9 51 ff        JMP        LAB_01a2_5cc6
                             LAB_01a2_5d75                                   XREF[1]:     01a2:5d70(j)  
       01a2:5d75 90              NOP
       01a2:5d76 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:5d7a 90              NOP
       01a2:5d7b d8 06 78 a6     FADD       float ptr [0xa678]
       01a2:5d7f 83 ec 04        SUB        SP,0x4
       01a2:5d82 8b dc           MOV        BX,SP
       01a2:5d84 90              NOP
       01a2:5d85 d9 1f           FSTP       float ptr [BX]
       01a2:5d87 90              NOP
       01a2:5d88 9b              WAIT
       01a2:5d89 90              NOP
       01a2:5d8a d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:5d8e 90              NOP
       01a2:5d8f d8 06 78 a6     FADD       float ptr [0xa678]
       01a2:5d93 83 ec 04        SUB        SP,0x4
       01a2:5d96 8b dc           MOV        BX,SP
       01a2:5d98 90              NOP
       01a2:5d99 d9 1f           FSTP       float ptr [BX]
       01a2:5d9b 90              NOP
       01a2:5d9c 9b              WAIT
       01a2:5d9d 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:5da2 90              NOP
       01a2:5da3 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:5da7 90              NOP
       01a2:5da8 d8 06 78 a6     FADD       float ptr [0xa678]
       01a2:5dac 83 ec 04        SUB        SP,0x4
       01a2:5daf 8b dc           MOV        BX,SP
       01a2:5db1 90              NOP
       01a2:5db2 d9 1f           FSTP       float ptr [BX]
       01a2:5db4 90              NOP
       01a2:5db5 9b              WAIT
       01a2:5db6 90              NOP
       01a2:5db7 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:5dbb 90              NOP
       01a2:5dbc d8 06 f6 b4     FADD       float ptr [0xb4f6]
       01a2:5dc0 83 ec 04        SUB        SP,0x4
       01a2:5dc3 8b dc           MOV        BX,SP
       01a2:5dc5 90              NOP
       01a2:5dc6 d9 1f           FSTP       float ptr [BX]
       01a2:5dc8 90              NOP
       01a2:5dc9 9b              WAIT
       01a2:5dca 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:5dcf 33 c0           XOR        AX,AX
       01a2:5dd1 50              PUSH       AX
       01a2:5dd2 b8 ff ff        MOV        AX,0xffff
       01a2:5dd5 50              PUSH       AX
       01a2:5dd6 33 c0           XOR        AX,AX
       01a2:5dd8 50              PUSH       AX
       01a2:5dd9 9a 80 10        CALLF      LINE
                 71 0e
       01a2:5dde 90              NOP
       01a2:5ddf d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:5de3 90              NOP
       01a2:5de4 d8 06 78 a6     FADD       float ptr [0xa678]
       01a2:5de8 83 ec 04        SUB        SP,0x4
       01a2:5deb 8b dc           MOV        BX,SP
       01a2:5ded 90              NOP
       01a2:5dee d9 1f           FSTP       float ptr [BX]
       01a2:5df0 90              NOP
       01a2:5df1 9b              WAIT
       01a2:5df2 90              NOP
       01a2:5df3 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:5df7 90              NOP
       01a2:5df8 d8 06 78 a6     FADD       float ptr [0xa678]
       01a2:5dfc 83 ec 04        SUB        SP,0x4
       01a2:5dff 8b dc           MOV        BX,SP
       01a2:5e01 90              NOP
       01a2:5e02 d9 1f           FSTP       float ptr [BX]
       01a2:5e04 90              NOP
       01a2:5e05 9b              WAIT
       01a2:5e06 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:5e0b 90              NOP
       01a2:5e0c d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:5e10 90              NOP
       01a2:5e11 d8 06 3a b4     FADD       float ptr [0xb43a]
       01a2:5e15 83 ec 04        SUB        SP,0x4
       01a2:5e18 8b dc           MOV        BX,SP
       01a2:5e1a 90              NOP
       01a2:5e1b d9 1f           FSTP       float ptr [BX]
       01a2:5e1d 90              NOP
       01a2:5e1e 9b              WAIT
       01a2:5e1f 90              NOP
       01a2:5e20 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:5e24 90              NOP
       01a2:5e25 d8 06 3a b4     FADD       float ptr [0xb43a]
       01a2:5e29 83 ec 04        SUB        SP,0x4
       01a2:5e2c 8b dc           MOV        BX,SP
       01a2:5e2e 90              NOP
       01a2:5e2f d9 1f           FSTP       float ptr [BX]
       01a2:5e31 90              NOP
       01a2:5e32 9b              WAIT
       01a2:5e33 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:5e38 33 c0           XOR        AX,AX
       01a2:5e3a 50              PUSH       AX
       01a2:5e3b b8 ff ff        MOV        AX,0xffff
       01a2:5e3e 50              PUSH       AX
       01a2:5e3f b8 01 00        MOV        AX,0x1
       01a2:5e42 50              PUSH       AX
       01a2:5e43 9a 80 10        CALLF      LINE
                 71 0e
       01a2:5e48 90              NOP
       01a2:5e49 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:5e4d 90              NOP
       01a2:5e4e d8 06 0c a6     FADD       float ptr [0xa60c]
       01a2:5e52 83 ec 04        SUB        SP,0x4
       01a2:5e55 8b dc           MOV        BX,SP
       01a2:5e57 90              NOP
       01a2:5e58 d9 1f           FSTP       float ptr [BX]
       01a2:5e5a 90              NOP
       01a2:5e5b 9b              WAIT
       01a2:5e5c 90              NOP
       01a2:5e5d d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:5e61 90              NOP
       01a2:5e62 d8 06 3a b4     FADD       float ptr [0xb43a]
       01a2:5e66 83 ec 04        SUB        SP,0x4
       01a2:5e69 8b dc           MOV        BX,SP
       01a2:5e6b 90              NOP
       01a2:5e6c d9 1f           FSTP       float ptr [BX]
       01a2:5e6e 90              NOP
       01a2:5e6f 9b              WAIT
       01a2:5e70 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:5e75 90              NOP
       01a2:5e76 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:5e7a 90              NOP
       01a2:5e7b d8 06 10 a6     FADD       float ptr { 18.0 }
       01a2:5e7f 83 ec 04        SUB        SP,0x4
       01a2:5e82 8b dc           MOV        BX,SP
       01a2:5e84 90              NOP
       01a2:5e85 d9 1f           FSTP       float ptr [BX]
       01a2:5e87 90              NOP
       01a2:5e88 9b              WAIT
       01a2:5e89 90              NOP
       01a2:5e8a d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:5e8e 90              NOP
       01a2:5e8f d8 06 f6 b4     FADD       float ptr [0xb4f6]
       01a2:5e93 83 ec 04        SUB        SP,0x4
       01a2:5e96 8b dc           MOV        BX,SP
       01a2:5e98 90              NOP
       01a2:5e99 d9 1f           FSTP       float ptr [BX]
       01a2:5e9b 90              NOP
       01a2:5e9c 9b              WAIT
       01a2:5e9d 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:5ea2 33 c0           XOR        AX,AX
       01a2:5ea4 50              PUSH       AX
       01a2:5ea5 b8 ff ff        MOV        AX,0xffff
       01a2:5ea8 50              PUSH       AX
       01a2:5ea9 33 c0           XOR        AX,AX
       01a2:5eab 50              PUSH       AX
       01a2:5eac 9a 80 10        CALLF      LINE
                 71 0e
       01a2:5eb1 90              NOP
       01a2:5eb2 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:5eb6 90              NOP
       01a2:5eb7 d8 06 5e b4     FADD       float ptr [0xb45e]
       01a2:5ebb 83 ec 04        SUB        SP,0x4
       01a2:5ebe 8b dc           MOV        BX,SP
       01a2:5ec0 90              NOP
       01a2:5ec1 d9 1f           FSTP       float ptr [BX]
       01a2:5ec3 90              NOP
       01a2:5ec4 9b              WAIT
       01a2:5ec5 90              NOP
       01a2:5ec6 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:5eca 90              NOP
       01a2:5ecb d8 06 f6 b4     FADD       float ptr [0xb4f6]
       01a2:5ecf 83 ec 04        SUB        SP,0x4
       01a2:5ed2 8b dc           MOV        BX,SP
       01a2:5ed4 90              NOP
       01a2:5ed5 d9 1f           FSTP       float ptr [BX]
       01a2:5ed7 90              NOP
       01a2:5ed8 9b              WAIT
       01a2:5ed9 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:5ede 33 c0           XOR        AX,AX
       01a2:5ee0 50              PUSH       AX
       01a2:5ee1 9a 74 12        CALLF      SUB_0e71_1274
                 71 0e
       01a2:5ee6 90              NOP
       01a2:5ee7 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:5eeb 90              NOP
       01a2:5eec d8 06 4e b4     FADD       float ptr [0xb44e]
       01a2:5ef0 83 ec 04        SUB        SP,0x4
       01a2:5ef3 8b dc           MOV        BX,SP
       01a2:5ef5 90              NOP
       01a2:5ef6 d9 1f           FSTP       float ptr [BX]
       01a2:5ef8 90              NOP
       01a2:5ef9 9b              WAIT
       01a2:5efa 90              NOP
       01a2:5efb d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:5eff 90              NOP
       01a2:5f00 d8 06 78 a6     FADD       float ptr [0xa678]
       01a2:5f04 83 ec 04        SUB        SP,0x4
       01a2:5f07 8b dc           MOV        BX,SP
       01a2:5f09 90              NOP
       01a2:5f0a d9 1f           FSTP       float ptr [BX]
       01a2:5f0c 90              NOP
       01a2:5f0d 9b              WAIT
       01a2:5f0e 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:5f13 90              NOP
       01a2:5f14 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:5f18 90              NOP
       01a2:5f19 d8 06 4e b4     FADD       float ptr [0xb44e]
       01a2:5f1d 83 ec 04        SUB        SP,0x4
       01a2:5f20 8b dc           MOV        BX,SP
       01a2:5f22 90              NOP
       01a2:5f23 d9 1f           FSTP       float ptr [BX]
       01a2:5f25 90              NOP
       01a2:5f26 9b              WAIT
       01a2:5f27 90              NOP
       01a2:5f28 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:5f2c 90              NOP
       01a2:5f2d d8 06 f6 b4     FADD       float ptr [0xb4f6]
       01a2:5f31 83 ec 04        SUB        SP,0x4
       01a2:5f34 8b dc           MOV        BX,SP
       01a2:5f36 90              NOP
       01a2:5f37 d9 1f           FSTP       float ptr [BX]
       01a2:5f39 90              NOP
       01a2:5f3a 9b              WAIT
       01a2:5f3b 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:5f40 33 c0           XOR        AX,AX
       01a2:5f42 50              PUSH       AX
       01a2:5f43 b8 ff ff        MOV        AX,0xffff
       01a2:5f46 50              PUSH       AX
       01a2:5f47 33 c0           XOR        AX,AX
       01a2:5f49 50              PUSH       AX
       01a2:5f4a 9a 80 10        CALLF      LINE
                 71 0e
       01a2:5f4f 90              NOP
       01a2:5f50 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:5f54 90              NOP
       01a2:5f55 d8 06 ca b4     FADD       float ptr [0xb4ca]
       01a2:5f59 83 ec 04        SUB        SP,0x4
       01a2:5f5c 8b dc           MOV        BX,SP
       01a2:5f5e 90              NOP
       01a2:5f5f d9 1f           FSTP       float ptr [BX]
       01a2:5f61 90              NOP
       01a2:5f62 9b              WAIT
       01a2:5f63 90              NOP
       01a2:5f64 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:5f68 90              NOP
       01a2:5f69 d8 06 f6 b4     FADD       float ptr [0xb4f6]
       01a2:5f6d 83 ec 04        SUB        SP,0x4
       01a2:5f70 8b dc           MOV        BX,SP
       01a2:5f72 90              NOP
       01a2:5f73 d9 1f           FSTP       float ptr [BX]
       01a2:5f75 90              NOP
       01a2:5f76 9b              WAIT
       01a2:5f77 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:5f7c 33 c0           XOR        AX,AX
       01a2:5f7e 50              PUSH       AX
       01a2:5f7f 9a 74 12        CALLF      SUB_0e71_1274
                 71 0e
       01a2:5f84 90              NOP
       01a2:5f85 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:5f89 90              NOP
       01a2:5f8a d8 06 fa b4     FADD       float ptr [0xb4fa]
       01a2:5f8e 83 ec 04        SUB        SP,0x4
       01a2:5f91 8b dc           MOV        BX,SP
       01a2:5f93 90              NOP
       01a2:5f94 d9 1f           FSTP       float ptr [BX]
       01a2:5f96 90              NOP
       01a2:5f97 9b              WAIT
       01a2:5f98 90              NOP
       01a2:5f99 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:5f9d 90              NOP
       01a2:5f9e d8 06 78 a6     FADD       float ptr [0xa678]
       01a2:5fa2 83 ec 04        SUB        SP,0x4
       01a2:5fa5 8b dc           MOV        BX,SP
       01a2:5fa7 90              NOP
       01a2:5fa8 d9 1f           FSTP       float ptr [BX]
       01a2:5faa 90              NOP
       01a2:5fab 9b              WAIT
       01a2:5fac 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:5fb1 90              NOP
       01a2:5fb2 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:5fb6 90              NOP
       01a2:5fb7 d8 06 fa b4     FADD       float ptr [0xb4fa]
       01a2:5fbb 83 ec 04        SUB        SP,0x4
       01a2:5fbe 8b dc           MOV        BX,SP
       01a2:5fc0 90              NOP
       01a2:5fc1 d9 1f           FSTP       float ptr [BX]
       01a2:5fc3 90              NOP
       01a2:5fc4 9b              WAIT
       01a2:5fc5 90              NOP
       01a2:5fc6 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:5fca 90              NOP
       01a2:5fcb d8 06 f6 b4     FADD       float ptr [0xb4f6]
       01a2:5fcf 83 ec 04        SUB        SP,0x4
       01a2:5fd2 8b dc           MOV        BX,SP
       01a2:5fd4 90              NOP
       01a2:5fd5 d9 1f           FSTP       float ptr [BX]
       01a2:5fd7 90              NOP
       01a2:5fd8 9b              WAIT
       01a2:5fd9 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:5fde 33 c0           XOR        AX,AX
       01a2:5fe0 50              PUSH       AX
       01a2:5fe1 b8 ff ff        MOV        AX,0xffff
       01a2:5fe4 50              PUSH       AX
       01a2:5fe5 33 c0           XOR        AX,AX
       01a2:5fe7 50              PUSH       AX
       01a2:5fe8 9a 80 10        CALLF      LINE
                 71 0e
       01a2:5fed 90              NOP
       01a2:5fee d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:5ff2 90              NOP
       01a2:5ff3 d8 06 fa b4     FADD       float ptr [0xb4fa]
       01a2:5ff7 83 ec 04        SUB        SP,0x4
       01a2:5ffa 8b dc           MOV        BX,SP
       01a2:5ffc 90              NOP
       01a2:5ffd d9 1f           FSTP       float ptr [BX]
       01a2:5fff 90              NOP
       01a2:6000 9b              WAIT
       01a2:6001 90              NOP
       01a2:6002 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:6006 90              NOP
       01a2:6007 d8 06 78 a6     FADD       float ptr [0xa678]
       01a2:600b 83 ec 04        SUB        SP,0x4
       01a2:600e 8b dc           MOV        BX,SP
       01a2:6010 90              NOP
       01a2:6011 d9 1f           FSTP       float ptr [BX]
       01a2:6013 90              NOP
       01a2:6014 9b              WAIT
       01a2:6015 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:601a 90              NOP
       01a2:601b d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:601f 90              NOP
       01a2:6020 d8 06 4a b4     FADD       float ptr [0xb44a]
       01a2:6024 83 ec 04        SUB        SP,0x4
       01a2:6027 8b dc           MOV        BX,SP
       01a2:6029 90              NOP
       01a2:602a d9 1f           FSTP       float ptr [BX]
       01a2:602c 90              NOP
       01a2:602d 9b              WAIT
       01a2:602e 90              NOP
       01a2:602f d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:6033 90              NOP
       01a2:6034 d8 06 3a b4     FADD       float ptr [0xb43a]
       01a2:6038 83 ec 04        SUB        SP,0x4
       01a2:603b 8b dc           MOV        BX,SP
       01a2:603d 90              NOP
       01a2:603e d9 1f           FSTP       float ptr [BX]
       01a2:6040 90              NOP
       01a2:6041 9b              WAIT
       01a2:6042 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:6047 33 c0           XOR        AX,AX
       01a2:6049 50              PUSH       AX
       01a2:604a b8 ff ff        MOV        AX,0xffff
       01a2:604d 50              PUSH       AX
       01a2:604e b8 01 00        MOV        AX,0x1
       01a2:6051 50              PUSH       AX
       01a2:6052 9a 80 10        CALLF      LINE
                 71 0e
       01a2:6057 90              NOP
       01a2:6058 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:605c 90              NOP
       01a2:605d d8 06 fe b4     FADD       float ptr [0xb4fe]
       01a2:6061 83 ec 04        SUB        SP,0x4
       01a2:6064 8b dc           MOV        BX,SP
       01a2:6066 90              NOP
       01a2:6067 d9 1f           FSTP       float ptr [BX]
       01a2:6069 90              NOP
       01a2:606a 9b              WAIT
       01a2:606b 90              NOP
       01a2:606c d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:6070 90              NOP
       01a2:6071 d8 06 f6 b4     FADD       float ptr [0xb4f6]
       01a2:6075 83 ec 04        SUB        SP,0x4
       01a2:6078 8b dc           MOV        BX,SP
       01a2:607a 90              NOP
       01a2:607b d9 1f           FSTP       float ptr [BX]
       01a2:607d 90              NOP
       01a2:607e 9b              WAIT
       01a2:607f 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:6084 33 c0           XOR        AX,AX
       01a2:6086 50              PUSH       AX
       01a2:6087 9a 74 12        CALLF      SUB_0e71_1274
                 71 0e
       01a2:608c 90              NOP
       01a2:608d d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:6091 90              NOP
       01a2:6092 d8 06 2e b4     FADD       float ptr [0xb42e]
       01a2:6096 83 ec 04        SUB        SP,0x4
       01a2:6099 8b dc           MOV        BX,SP
       01a2:609b 90              NOP
       01a2:609c d9 1f           FSTP       float ptr [BX]
       01a2:609e 90              NOP
       01a2:609f 9b              WAIT
       01a2:60a0 90              NOP
       01a2:60a1 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:60a5 90              NOP
       01a2:60a6 d8 06 12 b4     FADD       float ptr [0xb412]
       01a2:60aa 83 ec 04        SUB        SP,0x4
       01a2:60ad 8b dc           MOV        BX,SP
       01a2:60af 90              NOP
       01a2:60b0 d9 1f           FSTP       float ptr [BX]
       01a2:60b2 90              NOP
       01a2:60b3 9b              WAIT
       01a2:60b4 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:60b9 90              NOP
       01a2:60ba d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:60be 90              NOP
       01a2:60bf d8 06 24 b0     FADD       float ptr { 27.0 }
       01a2:60c3 83 ec 04        SUB        SP,0x4
       01a2:60c6 8b dc           MOV        BX,SP
       01a2:60c8 90              NOP
       01a2:60c9 d9 1f           FSTP       float ptr [BX]
       01a2:60cb 90              NOP
       01a2:60cc 9b              WAIT
       01a2:60cd 90              NOP
       01a2:60ce d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:60d2 90              NOP
       01a2:60d3 d8 06 02 b4     FADD       float ptr [0xb402]
       01a2:60d7 83 ec 04        SUB        SP,0x4
       01a2:60da 8b dc           MOV        BX,SP
       01a2:60dc 90              NOP
       01a2:60dd d9 1f           FSTP       float ptr [BX]
       01a2:60df 90              NOP
       01a2:60e0 9b              WAIT
       01a2:60e1 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:60e6 33 c0           XOR        AX,AX
       01a2:60e8 50              PUSH       AX
       01a2:60e9 b8 ff ff        MOV        AX,0xffff
       01a2:60ec 50              PUSH       AX
       01a2:60ed b8 01 00        MOV        AX,0x1
       01a2:60f0 50              PUSH       AX
       01a2:60f1 9a 80 10        CALLF      LINE
                 71 0e
       01a2:60f6 90              NOP
       01a2:60f7 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:60fb 90              NOP
       01a2:60fc d8 06 24 b0     FADD       float ptr { 27.0 }
       01a2:6100 83 ec 04        SUB        SP,0x4
       01a2:6103 8b dc           MOV        BX,SP
       01a2:6105 90              NOP
       01a2:6106 d9 1f           FSTP       float ptr [BX]
       01a2:6108 90              NOP
       01a2:6109 9b              WAIT
       01a2:610a 90              NOP
       01a2:610b d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:610f 90              NOP
       01a2:6110 d8 06 ee b3     FADD       float ptr [0xb3ee]
       01a2:6114 83 ec 04        SUB        SP,0x4
       01a2:6117 8b dc           MOV        BX,SP
       01a2:6119 90              NOP
       01a2:611a d9 1f           FSTP       float ptr [BX]
       01a2:611c 90              NOP
       01a2:611d 9b              WAIT
       01a2:611e 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:6123 90              NOP
       01a2:6124 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:6128 90              NOP
       01a2:6129 d8 06 24 b0     FADD       float ptr { 27.0 }
       01a2:612d 83 ec 04        SUB        SP,0x4
       01a2:6130 8b dc           MOV        BX,SP
       01a2:6132 90              NOP
       01a2:6133 d9 1f           FSTP       float ptr [BX]
       01a2:6135 90              NOP
       01a2:6136 9b              WAIT
       01a2:6137 90              NOP
       01a2:6138 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:613c 90              NOP
       01a2:613d d8 06 4a b4     FADD       float ptr [0xb44a]
       01a2:6141 83 ec 04        SUB        SP,0x4
       01a2:6144 8b dc           MOV        BX,SP
       01a2:6146 90              NOP
       01a2:6147 d9 1f           FSTP       float ptr [BX]
       01a2:6149 90              NOP
       01a2:614a 9b              WAIT
       01a2:614b 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:6150 b8 0f 00        MOV        AX,0xf
       01a2:6153 50              PUSH       AX
       01a2:6154 b8 ff ff        MOV        AX,0xffff
       01a2:6157 50              PUSH       AX
       01a2:6158 33 c0           XOR        AX,AX
       01a2:615a 50              PUSH       AX
       01a2:615b 9a 80 10        CALLF      LINE
                 71 0e
       01a2:6160 90              NOP
       01a2:6161 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:6165 90              NOP
       01a2:6166 d8 06 12 b4     FADD       float ptr [0xb412]
       01a2:616a 83 ec 04        SUB        SP,0x4
       01a2:616d 8b dc           MOV        BX,SP
       01a2:616f 90              NOP
       01a2:6170 d9 1f           FSTP       float ptr [BX]
       01a2:6172 90              NOP
       01a2:6173 9b              WAIT
       01a2:6174 90              NOP
       01a2:6175 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:6179 90              NOP
       01a2:617a d8 06 f6 b3     FADD       float ptr [0xb3f6]
       01a2:617e 83 ec 04        SUB        SP,0x4
       01a2:6181 8b dc           MOV        BX,SP
       01a2:6183 90              NOP
       01a2:6184 d9 1f           FSTP       float ptr [BX]
       01a2:6186 90              NOP
       01a2:6187 9b              WAIT
       01a2:6188 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:618d 33 c0           XOR        AX,AX
       01a2:618f 50              PUSH       AX
       01a2:6190 9a 74 12        CALLF      SUB_0e71_1274
                 71 0e
       01a2:6195 90              NOP
       01a2:6196 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:619a 90              NOP
       01a2:619b d8 06 12 b4     FADD       float ptr [0xb412]
       01a2:619f 83 ec 04        SUB        SP,0x4
       01a2:61a2 8b dc           MOV        BX,SP
       01a2:61a4 90              NOP
       01a2:61a5 d9 1f           FSTP       float ptr [BX]
       01a2:61a7 90              NOP
       01a2:61a8 9b              WAIT
       01a2:61a9 90              NOP
       01a2:61aa d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:61ae 90              NOP
       01a2:61af d8 06 fe b4     FADD       float ptr [0xb4fe]
       01a2:61b3 83 ec 04        SUB        SP,0x4
       01a2:61b6 8b dc           MOV        BX,SP
       01a2:61b8 90              NOP
       01a2:61b9 d9 1f           FSTP       float ptr [BX]
       01a2:61bb 90              NOP
       01a2:61bc 9b              WAIT
       01a2:61bd 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:61c2 33 c0           XOR        AX,AX
       01a2:61c4 50              PUSH       AX
       01a2:61c5 9a 74 12        CALLF      SUB_0e71_1274
                 71 0e
       01a2:61ca c3              RET
                             **************************************************************
                             *                          FUNCTION                          *
                             **************************************************************
                             undefined __cdecl16near FUN_01a2_61cb()
                               assume DS = 0x1997
             undefined         <UNASSIGNED>   <RETURN>
             undefined4        Stack[-0x4]:4  local_4                                 XREF[1]:     01a2:61db(*)  
             undefined4        Stack[-0x8]:4  local_8                                 XREF[1]:     01a2:61ef(*)  
                             FUN_01a2_61cb                                   XREF[3]:     FUN_01a2_56c4:01a2:59f8(c), 
                                                                                          FUN_01a2_56c4:01a2:5a18(c), 
                                                                                          FUN_01a2_56c4:01a2:5a5c(c)  
       01a2:61cb 90              NOP
       01a2:61cc d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:61d0 90              NOP
       01a2:61d1 d8 06 f6 b4     FADD       float ptr [0xb4f6]
       01a2:61d5 83 ec 04        SUB        SP,0x4
       01a2:61d8 8b dc           MOV        BX,SP
       01a2:61da 90              NOP
       01a2:61db d9 1f           FSTP       float ptr [BX]=>local_4
       01a2:61dd 90              NOP
       01a2:61de 9b              WAIT
       01a2:61df 90              NOP
       01a2:61e0 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:61e4 90              NOP
       01a2:61e5 d8 06 24 b0     FADD       float ptr { 27.0 }
       01a2:61e9 83 ec 04        SUB        SP,0x4
       01a2:61ec 8b dc           MOV        BX,SP
       01a2:61ee 90              NOP
       01a2:61ef d9 1f           FSTP       float ptr [BX]=>local_8
       01a2:61f1 90              NOP
       01a2:61f2 9b              WAIT
       01a2:61f3 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:61f8 ff 36 38 b0     PUSH       word ptr [0xb038]
       01a2:61fc ff 36 36 b0     PUSH       word ptr { 30.0 }
       01a2:6200 90              NOP
       01a2:6201 d9 06 be a4     FLD        float ptr [0xa4be]
       01a2:6205 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:620a 50              PUSH       AX
       01a2:620b 9a b4 0d        CALLF      CIRCLE
                 71 0e
       01a2:6210 90              NOP
       01a2:6211 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:6215 90              NOP
       01a2:6216 d8 06 f6 b4     FADD       float ptr [0xb4f6]
       01a2:621a 83 ec 04        SUB        SP,0x4
       01a2:621d 8b dc           MOV        BX,SP
       01a2:621f 90              NOP
       01a2:6220 d9 1f           FSTP       float ptr [BX]
       01a2:6222 90              NOP
       01a2:6223 9b              WAIT
       01a2:6224 90              NOP
       01a2:6225 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:6229 90              NOP
       01a2:622a d8 06 24 b0     FADD       float ptr { 27.0 }
       01a2:622e 83 ec 04        SUB        SP,0x4
       01a2:6231 8b dc           MOV        BX,SP
       01a2:6233 90              NOP
       01a2:6234 d9 1f           FSTP       float ptr [BX]
       01a2:6236 90              NOP
       01a2:6237 9b              WAIT
       01a2:6238 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:623d ff 36 12 a6     PUSH       word ptr [0xa612]
       01a2:6241 ff 36 10 a6     PUSH       word ptr { 18.0 }
       01a2:6245 90              NOP
       01a2:6246 d9 06 be a4     FLD        float ptr [0xa4be]
       01a2:624a 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:624f 50              PUSH       AX
       01a2:6250 9a b4 0d        CALLF      CIRCLE
                 71 0e
       01a2:6255 90              NOP
       01a2:6256 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:625a 90              NOP
       01a2:625b d8 06 f6 b4     FADD       float ptr [0xb4f6]
       01a2:625f 83 ec 04        SUB        SP,0x4
       01a2:6262 8b dc           MOV        BX,SP
       01a2:6264 90              NOP
       01a2:6265 d9 1f           FSTP       float ptr [BX]
       01a2:6267 90              NOP
       01a2:6268 9b              WAIT
       01a2:6269 90              NOP
       01a2:626a d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:626e 90              NOP
       01a2:626f d8 06 24 b0     FADD       float ptr { 27.0 }
       01a2:6273 83 ec 04        SUB        SP,0x4
       01a2:6276 8b dc           MOV        BX,SP
       01a2:6278 90              NOP
       01a2:6279 d9 1f           FSTP       float ptr [BX]
       01a2:627b 90              NOP
       01a2:627c 9b              WAIT
       01a2:627d 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:6282 ff 36 82 af     PUSH       word ptr [0xaf82]
       01a2:6286 ff 36 80 af     PUSH       word ptr { 6.0 }
       01a2:628a 90              NOP
       01a2:628b d9 06 be a4     FLD        float ptr [0xa4be]
       01a2:628f 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:6294 50              PUSH       AX
       01a2:6295 9a b4 0d        CALLF      CIRCLE
                 71 0e
       01a2:629a 90              NOP
       01a2:629b d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:629f 90              NOP
       01a2:62a0 d8 06 f6 b4     FADD       float ptr [0xb4f6]
       01a2:62a4 83 ec 04        SUB        SP,0x4
       01a2:62a7 8b dc           MOV        BX,SP
       01a2:62a9 90              NOP
       01a2:62aa d9 1f           FSTP       float ptr [BX]
       01a2:62ac 90              NOP
       01a2:62ad 9b              WAIT
       01a2:62ae 90              NOP
       01a2:62af d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:62b3 90              NOP
       01a2:62b4 d8 06 e6 b3     FADD       float ptr [0xb3e6]
       01a2:62b8 83 ec 04        SUB        SP,0x4
       01a2:62bb 8b dc           MOV        BX,SP
       01a2:62bd 90              NOP
       01a2:62be d9 1f           FSTP       float ptr [BX]
       01a2:62c0 90              NOP
       01a2:62c1 9b              WAIT
       01a2:62c2 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:62c7 90              NOP
       01a2:62c8 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:62cc 90              NOP
       01a2:62cd d8 06 f6 b4     FADD       float ptr [0xb4f6]
       01a2:62d1 83 ec 04        SUB        SP,0x4
       01a2:62d4 8b dc           MOV        BX,SP
       01a2:62d6 90              NOP
       01a2:62d7 d9 1f           FSTP       float ptr [BX]
       01a2:62d9 90              NOP
       01a2:62da 9b              WAIT
       01a2:62db 90              NOP
       01a2:62dc d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:62e0 90              NOP
       01a2:62e1 d8 06 0a b4     FADD       float ptr [0xb40a]
       01a2:62e5 83 ec 04        SUB        SP,0x4
       01a2:62e8 8b dc           MOV        BX,SP
       01a2:62ea 90              NOP
       01a2:62eb d9 1f           FSTP       float ptr [BX]
       01a2:62ed 90              NOP
       01a2:62ee 9b              WAIT
       01a2:62ef 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:62f4 90              NOP
       01a2:62f5 d9 06 be a4     FLD        float ptr [0xa4be]
       01a2:62f9 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:62fe 50              PUSH       AX
       01a2:62ff b8 ff ff        MOV        AX,0xffff
       01a2:6302 50              PUSH       AX
       01a2:6303 33 c0           XOR        AX,AX
       01a2:6305 50              PUSH       AX
       01a2:6306 9a 80 10        CALLF      LINE
                 71 0e
       01a2:630b 90              NOP
       01a2:630c d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:6310 90              NOP
       01a2:6311 d8 06 f2 b3     FADD       float ptr [0xb3f2]
       01a2:6315 83 ec 04        SUB        SP,0x4
       01a2:6318 8b dc           MOV        BX,SP
       01a2:631a 90              NOP
       01a2:631b d9 1f           FSTP       float ptr [BX]
       01a2:631d 90              NOP
       01a2:631e 9b              WAIT
       01a2:631f 90              NOP
       01a2:6320 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:6324 90              NOP
       01a2:6325 d8 06 24 b0     FADD       float ptr { 27.0 }
       01a2:6329 83 ec 04        SUB        SP,0x4
       01a2:632c 8b dc           MOV        BX,SP
       01a2:632e 90              NOP
       01a2:632f d9 1f           FSTP       float ptr [BX]
       01a2:6331 90              NOP
       01a2:6332 9b              WAIT
       01a2:6333 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:6338 90              NOP
       01a2:6339 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:633d 90              NOP
       01a2:633e d8 06 fe b3     FADD       float ptr [0xb3fe]
       01a2:6342 83 ec 04        SUB        SP,0x4
       01a2:6345 8b dc           MOV        BX,SP
       01a2:6347 90              NOP
       01a2:6348 d9 1f           FSTP       float ptr [BX]
       01a2:634a 90              NOP
       01a2:634b 9b              WAIT
       01a2:634c 90              NOP
       01a2:634d d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:6351 90              NOP
       01a2:6352 d8 06 24 b0     FADD       float ptr { 27.0 }
       01a2:6356 83 ec 04        SUB        SP,0x4
       01a2:6359 8b dc           MOV        BX,SP
       01a2:635b 90              NOP
       01a2:635c d9 1f           FSTP       float ptr [BX]
       01a2:635e 90              NOP
       01a2:635f 9b              WAIT
       01a2:6360 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:6365 90              NOP
       01a2:6366 d9 06 be a4     FLD        float ptr [0xa4be]
       01a2:636a 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:636f 50              PUSH       AX
       01a2:6370 b8 ff ff        MOV        AX,0xffff
       01a2:6373 50              PUSH       AX
       01a2:6374 33 c0           XOR        AX,AX
       01a2:6376 50              PUSH       AX
       01a2:6377 9a 80 10        CALLF      LINE
                 71 0e
       01a2:637c c3              RET
                             **************************************************************
                             *                          FUNCTION                          *
                             **************************************************************
                             undefined FUN_01a2_637d()
                               assume DS = 0x1997
             undefined         <UNASSIGNED>   <RETURN>
             undefined4        Stack[-0x4]:4  local_4                                 XREF[1]:     01a2:638d(*)  
             undefined4        Stack[-0x8]:4  local_8                                 XREF[1]:     01a2:63a1(*)  
                             FUN_01a2_637d                                   XREF[4]:     ENTRY:01a2:0b06(c), 
                                                                                          FUN_01a2_19fa:01a2:1a29(c), 
                                                                                          FUN_01a2_376f:01a2:399e(c), 
                                                                                          FUN_01a2_9170:01a2:959c(c)  
       01a2:637d 90              NOP
       01a2:637e d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:6382 90              NOP
       01a2:6383 d8 06 f2 b3     FADD       float ptr [0xb3f2]
       01a2:6387 83 ec 04        SUB        SP,0x4
       01a2:638a 8b dc           MOV        BX,SP
       01a2:638c 90              NOP
       01a2:638d d9 1f           FSTP       float ptr [BX]=>local_4
       01a2:638f 90              NOP
       01a2:6390 9b              WAIT
       01a2:6391 90              NOP
       01a2:6392 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:6396 90              NOP
       01a2:6397 d8 06 f2 b3     FADD       float ptr [0xb3f2]
       01a2:639b 83 ec 04        SUB        SP,0x4
       01a2:639e 8b dc           MOV        BX,SP
       01a2:63a0 90              NOP
       01a2:63a1 d9 1f           FSTP       float ptr [BX]=>local_8
       01a2:63a3 90              NOP
       01a2:63a4 9b              WAIT
       01a2:63a5 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:63aa 90              NOP
       01a2:63ab d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:63af 90              NOP
       01a2:63b0 d8 06 fe b3     FADD       float ptr [0xb3fe]
       01a2:63b4 83 ec 04        SUB        SP,0x4
       01a2:63b7 8b dc           MOV        BX,SP
       01a2:63b9 90              NOP
       01a2:63ba d9 1f           FSTP       float ptr [BX]
       01a2:63bc 90              NOP
       01a2:63bd 9b              WAIT
       01a2:63be 90              NOP
       01a2:63bf d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:63c3 90              NOP
       01a2:63c4 d8 06 da b3     FADD       float ptr [0xb3da]
       01a2:63c8 83 ec 04        SUB        SP,0x4
       01a2:63cb 8b dc           MOV        BX,SP
       01a2:63cd 90              NOP
       01a2:63ce d9 1f           FSTP       float ptr [BX]
       01a2:63d0 90              NOP
       01a2:63d1 9b              WAIT
       01a2:63d2 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:63d7 b8 03 00        MOV        AX,0x3
       01a2:63da 50              PUSH       AX
       01a2:63db b8 ff ff        MOV        AX,0xffff
       01a2:63de 50              PUSH       AX
       01a2:63df b8 02 00        MOV        AX,0x2
       01a2:63e2 50              PUSH       AX
       01a2:63e3 9a 80 10        CALLF      LINE
                 71 0e
       01a2:63e8 90              NOP
       01a2:63e9 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:63ed 90              NOP
       01a2:63ee d8 06 f6 b4     FADD       float ptr [0xb4f6]
       01a2:63f2 83 ec 04        SUB        SP,0x4
       01a2:63f5 8b dc           MOV        BX,SP
       01a2:63f7 90              NOP
       01a2:63f8 d9 1f           FSTP       float ptr [BX]
       01a2:63fa 90              NOP
       01a2:63fb 9b              WAIT
       01a2:63fc 90              NOP
       01a2:63fd d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:6401 90              NOP
       01a2:6402 d8 06 36 b0     FADD       float ptr { 30.0 }
       01a2:6406 83 ec 04        SUB        SP,0x4
       01a2:6409 8b dc           MOV        BX,SP
       01a2:640b 90              NOP
       01a2:640c d9 1f           FSTP       float ptr [BX]
       01a2:640e 90              NOP
       01a2:640f 9b              WAIT
       01a2:6410 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:6415 ff 36 30 b4     PUSH       word ptr [0xb430]
       01a2:6419 ff 36 2e b4     PUSH       word ptr [0xb42e]
       01a2:641d 33 c0           XOR        AX,AX
       01a2:641f 50              PUSH       AX
       01a2:6420 9a b4 0d        CALLF      CIRCLE
                 71 0e
       01a2:6425 90              NOP
       01a2:6426 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:642a 90              NOP
       01a2:642b d8 06 f6 b4     FADD       float ptr [0xb4f6]
       01a2:642f 83 ec 04        SUB        SP,0x4
       01a2:6432 8b dc           MOV        BX,SP
       01a2:6434 90              NOP
       01a2:6435 d9 1f           FSTP       float ptr [BX]
       01a2:6437 90              NOP
       01a2:6438 9b              WAIT
       01a2:6439 90              NOP
       01a2:643a d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:643e 90              NOP
       01a2:643f d8 06 36 b0     FADD       float ptr { 30.0 }
       01a2:6443 83 ec 04        SUB        SP,0x4
       01a2:6446 8b dc           MOV        BX,SP
       01a2:6448 90              NOP
       01a2:6449 d9 1f           FSTP       float ptr [BX]
       01a2:644b 90              NOP
       01a2:644c 9b              WAIT
       01a2:644d 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:6452 b8 07 00        MOV        AX,0x7
       01a2:6455 50              PUSH       AX
       01a2:6456 33 c0           XOR        AX,AX
       01a2:6458 50              PUSH       AX
       01a2:6459 9a 35 17        CALLF      PAINT
                 71 0e
       01a2:645e 90              NOP
       01a2:645f d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:6463 90              NOP
       01a2:6464 d8 06 24 a6     FADD       float ptr { 3.0 }
       01a2:6468 83 ec 04        SUB        SP,0x4
       01a2:646b 8b dc           MOV        BX,SP
       01a2:646d 90              NOP
       01a2:646e d9 1f           FSTP       float ptr [BX]
       01a2:6470 90              NOP
       01a2:6471 9b              WAIT
       01a2:6472 90              NOP
       01a2:6473 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:6477 90              NOP
       01a2:6478 d8 06 c6 b4     FADD       float ptr [0xb4c6]
       01a2:647c 83 ec 04        SUB        SP,0x4
       01a2:647f 8b dc           MOV        BX,SP
       01a2:6481 90              NOP
       01a2:6482 d9 1f           FSTP       float ptr [BX]
       01a2:6484 90              NOP
       01a2:6485 9b              WAIT
       01a2:6486 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:648b 90              NOP
       01a2:648c d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:6490 90              NOP
       01a2:6491 d8 06 2a b4     FADD       float ptr [0xb42a]
       01a2:6495 83 ec 04        SUB        SP,0x4
       01a2:6498 8b dc           MOV        BX,SP
       01a2:649a 90              NOP
       01a2:649b d9 1f           FSTP       float ptr [BX]
       01a2:649d 90              NOP
       01a2:649e 9b              WAIT
       01a2:649f ff 36 34 a2     PUSH       word ptr [0xa234]
       01a2:64a3 ff 36 32 a2     PUSH       word ptr [0xa232]
       01a2:64a7 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:64ac b8 03 00        MOV        AX,0x3
       01a2:64af 50              PUSH       AX
       01a2:64b0 b8 ff ff        MOV        AX,0xffff
       01a2:64b3 50              PUSH       AX
       01a2:64b4 b8 02 00        MOV        AX,0x2
       01a2:64b7 50              PUSH       AX
       01a2:64b8 9a 80 10        CALLF      LINE
                 71 0e
       01a2:64bd 90              NOP
       01a2:64be d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:64c2 90              NOP
       01a2:64c3 d8 06 c6 b4     FADD       float ptr [0xb4c6]
       01a2:64c7 83 ec 04        SUB        SP,0x4
       01a2:64ca 8b dc           MOV        BX,SP
       01a2:64cc 90              NOP
       01a2:64cd d9 1f           FSTP       float ptr [BX]
       01a2:64cf 90              NOP
       01a2:64d0 9b              WAIT
       01a2:64d1 90              NOP
       01a2:64d2 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:64d6 90              NOP
       01a2:64d7 d8 06 f2 b3     FADD       float ptr [0xb3f2]
       01a2:64db 83 ec 04        SUB        SP,0x4
       01a2:64de 8b dc           MOV        BX,SP
       01a2:64e0 90              NOP
       01a2:64e1 d9 1f           FSTP       float ptr [BX]
       01a2:64e3 90              NOP
       01a2:64e4 9b              WAIT
       01a2:64e5 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:64ea 90              NOP
       01a2:64eb d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:64ef 90              NOP
       01a2:64f0 d8 06 4e b4     FADD       float ptr [0xb44e]
       01a2:64f4 83 ec 04        SUB        SP,0x4
       01a2:64f7 8b dc           MOV        BX,SP
       01a2:64f9 90              NOP
       01a2:64fa d9 1f           FSTP       float ptr [BX]
       01a2:64fc 90              NOP
       01a2:64fd 9b              WAIT
       01a2:64fe 90              NOP
       01a2:64ff d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:6503 90              NOP
       01a2:6504 d8 06 e6 b3     FADD       float ptr [0xb3e6]
       01a2:6508 83 ec 04        SUB        SP,0x4
       01a2:650b 8b dc           MOV        BX,SP
       01a2:650d 90              NOP
       01a2:650e d9 1f           FSTP       float ptr [BX]
       01a2:6510 90              NOP
       01a2:6511 9b              WAIT
       01a2:6512 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:6517 33 c0           XOR        AX,AX
       01a2:6519 50              PUSH       AX
       01a2:651a b8 ff ff        MOV        AX,0xffff
       01a2:651d 50              PUSH       AX
       01a2:651e 33 c0           XOR        AX,AX
       01a2:6520 50              PUSH       AX
       01a2:6521 9a 80 10        CALLF      LINE
                 71 0e
       01a2:6526 90              NOP
       01a2:6527 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:652b 90              NOP
       01a2:652c d8 06 4e b4     FADD       float ptr [0xb44e]
       01a2:6530 83 ec 04        SUB        SP,0x4
       01a2:6533 8b dc           MOV        BX,SP
       01a2:6535 90              NOP
       01a2:6536 d9 1f           FSTP       float ptr [BX]
       01a2:6538 90              NOP
       01a2:6539 9b              WAIT
       01a2:653a 90              NOP
       01a2:653b d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:653f 90              NOP
       01a2:6540 d8 06 e6 b3     FADD       float ptr [0xb3e6]
       01a2:6544 83 ec 04        SUB        SP,0x4
       01a2:6547 8b dc           MOV        BX,SP
       01a2:6549 90              NOP
       01a2:654a d9 1f           FSTP       float ptr [BX]
       01a2:654c 90              NOP
       01a2:654d 9b              WAIT
       01a2:654e 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:6553 90              NOP
       01a2:6554 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:6558 90              NOP
       01a2:6559 d8 06 2a b4     FADD       float ptr [0xb42a]
       01a2:655d 83 ec 04        SUB        SP,0x4
       01a2:6560 8b dc           MOV        BX,SP
       01a2:6562 90              NOP
       01a2:6563 d9 1f           FSTP       float ptr [BX]
       01a2:6565 90              NOP
       01a2:6566 9b              WAIT
       01a2:6567 90              NOP
       01a2:6568 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:656c 90              NOP
       01a2:656d d8 06 c6 b4     FADD       float ptr [0xb4c6]
       01a2:6571 83 ec 04        SUB        SP,0x4
       01a2:6574 8b dc           MOV        BX,SP
       01a2:6576 90              NOP
       01a2:6577 d9 1f           FSTP       float ptr [BX]
       01a2:6579 90              NOP
       01a2:657a 9b              WAIT
       01a2:657b 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:6580 33 c0           XOR        AX,AX
       01a2:6582 50              PUSH       AX
       01a2:6583 b8 ff ff        MOV        AX,0xffff
       01a2:6586 50              PUSH       AX
       01a2:6587 33 c0           XOR        AX,AX
       01a2:6589 50              PUSH       AX
       01a2:658a 9a 80 10        CALLF      LINE
                 71 0e
       01a2:658f 90              NOP
       01a2:6590 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:6594 90              NOP
       01a2:6595 d8 06 c6 b4     FADD       float ptr [0xb4c6]
       01a2:6599 83 ec 04        SUB        SP,0x4
       01a2:659c 8b dc           MOV        BX,SP
       01a2:659e 90              NOP
       01a2:659f d9 1f           FSTP       float ptr [BX]
       01a2:65a1 90              NOP
       01a2:65a2 9b              WAIT
       01a2:65a3 90              NOP
       01a2:65a4 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:65a8 90              NOP
       01a2:65a9 d8 06 f2 b3     FADD       float ptr [0xb3f2]
       01a2:65ad 83 ec 04        SUB        SP,0x4
       01a2:65b0 8b dc           MOV        BX,SP
       01a2:65b2 90              NOP
       01a2:65b3 d9 1f           FSTP       float ptr [BX]
       01a2:65b5 90              NOP
       01a2:65b6 9b              WAIT
       01a2:65b7 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:65bc 90              NOP
       01a2:65bd d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:65c1 90              NOP
       01a2:65c2 d8 06 8c af     FADD       float ptr { 10.0 }
       01a2:65c6 83 ec 04        SUB        SP,0x4
       01a2:65c9 8b dc           MOV        BX,SP
       01a2:65cb 90              NOP
       01a2:65cc d9 1f           FSTP       float ptr [BX]
       01a2:65ce 90              NOP
       01a2:65cf 9b              WAIT
       01a2:65d0 90              NOP
       01a2:65d1 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:65d5 90              NOP
       01a2:65d6 d8 06 74 a6     FADD       float ptr { 4.0 }
       01a2:65da 83 ec 04        SUB        SP,0x4
       01a2:65dd 8b dc           MOV        BX,SP
       01a2:65df 90              NOP
       01a2:65e0 d9 1f           FSTP       float ptr [BX]
       01a2:65e2 90              NOP
       01a2:65e3 9b              WAIT
       01a2:65e4 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:65e9 33 c0           XOR        AX,AX
       01a2:65eb 50              PUSH       AX
       01a2:65ec b8 ff ff        MOV        AX,0xffff
       01a2:65ef 50              PUSH       AX
       01a2:65f0 33 c0           XOR        AX,AX
       01a2:65f2 50              PUSH       AX
       01a2:65f3 9a 80 10        CALLF      LINE
                 71 0e
       01a2:65f8 90              NOP
       01a2:65f9 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:65fd 90              NOP
       01a2:65fe d8 06 8c af     FADD       float ptr { 10.0 }
       01a2:6602 83 ec 04        SUB        SP,0x4
       01a2:6605 8b dc           MOV        BX,SP
       01a2:6607 90              NOP
       01a2:6608 d9 1f           FSTP       float ptr [BX]
       01a2:660a 90              NOP
       01a2:660b 9b              WAIT
       01a2:660c 90              NOP
       01a2:660d d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:6611 90              NOP
       01a2:6612 d8 06 74 a6     FADD       float ptr { 4.0 }
       01a2:6616 83 ec 04        SUB        SP,0x4
       01a2:6619 8b dc           MOV        BX,SP
       01a2:661b 90              NOP
       01a2:661c d9 1f           FSTP       float ptr [BX]
       01a2:661e 90              NOP
       01a2:661f 9b              WAIT
       01a2:6620 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:6625 90              NOP
       01a2:6626 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:662a 90              NOP
       01a2:662b d8 06 3a b4     FADD       float ptr [0xb43a]
       01a2:662f 83 ec 04        SUB        SP,0x4
       01a2:6632 8b dc           MOV        BX,SP
       01a2:6634 90              NOP
       01a2:6635 d9 1f           FSTP       float ptr [BX]
       01a2:6637 90              NOP
       01a2:6638 9b              WAIT
       01a2:6639 90              NOP
       01a2:663a d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:663e 90              NOP
       01a2:663f d8 06 b4 a6     FADD       float ptr { 2.0 }
       01a2:6643 83 ec 04        SUB        SP,0x4
       01a2:6646 8b dc           MOV        BX,SP
       01a2:6648 90              NOP
       01a2:6649 d9 1f           FSTP       float ptr [BX]
       01a2:664b 90              NOP
       01a2:664c 9b              WAIT
       01a2:664d 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:6652 33 c0           XOR        AX,AX
       01a2:6654 50              PUSH       AX
       01a2:6655 b8 ff ff        MOV        AX,0xffff
       01a2:6658 50              PUSH       AX
       01a2:6659 33 c0           XOR        AX,AX
       01a2:665b 50              PUSH       AX
       01a2:665c 9a 80 10        CALLF      LINE
                 71 0e
       01a2:6661 90              NOP
       01a2:6662 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:6666 90              NOP
       01a2:6667 d8 06 3a b4     FADD       float ptr [0xb43a]
       01a2:666b 83 ec 04        SUB        SP,0x4
       01a2:666e 8b dc           MOV        BX,SP
       01a2:6670 90              NOP
       01a2:6671 d9 1f           FSTP       float ptr [BX]
       01a2:6673 90              NOP
       01a2:6674 9b              WAIT
       01a2:6675 90              NOP
       01a2:6676 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:667a 90              NOP
       01a2:667b d8 06 b4 a6     FADD       float ptr { 2.0 }
       01a2:667f 83 ec 04        SUB        SP,0x4
       01a2:6682 8b dc           MOV        BX,SP
       01a2:6684 90              NOP
       01a2:6685 d9 1f           FSTP       float ptr [BX]
       01a2:6687 90              NOP
       01a2:6688 9b              WAIT
       01a2:6689 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:668e 90              NOP
       01a2:668f d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:6693 90              NOP
       01a2:6694 d8 06 5e b4     FADD       float ptr [0xb45e]
       01a2:6698 83 ec 04        SUB        SP,0x4
       01a2:669b 8b dc           MOV        BX,SP
       01a2:669d 90              NOP
       01a2:669e d9 1f           FSTP       float ptr [BX]
       01a2:66a0 90              NOP
       01a2:66a1 9b              WAIT
       01a2:66a2 90              NOP
       01a2:66a3 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:66a7 90              NOP
       01a2:66a8 d8 06 24 a6     FADD       float ptr { 3.0 }
       01a2:66ac 83 ec 04        SUB        SP,0x4
       01a2:66af 8b dc           MOV        BX,SP
       01a2:66b1 90              NOP
       01a2:66b2 d9 1f           FSTP       float ptr [BX]
       01a2:66b4 90              NOP
       01a2:66b5 9b              WAIT
       01a2:66b6 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:66bb 33 c0           XOR        AX,AX
       01a2:66bd 50              PUSH       AX
       01a2:66be b8 ff ff        MOV        AX,0xffff
       01a2:66c1 50              PUSH       AX
       01a2:66c2 33 c0           XOR        AX,AX
       01a2:66c4 50              PUSH       AX
       01a2:66c5 9a 80 10        CALLF      LINE
                 71 0e
       01a2:66ca 90              NOP
       01a2:66cb d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:66cf 90              NOP
       01a2:66d0 d8 06 24 a6     FADD       float ptr { 3.0 }
       01a2:66d4 83 ec 04        SUB        SP,0x4
       01a2:66d7 8b dc           MOV        BX,SP
       01a2:66d9 90              NOP
       01a2:66da d9 1f           FSTP       float ptr [BX]
       01a2:66dc 90              NOP
       01a2:66dd 9b              WAIT
       01a2:66de 90              NOP
       01a2:66df d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:66e3 90              NOP
       01a2:66e4 d8 06 c6 b4     FADD       float ptr [0xb4c6]
       01a2:66e8 83 ec 04        SUB        SP,0x4
       01a2:66eb 8b dc           MOV        BX,SP
       01a2:66ed 90              NOP
       01a2:66ee d9 1f           FSTP       float ptr [BX]
       01a2:66f0 90              NOP
       01a2:66f1 9b              WAIT
       01a2:66f2 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:66f7 90              NOP
       01a2:66f8 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:66fc 90              NOP
       01a2:66fd d8 06 5e b4     FADD       float ptr [0xb45e]
       01a2:6701 83 ec 04        SUB        SP,0x4
       01a2:6704 8b dc           MOV        BX,SP
       01a2:6706 90              NOP
       01a2:6707 d9 1f           FSTP       float ptr [BX]
       01a2:6709 90              NOP
       01a2:670a 9b              WAIT
       01a2:670b 90              NOP
       01a2:670c d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:6710 90              NOP
       01a2:6711 d8 06 24 a6     FADD       float ptr { 3.0 }
       01a2:6715 83 ec 04        SUB        SP,0x4
       01a2:6718 8b dc           MOV        BX,SP
       01a2:671a 90              NOP
       01a2:671b d9 1f           FSTP       float ptr [BX]
       01a2:671d 90              NOP
       01a2:671e 9b              WAIT
       01a2:671f 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:6724 33 c0           XOR        AX,AX
       01a2:6726 50              PUSH       AX
       01a2:6727 b8 ff ff        MOV        AX,0xffff
       01a2:672a 50              PUSH       AX
       01a2:672b 33 c0           XOR        AX,AX
       01a2:672d 50              PUSH       AX
       01a2:672e 9a 80 10        CALLF      LINE
                 71 0e
       01a2:6733 90              NOP
       01a2:6734 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:6738 90              NOP
       01a2:6739 d8 06 24 a6     FADD       float ptr { 3.0 }
       01a2:673d 83 ec 04        SUB        SP,0x4
       01a2:6740 8b dc           MOV        BX,SP
       01a2:6742 90              NOP
       01a2:6743 d9 1f           FSTP       float ptr [BX]
       01a2:6745 90              NOP
       01a2:6746 9b              WAIT
       01a2:6747 90              NOP
       01a2:6748 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:674c 90              NOP
       01a2:674d d8 06 c6 b4     FADD       float ptr [0xb4c6]
       01a2:6751 83 ec 04        SUB        SP,0x4
       01a2:6754 8b dc           MOV        BX,SP
       01a2:6756 90              NOP
       01a2:6757 d9 1f           FSTP       float ptr [BX]
       01a2:6759 90              NOP
       01a2:675a 9b              WAIT
       01a2:675b 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:6760 90              NOP
       01a2:6761 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:6765 90              NOP
       01a2:6766 d8 06 2a b4     FADD       float ptr [0xb42a]
       01a2:676a 83 ec 04        SUB        SP,0x4
       01a2:676d 8b dc           MOV        BX,SP
       01a2:676f 90              NOP
       01a2:6770 d9 1f           FSTP       float ptr [BX]
       01a2:6772 90              NOP
       01a2:6773 9b              WAIT
       01a2:6774 90              NOP
       01a2:6775 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:6779 90              NOP
       01a2:677a d8 06 c6 b4     FADD       float ptr [0xb4c6]
       01a2:677e 83 ec 04        SUB        SP,0x4
       01a2:6781 8b dc           MOV        BX,SP
       01a2:6783 90              NOP
       01a2:6784 d9 1f           FSTP       float ptr [BX]
       01a2:6786 90              NOP
       01a2:6787 9b              WAIT
       01a2:6788 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:678d 33 c0           XOR        AX,AX
       01a2:678f 50              PUSH       AX
       01a2:6790 b8 ff ff        MOV        AX,0xffff
       01a2:6793 50              PUSH       AX
       01a2:6794 33 c0           XOR        AX,AX
       01a2:6796 50              PUSH       AX
       01a2:6797 9a 80 10        CALLF      LINE
                 71 0e
       01a2:679c 90              NOP
       01a2:679d d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:67a1 90              NOP
       01a2:67a2 d8 06 80 af     FADD       float ptr { 6.0 }
       01a2:67a6 83 ec 04        SUB        SP,0x4
       01a2:67a9 8b dc           MOV        BX,SP
       01a2:67ab 90              NOP
       01a2:67ac d9 1f           FSTP       float ptr [BX]
       01a2:67ae 90              NOP
       01a2:67af 9b              WAIT
       01a2:67b0 90              NOP
       01a2:67b1 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:67b5 90              NOP
       01a2:67b6 d8 06 3a b4     FADD       float ptr [0xb43a]
       01a2:67ba 83 ec 04        SUB        SP,0x4
       01a2:67bd 8b dc           MOV        BX,SP
       01a2:67bf 90              NOP
       01a2:67c0 d9 1f           FSTP       float ptr [BX]
       01a2:67c2 90              NOP
       01a2:67c3 9b              WAIT
       01a2:67c4 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:67c9 90              NOP
       01a2:67ca d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:67ce 90              NOP
       01a2:67cf d8 06 32 b4     FADD       float ptr [0xb432]
       01a2:67d3 83 ec 04        SUB        SP,0x4
       01a2:67d6 8b dc           MOV        BX,SP
       01a2:67d8 90              NOP
       01a2:67d9 d9 1f           FSTP       float ptr [BX]
       01a2:67db 90              NOP
       01a2:67dc 9b              WAIT
       01a2:67dd 90              NOP
       01a2:67de d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:67e2 90              NOP
       01a2:67e3 d8 06 5e b4     FADD       float ptr [0xb45e]
       01a2:67e7 83 ec 04        SUB        SP,0x4
       01a2:67ea 8b dc           MOV        BX,SP
       01a2:67ec 90              NOP
       01a2:67ed d9 1f           FSTP       float ptr [BX]
       01a2:67ef 90              NOP
       01a2:67f0 9b              WAIT
       01a2:67f1 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:67f6 b8 09 00        MOV        AX,0x9
       01a2:67f9 50              PUSH       AX
       01a2:67fa b8 ff ff        MOV        AX,0xffff
       01a2:67fd 50              PUSH       AX
       01a2:67fe b8 02 00        MOV        AX,0x2
       01a2:6801 50              PUSH       AX
       01a2:6802 9a 80 10        CALLF      LINE
                 71 0e
       01a2:6807 90              NOP
       01a2:6808 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:680c 90              NOP
       01a2:680d d8 06 7c af     FADD       float ptr { 5.0 }
       01a2:6811 83 ec 04        SUB        SP,0x4
       01a2:6814 8b dc           MOV        BX,SP
       01a2:6816 90              NOP
       01a2:6817 d9 1f           FSTP       float ptr [BX]
       01a2:6819 90              NOP
       01a2:681a 9b              WAIT
       01a2:681b 90              NOP
       01a2:681c d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:6820 90              NOP
       01a2:6821 d8 06 10 a6     FADD       float ptr { 18.0 }
       01a2:6825 83 ec 04        SUB        SP,0x4
       01a2:6828 8b dc           MOV        BX,SP
       01a2:682a 90              NOP
       01a2:682b d9 1f           FSTP       float ptr [BX]
       01a2:682d 90              NOP
       01a2:682e 9b              WAIT
       01a2:682f 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:6834 90              NOP
       01a2:6835 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:6839 90              NOP
       01a2:683a d8 06 2a b4     FADD       float ptr [0xb42a]
       01a2:683e 83 ec 04        SUB        SP,0x4
       01a2:6841 8b dc           MOV        BX,SP
       01a2:6843 90              NOP
       01a2:6844 d9 1f           FSTP       float ptr [BX]
       01a2:6846 90              NOP
       01a2:6847 9b              WAIT
       01a2:6848 90              NOP
       01a2:6849 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:684d 90              NOP
       01a2:684e d8 06 c6 b4     FADD       float ptr [0xb4c6]
       01a2:6852 83 ec 04        SUB        SP,0x4
       01a2:6855 8b dc           MOV        BX,SP
       01a2:6857 90              NOP
       01a2:6858 d9 1f           FSTP       float ptr [BX]
       01a2:685a 90              NOP
       01a2:685b 9b              WAIT
       01a2:685c 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:6861 33 c0           XOR        AX,AX
       01a2:6863 50              PUSH       AX
       01a2:6864 b8 ff ff        MOV        AX,0xffff
       01a2:6867 50              PUSH       AX
       01a2:6868 b8 01 00        MOV        AX,0x1
       01a2:686b 50              PUSH       AX
       01a2:686c 9a 80 10        CALLF      LINE
                 71 0e
       01a2:6871 90              NOP
       01a2:6872 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:6876 90              NOP
       01a2:6877 d8 06 f6 b4     FADD       float ptr [0xb4f6]
       01a2:687b 83 ec 04        SUB        SP,0x4
       01a2:687e 8b dc           MOV        BX,SP
       01a2:6880 90              NOP
       01a2:6881 d9 1f           FSTP       float ptr [BX]
       01a2:6883 90              NOP
       01a2:6884 9b              WAIT
       01a2:6885 ff 36 34 a2     PUSH       word ptr [0xa234]
       01a2:6889 ff 36 32 a2     PUSH       word ptr [0xa232]
       01a2:688d 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:6892 b8 02 00        MOV        AX,0x2
       01a2:6895 50              PUSH       AX
       01a2:6896 33 c0           XOR        AX,AX
       01a2:6898 50              PUSH       AX
       01a2:6899 9a 35 17        CALLF      PAINT
                 71 0e
       01a2:689e 90              NOP
       01a2:689f d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:68a3 90              NOP
       01a2:68a4 d8 06 24 a6     FADD       float ptr { 3.0 }
       01a2:68a8 83 ec 04        SUB        SP,0x4
       01a2:68ab 8b dc           MOV        BX,SP
       01a2:68ad 90              NOP
       01a2:68ae d9 1f           FSTP       float ptr [BX]
       01a2:68b0 90              NOP
       01a2:68b1 9b              WAIT
       01a2:68b2 90              NOP
       01a2:68b3 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:68b7 90              NOP
       01a2:68b8 d8 06 c6 b4     FADD       float ptr [0xb4c6]
       01a2:68bc 83 ec 04        SUB        SP,0x4
       01a2:68bf 8b dc           MOV        BX,SP
       01a2:68c1 90              NOP
       01a2:68c2 d9 1f           FSTP       float ptr [BX]
       01a2:68c4 90              NOP
       01a2:68c5 9b              WAIT
       01a2:68c6 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:68cb 90              NOP
       01a2:68cc d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:68d0 90              NOP
       01a2:68d1 d8 06 56 b4     FADD       float ptr [0xb456]
       01a2:68d5 83 ec 04        SUB        SP,0x4
       01a2:68d8 8b dc           MOV        BX,SP
       01a2:68da 90              NOP
       01a2:68db d9 1f           FSTP       float ptr [BX]
       01a2:68dd 90              NOP
       01a2:68de 9b              WAIT
       01a2:68df 90              NOP
       01a2:68e0 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:68e4 90              NOP
       01a2:68e5 d8 06 50 a5     FADD       float ptr { 1.0 }
       01a2:68e9 83 ec 04        SUB        SP,0x4
       01a2:68ec 8b dc           MOV        BX,SP
       01a2:68ee 90              NOP
       01a2:68ef d9 1f           FSTP       float ptr [BX]
       01a2:68f1 90              NOP
       01a2:68f2 9b              WAIT
       01a2:68f3 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:68f8 33 c0           XOR        AX,AX
       01a2:68fa 50              PUSH       AX
       01a2:68fb b8 ff ff        MOV        AX,0xffff
       01a2:68fe 50              PUSH       AX
       01a2:68ff 33 c0           XOR        AX,AX
       01a2:6901 50              PUSH       AX
       01a2:6902 9a 80 10        CALLF      LINE
                 71 0e
       01a2:6907 90              NOP
       01a2:6908 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:690c 90              NOP
       01a2:690d d8 06 94 af     FADD       float ptr { 9.0 }
       01a2:6911 83 ec 04        SUB        SP,0x4
       01a2:6914 8b dc           MOV        BX,SP
       01a2:6916 90              NOP
       01a2:6917 d9 1f           FSTP       float ptr [BX]
       01a2:6919 90              NOP
       01a2:691a 9b              WAIT
       01a2:691b 90              NOP
       01a2:691c d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:6920 90              NOP
       01a2:6921 d8 06 7c af     FADD       float ptr { 5.0 }
       01a2:6925 83 ec 04        SUB        SP,0x4
       01a2:6928 8b dc           MOV        BX,SP
       01a2:692a 90              NOP
       01a2:692b d9 1f           FSTP       float ptr [BX]
       01a2:692d 90              NOP
       01a2:692e 9b              WAIT
       01a2:692f 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:6934 ff 36 b6 a6     PUSH       word ptr [0xa6b6]
       01a2:6938 ff 36 b4 a6     PUSH       word ptr { 2.0 }
       01a2:693c b8 0f 00        MOV        AX,0xf
       01a2:693f 50              PUSH       AX
       01a2:6940 9a b4 0d        CALLF      CIRCLE
                 71 0e
       01a2:6945 90              NOP
       01a2:6946 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:694a 90              NOP
       01a2:694b d8 06 94 af     FADD       float ptr { 9.0 }
       01a2:694f 83 ec 04        SUB        SP,0x4
       01a2:6952 8b dc           MOV        BX,SP
       01a2:6954 90              NOP
       01a2:6955 d9 1f           FSTP       float ptr [BX]
       01a2:6957 90              NOP
       01a2:6958 9b              WAIT
       01a2:6959 90              NOP
       01a2:695a d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:695e 90              NOP
       01a2:695f d8 06 7c af     FADD       float ptr { 5.0 }
       01a2:6963 83 ec 04        SUB        SP,0x4
       01a2:6966 8b dc           MOV        BX,SP
       01a2:6968 90              NOP
       01a2:6969 d9 1f           FSTP       float ptr [BX]
       01a2:696b 90              NOP
       01a2:696c 9b              WAIT
       01a2:696d 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:6972 b8 0f 00        MOV        AX,0xf
       01a2:6975 50              PUSH       AX
       01a2:6976 50              PUSH       AX
       01a2:6977 9a 35 17        CALLF      PAINT
                 71 0e
       01a2:697c 90              NOP
       01a2:697d d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:6981 90              NOP
       01a2:6982 d8 06 94 af     FADD       float ptr { 9.0 }
       01a2:6986 83 ec 04        SUB        SP,0x4
       01a2:6989 8b dc           MOV        BX,SP
       01a2:698b 90              NOP
       01a2:698c d9 1f           FSTP       float ptr [BX]
       01a2:698e 90              NOP
       01a2:698f 9b              WAIT
       01a2:6990 90              NOP
       01a2:6991 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:6995 90              NOP
       01a2:6996 d8 06 7c af     FADD       float ptr { 5.0 }
       01a2:699a 83 ec 04        SUB        SP,0x4
       01a2:699d 8b dc           MOV        BX,SP
       01a2:699f 90              NOP
       01a2:69a0 d9 1f           FSTP       float ptr [BX]
       01a2:69a2 90              NOP
       01a2:69a3 9b              WAIT
       01a2:69a4 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:69a9 ff 36 26 a6     PUSH       word ptr [0xa626]
       01a2:69ad ff 36 24 a6     PUSH       word ptr { 3.0 }
       01a2:69b1 33 c0           XOR        AX,AX
       01a2:69b3 50              PUSH       AX
       01a2:69b4 9a b4 0d        CALLF      CIRCLE
                 71 0e
       01a2:69b9 90              NOP
       01a2:69ba d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:69be 90              NOP
       01a2:69bf d8 06 2e b4     FADD       float ptr [0xb42e]
       01a2:69c3 83 ec 04        SUB        SP,0x4
       01a2:69c6 8b dc           MOV        BX,SP
       01a2:69c8 90              NOP
       01a2:69c9 d9 1f           FSTP       float ptr [BX]
       01a2:69cb 90              NOP
       01a2:69cc 9b              WAIT
       01a2:69cd 90              NOP
       01a2:69ce d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:69d2 90              NOP
       01a2:69d3 d8 06 ca b4     FADD       float ptr [0xb4ca]
       01a2:69d7 83 ec 04        SUB        SP,0x4
       01a2:69da 8b dc           MOV        BX,SP
       01a2:69dc 90              NOP
       01a2:69dd d9 1f           FSTP       float ptr [BX]
       01a2:69df 90              NOP
       01a2:69e0 9b              WAIT
       01a2:69e1 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:69e6 ff 36 b6 a6     PUSH       word ptr [0xa6b6]
       01a2:69ea ff 36 b4 a6     PUSH       word ptr { 2.0 }
       01a2:69ee 33 c0           XOR        AX,AX
       01a2:69f0 50              PUSH       AX
       01a2:69f1 9a b4 0d        CALLF      CIRCLE
                 71 0e
       01a2:69f6 90              NOP
       01a2:69f7 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:69fb 90              NOP
       01a2:69fc d8 06 36 b0     FADD       float ptr { 30.0 }
       01a2:6a00 83 ec 04        SUB        SP,0x4
       01a2:6a03 8b dc           MOV        BX,SP
       01a2:6a05 90              NOP
       01a2:6a06 d9 1f           FSTP       float ptr [BX]
       01a2:6a08 90              NOP
       01a2:6a09 9b              WAIT
       01a2:6a0a 90              NOP
       01a2:6a0b d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:6a0f 90              NOP
       01a2:6a10 d8 06 ca b4     FADD       float ptr [0xb4ca]
       01a2:6a14 83 ec 04        SUB        SP,0x4
       01a2:6a17 8b dc           MOV        BX,SP
       01a2:6a19 90              NOP
       01a2:6a1a d9 1f           FSTP       float ptr [BX]
       01a2:6a1c 90              NOP
       01a2:6a1d 9b              WAIT
       01a2:6a1e 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:6a23 ff 36 b6 a6     PUSH       word ptr [0xa6b6]
       01a2:6a27 ff 36 b4 a6     PUSH       word ptr { 2.0 }
       01a2:6a2b 33 c0           XOR        AX,AX
       01a2:6a2d 50              PUSH       AX
       01a2:6a2e 9a b4 0d        CALLF      CIRCLE
                 71 0e
       01a2:6a33 90              NOP
       01a2:6a34 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:6a38 90              NOP
       01a2:6a39 d8 06 2e b4     FADD       float ptr [0xb42e]
       01a2:6a3d 83 ec 04        SUB        SP,0x4
       01a2:6a40 8b dc           MOV        BX,SP
       01a2:6a42 90              NOP
       01a2:6a43 d9 1f           FSTP       float ptr [BX]
       01a2:6a45 90              NOP
       01a2:6a46 9b              WAIT
       01a2:6a47 90              NOP
       01a2:6a48 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:6a4c 90              NOP
       01a2:6a4d d8 06 ca b4     FADD       float ptr [0xb4ca]
       01a2:6a51 83 ec 04        SUB        SP,0x4
       01a2:6a54 8b dc           MOV        BX,SP
       01a2:6a56 90              NOP
       01a2:6a57 d9 1f           FSTP       float ptr [BX]
       01a2:6a59 90              NOP
       01a2:6a5a 9b              WAIT
       01a2:6a5b 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:6a60 33 c0           XOR        AX,AX
       01a2:6a62 50              PUSH       AX
       01a2:6a63 50              PUSH       AX
       01a2:6a64 9a 35 17        CALLF      PAINT
                 71 0e
       01a2:6a69 90              NOP
       01a2:6a6a d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:6a6e 90              NOP
       01a2:6a6f d8 06 36 b0     FADD       float ptr { 30.0 }
       01a2:6a73 83 ec 04        SUB        SP,0x4
       01a2:6a76 8b dc           MOV        BX,SP
       01a2:6a78 90              NOP
       01a2:6a79 d9 1f           FSTP       float ptr [BX]
       01a2:6a7b 90              NOP
       01a2:6a7c 9b              WAIT
       01a2:6a7d 90              NOP
       01a2:6a7e d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:6a82 90              NOP
       01a2:6a83 d8 06 ca b4     FADD       float ptr [0xb4ca]
       01a2:6a87 83 ec 04        SUB        SP,0x4
       01a2:6a8a 8b dc           MOV        BX,SP
       01a2:6a8c 90              NOP
       01a2:6a8d d9 1f           FSTP       float ptr [BX]
       01a2:6a8f 90              NOP
       01a2:6a90 9b              WAIT
       01a2:6a91 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:6a96 33 c0           XOR        AX,AX
       01a2:6a98 50              PUSH       AX
       01a2:6a99 50              PUSH       AX
       01a2:6a9a 9a 35 17        CALLF      PAINT
                 71 0e
       01a2:6a9f 90              NOP
       01a2:6aa0 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:6aa4 90              NOP
       01a2:6aa5 d8 06 2e b4     FADD       float ptr [0xb42e]
       01a2:6aa9 83 ec 04        SUB        SP,0x4
       01a2:6aac 8b dc           MOV        BX,SP
       01a2:6aae 90              NOP
       01a2:6aaf d9 1f           FSTP       float ptr [BX]
       01a2:6ab1 90              NOP
       01a2:6ab2 9b              WAIT
       01a2:6ab3 90              NOP
       01a2:6ab4 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:6ab8 90              NOP
       01a2:6ab9 d8 06 ca b4     FADD       float ptr [0xb4ca]
       01a2:6abd 83 ec 04        SUB        SP,0x4
       01a2:6ac0 8b dc           MOV        BX,SP
       01a2:6ac2 90              NOP
       01a2:6ac3 d9 1f           FSTP       float ptr [BX]
       01a2:6ac5 90              NOP
       01a2:6ac6 9b              WAIT
       01a2:6ac7 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:6acc ff 36 b6 a6     PUSH       word ptr [0xa6b6]
       01a2:6ad0 ff 36 b4 a6     PUSH       word ptr { 2.0 }
       01a2:6ad4 b8 0c 00        MOV        AX,0xc
       01a2:6ad7 50              PUSH       AX
       01a2:6ad8 9a b4 0d        CALLF      CIRCLE
                 71 0e
       01a2:6add 90              NOP
       01a2:6ade d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:6ae2 90              NOP
       01a2:6ae3 d8 06 36 b0     FADD       float ptr { 30.0 }
       01a2:6ae7 83 ec 04        SUB        SP,0x4
       01a2:6aea 8b dc           MOV        BX,SP
       01a2:6aec 90              NOP
       01a2:6aed d9 1f           FSTP       float ptr [BX]
       01a2:6aef 90              NOP
       01a2:6af0 9b              WAIT
       01a2:6af1 90              NOP
       01a2:6af2 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:6af6 90              NOP
       01a2:6af7 d8 06 ca b4     FADD       float ptr [0xb4ca]
       01a2:6afb 83 ec 04        SUB        SP,0x4
       01a2:6afe 8b dc           MOV        BX,SP
       01a2:6b00 90              NOP
       01a2:6b01 d9 1f           FSTP       float ptr [BX]
       01a2:6b03 90              NOP
       01a2:6b04 9b              WAIT
       01a2:6b05 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:6b0a ff 36 b6 a6     PUSH       word ptr [0xa6b6]
       01a2:6b0e ff 36 b4 a6     PUSH       word ptr { 2.0 }
       01a2:6b12 b8 0c 00        MOV        AX,0xc
       01a2:6b15 50              PUSH       AX
       01a2:6b16 9a b4 0d        CALLF      CIRCLE
                 71 0e
       01a2:6b1b 90              NOP
       01a2:6b1c d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:6b20 90              NOP
       01a2:6b21 d8 06 5e b4     FADD       float ptr [0xb45e]
       01a2:6b25 83 ec 04        SUB        SP,0x4
       01a2:6b28 8b dc           MOV        BX,SP
       01a2:6b2a 90              NOP
       01a2:6b2b d9 1f           FSTP       float ptr [BX]
       01a2:6b2d 90              NOP
       01a2:6b2e 9b              WAIT
       01a2:6b2f 90              NOP
       01a2:6b30 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:6b34 90              NOP
       01a2:6b35 d8 06 0e b4     FADD       float ptr [0xb40e]
       01a2:6b39 83 ec 04        SUB        SP,0x4
       01a2:6b3c 8b dc           MOV        BX,SP
       01a2:6b3e 90              NOP
       01a2:6b3f d9 1f           FSTP       float ptr [BX]
       01a2:6b41 90              NOP
       01a2:6b42 9b              WAIT
       01a2:6b43 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:6b48 b8 0f 00        MOV        AX,0xf
       01a2:6b4b 50              PUSH       AX
       01a2:6b4c 9a 74 12        CALLF      SUB_0e71_1274
                 71 0e
       01a2:6b51 90              NOP
       01a2:6b52 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:6b56 90              NOP
       01a2:6b57 d8 06 12 b4     FADD       float ptr [0xb412]
       01a2:6b5b 83 ec 04        SUB        SP,0x4
       01a2:6b5e 8b dc           MOV        BX,SP
       01a2:6b60 90              NOP
       01a2:6b61 d9 1f           FSTP       float ptr [BX]
       01a2:6b63 90              NOP
       01a2:6b64 9b              WAIT
       01a2:6b65 90              NOP
       01a2:6b66 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:6b6a 90              NOP
       01a2:6b6b d8 06 0e b4     FADD       float ptr [0xb40e]
       01a2:6b6f 83 ec 04        SUB        SP,0x4
       01a2:6b72 8b dc           MOV        BX,SP
       01a2:6b74 90              NOP
       01a2:6b75 d9 1f           FSTP       float ptr [BX]
       01a2:6b77 90              NOP
       01a2:6b78 9b              WAIT
       01a2:6b79 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:6b7e b8 0f 00        MOV        AX,0xf
       01a2:6b81 50              PUSH       AX
       01a2:6b82 9a 74 12        CALLF      SUB_0e71_1274
                 71 0e
       01a2:6b87 90              NOP
       01a2:6b88 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:6b8c 90              NOP
       01a2:6b8d d8 06 56 b4     FADD       float ptr [0xb456]
       01a2:6b91 83 ec 04        SUB        SP,0x4
       01a2:6b94 8b dc           MOV        BX,SP
       01a2:6b96 90              NOP
       01a2:6b97 d9 1f           FSTP       float ptr [BX]
       01a2:6b99 90              NOP
       01a2:6b9a 9b              WAIT
       01a2:6b9b 90              NOP
       01a2:6b9c d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:6ba0 90              NOP
       01a2:6ba1 d8 06 ee b3     FADD       float ptr [0xb3ee]
       01a2:6ba5 83 ec 04        SUB        SP,0x4
       01a2:6ba8 8b dc           MOV        BX,SP
       01a2:6baa 90              NOP
       01a2:6bab d9 1f           FSTP       float ptr [BX]
       01a2:6bad 90              NOP
       01a2:6bae 9b              WAIT
       01a2:6baf 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:6bb4 ff 36 52 a5     PUSH       word ptr [0xa552]
       01a2:6bb8 ff 36 50 a5     PUSH       word ptr { 1.0 }
       01a2:6bbc 33 c0           XOR        AX,AX
       01a2:6bbe 50              PUSH       AX
       01a2:6bbf 9a b4 0d        CALLF      CIRCLE
                 71 0e
       01a2:6bc4 90              NOP
       01a2:6bc5 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:6bc9 90              NOP
       01a2:6bca d8 06 4e b4     FADD       float ptr [0xb44e]
       01a2:6bce 83 ec 04        SUB        SP,0x4
       01a2:6bd1 8b dc           MOV        BX,SP
       01a2:6bd3 90              NOP
       01a2:6bd4 d9 1f           FSTP       float ptr [BX]
       01a2:6bd6 90              NOP
       01a2:6bd7 9b              WAIT
       01a2:6bd8 90              NOP
       01a2:6bd9 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:6bdd 90              NOP
       01a2:6bde d8 06 ee b3     FADD       float ptr [0xb3ee]
       01a2:6be2 83 ec 04        SUB        SP,0x4
       01a2:6be5 8b dc           MOV        BX,SP
       01a2:6be7 90              NOP
       01a2:6be8 d9 1f           FSTP       float ptr [BX]
       01a2:6bea 90              NOP
       01a2:6beb 9b              WAIT
       01a2:6bec 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:6bf1 ff 36 52 a5     PUSH       word ptr [0xa552]
       01a2:6bf5 ff 36 50 a5     PUSH       word ptr { 1.0 }
       01a2:6bf9 33 c0           XOR        AX,AX
       01a2:6bfb 50              PUSH       AX
       01a2:6bfc 9a b4 0d        CALLF      CIRCLE
                 71 0e
       01a2:6c01 90              NOP
       01a2:6c02 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:6c06 90              NOP
       01a2:6c07 d8 06 f6 b4     FADD       float ptr [0xb4f6]
       01a2:6c0b 83 ec 04        SUB        SP,0x4
       01a2:6c0e 8b dc           MOV        BX,SP
       01a2:6c10 90              NOP
       01a2:6c11 d9 1f           FSTP       float ptr [BX]
       01a2:6c13 90              NOP
       01a2:6c14 9b              WAIT
       01a2:6c15 90              NOP
       01a2:6c16 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:6c1a 90              NOP
       01a2:6c1b d8 06 da b3     FADD       float ptr [0xb3da]
       01a2:6c1f 83 ec 04        SUB        SP,0x4
       01a2:6c22 8b dc           MOV        BX,SP
       01a2:6c24 90              NOP
       01a2:6c25 d9 1f           FSTP       float ptr [BX]
       01a2:6c27 90              NOP
       01a2:6c28 9b              WAIT
       01a2:6c29 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:6c2e ff 36 04 b5     PUSH       word ptr [0xb504]
       01a2:6c32 ff 36 02 b5     PUSH       word ptr [0xb502]
       01a2:6c36 9a 44 0d        CALLF      CIRCLE_Start
                 71 0e
       01a2:6c3b ff 36 b6 a6     PUSH       word ptr [0xa6b6]
       01a2:6c3f ff 36 b4 a6     PUSH       word ptr { 2.0 }
       01a2:6c43 9a 4f 0d        CALLF      CIRCLE_End
                 71 0e
       01a2:6c48 ff 36 30 b4     PUSH       word ptr [0xb430]
       01a2:6c4c ff 36 2e b4     PUSH       word ptr [0xb42e]
       01a2:6c50 33 c0           XOR        AX,AX
       01a2:6c52 50              PUSH       AX
       01a2:6c53 9a b4 0d        CALLF      CIRCLE
                 71 0e
       01a2:6c58 90              NOP
       01a2:6c59 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:6c5d 90              NOP
       01a2:6c5e d8 06 f6 b4     FADD       float ptr [0xb4f6]
       01a2:6c62 83 ec 04        SUB        SP,0x4
       01a2:6c65 8b dc           MOV        BX,SP
       01a2:6c67 90              NOP
       01a2:6c68 d9 1f           FSTP       float ptr [BX]
       01a2:6c6a 90              NOP
       01a2:6c6b 9b              WAIT
       01a2:6c6c 90              NOP
       01a2:6c6d d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:6c71 90              NOP
       01a2:6c72 d8 06 da b3     FADD       float ptr [0xb3da]
       01a2:6c76 83 ec 04        SUB        SP,0x4
       01a2:6c79 8b dc           MOV        BX,SP
       01a2:6c7b 90              NOP
       01a2:6c7c d9 1f           FSTP       float ptr [BX]
       01a2:6c7e 90              NOP
       01a2:6c7f 9b              WAIT
       01a2:6c80 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:6c85 ff 36 04 b5     PUSH       word ptr [0xb504]
       01a2:6c89 ff 36 02 b5     PUSH       word ptr [0xb502]
       01a2:6c8d 9a 44 0d        CALLF      CIRCLE_Start
                 71 0e
       01a2:6c92 ff 36 b6 a6     PUSH       word ptr [0xa6b6]
       01a2:6c96 ff 36 b4 a6     PUSH       word ptr { 2.0 }
       01a2:6c9a 9a 4f 0d        CALLF      CIRCLE_End
                 71 0e
       01a2:6c9f ff 36 3c b4     PUSH       word ptr [0xb43c]
       01a2:6ca3 ff 36 3a b4     PUSH       word ptr [0xb43a]
       01a2:6ca7 33 c0           XOR        AX,AX
       01a2:6ca9 50              PUSH       AX
       01a2:6caa 9a b4 0d        CALLF      CIRCLE
                 71 0e
       01a2:6caf 90              NOP
       01a2:6cb0 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:6cb4 90              NOP
       01a2:6cb5 d8 06 5e b4     FADD       float ptr [0xb45e]
       01a2:6cb9 83 ec 04        SUB        SP,0x4
       01a2:6cbc 8b dc           MOV        BX,SP
       01a2:6cbe 90              NOP
       01a2:6cbf d9 1f           FSTP       float ptr [BX]
       01a2:6cc1 90              NOP
       01a2:6cc2 9b              WAIT
       01a2:6cc3 90              NOP
       01a2:6cc4 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:6cc8 90              NOP
       01a2:6cc9 d8 06 c6 b4     FADD       float ptr [0xb4c6]
       01a2:6ccd 83 ec 04        SUB        SP,0x4
       01a2:6cd0 8b dc           MOV        BX,SP
       01a2:6cd2 90              NOP
       01a2:6cd3 d9 1f           FSTP       float ptr [BX]
       01a2:6cd5 90              NOP
       01a2:6cd6 9b              WAIT
       01a2:6cd7 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:6cdc 90              NOP
       01a2:6cdd d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:6ce1 90              NOP
       01a2:6ce2 d8 06 7c af     FADD       float ptr { 5.0 }
       01a2:6ce6 83 ec 04        SUB        SP,0x4
       01a2:6ce9 8b dc           MOV        BX,SP
       01a2:6ceb 90              NOP
       01a2:6cec d9 1f           FSTP       float ptr [BX]
       01a2:6cee 90              NOP
       01a2:6cef 9b              WAIT
       01a2:6cf0 90              NOP
       01a2:6cf1 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:6cf5 90              NOP
       01a2:6cf6 d8 06 36 b0     FADD       float ptr { 30.0 }
       01a2:6cfa 83 ec 04        SUB        SP,0x4
       01a2:6cfd 8b dc           MOV        BX,SP
       01a2:6cff 90              NOP
       01a2:6d00 d9 1f           FSTP       float ptr [BX]
       01a2:6d02 90              NOP
       01a2:6d03 9b              WAIT
       01a2:6d04 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:6d09 33 c0           XOR        AX,AX
       01a2:6d0b 50              PUSH       AX
       01a2:6d0c b8 ff ff        MOV        AX,0xffff
       01a2:6d0f 50              PUSH       AX
       01a2:6d10 33 c0           XOR        AX,AX
       01a2:6d12 50              PUSH       AX
       01a2:6d13 9a 80 10        CALLF      LINE
                 71 0e
       01a2:6d18 90              NOP
       01a2:6d19 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:6d1d 90              NOP
       01a2:6d1e d8 06 ca b4     FADD       float ptr [0xb4ca]
       01a2:6d22 83 ec 04        SUB        SP,0x4
       01a2:6d25 8b dc           MOV        BX,SP
       01a2:6d27 90              NOP
       01a2:6d28 d9 1f           FSTP       float ptr [BX]
       01a2:6d2a 90              NOP
       01a2:6d2b 9b              WAIT
       01a2:6d2c 90              NOP
       01a2:6d2d d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:6d31 90              NOP
       01a2:6d32 d8 06 c6 b4     FADD       float ptr [0xb4c6]
       01a2:6d36 83 ec 04        SUB        SP,0x4
       01a2:6d39 8b dc           MOV        BX,SP
       01a2:6d3b 90              NOP
       01a2:6d3c d9 1f           FSTP       float ptr [BX]
       01a2:6d3e 90              NOP
       01a2:6d3f 9b              WAIT
       01a2:6d40 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:6d45 90              NOP
       01a2:6d46 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:6d4a 90              NOP
       01a2:6d4b d8 06 32 b4     FADD       float ptr [0xb432]
       01a2:6d4f 83 ec 04        SUB        SP,0x4
       01a2:6d52 8b dc           MOV        BX,SP
       01a2:6d54 90              NOP
       01a2:6d55 d9 1f           FSTP       float ptr [BX]
       01a2:6d57 90              NOP
       01a2:6d58 9b              WAIT
       01a2:6d59 90              NOP
       01a2:6d5a d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:6d5e 90              NOP
       01a2:6d5f d8 06 36 b0     FADD       float ptr { 30.0 }
       01a2:6d63 83 ec 04        SUB        SP,0x4
       01a2:6d66 8b dc           MOV        BX,SP
       01a2:6d68 90              NOP
       01a2:6d69 d9 1f           FSTP       float ptr [BX]
       01a2:6d6b 90              NOP
       01a2:6d6c 9b              WAIT
       01a2:6d6d 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:6d72 33 c0           XOR        AX,AX
       01a2:6d74 50              PUSH       AX
       01a2:6d75 b8 ff ff        MOV        AX,0xffff
       01a2:6d78 50              PUSH       AX
       01a2:6d79 33 c0           XOR        AX,AX
       01a2:6d7b 50              PUSH       AX
       01a2:6d7c 9a 80 10        CALLF      LINE
                 71 0e
       01a2:6d81 90              NOP
       01a2:6d82 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:6d86 90              NOP
       01a2:6d87 d8 06 10 a6     FADD       float ptr { 18.0 }
       01a2:6d8b 83 ec 04        SUB        SP,0x4
       01a2:6d8e 8b dc           MOV        BX,SP
       01a2:6d90 90              NOP
       01a2:6d91 d9 1f           FSTP       float ptr [BX]
       01a2:6d93 90              NOP
       01a2:6d94 9b              WAIT
       01a2:6d95 90              NOP
       01a2:6d96 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:6d9a 90              NOP
       01a2:6d9b d8 06 c6 b4     FADD       float ptr [0xb4c6]
       01a2:6d9f 83 ec 04        SUB        SP,0x4
       01a2:6da2 8b dc           MOV        BX,SP
       01a2:6da4 90              NOP
       01a2:6da5 d9 1f           FSTP       float ptr [BX]
       01a2:6da7 90              NOP
       01a2:6da8 9b              WAIT
       01a2:6da9 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:6dae 90              NOP
       01a2:6daf d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:6db3 90              NOP
       01a2:6db4 d8 06 3a b2     FADD       float ptr { 7.0 }
       01a2:6db8 83 ec 04        SUB        SP,0x4
       01a2:6dbb 8b dc           MOV        BX,SP
       01a2:6dbd 90              NOP
       01a2:6dbe d9 1f           FSTP       float ptr [BX]
       01a2:6dc0 90              NOP
       01a2:6dc1 9b              WAIT
       01a2:6dc2 90              NOP
       01a2:6dc3 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:6dc7 90              NOP
       01a2:6dc8 d8 06 0e b4     FADD       float ptr [0xb40e]
       01a2:6dcc 83 ec 04        SUB        SP,0x4
       01a2:6dcf 8b dc           MOV        BX,SP
       01a2:6dd1 90              NOP
       01a2:6dd2 d9 1f           FSTP       float ptr [BX]
       01a2:6dd4 90              NOP
       01a2:6dd5 9b              WAIT
       01a2:6dd6 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:6ddb 33 c0           XOR        AX,AX
       01a2:6ddd 50              PUSH       AX
       01a2:6dde b8 ff ff        MOV        AX,0xffff
       01a2:6de1 50              PUSH       AX
       01a2:6de2 33 c0           XOR        AX,AX
       01a2:6de4 50              PUSH       AX
       01a2:6de5 9a 80 10        CALLF      LINE
                 71 0e
       01a2:6dea 90              NOP
       01a2:6deb d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:6def 90              NOP
       01a2:6df0 d8 06 12 b4     FADD       float ptr [0xb412]
       01a2:6df4 83 ec 04        SUB        SP,0x4
       01a2:6df7 8b dc           MOV        BX,SP
       01a2:6df9 90              NOP
       01a2:6dfa d9 1f           FSTP       float ptr [BX]
       01a2:6dfc 90              NOP
       01a2:6dfd 9b              WAIT
       01a2:6dfe 90              NOP
       01a2:6dff d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:6e03 90              NOP
       01a2:6e04 d8 06 c6 b4     FADD       float ptr [0xb4c6]
       01a2:6e08 83 ec 04        SUB        SP,0x4
       01a2:6e0b 8b dc           MOV        BX,SP
       01a2:6e0d 90              NOP
       01a2:6e0e d9 1f           FSTP       float ptr [BX]
       01a2:6e10 90              NOP
       01a2:6e11 9b              WAIT
       01a2:6e12 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:6e17 90              NOP
       01a2:6e18 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:6e1c 90              NOP
       01a2:6e1d d8 06 2a b4     FADD       float ptr [0xb42a]
       01a2:6e21 83 ec 04        SUB        SP,0x4
       01a2:6e24 8b dc           MOV        BX,SP
       01a2:6e26 90              NOP
       01a2:6e27 d9 1f           FSTP       float ptr [BX]
       01a2:6e29 90              NOP
       01a2:6e2a 9b              WAIT
       01a2:6e2b 90              NOP
       01a2:6e2c d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:6e30 90              NOP
       01a2:6e31 d8 06 0e b4     FADD       float ptr [0xb40e]
       01a2:6e35 83 ec 04        SUB        SP,0x4
       01a2:6e38 8b dc           MOV        BX,SP
       01a2:6e3a 90              NOP
       01a2:6e3b d9 1f           FSTP       float ptr [BX]
       01a2:6e3d 90              NOP
       01a2:6e3e 9b              WAIT
       01a2:6e3f 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:6e44 33 c0           XOR        AX,AX
       01a2:6e46 50              PUSH       AX
       01a2:6e47 b8 ff ff        MOV        AX,0xffff
       01a2:6e4a 50              PUSH       AX
       01a2:6e4b 33 c0           XOR        AX,AX
       01a2:6e4d 50              PUSH       AX
       01a2:6e4e 9a 80 10        CALLF      LINE
                 71 0e
       01a2:6e53 90              NOP
       01a2:6e54 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:6e58 90              NOP
       01a2:6e59 d8 06 0c a6     FADD       float ptr [0xa60c]
       01a2:6e5d 83 ec 04        SUB        SP,0x4
       01a2:6e60 8b dc           MOV        BX,SP
       01a2:6e62 90              NOP
       01a2:6e63 d9 1f           FSTP       float ptr [BX]
       01a2:6e65 90              NOP
       01a2:6e66 9b              WAIT
       01a2:6e67 90              NOP
       01a2:6e68 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:6e6c 90              NOP
       01a2:6e6d d8 06 c6 b4     FADD       float ptr [0xb4c6]
       01a2:6e71 83 ec 04        SUB        SP,0x4
       01a2:6e74 8b dc           MOV        BX,SP
       01a2:6e76 90              NOP
       01a2:6e77 d9 1f           FSTP       float ptr [BX]
       01a2:6e79 90              NOP
       01a2:6e7a 9b              WAIT
       01a2:6e7b 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:6e80 90              NOP
       01a2:6e81 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:6e85 90              NOP
       01a2:6e86 d8 06 80 af     FADD       float ptr { 6.0 }
       01a2:6e8a 83 ec 04        SUB        SP,0x4
       01a2:6e8d 8b dc           MOV        BX,SP
       01a2:6e8f 90              NOP
       01a2:6e90 d9 1f           FSTP       float ptr [BX]
       01a2:6e92 90              NOP
       01a2:6e93 9b              WAIT
       01a2:6e94 90              NOP
       01a2:6e95 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:6e99 90              NOP
       01a2:6e9a d8 06 24 b0     FADD       float ptr { 27.0 }
       01a2:6e9e 83 ec 04        SUB        SP,0x4
       01a2:6ea1 8b dc           MOV        BX,SP
       01a2:6ea3 90              NOP
       01a2:6ea4 d9 1f           FSTP       float ptr [BX]
       01a2:6ea6 90              NOP
       01a2:6ea7 9b              WAIT
       01a2:6ea8 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:6ead 33 c0           XOR        AX,AX
       01a2:6eaf 50              PUSH       AX
       01a2:6eb0 b8 ff ff        MOV        AX,0xffff
       01a2:6eb3 50              PUSH       AX
       01a2:6eb4 33 c0           XOR        AX,AX
       01a2:6eb6 50              PUSH       AX
       01a2:6eb7 9a 80 10        CALLF      LINE
                 71 0e
       01a2:6ebc 90              NOP
       01a2:6ebd d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:6ec1 90              NOP
       01a2:6ec2 d8 06 f6 b3     FADD       float ptr [0xb3f6]
       01a2:6ec6 83 ec 04        SUB        SP,0x4
       01a2:6ec9 8b dc           MOV        BX,SP
       01a2:6ecb 90              NOP
       01a2:6ecc d9 1f           FSTP       float ptr [BX]
       01a2:6ece 90              NOP
       01a2:6ecf 9b              WAIT
       01a2:6ed0 90              NOP
       01a2:6ed1 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:6ed5 90              NOP
       01a2:6ed6 d8 06 c6 b4     FADD       float ptr [0xb4c6]
       01a2:6eda 83 ec 04        SUB        SP,0x4
       01a2:6edd 8b dc           MOV        BX,SP
       01a2:6edf 90              NOP
       01a2:6ee0 d9 1f           FSTP       float ptr [BX]
       01a2:6ee2 90              NOP
       01a2:6ee3 9b              WAIT
       01a2:6ee4 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:6ee9 90              NOP
       01a2:6eea d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:6eee 90              NOP
       01a2:6eef d8 06 06 b5     FADD       float ptr [0xb506]
       01a2:6ef3 83 ec 04        SUB        SP,0x4
       01a2:6ef6 8b dc           MOV        BX,SP
       01a2:6ef8 90              NOP
       01a2:6ef9 d9 1f           FSTP       float ptr [BX]
       01a2:6efb 90              NOP
       01a2:6efc 9b              WAIT
       01a2:6efd 90              NOP
       01a2:6efe d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:6f02 90              NOP
       01a2:6f03 d8 06 24 b0     FADD       float ptr { 27.0 }
       01a2:6f07 83 ec 04        SUB        SP,0x4
       01a2:6f0a 8b dc           MOV        BX,SP
       01a2:6f0c 90              NOP
       01a2:6f0d d9 1f           FSTP       float ptr [BX]
       01a2:6f0f 90              NOP
       01a2:6f10 9b              WAIT
       01a2:6f11 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:6f16 33 c0           XOR        AX,AX
       01a2:6f18 50              PUSH       AX
       01a2:6f19 b8 ff ff        MOV        AX,0xffff
       01a2:6f1c 50              PUSH       AX
       01a2:6f1d 33 c0           XOR        AX,AX
       01a2:6f1f 50              PUSH       AX
       01a2:6f20 9a 80 10        CALLF      LINE
                 71 0e
       01a2:6f25 90              NOP
       01a2:6f26 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:6f2a 90              NOP
       01a2:6f2b d8 06 7c a6     FADD       float ptr [0xa67c]
       01a2:6f2f 83 ec 04        SUB        SP,0x4
       01a2:6f32 8b dc           MOV        BX,SP
       01a2:6f34 90              NOP
       01a2:6f35 d9 1f           FSTP       float ptr [BX]
       01a2:6f37 90              NOP
       01a2:6f38 9b              WAIT
       01a2:6f39 90              NOP
       01a2:6f3a d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:6f3e 90              NOP
       01a2:6f3f d8 06 c6 b4     FADD       float ptr [0xb4c6]
       01a2:6f43 83 ec 04        SUB        SP,0x4
       01a2:6f46 8b dc           MOV        BX,SP
       01a2:6f48 90              NOP
       01a2:6f49 d9 1f           FSTP       float ptr [BX]
       01a2:6f4b 90              NOP
       01a2:6f4c 9b              WAIT
       01a2:6f4d 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:6f52 90              NOP
       01a2:6f53 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:6f57 90              NOP
       01a2:6f58 d8 06 7c af     FADD       float ptr { 5.0 }
       01a2:6f5c 83 ec 04        SUB        SP,0x4
       01a2:6f5f 8b dc           MOV        BX,SP
       01a2:6f61 90              NOP
       01a2:6f62 d9 1f           FSTP       float ptr [BX]
       01a2:6f64 90              NOP
       01a2:6f65 9b              WAIT
       01a2:6f66 90              NOP
       01a2:6f67 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:6f6b 90              NOP
       01a2:6f6c d8 06 36 b0     FADD       float ptr { 30.0 }
       01a2:6f70 83 ec 04        SUB        SP,0x4
       01a2:6f73 8b dc           MOV        BX,SP
       01a2:6f75 90              NOP
       01a2:6f76 d9 1f           FSTP       float ptr [BX]
       01a2:6f78 90              NOP
       01a2:6f79 9b              WAIT
       01a2:6f7a 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:6f7f 33 c0           XOR        AX,AX
       01a2:6f81 50              PUSH       AX
       01a2:6f82 b8 ff ff        MOV        AX,0xffff
       01a2:6f85 50              PUSH       AX
       01a2:6f86 33 c0           XOR        AX,AX
       01a2:6f88 50              PUSH       AX
       01a2:6f89 9a 80 10        CALLF      LINE
                 71 0e
       01a2:6f8e 90              NOP
       01a2:6f8f d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:6f93 90              NOP
       01a2:6f94 d8 06 fe b4     FADD       float ptr [0xb4fe]
       01a2:6f98 83 ec 04        SUB        SP,0x4
       01a2:6f9b 8b dc           MOV        BX,SP
       01a2:6f9d 90              NOP
       01a2:6f9e d9 1f           FSTP       float ptr [BX]
       01a2:6fa0 90              NOP
       01a2:6fa1 9b              WAIT
       01a2:6fa2 90              NOP
       01a2:6fa3 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:6fa7 90              NOP
       01a2:6fa8 d8 06 c6 b4     FADD       float ptr [0xb4c6]
       01a2:6fac 83 ec 04        SUB        SP,0x4
       01a2:6faf 8b dc           MOV        BX,SP
       01a2:6fb1 90              NOP
       01a2:6fb2 d9 1f           FSTP       float ptr [BX]
       01a2:6fb4 90              NOP
       01a2:6fb5 9b              WAIT
       01a2:6fb6 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:6fbb 90              NOP
       01a2:6fbc d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:6fc0 90              NOP
       01a2:6fc1 d8 06 3e b4     FADD       float ptr [0xb43e]
       01a2:6fc5 83 ec 04        SUB        SP,0x4
       01a2:6fc8 8b dc           MOV        BX,SP
       01a2:6fca 90              NOP
       01a2:6fcb d9 1f           FSTP       float ptr [BX]
       01a2:6fcd 90              NOP
       01a2:6fce 9b              WAIT
       01a2:6fcf 90              NOP
       01a2:6fd0 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:6fd4 90              NOP
       01a2:6fd5 d8 06 36 b0     FADD       float ptr { 30.0 }
       01a2:6fd9 83 ec 04        SUB        SP,0x4
       01a2:6fdc 8b dc           MOV        BX,SP
       01a2:6fde 90              NOP
       01a2:6fdf d9 1f           FSTP       float ptr [BX]
       01a2:6fe1 90              NOP
       01a2:6fe2 9b              WAIT
       01a2:6fe3 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:6fe8 33 c0           XOR        AX,AX
       01a2:6fea 50              PUSH       AX
       01a2:6feb b8 ff ff        MOV        AX,0xffff
       01a2:6fee 50              PUSH       AX
       01a2:6fef 33 c0           XOR        AX,AX
       01a2:6ff1 50              PUSH       AX
       01a2:6ff2 9a 80 10        CALLF      LINE
                 71 0e
       01a2:6ff7 90              NOP
       01a2:6ff8 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:6ffc 90              NOP
       01a2:6ffd d8 06 8c af     FADD       float ptr { 10.0 }
       01a2:7001 83 ec 04        SUB        SP,0x4
       01a2:7004 8b dc           MOV        BX,SP
       01a2:7006 90              NOP
       01a2:7007 d9 1f           FSTP       float ptr [BX]
       01a2:7009 90              NOP
       01a2:700a 9b              WAIT
       01a2:700b 90              NOP
       01a2:700c d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:7010 90              NOP
       01a2:7011 d8 06 c6 b4     FADD       float ptr [0xb4c6]
       01a2:7015 83 ec 04        SUB        SP,0x4
       01a2:7018 8b dc           MOV        BX,SP
       01a2:701a 90              NOP
       01a2:701b d9 1f           FSTP       float ptr [BX]
       01a2:701d 90              NOP
       01a2:701e 9b              WAIT
       01a2:701f 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:7024 90              NOP
       01a2:7025 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:7029 90              NOP
       01a2:702a d8 06 7c af     FADD       float ptr { 5.0 }
       01a2:702e 83 ec 04        SUB        SP,0x4
       01a2:7031 8b dc           MOV        BX,SP
       01a2:7033 90              NOP
       01a2:7034 d9 1f           FSTP       float ptr [BX]
       01a2:7036 90              NOP
       01a2:7037 9b              WAIT
       01a2:7038 90              NOP
       01a2:7039 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:703d 90              NOP
       01a2:703e d8 06 36 b0     FADD       float ptr { 30.0 }
       01a2:7042 83 ec 04        SUB        SP,0x4
       01a2:7045 8b dc           MOV        BX,SP
       01a2:7047 90              NOP
       01a2:7048 d9 1f           FSTP       float ptr [BX]
       01a2:704a 90              NOP
       01a2:704b 9b              WAIT
       01a2:704c 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:7051 33 c0           XOR        AX,AX
       01a2:7053 50              PUSH       AX
       01a2:7054 b8 ff ff        MOV        AX,0xffff
       01a2:7057 50              PUSH       AX
       01a2:7058 33 c0           XOR        AX,AX
       01a2:705a 50              PUSH       AX
       01a2:705b 9a 80 10        CALLF      LINE
                 71 0e
       01a2:7060 90              NOP
       01a2:7061 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:7065 90              NOP
       01a2:7066 d8 06 b0 a6     FADD       float ptr [0xa6b0]
       01a2:706a 83 ec 04        SUB        SP,0x4
       01a2:706d 8b dc           MOV        BX,SP
       01a2:706f 90              NOP
       01a2:7070 d9 1f           FSTP       float ptr [BX]
       01a2:7072 90              NOP
       01a2:7073 9b              WAIT
       01a2:7074 90              NOP
       01a2:7075 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:7079 90              NOP
       01a2:707a d8 06 c6 b4     FADD       float ptr [0xb4c6]
       01a2:707e 83 ec 04        SUB        SP,0x4
       01a2:7081 8b dc           MOV        BX,SP
       01a2:7083 90              NOP
       01a2:7084 d9 1f           FSTP       float ptr [BX]
       01a2:7086 90              NOP
       01a2:7087 9b              WAIT
       01a2:7088 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:708d 90              NOP
       01a2:708e d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:7092 90              NOP
       01a2:7093 d8 06 32 b4     FADD       float ptr [0xb432]
       01a2:7097 83 ec 04        SUB        SP,0x4
       01a2:709a 8b dc           MOV        BX,SP
       01a2:709c 90              NOP
       01a2:709d d9 1f           FSTP       float ptr [BX]
       01a2:709f 90              NOP
       01a2:70a0 9b              WAIT
       01a2:70a1 90              NOP
       01a2:70a2 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:70a6 90              NOP
       01a2:70a7 d8 06 36 b0     FADD       float ptr { 30.0 }
       01a2:70ab 83 ec 04        SUB        SP,0x4
       01a2:70ae 8b dc           MOV        BX,SP
       01a2:70b0 90              NOP
       01a2:70b1 d9 1f           FSTP       float ptr [BX]
       01a2:70b3 90              NOP
       01a2:70b4 9b              WAIT
       01a2:70b5 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:70ba 33 c0           XOR        AX,AX
       01a2:70bc 50              PUSH       AX
       01a2:70bd b8 ff ff        MOV        AX,0xffff
       01a2:70c0 50              PUSH       AX
       01a2:70c1 33 c0           XOR        AX,AX
       01a2:70c3 50              PUSH       AX
       01a2:70c4 9a 80 10        CALLF      LINE
                 71 0e
       01a2:70c9 90              NOP
       01a2:70ca d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:70ce 90              NOP
       01a2:70cf d8 06 3a b2     FADD       float ptr { 7.0 }
       01a2:70d3 83 ec 04        SUB        SP,0x4
       01a2:70d6 8b dc           MOV        BX,SP
       01a2:70d8 90              NOP
       01a2:70d9 d9 1f           FSTP       float ptr [BX]
       01a2:70db 90              NOP
       01a2:70dc 9b              WAIT
       01a2:70dd 90              NOP
       01a2:70de d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:70e2 90              NOP
       01a2:70e3 d8 06 c6 b4     FADD       float ptr [0xb4c6]
       01a2:70e7 83 ec 04        SUB        SP,0x4
       01a2:70ea 8b dc           MOV        BX,SP
       01a2:70ec 90              NOP
       01a2:70ed d9 1f           FSTP       float ptr [BX]
       01a2:70ef 90              NOP
       01a2:70f0 9b              WAIT
       01a2:70f1 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:70f6 90              NOP
       01a2:70f7 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:70fb 90              NOP
       01a2:70fc d8 06 74 a6     FADD       float ptr { 4.0 }
       01a2:7100 83 ec 04        SUB        SP,0x4
       01a2:7103 8b dc           MOV        BX,SP
       01a2:7105 90              NOP
       01a2:7106 d9 1f           FSTP       float ptr [BX]
       01a2:7108 90              NOP
       01a2:7109 9b              WAIT
       01a2:710a 90              NOP
       01a2:710b d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:710f 90              NOP
       01a2:7110 d8 06 36 b0     FADD       float ptr { 30.0 }
       01a2:7114 83 ec 04        SUB        SP,0x4
       01a2:7117 8b dc           MOV        BX,SP
       01a2:7119 90              NOP
       01a2:711a d9 1f           FSTP       float ptr [BX]
       01a2:711c 90              NOP
       01a2:711d 9b              WAIT
       01a2:711e 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:7123 33 c0           XOR        AX,AX
       01a2:7125 50              PUSH       AX
       01a2:7126 b8 ff ff        MOV        AX,0xffff
       01a2:7129 50              PUSH       AX
       01a2:712a 33 c0           XOR        AX,AX
       01a2:712c 50              PUSH       AX
       01a2:712d 9a 80 10        CALLF      LINE
                 71 0e
       01a2:7132 90              NOP
       01a2:7133 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:7137 90              NOP
       01a2:7138 d8 06 02 b4     FADD       float ptr [0xb402]
       01a2:713c 83 ec 04        SUB        SP,0x4
       01a2:713f 8b dc           MOV        BX,SP
       01a2:7141 90              NOP
       01a2:7142 d9 1f           FSTP       float ptr [BX]
       01a2:7144 90              NOP
       01a2:7145 9b              WAIT
       01a2:7146 90              NOP
       01a2:7147 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:714b 90              NOP
       01a2:714c d8 06 c6 b4     FADD       float ptr [0xb4c6]
       01a2:7150 83 ec 04        SUB        SP,0x4
       01a2:7153 8b dc           MOV        BX,SP
       01a2:7155 90              NOP
       01a2:7156 d9 1f           FSTP       float ptr [BX]
       01a2:7158 90              NOP
       01a2:7159 9b              WAIT
       01a2:715a 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:715f 90              NOP
       01a2:7160 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:7164 90              NOP
       01a2:7165 d8 06 1a b4     FADD       float ptr [0xb41a]
       01a2:7169 83 ec 04        SUB        SP,0x4
       01a2:716c 8b dc           MOV        BX,SP
       01a2:716e 90              NOP
       01a2:716f d9 1f           FSTP       float ptr [BX]
       01a2:7171 90              NOP
       01a2:7172 9b              WAIT
       01a2:7173 90              NOP
       01a2:7174 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:7178 90              NOP
       01a2:7179 d8 06 36 b0     FADD       float ptr { 30.0 }
       01a2:717d 83 ec 04        SUB        SP,0x4
       01a2:7180 8b dc           MOV        BX,SP
       01a2:7182 90              NOP
       01a2:7183 d9 1f           FSTP       float ptr [BX]
       01a2:7185 90              NOP
       01a2:7186 9b              WAIT
       01a2:7187 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:718c 33 c0           XOR        AX,AX
       01a2:718e 50              PUSH       AX
       01a2:718f b8 ff ff        MOV        AX,0xffff
       01a2:7192 50              PUSH       AX
       01a2:7193 33 c0           XOR        AX,AX
       01a2:7195 50              PUSH       AX
       01a2:7196 9a 80 10        CALLF      LINE
                 71 0e
       01a2:719b 90              NOP
       01a2:719c d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:71a0 90              NOP
       01a2:71a1 d8 06 7c af     FADD       float ptr { 5.0 }
       01a2:71a5 83 ec 04        SUB        SP,0x4
       01a2:71a8 8b dc           MOV        BX,SP
       01a2:71aa 90              NOP
       01a2:71ab d9 1f           FSTP       float ptr [BX]
       01a2:71ad 90              NOP
       01a2:71ae 9b              WAIT
       01a2:71af 90              NOP
       01a2:71b0 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:71b4 90              NOP
       01a2:71b5 d8 06 c6 b4     FADD       float ptr [0xb4c6]
       01a2:71b9 83 ec 04        SUB        SP,0x4
       01a2:71bc 8b dc           MOV        BX,SP
       01a2:71be 90              NOP
                             LAB_01a2_71bf                                   XREF[1]:     0d75:0f53(j)  
       01a2:71bf d9 1f           FSTP       float ptr [BX]
       01a2:71c1 90              NOP
       01a2:71c2 9b              WAIT
       01a2:71c3 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:71c8 90              NOP
       01a2:71c9 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:71cd 90              NOP
       01a2:71ce d8 06 24 a6     FADD       float ptr { 3.0 }
       01a2:71d2 83 ec 04        SUB        SP,0x4
       01a2:71d5 8b dc           MOV        BX,SP
       01a2:71d7 90              NOP
       01a2:71d8 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:71da 90              NOP
       01a2:71db 9b              WAIT
       01a2:71dc 90              NOP
       01a2:71dd d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:71e1 90              NOP
       01a2:71e2 d8 06 36 b0     FADD       float ptr { 30.0 }
       01a2:71e6 83 ec 04        SUB        SP,0x4
       01a2:71e9 8b dc           MOV        BX,SP
       01a2:71eb 90              NOP
       01a2:71ec d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:71ee 90              NOP
       01a2:71ef 9b              WAIT
       01a2:71f0 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:71f5 33 c0           XOR        AX,AX
       01a2:71f7 50              PUSH       AX=>DAT_0e71_18ee                                = C0h
       01a2:71f8 b8 ff ff        MOV        AX,0xffff
       01a2:71fb 50              PUSH       AX=>DAT_0e71_18ec
       01a2:71fc 33 c0           XOR        AX,AX
       01a2:71fe 50              PUSH       AX=>DAT_0e71_18ea                                = B9h
       01a2:71ff 9a 80 10        CALLF      LINE
                 71 0e
       01a2:7204 90              NOP
       01a2:7205 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:7209 90              NOP
       01a2:720a d8 06 32 b4     FADD       float ptr [0xb432]
       01a2:720e 83 ec 04        SUB        SP,0x4
       01a2:7211 8b dc           MOV        BX,SP
       01a2:7213 90              NOP
       01a2:7214 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:7216 90              NOP
       01a2:7217 9b              WAIT
       01a2:7218 90              NOP
       01a2:7219 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:721d 90              NOP
       01a2:721e d8 06 c6 b4     FADD       float ptr [0xb4c6]
       01a2:7222 83 ec 04        SUB        SP,0x4
       01a2:7225 8b dc           MOV        BX,SP
       01a2:7227 90              NOP
       01a2:7228 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:722a 90              NOP
       01a2:722b 9b              WAIT
       01a2:722c 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:7231 90              NOP
       01a2:7232 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:7236 90              NOP
       01a2:7237 d8 06 1a b4     FADD       float ptr [0xb41a]
       01a2:723b 83 ec 04        SUB        SP,0x4
       01a2:723e 8b dc           MOV        BX,SP
       01a2:7240 90              NOP
       01a2:7241 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:7243 90              NOP
       01a2:7244 9b              WAIT
       01a2:7245 90              NOP
       01a2:7246 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:724a 90              NOP
       01a2:724b d8 06 36 b0     FADD       float ptr { 30.0 }
       01a2:724f 83 ec 04        SUB        SP,0x4
       01a2:7252 8b dc           MOV        BX,SP
       01a2:7254 90              NOP
       01a2:7255 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:7257 90              NOP
       01a2:7258 9b              WAIT
       01a2:7259 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:725e 33 c0           XOR        AX,AX
       01a2:7260 50              PUSH       AX=>DAT_0e71_18ee                                = C0h
       01a2:7261 b8 ff ff        MOV        AX,0xffff
       01a2:7264 50              PUSH       AX=>DAT_0e71_18ec
       01a2:7265 33 c0           XOR        AX,AX
       01a2:7267 50              PUSH       AX=>DAT_0e71_18ea                                = B9h
       01a2:7268 9a 80 10        CALLF      LINE
                 71 0e
       01a2:726d 90              NOP
       01a2:726e d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:7272 90              NOP
       01a2:7273 d8 06 7c af     FADD       float ptr { 5.0 }
       01a2:7277 83 ec 04        SUB        SP,0x4
       01a2:727a 8b dc           MOV        BX,SP
       01a2:727c 90              NOP
       01a2:727d d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:727f 90              NOP
       01a2:7280 9b              WAIT
       01a2:7281 90              NOP
       01a2:7282 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:7286 90              NOP
       01a2:7287 d8 06 c6 b4     FADD       float ptr [0xb4c6]
       01a2:728b 83 ec 04        SUB        SP,0x4
       01a2:728e 8b dc           MOV        BX,SP
       01a2:7290 90              NOP
       01a2:7291 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:7293 90              NOP
       01a2:7294 9b              WAIT
       01a2:7295 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:729a 90              NOP
       01a2:729b d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:729f 90              NOP
       01a2:72a0 d8 06 24 a6     FADD       float ptr { 3.0 }
       01a2:72a4 83 ec 04        SUB        SP,0x4
       01a2:72a7 8b dc           MOV        BX,SP
       01a2:72a9 90              NOP
       01a2:72aa d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:72ac 90              NOP
       01a2:72ad 9b              WAIT
       01a2:72ae 90              NOP
       01a2:72af d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:72b3 90              NOP
       01a2:72b4 d8 06 4a b4     FADD       float ptr [0xb44a]
       01a2:72b8 83 ec 04        SUB        SP,0x4
       01a2:72bb 8b dc           MOV        BX,SP
       01a2:72bd 90              NOP
       01a2:72be d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:72c0 90              NOP
       01a2:72c1 9b              WAIT
       01a2:72c2 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:72c7 33 c0           XOR        AX,AX
       01a2:72c9 50              PUSH       AX=>DAT_0e71_18ee                                = C0h
       01a2:72ca b8 ff ff        MOV        AX,0xffff
       01a2:72cd 50              PUSH       AX=>DAT_0e71_18ec
       01a2:72ce 33 c0           XOR        AX,AX
       01a2:72d0 50              PUSH       AX=>DAT_0e71_18ea                                = B9h
       01a2:72d1 9a 80 10        CALLF      LINE
                 71 0e
       01a2:72d6 90              NOP
       01a2:72d7 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:72db 90              NOP
       01a2:72dc d8 06 32 b4     FADD       float ptr [0xb432]
       01a2:72e0 83 ec 04        SUB        SP,0x4
       01a2:72e3 8b dc           MOV        BX,SP
       01a2:72e5 90              NOP
       01a2:72e6 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:72e8 90              NOP
       01a2:72e9 9b              WAIT
       01a2:72ea 90              NOP
       01a2:72eb d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:72ef 90              NOP
       01a2:72f0 d8 06 c6 b4     FADD       float ptr [0xb4c6]
       01a2:72f4 83 ec 04        SUB        SP,0x4
       01a2:72f7 8b dc           MOV        BX,SP
       01a2:72f9 90              NOP
       01a2:72fa d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:72fc 90              NOP
       01a2:72fd 9b              WAIT
       01a2:72fe 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:7303 90              NOP
       01a2:7304 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:7308 90              NOP
       01a2:7309 d8 06 06 b5     FADD       float ptr [0xb506]
       01a2:730d 83 ec 04        SUB        SP,0x4
       01a2:7310 8b dc           MOV        BX,SP
       01a2:7312 90              NOP
       01a2:7313 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:7315 90              NOP
       01a2:7316 9b              WAIT
       01a2:7317 90              NOP
       01a2:7318 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:731c 90              NOP
       01a2:731d d8 06 4a b4     FADD       float ptr [0xb44a]
       01a2:7321 83 ec 04        SUB        SP,0x4
       01a2:7324 8b dc           MOV        BX,SP
       01a2:7326 90              NOP
       01a2:7327 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:7329 90              NOP
       01a2:732a 9b              WAIT
       01a2:732b 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:7330 33 c0           XOR        AX,AX
       01a2:7332 50              PUSH       AX=>DAT_0e71_18ee                                = C0h
       01a2:7333 b8 ff ff        MOV        AX,0xffff
       01a2:7336 50              PUSH       AX=>DAT_0e71_18ec
       01a2:7337 33 c0           XOR        AX,AX
       01a2:7339 50              PUSH       AX=>DAT_0e71_18ea                                = B9h
       01a2:733a 9a 80 10        CALLF      LINE
                 71 0e
       01a2:733f 90              NOP
       01a2:7340 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:7344 90              NOP
       01a2:7345 d8 06 74 a6     FADD       float ptr { 4.0 }
       01a2:7349 83 ec 04        SUB        SP,0x4
       01a2:734c 8b dc           MOV        BX,SP
       01a2:734e 90              NOP
       01a2:734f d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:7351 90              NOP
       01a2:7352 9b              WAIT
       01a2:7353 90              NOP
       01a2:7354 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:7358 90              NOP
       01a2:7359 d8 06 c6 b4     FADD       float ptr [0xb4c6]
       01a2:735d 83 ec 04        SUB        SP,0x4
       01a2:7360 8b dc           MOV        BX,SP
       01a2:7362 90              NOP
       01a2:7363 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:7365 90              NOP
       01a2:7366 9b              WAIT
       01a2:7367 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:736c 90              NOP
       01a2:736d d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:7371 90              NOP
       01a2:7372 d8 06 b4 a6     FADD       float ptr { 2.0 }
       01a2:7376 83 ec 04        SUB        SP,0x4
       01a2:7379 8b dc           MOV        BX,SP
       01a2:737b 90              NOP
       01a2:737c d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:737e 90              NOP
       01a2:737f 9b              WAIT
       01a2:7380 90              NOP
       01a2:7381 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:7385 90              NOP
       01a2:7386 d8 06 b0 a6     FADD       float ptr [0xa6b0]
       01a2:738a 83 ec 04        SUB        SP,0x4
       01a2:738d 8b dc           MOV        BX,SP
       01a2:738f 90              NOP
       01a2:7390 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:7392 90              NOP
       01a2:7393 9b              WAIT
       01a2:7394 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:7399 33 c0           XOR        AX,AX
       01a2:739b 50              PUSH       AX=>DAT_0e71_18ee                                = C0h
       01a2:739c b8 ff ff        MOV        AX,0xffff
       01a2:739f 50              PUSH       AX=>DAT_0e71_18ec
       01a2:73a0 33 c0           XOR        AX,AX
       01a2:73a2 50              PUSH       AX=>DAT_0e71_18ea                                = B9h
       01a2:73a3 9a 80 10        CALLF      LINE
                 71 0e
       01a2:73a8 90              NOP
       01a2:73a9 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:73ad 90              NOP
       01a2:73ae d8 06 2a b4     FADD       float ptr [0xb42a]
       01a2:73b2 83 ec 04        SUB        SP,0x4
       01a2:73b5 8b dc           MOV        BX,SP
       01a2:73b7 90              NOP
       01a2:73b8 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:73ba 90              NOP
       01a2:73bb 9b              WAIT
       01a2:73bc 90              NOP
       01a2:73bd d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:73c1 90              NOP
       01a2:73c2 d8 06 c6 b4     FADD       float ptr [0xb4c6]
       01a2:73c6 83 ec 04        SUB        SP,0x4
       01a2:73c9 8b dc           MOV        BX,SP
       01a2:73cb 90              NOP
       01a2:73cc d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:73ce 90              NOP
       01a2:73cf 9b              WAIT
       01a2:73d0 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:73d5 90              NOP
       01a2:73d6 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:73da 90              NOP
       01a2:73db d8 06 26 b4     FADD       float ptr [0xb426]
       01a2:73df 83 ec 04        SUB        SP,0x4
       01a2:73e2 8b dc           MOV        BX,SP
       01a2:73e4 90              NOP
       01a2:73e5 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:73e7 90              NOP
       01a2:73e8 9b              WAIT
       01a2:73e9 90              NOP
       01a2:73ea d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:73ee 90              NOP
       01a2:73ef d8 06 b0 a6     FADD       float ptr [0xa6b0]
       01a2:73f3 83 ec 04        SUB        SP,0x4
       01a2:73f6 8b dc           MOV        BX,SP
       01a2:73f8 90              NOP
       01a2:73f9 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:73fb 90              NOP
       01a2:73fc 9b              WAIT
       01a2:73fd 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:7402 33 c0           XOR        AX,AX
       01a2:7404 50              PUSH       AX=>DAT_0e71_18ee                                = C0h
       01a2:7405 b8 ff ff        MOV        AX,0xffff
       01a2:7408 50              PUSH       AX=>DAT_0e71_18ec
       01a2:7409 33 c0           XOR        AX,AX
       01a2:740b 50              PUSH       AX=>DAT_0e71_18ea                                = B9h
       01a2:740c 9a 80 10        CALLF      LINE
                 71 0e
       01a2:7411 90              NOP
       01a2:7412 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:7416 90              NOP
       01a2:7417 d8 06 8c af     FADD       float ptr { 10.0 }
       01a2:741b 83 ec 04        SUB        SP,0x4
       01a2:741e 8b dc           MOV        BX,SP
       01a2:7420 90              NOP
       01a2:7421 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:7423 90              NOP
       01a2:7424 9b              WAIT
       01a2:7425 90              NOP
       01a2:7426 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:742a 90              NOP
       01a2:742b d8 06 c6 b4     FADD       float ptr [0xb4c6]
       01a2:742f 83 ec 04        SUB        SP,0x4
       01a2:7432 8b dc           MOV        BX,SP
       01a2:7434 90              NOP
       01a2:7435 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:7437 90              NOP
       01a2:7438 9b              WAIT
       01a2:7439 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:743e 90              NOP
       01a2:743f d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:7443 90              NOP
       01a2:7444 d8 06 80 af     FADD       float ptr { 6.0 }
       01a2:7448 83 ec 04        SUB        SP,0x4
       01a2:744b 8b dc           MOV        BX,SP
       01a2:744d 90              NOP
       01a2:744e d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:7450 90              NOP
       01a2:7451 9b              WAIT
       01a2:7452 90              NOP
       01a2:7453 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:7457 90              NOP
       01a2:7458 d8 06 fa b3     FADD       float ptr [0xb3fa]
       01a2:745c 83 ec 04        SUB        SP,0x4
       01a2:745f 8b dc           MOV        BX,SP
       01a2:7461 90              NOP
       01a2:7462 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:7464 90              NOP
       01a2:7465 9b              WAIT
       01a2:7466 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:746b 33 c0           XOR        AX,AX
       01a2:746d 50              PUSH       AX=>DAT_0e71_18ee                                = C0h
       01a2:746e b8 ff ff        MOV        AX,0xffff
       01a2:7471 50              PUSH       AX=>DAT_0e71_18ec
       01a2:7472 33 c0           XOR        AX,AX
       01a2:7474 50              PUSH       AX=>DAT_0e71_18ea                                = B9h
       01a2:7475 9a 80 10        CALLF      LINE
                 71 0e
       01a2:747a 90              NOP
       01a2:747b d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:747f 90              NOP
       01a2:7480 d8 06 4a b4     FADD       float ptr [0xb44a]
       01a2:7484 83 ec 04        SUB        SP,0x4
       01a2:7487 8b dc           MOV        BX,SP
       01a2:7489 90              NOP
       01a2:748a d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:748c 90              NOP
       01a2:748d 9b              WAIT
       01a2:748e 90              NOP
       01a2:748f d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:7493 90              NOP
       01a2:7494 d8 06 c6 b4     FADD       float ptr [0xb4c6]
       01a2:7498 83 ec 04        SUB        SP,0x4
       01a2:749b 8b dc           MOV        BX,SP
       01a2:749d 90              NOP
       01a2:749e d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:74a0 90              NOP
       01a2:74a1 9b              WAIT
       01a2:74a2 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:74a7 90              NOP
       01a2:74a8 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:74ac 90              NOP
       01a2:74ad d8 06 32 b4     FADD       float ptr [0xb432]
       01a2:74b1 83 ec 04        SUB        SP,0x4
       01a2:74b4 8b dc           MOV        BX,SP
       01a2:74b6 90              NOP
       01a2:74b7 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:74b9 90              NOP
       01a2:74ba 9b              WAIT
       01a2:74bb 90              NOP
       01a2:74bc d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:74c0 90              NOP
       01a2:74c1 d8 06 fa b3     FADD       float ptr [0xb3fa]
       01a2:74c5 83 ec 04        SUB        SP,0x4
       01a2:74c8 8b dc           MOV        BX,SP
       01a2:74ca 90              NOP
       01a2:74cb d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:74cd 90              NOP
       01a2:74ce 9b              WAIT
       01a2:74cf 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:74d4 33 c0           XOR        AX,AX
       01a2:74d6 50              PUSH       AX=>DAT_0e71_18ee                                = C0h
       01a2:74d7 b8 ff ff        MOV        AX,0xffff
       01a2:74da 50              PUSH       AX=>DAT_0e71_18ec
       01a2:74db 33 c0           XOR        AX,AX
       01a2:74dd 50              PUSH       AX=>DAT_0e71_18ea                                = B9h
       01a2:74de 9a 80 10        CALLF      LINE
                 71 0e
       01a2:74e3 90              NOP
       01a2:74e4 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:74e8 90              NOP
       01a2:74e9 d8 06 14 a6     FADD       float ptr { 8.0 }
       01a2:74ed 83 ec 04        SUB        SP,0x4
       01a2:74f0 8b dc           MOV        BX,SP
       01a2:74f2 90              NOP
       01a2:74f3 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:74f5 90              NOP
       01a2:74f6 9b              WAIT
       01a2:74f7 90              NOP
       01a2:74f8 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:74fc 90              NOP
       01a2:74fd d8 06 c6 b4     FADD       float ptr [0xb4c6]
       01a2:7501 83 ec 04        SUB        SP,0x4
       01a2:7504 8b dc           MOV        BX,SP
       01a2:7506 90              NOP
       01a2:7507 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:7509 90              NOP
       01a2:750a 9b              WAIT
       01a2:750b 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:7510 90              NOP
       01a2:7511 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:7515 90              NOP
       01a2:7516 d8 06 74 a6     FADD       float ptr { 4.0 }
       01a2:751a 83 ec 04        SUB        SP,0x4
       01a2:751d 8b dc           MOV        BX,SP
       01a2:751f 90              NOP
       01a2:7520 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:7522 90              NOP
       01a2:7523 9b              WAIT
       01a2:7524 90              NOP
       01a2:7525 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:7529 90              NOP
       01a2:752a d8 06 3e b4     FADD       float ptr [0xb43e]
       01a2:752e 83 ec 04        SUB        SP,0x4
       01a2:7531 8b dc           MOV        BX,SP
       01a2:7533 90              NOP
       01a2:7534 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:7536 90              NOP
       01a2:7537 9b              WAIT
       01a2:7538 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:753d 33 c0           XOR        AX,AX
       01a2:753f 50              PUSH       AX=>DAT_0e71_18ee                                = C0h
       01a2:7540 b8 ff ff        MOV        AX,0xffff
       01a2:7543 50              PUSH       AX=>DAT_0e71_18ec
       01a2:7544 33 c0           XOR        AX,AX
       01a2:7546 50              PUSH       AX=>DAT_0e71_18ea                                = B9h
       01a2:7547 9a 80 10        CALLF      LINE
                 71 0e
       01a2:754c 90              NOP
       01a2:754d d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:7551 90              NOP
       01a2:7552 d8 06 ce b4     FADD       float ptr [0xb4ce]
       01a2:7556 83 ec 04        SUB        SP,0x4
       01a2:7559 8b dc           MOV        BX,SP
       01a2:755b 90              NOP
       01a2:755c d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:755e 90              NOP
       01a2:755f 9b              WAIT
       01a2:7560 90              NOP
       01a2:7561 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:7565 90              NOP
       01a2:7566 d8 06 c6 b4     FADD       float ptr [0xb4c6]
       01a2:756a 83 ec 04        SUB        SP,0x4
       01a2:756d 8b dc           MOV        BX,SP
       01a2:756f 90              NOP
       01a2:7570 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:7572 90              NOP
       01a2:7573 9b              WAIT
       01a2:7574 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:7579 90              NOP
       01a2:757a d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:757e 90              NOP
       01a2:757f d8 06 2a b4     FADD       float ptr [0xb42a]
       01a2:7583 83 ec 04        SUB        SP,0x4
       01a2:7586 8b dc           MOV        BX,SP
       01a2:7588 90              NOP
       01a2:7589 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:758b 90              NOP
       01a2:758c 9b              WAIT
       01a2:758d 90              NOP
       01a2:758e d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:7592 90              NOP
       01a2:7593 d8 06 3e b4     FADD       float ptr [0xb43e]
       01a2:7597 83 ec 04        SUB        SP,0x4
       01a2:759a 8b dc           MOV        BX,SP
       01a2:759c 90              NOP
       01a2:759d d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:759f 90              NOP
       01a2:75a0 9b              WAIT
       01a2:75a1 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:75a6 33 c0           XOR        AX,AX
       01a2:75a8 50              PUSH       AX=>DAT_0e71_18ee                                = C0h
       01a2:75a9 b8 ff ff        MOV        AX,0xffff
       01a2:75ac 50              PUSH       AX=>DAT_0e71_18ec
       01a2:75ad 33 c0           XOR        AX,AX
       01a2:75af 50              PUSH       AX=>DAT_0e71_18ea                                = B9h
       01a2:75b0 9a 80 10        CALLF      LINE
                 71 0e
       01a2:75b5 90              NOP
       01a2:75b6 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:75ba 90              NOP
       01a2:75bb d8 06 f6 b4     FADD       float ptr [0xb4f6]
       01a2:75bf 83 ec 04        SUB        SP,0x4
       01a2:75c2 8b dc           MOV        BX,SP
       01a2:75c4 90              NOP
       01a2:75c5 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:75c7 90              NOP
       01a2:75c8 9b              WAIT
       01a2:75c9 90              NOP
       01a2:75ca d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:75ce 90              NOP
       01a2:75cf d8 06 06 b5     FADD       float ptr [0xb506]
       01a2:75d3 83 ec 04        SUB        SP,0x4
       01a2:75d6 8b dc           MOV        BX,SP
       01a2:75d8 90              NOP
       01a2:75d9 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:75db 90              NOP
       01a2:75dc 9b              WAIT
       01a2:75dd 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:75e2 90              NOP
       01a2:75e3 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:75e7 90              NOP
       01a2:75e8 d8 06 46 b4     FADD       float ptr [0xb446]
       01a2:75ec 83 ec 04        SUB        SP,0x4
       01a2:75ef 8b dc           MOV        BX,SP
       01a2:75f1 90              NOP
       01a2:75f2 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:75f4 90              NOP
       01a2:75f5 9b              WAIT
       01a2:75f6 90              NOP
       01a2:75f7 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:75fb 90              NOP
       01a2:75fc d8 06 36 b4     FADD       float ptr [0xb436]
       01a2:7600 83 ec 04        SUB        SP,0x4
       01a2:7603 8b dc           MOV        BX,SP
       01a2:7605 90              NOP
       01a2:7606 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:7608 90              NOP
       01a2:7609 9b              WAIT
       01a2:760a 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:760f 33 c0           XOR        AX,AX
       01a2:7611 50              PUSH       AX=>DAT_0e71_18ee                                = C0h
       01a2:7612 b8 ff ff        MOV        AX,0xffff
       01a2:7615 50              PUSH       AX=>DAT_0e71_18ec
       01a2:7616 33 c0           XOR        AX,AX
       01a2:7618 50              PUSH       AX=>DAT_0e71_18ea                                = B9h
       01a2:7619 9a 80 10        CALLF      LINE
                 71 0e
       01a2:761e 90              NOP
       01a2:761f d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:7623 90              NOP
       01a2:7624 d8 06 c6 b4     FADD       float ptr [0xb4c6]
       01a2:7628 83 ec 04        SUB        SP,0x4
       01a2:762b 8b dc           MOV        BX,SP
       01a2:762d 90              NOP
       01a2:762e d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:7630 90              NOP
       01a2:7631 9b              WAIT
       01a2:7632 90              NOP
       01a2:7633 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:7637 90              NOP
       01a2:7638 d8 06 2a b4     FADD       float ptr [0xb42a]
       01a2:763c 83 ec 04        SUB        SP,0x4
       01a2:763f 8b dc           MOV        BX,SP
       01a2:7641 90              NOP
       01a2:7642 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:7644 90              NOP
       01a2:7645 9b              WAIT
       01a2:7646 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:764b 90              NOP
       01a2:764c d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:7650 90              NOP
       01a2:7651 d8 06 5e b4     FADD       float ptr [0xb45e]
       01a2:7655 83 ec 04        SUB        SP,0x4
       01a2:7658 8b dc           MOV        BX,SP
       01a2:765a 90              NOP
       01a2:765b d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:765d 90              NOP
       01a2:765e 9b              WAIT
       01a2:765f 90              NOP
       01a2:7660 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:7664 90              NOP
       01a2:7665 d8 06 42 b4     FADD       float ptr [0xb442]
       01a2:7669 83 ec 04        SUB        SP,0x4
       01a2:766c 8b dc           MOV        BX,SP
       01a2:766e 90              NOP
       01a2:766f d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:7671 90              NOP
       01a2:7672 9b              WAIT
       01a2:7673 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:7678 33 c0           XOR        AX,AX
       01a2:767a 50              PUSH       AX=>DAT_0e71_18ee                                = C0h
       01a2:767b b8 ff ff        MOV        AX,0xffff
       01a2:767e 50              PUSH       AX=>DAT_0e71_18ec
       01a2:767f 33 c0           XOR        AX,AX
       01a2:7681 50              PUSH       AX=>DAT_0e71_18ea                                = B9h
       01a2:7682 9a 80 10        CALLF      LINE
                 71 0e
       01a2:7687 90              NOP
       01a2:7688 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:768c 90              NOP
       01a2:768d d8 06 24 b0     FADD       float ptr { 27.0 }
       01a2:7691 83 ec 04        SUB        SP,0x4
       01a2:7694 8b dc           MOV        BX,SP
       01a2:7696 90              NOP
       01a2:7697 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:7699 90              NOP
       01a2:769a 9b              WAIT
       01a2:769b 90              NOP
       01a2:769c d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:76a0 90              NOP
       01a2:76a1 d8 06 06 b5     FADD       float ptr [0xb506]
       01a2:76a5 83 ec 04        SUB        SP,0x4
       01a2:76a8 8b dc           MOV        BX,SP
       01a2:76aa 90              NOP
       01a2:76ab d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:76ad 90              NOP
       01a2:76ae 9b              WAIT
       01a2:76af 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:76b4 90              NOP
       01a2:76b5 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:76b9 90              NOP
       01a2:76ba d8 06 ca b4     FADD       float ptr [0xb4ca]
       01a2:76be 83 ec 04        SUB        SP,0x4
       01a2:76c1 8b dc           MOV        BX,SP
       01a2:76c3 90              NOP
       01a2:76c4 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:76c6 90              NOP
       01a2:76c7 9b              WAIT
       01a2:76c8 90              NOP
       01a2:76c9 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:76cd 90              NOP
       01a2:76ce d8 06 36 b4     FADD       float ptr [0xb436]
       01a2:76d2 83 ec 04        SUB        SP,0x4
       01a2:76d5 8b dc           MOV        BX,SP
       01a2:76d7 90              NOP
       01a2:76d8 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:76da 90              NOP
       01a2:76db 9b              WAIT
       01a2:76dc 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:76e1 33 c0           XOR        AX,AX
       01a2:76e3 50              PUSH       AX=>DAT_0e71_18ee                                = C0h
       01a2:76e4 b8 ff ff        MOV        AX,0xffff
       01a2:76e7 50              PUSH       AX=>DAT_0e71_18ec
       01a2:76e8 33 c0           XOR        AX,AX
       01a2:76ea 50              PUSH       AX=>DAT_0e71_18ea                                = B9h
       01a2:76eb 9a 80 10        CALLF      LINE
                 71 0e
       01a2:76f0 90              NOP
       01a2:76f1 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:76f5 90              NOP
       01a2:76f6 d8 06 0e b4     FADD       float ptr [0xb40e]
       01a2:76fa 83 ec 04        SUB        SP,0x4
       01a2:76fd 8b dc           MOV        BX,SP
       01a2:76ff 90              NOP
       01a2:7700 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:7702 90              NOP
       01a2:7703 9b              WAIT
       01a2:7704 90              NOP
       01a2:7705 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:7709 90              NOP
       01a2:770a d8 06 32 b4     FADD       float ptr [0xb432]
       01a2:770e 83 ec 04        SUB        SP,0x4
       01a2:7711 8b dc           MOV        BX,SP
       01a2:7713 90              NOP
       01a2:7714 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:7716 90              NOP
       01a2:7717 9b              WAIT
       01a2:7718 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:771d 90              NOP
       01a2:771e d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:7722 90              NOP
       01a2:7723 d8 06 f6 b4     FADD       float ptr [0xb4f6]
       01a2:7727 83 ec 04        SUB        SP,0x4
       01a2:772a 8b dc           MOV        BX,SP
       01a2:772c 90              NOP
       01a2:772d d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:772f 90              NOP
       01a2:7730 9b              WAIT
       01a2:7731 90              NOP
       01a2:7732 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:7736 90              NOP
       01a2:7737 d8 06 42 b4     FADD       float ptr [0xb442]
       01a2:773b 83 ec 04        SUB        SP,0x4
       01a2:773e 8b dc           MOV        BX,SP
       01a2:7740 90              NOP
       01a2:7741 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:7743 90              NOP
       01a2:7744 9b              WAIT
       01a2:7745 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:774a 33 c0           XOR        AX,AX
       01a2:774c 50              PUSH       AX=>DAT_0e71_18ee                                = C0h
       01a2:774d b8 ff ff        MOV        AX,0xffff
       01a2:7750 50              PUSH       AX=>DAT_0e71_18ec
       01a2:7751 33 c0           XOR        AX,AX
       01a2:7753 50              PUSH       AX=>DAT_0e71_18ea                                = B9h
       01a2:7754 9a 80 10        CALLF      LINE
                 71 0e
       01a2:7759 90              NOP
       01a2:775a d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:775e 90              NOP
       01a2:775f d8 06 ca b4     FADD       float ptr [0xb4ca]
       01a2:7763 83 ec 04        SUB        SP,0x4
       01a2:7766 8b dc           MOV        BX,SP
       01a2:7768 90              NOP
       01a2:7769 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:776b 90              NOP
       01a2:776c 9b              WAIT
       01a2:776d 90              NOP
       01a2:776e d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:7772 90              NOP
       01a2:7773 d8 06 2a b4     FADD       float ptr [0xb42a]
       01a2:7777 83 ec 04        SUB        SP,0x4
       01a2:777a 8b dc           MOV        BX,SP
       01a2:777c 90              NOP
       01a2:777d d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:777f 90              NOP
       01a2:7780 9b              WAIT
       01a2:7781 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:7786 90              NOP
       01a2:7787 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:778b 90              NOP
       01a2:778c d8 06 24 b0     FADD       float ptr { 27.0 }
       01a2:7790 83 ec 04        SUB        SP,0x4
       01a2:7793 8b dc           MOV        BX,SP
       01a2:7795 90              NOP
       01a2:7796 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:7798 90              NOP
       01a2:7799 9b              WAIT
       01a2:779a 90              NOP
       01a2:779b d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:779f 90              NOP
       01a2:77a0 d8 06 0a b4     FADD       float ptr [0xb40a]
       01a2:77a4 83 ec 04        SUB        SP,0x4
       01a2:77a7 8b dc           MOV        BX,SP
       01a2:77a9 90              NOP
       01a2:77aa d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:77ac 90              NOP
       01a2:77ad 9b              WAIT
       01a2:77ae 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:77b3 33 c0           XOR        AX,AX
       01a2:77b5 50              PUSH       AX=>DAT_0e71_18ee                                = C0h
       01a2:77b6 b8 ff ff        MOV        AX,0xffff
       01a2:77b9 50              PUSH       AX=>DAT_0e71_18ec
       01a2:77ba 33 c0           XOR        AX,AX
       01a2:77bc 50              PUSH       AX=>DAT_0e71_18ea                                = B9h
       01a2:77bd 9a 80 10        CALLF      LINE
                 71 0e
       01a2:77c2 90              NOP
       01a2:77c3 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:77c7 90              NOP
       01a2:77c8 d8 06 46 b4     FADD       float ptr [0xb446]
       01a2:77cc 83 ec 04        SUB        SP,0x4
       01a2:77cf 8b dc           MOV        BX,SP
       01a2:77d1 90              NOP
       01a2:77d2 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:77d4 90              NOP
       01a2:77d5 9b              WAIT
       01a2:77d6 90              NOP
       01a2:77d7 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:77db 90              NOP
       01a2:77dc d8 06 06 b5     FADD       float ptr [0xb506]
       01a2:77e0 83 ec 04        SUB        SP,0x4
       01a2:77e3 8b dc           MOV        BX,SP
       01a2:77e5 90              NOP
       01a2:77e6 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:77e8 90              NOP
       01a2:77e9 9b              WAIT
       01a2:77ea 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:77ef 90              NOP
       01a2:77f0 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:77f4 90              NOP
       01a2:77f5 d8 06 46 b4     FADD       float ptr [0xb446]
       01a2:77f9 83 ec 04        SUB        SP,0x4
       01a2:77fc 8b dc           MOV        BX,SP
       01a2:77fe 90              NOP
       01a2:77ff d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:7801 90              NOP
       01a2:7802 9b              WAIT
       01a2:7803 90              NOP
       01a2:7804 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:7808 90              NOP
       01a2:7809 d8 06 36 b4     FADD       float ptr [0xb436]
       01a2:780d 83 ec 04        SUB        SP,0x4
       01a2:7810 8b dc           MOV        BX,SP
       01a2:7812 90              NOP
       01a2:7813 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:7815 90              NOP
       01a2:7816 9b              WAIT
       01a2:7817 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:781c 33 c0           XOR        AX,AX
       01a2:781e 50              PUSH       AX=>DAT_0e71_18ee                                = C0h
       01a2:781f b8 ff ff        MOV        AX,0xffff
       01a2:7822 50              PUSH       AX=>DAT_0e71_18ec
       01a2:7823 33 c0           XOR        AX,AX
       01a2:7825 50              PUSH       AX=>DAT_0e71_18ea                                = B9h
       01a2:7826 9a 80 10        CALLF      LINE
                 71 0e
       01a2:782b 90              NOP
       01a2:782c d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:7830 90              NOP
       01a2:7831 d8 06 c6 b4     FADD       float ptr [0xb4c6]
       01a2:7835 83 ec 04        SUB        SP,0x4
       01a2:7838 8b dc           MOV        BX,SP
       01a2:783a 90              NOP
       01a2:783b d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:783d 90              NOP
       01a2:783e 9b              WAIT
       01a2:783f 90              NOP
       01a2:7840 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:7844 90              NOP
       01a2:7845 d8 06 2a b4     FADD       float ptr [0xb42a]
       01a2:7849 83 ec 04        SUB        SP,0x4
       01a2:784c 8b dc           MOV        BX,SP
       01a2:784e 90              NOP
       01a2:784f d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:7851 90              NOP
       01a2:7852 9b              WAIT
       01a2:7853 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:7858 90              NOP
       01a2:7859 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:785d 90              NOP
       01a2:785e d8 06 f6 b4     FADD       float ptr [0xb4f6]
       01a2:7862 83 ec 04        SUB        SP,0x4
       01a2:7865 8b dc           MOV        BX,SP
       01a2:7867 90              NOP
       01a2:7868 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:786a 90              NOP
       01a2:786b 9b              WAIT
       01a2:786c 90              NOP
       01a2:786d d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:7871 90              NOP
       01a2:7872 d8 06 42 b4     FADD       float ptr [0xb442]
       01a2:7876 83 ec 04        SUB        SP,0x4
       01a2:7879 8b dc           MOV        BX,SP
       01a2:787b 90              NOP
       01a2:787c d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:787e 90              NOP
       01a2:787f 9b              WAIT
       01a2:7880 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:7885 33 c0           XOR        AX,AX
       01a2:7887 50              PUSH       AX=>DAT_0e71_18ee                                = C0h
       01a2:7888 b8 ff ff        MOV        AX,0xffff
       01a2:788b 50              PUSH       AX=>DAT_0e71_18ec
       01a2:788c 33 c0           XOR        AX,AX
       01a2:788e 50              PUSH       AX=>DAT_0e71_18ea                                = B9h
       01a2:788f 9a 80 10        CALLF      LINE
                 71 0e
       01a2:7894 90              NOP
       01a2:7895 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:7899 90              NOP
       01a2:789a d8 06 5e b4     FADD       float ptr [0xb45e]
                             LAB_01a2_789e                                   XREF[1]:     0d75:0f49(*)  
       01a2:789e 83 ec 04        SUB        SP,0x4
       01a2:78a1 8b dc           MOV        BX,SP
       01a2:78a3 90              NOP
       01a2:78a4 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:78a6 90              NOP
       01a2:78a7 9b              WAIT
       01a2:78a8 90              NOP
       01a2:78a9 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:78ad 90              NOP
       01a2:78ae d8 06 06 b5     FADD       float ptr [0xb506]
       01a2:78b2 83 ec 04        SUB        SP,0x4
       01a2:78b5 8b dc           MOV        BX,SP
       01a2:78b7 90              NOP
       01a2:78b8 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:78ba 90              NOP
       01a2:78bb 9b              WAIT
       01a2:78bc 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:78c1 90              NOP
       01a2:78c2 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:78c6 90              NOP
       01a2:78c7 d8 06 56 b4     FADD       float ptr [0xb456]
       01a2:78cb 83 ec 04        SUB        SP,0x4
       01a2:78ce 8b dc           MOV        BX,SP
       01a2:78d0 90              NOP
       01a2:78d1 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:78d3 90              NOP
       01a2:78d4 9b              WAIT
       01a2:78d5 90              NOP
       01a2:78d6 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:78da 90              NOP
       01a2:78db d8 06 36 b4     FADD       float ptr [0xb436]
       01a2:78df 83 ec 04        SUB        SP,0x4
       01a2:78e2 8b dc           MOV        BX,SP
       01a2:78e4 90              NOP
       01a2:78e5 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:78e7 90              NOP
       01a2:78e8 9b              WAIT
       01a2:78e9 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:78ee 33 c0           XOR        AX,AX
       01a2:78f0 50              PUSH       AX=>DAT_0e71_18ee                                = C0h
       01a2:78f1 b8 ff ff        MOV        AX,0xffff
       01a2:78f4 50              PUSH       AX=>DAT_0e71_18ec
       01a2:78f5 33 c0           XOR        AX,AX
       01a2:78f7 50              PUSH       AX=>DAT_0e71_18ea                                = B9h
       01a2:78f8 9a 80 10        CALLF      LINE
                 71 0e
       01a2:78fd 90              NOP
       01a2:78fe d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:7902 90              NOP
       01a2:7903 d8 06 3a b4     FADD       float ptr [0xb43a]
       01a2:7907 83 ec 04        SUB        SP,0x4
       01a2:790a 8b dc           MOV        BX,SP
       01a2:790c 90              NOP
       01a2:790d d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:790f 90              NOP
       01a2:7910 9b              WAIT
       01a2:7911 90              NOP
       01a2:7912 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:7916 90              NOP
       01a2:7917 d8 06 32 b4     FADD       float ptr [0xb432]
       01a2:791b 83 ec 04        SUB        SP,0x4
       01a2:791e 8b dc           MOV        BX,SP
       01a2:7920 90              NOP
       01a2:7921 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:7923 90              NOP
       01a2:7924 9b              WAIT
       01a2:7925 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:792a 90              NOP
       01a2:792b d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:792f 90              NOP
       01a2:7930 d8 06 c6 b4     FADD       float ptr [0xb4c6]
       01a2:7934 83 ec 04        SUB        SP,0x4
       01a2:7937 8b dc           MOV        BX,SP
       01a2:7939 90              NOP
       01a2:793a d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:793c 90              NOP
       01a2:793d 9b              WAIT
       01a2:793e 90              NOP
       01a2:793f d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:7943 90              NOP
       01a2:7944 d8 06 42 b4     FADD       float ptr [0xb442]
       01a2:7948 83 ec 04        SUB        SP,0x4
       01a2:794b 8b dc           MOV        BX,SP
       01a2:794d 90              NOP
       01a2:794e d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:7950 90              NOP
       01a2:7951 9b              WAIT
       01a2:7952 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:7957 33 c0           XOR        AX,AX
       01a2:7959 50              PUSH       AX=>DAT_0e71_18ee                                = C0h
       01a2:795a b8 ff ff        MOV        AX,0xffff
       01a2:795d 50              PUSH       AX=>DAT_0e71_18ec
       01a2:795e 33 c0           XOR        AX,AX
       01a2:7960 50              PUSH       AX=>DAT_0e71_18ea                                = B9h
       01a2:7961 9a 80 10        CALLF      LINE
                 71 0e
       01a2:7966 90              NOP
       01a2:7967 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:796b 90              NOP
       01a2:796c d8 06 66 b4     FADD       float ptr [0xb466]
       01a2:7970 83 ec 04        SUB        SP,0x4
       01a2:7973 8b dc           MOV        BX,SP
       01a2:7975 90              NOP
       01a2:7976 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:7978 90              NOP
       01a2:7979 9b              WAIT
       01a2:797a 90              NOP
       01a2:797b d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:797f 90              NOP
       01a2:7980 d8 06 2a b4     FADD       float ptr [0xb42a]
       01a2:7984 83 ec 04        SUB        SP,0x4
       01a2:7987 8b dc           MOV        BX,SP
       01a2:7989 90              NOP
       01a2:798a d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:798c 90              NOP
       01a2:798d 9b              WAIT
       01a2:798e 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:7993 90              NOP
       01a2:7994 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:7998 90              NOP
       01a2:7999 d8 06 5e b4     FADD       float ptr [0xb45e]
       01a2:799d 83 ec 04        SUB        SP,0x4
       01a2:79a0 8b dc           MOV        BX,SP
       01a2:79a2 90              NOP
       01a2:79a3 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:79a5 90              NOP
       01a2:79a6 9b              WAIT
       01a2:79a7 90              NOP
       01a2:79a8 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:79ac 90              NOP
       01a2:79ad d8 06 0a b4     FADD       float ptr [0xb40a]
       01a2:79b1 83 ec 04        SUB        SP,0x4
       01a2:79b4 8b dc           MOV        BX,SP
       01a2:79b6 90              NOP
       01a2:79b7 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:79b9 90              NOP
       01a2:79ba 9b              WAIT
       01a2:79bb 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:79c0 33 c0           XOR        AX,AX
       01a2:79c2 50              PUSH       AX=>DAT_0e71_18ee                                = C0h
       01a2:79c3 b8 ff ff        MOV        AX,0xffff
       01a2:79c6 50              PUSH       AX=>DAT_0e71_18ec
       01a2:79c7 33 c0           XOR        AX,AX
       01a2:79c9 50              PUSH       AX=>DAT_0e71_18ea                                = B9h
       01a2:79ca 9a 80 10        CALLF      LINE
                 71 0e
       01a2:79cf 90              NOP
       01a2:79d0 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:79d4 90              NOP
       01a2:79d5 d8 06 0e b4     FADD       float ptr [0xb40e]
       01a2:79d9 83 ec 04        SUB        SP,0x4
       01a2:79dc 8b dc           MOV        BX,SP
       01a2:79de 90              NOP
       01a2:79df d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:79e1 90              NOP
       01a2:79e2 9b              WAIT
       01a2:79e3 90              NOP
       01a2:79e4 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:79e8 90              NOP
       01a2:79e9 d8 06 ce b4     FADD       float ptr [0xb4ce]
       01a2:79ed 83 ec 04        SUB        SP,0x4
       01a2:79f0 8b dc           MOV        BX,SP
       01a2:79f2 90              NOP
       01a2:79f3 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:79f5 90              NOP
       01a2:79f6 9b              WAIT
       01a2:79f7 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:79fc 90              NOP
       01a2:79fd d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:7a01 90              NOP
       01a2:7a02 d8 06 02 b4     FADD       float ptr [0xb402]
       01a2:7a06 83 ec 04        SUB        SP,0x4
       01a2:7a09 8b dc           MOV        BX,SP
       01a2:7a0b 90              NOP
       01a2:7a0c d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:7a0e 90              NOP
       01a2:7a0f 9b              WAIT
       01a2:7a10 90              NOP
       01a2:7a11 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:7a15 90              NOP
       01a2:7a16 d8 06 06 b5     FADD       float ptr [0xb506]
       01a2:7a1a 83 ec 04        SUB        SP,0x4
       01a2:7a1d 8b dc           MOV        BX,SP
       01a2:7a1f 90              NOP
       01a2:7a20 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:7a22 90              NOP
       01a2:7a23 9b              WAIT
       01a2:7a24 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:7a29 33 c0           XOR        AX,AX
       01a2:7a2b 50              PUSH       AX=>DAT_0e71_18ee                                = C0h
       01a2:7a2c b8 ff ff        MOV        AX,0xffff
       01a2:7a2f 50              PUSH       AX=>DAT_0e71_18ec
       01a2:7a30 33 c0           XOR        AX,AX
       01a2:7a32 50              PUSH       AX=>DAT_0e71_18ea                                = B9h
       01a2:7a33 9a 80 10        CALLF      LINE
                 71 0e
       01a2:7a38 90              NOP
       01a2:7a39 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:7a3d 90              NOP
       01a2:7a3e d8 06 c6 b4     FADD       float ptr [0xb4c6]
       01a2:7a42 83 ec 04        SUB        SP,0x4
       01a2:7a45 8b dc           MOV        BX,SP
       01a2:7a47 90              NOP
       01a2:7a48 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:7a4a 90              NOP
       01a2:7a4b 9b              WAIT
       01a2:7a4c 90              NOP
       01a2:7a4d d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:7a51 90              NOP
       01a2:7a52 d8 06 ce b4     FADD       float ptr [0xb4ce]
       01a2:7a56 83 ec 04        SUB        SP,0x4
       01a2:7a59 8b dc           MOV        BX,SP
       01a2:7a5b 90              NOP
       01a2:7a5c d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:7a5e 90              NOP
       01a2:7a5f 9b              WAIT
       01a2:7a60 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:7a65 90              NOP
       01a2:7a66 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:7a6a 90              NOP
       01a2:7a6b d8 06 14 a6     FADD       float ptr { 8.0 }
       01a2:7a6f 83 ec 04        SUB        SP,0x4
       01a2:7a72 8b dc           MOV        BX,SP
       01a2:7a74 90              NOP
       01a2:7a75 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:7a77 90              NOP
       01a2:7a78 9b              WAIT
       01a2:7a79 90              NOP
       01a2:7a7a d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:7a7e 90              NOP
       01a2:7a7f d8 06 06 b5     FADD       float ptr [0xb506]
       01a2:7a83 83 ec 04        SUB        SP,0x4
       01a2:7a86 8b dc           MOV        BX,SP
       01a2:7a88 90              NOP
       01a2:7a89 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:7a8b 90              NOP
       01a2:7a8c 9b              WAIT
       01a2:7a8d 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:7a92 33 c0           XOR        AX,AX
       01a2:7a94 50              PUSH       AX=>DAT_0e71_18ee                                = C0h
       01a2:7a95 b8 ff ff        MOV        AX,0xffff
       01a2:7a98 50              PUSH       AX=>DAT_0e71_18ec
       01a2:7a99 33 c0           XOR        AX,AX
       01a2:7a9b 50              PUSH       AX=>DAT_0e71_18ea                                = B9h
       01a2:7a9c 9a 80 10        CALLF      LINE
                 71 0e
       01a2:7aa1 90              NOP
       01a2:7aa2 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:7aa6 90              NOP
       01a2:7aa7 d8 06 24 b0     FADD       float ptr { 27.0 }
       01a2:7aab 83 ec 04        SUB        SP,0x4
       01a2:7aae 8b dc           MOV        BX,SP
       01a2:7ab0 90              NOP
       01a2:7ab1 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:7ab3 90              NOP
       01a2:7ab4 9b              WAIT
       01a2:7ab5 90              NOP
       01a2:7ab6 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:7aba 90              NOP
       01a2:7abb d8 06 fe b4     FADD       float ptr [0xb4fe]
       01a2:7abf 83 ec 04        SUB        SP,0x4
       01a2:7ac2 8b dc           MOV        BX,SP
       01a2:7ac4 90              NOP
       01a2:7ac5 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:7ac7 90              NOP
       01a2:7ac8 9b              WAIT
       01a2:7ac9 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:7ace 90              NOP
       01a2:7acf d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:7ad3 90              NOP
       01a2:7ad4 d8 06 02 b4     FADD       float ptr [0xb402]
       01a2:7ad8 83 ec 04        SUB        SP,0x4
       01a2:7adb 8b dc           MOV        BX,SP
       01a2:7add 90              NOP
       01a2:7ade d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:7ae0 90              NOP
       01a2:7ae1 9b              WAIT
       01a2:7ae2 90              NOP
       01a2:7ae3 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:7ae7 90              NOP
       01a2:7ae8 d8 06 26 b4     FADD       float ptr [0xb426]
       01a2:7aec 83 ec 04        SUB        SP,0x4
       01a2:7aef 8b dc           MOV        BX,SP
       01a2:7af1 90              NOP
       01a2:7af2 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:7af4 90              NOP
       01a2:7af5 9b              WAIT
       01a2:7af6 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:7afb 33 c0           XOR        AX,AX
       01a2:7afd 50              PUSH       AX=>DAT_0e71_18ee                                = C0h
       01a2:7afe b8 ff ff        MOV        AX,0xffff
       01a2:7b01 50              PUSH       AX=>DAT_0e71_18ec
       01a2:7b02 33 c0           XOR        AX,AX
       01a2:7b04 50              PUSH       AX=>DAT_0e71_18ea                                = B9h
       01a2:7b05 9a 80 10        CALLF      LINE
                 71 0e
       01a2:7b0a 90              NOP
       01a2:7b0b d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:7b0f 90              NOP
       01a2:7b10 d8 06 c6 b4     FADD       float ptr [0xb4c6]
       01a2:7b14 83 ec 04        SUB        SP,0x4
       01a2:7b17 8b dc           MOV        BX,SP
       01a2:7b19 90              NOP
       01a2:7b1a d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:7b1c 90              NOP
       01a2:7b1d 9b              WAIT
       01a2:7b1e 90              NOP
       01a2:7b1f d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:7b23 90              NOP
       01a2:7b24 d8 06 fe b4     FADD       float ptr [0xb4fe]
       01a2:7b28 83 ec 04        SUB        SP,0x4
       01a2:7b2b 8b dc           MOV        BX,SP
       01a2:7b2d 90              NOP
       01a2:7b2e d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:7b30 90              NOP
       01a2:7b31 9b              WAIT
       01a2:7b32 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:7b37 90              NOP
       01a2:7b38 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:7b3c 90              NOP
       01a2:7b3d d8 06 14 a6     FADD       float ptr { 8.0 }
       01a2:7b41 83 ec 04        SUB        SP,0x4
       01a2:7b44 8b dc           MOV        BX,SP
       01a2:7b46 90              NOP
       01a2:7b47 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:7b49 90              NOP
       01a2:7b4a 9b              WAIT
       01a2:7b4b 90              NOP
       01a2:7b4c d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:7b50 90              NOP
       01a2:7b51 d8 06 26 b4     FADD       float ptr [0xb426]
       01a2:7b55 83 ec 04        SUB        SP,0x4
       01a2:7b58 8b dc           MOV        BX,SP
       01a2:7b5a 90              NOP
       01a2:7b5b d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:7b5d 90              NOP
       01a2:7b5e 9b              WAIT
       01a2:7b5f 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:7b64 33 c0           XOR        AX,AX
       01a2:7b66 50              PUSH       AX=>DAT_0e71_18ee                                = C0h
       01a2:7b67 b8 ff ff        MOV        AX,0xffff
       01a2:7b6a 50              PUSH       AX=>DAT_0e71_18ec
       01a2:7b6b 33 c0           XOR        AX,AX
       01a2:7b6d 50              PUSH       AX=>DAT_0e71_18ea                                = B9h
       01a2:7b6e 9a 80 10        CALLF      LINE
                 71 0e
       01a2:7b73 90              NOP
       01a2:7b74 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:7b78 90              NOP
       01a2:7b79 d8 06 f6 b4     FADD       float ptr [0xb4f6]
       01a2:7b7d 83 ec 04        SUB        SP,0x4
       01a2:7b80 8b dc           MOV        BX,SP
       01a2:7b82 90              NOP
       01a2:7b83 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:7b85 90              NOP
       01a2:7b86 9b              WAIT
       01a2:7b87 90              NOP
       01a2:7b88 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:7b8c 90              NOP
       01a2:7b8d d8 06 06 b5     FADD       float ptr [0xb506]
       01a2:7b91 83 ec 04        SUB        SP,0x4
       01a2:7b94 8b dc           MOV        BX,SP
       01a2:7b96 90              NOP
       01a2:7b97 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:7b99 90              NOP
       01a2:7b9a 9b              WAIT
       01a2:7b9b 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:7ba0 90              NOP
       01a2:7ba1 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:7ba5 90              NOP
       01a2:7ba6 d8 06 f6 b4     FADD       float ptr [0xb4f6]
       01a2:7baa 83 ec 04        SUB        SP,0x4
       01a2:7bad 8b dc           MOV        BX,SP
       01a2:7baf 90              NOP
       01a2:7bb0 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:7bb2 90              NOP
       01a2:7bb3 9b              WAIT
       01a2:7bb4 90              NOP
       01a2:7bb5 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:7bb9 90              NOP
       01a2:7bba d8 06 36 b4     FADD       float ptr [0xb436]
       01a2:7bbe 83 ec 04        SUB        SP,0x4
       01a2:7bc1 8b dc           MOV        BX,SP
       01a2:7bc3 90              NOP
       01a2:7bc4 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:7bc6 90              NOP
       01a2:7bc7 9b              WAIT
       01a2:7bc8 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:7bcd 33 c0           XOR        AX,AX
       01a2:7bcf 50              PUSH       AX=>DAT_0e71_18ee                                = C0h
       01a2:7bd0 b8 ff ff        MOV        AX,0xffff
       01a2:7bd3 50              PUSH       AX=>DAT_0e71_18ec
       01a2:7bd4 33 c0           XOR        AX,AX
       01a2:7bd6 50              PUSH       AX=>DAT_0e71_18ea                                = B9h
       01a2:7bd7 9a 80 10        CALLF      LINE
                 71 0e
       01a2:7bdc 90              NOP
       01a2:7bdd d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:7be1 90              NOP
       01a2:7be2 d8 06 c6 b4     FADD       float ptr [0xb4c6]
       01a2:7be6 83 ec 04        SUB        SP,0x4
       01a2:7be9 8b dc           MOV        BX,SP
       01a2:7beb 90              NOP
       01a2:7bec d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:7bee 90              NOP
       01a2:7bef 9b              WAIT
       01a2:7bf0 90              NOP
       01a2:7bf1 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:7bf5 90              NOP
       01a2:7bf6 d8 06 1a b4     FADD       float ptr [0xb41a]
       01a2:7bfa 83 ec 04        SUB        SP,0x4
       01a2:7bfd 8b dc           MOV        BX,SP
       01a2:7bff 90              NOP
       01a2:7c00 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:7c02 90              NOP
       01a2:7c03 9b              WAIT
       01a2:7c04 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:7c09 90              NOP
       01a2:7c0a d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:7c0e 90              NOP
       01a2:7c0f d8 06 5e b4     FADD       float ptr [0xb45e]
       01a2:7c13 83 ec 04        SUB        SP,0x4
       01a2:7c16 8b dc           MOV        BX,SP
       01a2:7c18 90              NOP
       01a2:7c19 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:7c1b 90              NOP
       01a2:7c1c 9b              WAIT
       01a2:7c1d 90              NOP
       01a2:7c1e d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:7c22 90              NOP
       01a2:7c23 d8 06 42 b4     FADD       float ptr [0xb442]
       01a2:7c27 83 ec 04        SUB        SP,0x4
       01a2:7c2a 8b dc           MOV        BX,SP
       01a2:7c2c 90              NOP
       01a2:7c2d d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:7c2f 90              NOP
       01a2:7c30 9b              WAIT
       01a2:7c31 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:7c36 33 c0           XOR        AX,AX
       01a2:7c38 50              PUSH       AX=>DAT_0e71_18ee                                = C0h
       01a2:7c39 b8 ff ff        MOV        AX,0xffff
       01a2:7c3c 50              PUSH       AX=>DAT_0e71_18ec
       01a2:7c3d 33 c0           XOR        AX,AX
       01a2:7c3f 50              PUSH       AX=>DAT_0e71_18ea                                = B9h
       01a2:7c40 9a 80 10        CALLF      LINE
                 71 0e
       01a2:7c45 90              NOP
       01a2:7c46 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:7c4a 90              NOP
       01a2:7c4b d8 06 24 b0     FADD       float ptr { 27.0 }
       01a2:7c4f 83 ec 04        SUB        SP,0x4
       01a2:7c52 8b dc           MOV        BX,SP
       01a2:7c54 90              NOP
       01a2:7c55 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:7c57 90              NOP
       01a2:7c58 9b              WAIT
       01a2:7c59 90              NOP
       01a2:7c5a d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:7c5e 90              NOP
       01a2:7c5f d8 06 1a b4     FADD       float ptr [0xb41a]
       01a2:7c63 83 ec 04        SUB        SP,0x4
       01a2:7c66 8b dc           MOV        BX,SP
       01a2:7c68 90              NOP
       01a2:7c69 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:7c6b 90              NOP
       01a2:7c6c 9b              WAIT
       01a2:7c6d 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:7c72 90              NOP
       01a2:7c73 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:7c77 90              NOP
       01a2:7c78 d8 06 ca b4     FADD       float ptr [0xb4ca]
       01a2:7c7c 83 ec 04        SUB        SP,0x4
       01a2:7c7f 8b dc           MOV        BX,SP
       01a2:7c81 90              NOP
       01a2:7c82 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:7c84 90              NOP
       01a2:7c85 9b              WAIT
       01a2:7c86 90              NOP
       01a2:7c87 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:7c8b 90              NOP
       01a2:7c8c d8 06 36 b4     FADD       float ptr [0xb436]
       01a2:7c90 83 ec 04        SUB        SP,0x4
       01a2:7c93 8b dc           MOV        BX,SP
       01a2:7c95 90              NOP
       01a2:7c96 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:7c98 90              NOP
       01a2:7c99 9b              WAIT
       01a2:7c9a 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:7c9f 33 c0           XOR        AX,AX
       01a2:7ca1 50              PUSH       AX=>DAT_0e71_18ee                                = C0h
       01a2:7ca2 b8 ff ff        MOV        AX,0xffff
       01a2:7ca5 50              PUSH       AX=>DAT_0e71_18ec
       01a2:7ca6 33 c0           XOR        AX,AX
       01a2:7ca8 50              PUSH       AX=>DAT_0e71_18ea                                = B9h
       01a2:7ca9 9a 80 10        CALLF      LINE
                 71 0e
       01a2:7cae 90              NOP
       01a2:7caf d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:7cb3 90              NOP
       01a2:7cb4 d8 06 0e b4     FADD       float ptr [0xb40e]
       01a2:7cb8 83 ec 04        SUB        SP,0x4
       01a2:7cbb 8b dc           MOV        BX,SP
       01a2:7cbd 90              NOP
       01a2:7cbe d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:7cc0 90              NOP
       01a2:7cc1 9b              WAIT
       01a2:7cc2 90              NOP
       01a2:7cc3 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:7cc7 90              NOP
       01a2:7cc8 d8 06 1a b4     FADD       float ptr [0xb41a]
       01a2:7ccc 83 ec 04        SUB        SP,0x4
       01a2:7ccf 8b dc           MOV        BX,SP
       01a2:7cd1 90              NOP
       01a2:7cd2 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:7cd4 90              NOP
       01a2:7cd5 9b              WAIT
       01a2:7cd6 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:7cdb 90              NOP
       01a2:7cdc d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:7ce0 90              NOP
       01a2:7ce1 d8 06 ca b4     FADD       float ptr [0xb4ca]
       01a2:7ce5 83 ec 04        SUB        SP,0x4
       01a2:7ce8 8b dc           MOV        BX,SP
       01a2:7cea 90              NOP
       01a2:7ceb d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:7ced 90              NOP
       01a2:7cee 9b              WAIT
       01a2:7cef 90              NOP
       01a2:7cf0 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:7cf4 90              NOP
       01a2:7cf5 d8 06 42 b4     FADD       float ptr [0xb442]
       01a2:7cf9 83 ec 04        SUB        SP,0x4
       01a2:7cfc 8b dc           MOV        BX,SP
       01a2:7cfe 90              NOP
       01a2:7cff d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:7d01 90              NOP
       01a2:7d02 9b              WAIT
       01a2:7d03 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:7d08 33 c0           XOR        AX,AX
       01a2:7d0a 50              PUSH       AX=>DAT_0e71_18ee                                = C0h
       01a2:7d0b b8 ff ff        MOV        AX,0xffff
       01a2:7d0e 50              PUSH       AX=>DAT_0e71_18ec
       01a2:7d0f 33 c0           XOR        AX,AX
       01a2:7d11 50              PUSH       AX=>DAT_0e71_18ea                                = B9h
       01a2:7d12 9a 80 10        CALLF      LINE
                 71 0e
       01a2:7d17 90              NOP
       01a2:7d18 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:7d1c 90              NOP
       01a2:7d1d d8 06 ca b4     FADD       float ptr [0xb4ca]
       01a2:7d21 83 ec 04        SUB        SP,0x4
       01a2:7d24 8b dc           MOV        BX,SP
       01a2:7d26 90              NOP
       01a2:7d27 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:7d29 90              NOP
       01a2:7d2a 9b              WAIT
       01a2:7d2b 90              NOP
       01a2:7d2c d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:7d30 90              NOP
       01a2:7d31 d8 06 1a b4     FADD       float ptr [0xb41a]
       01a2:7d35 83 ec 04        SUB        SP,0x4
       01a2:7d38 8b dc           MOV        BX,SP
       01a2:7d3a 90              NOP
       01a2:7d3b d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:7d3d 90              NOP
       01a2:7d3e 9b              WAIT
       01a2:7d3f 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:7d44 90              NOP
       01a2:7d45 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:7d49 90              NOP
       01a2:7d4a d8 06 12 b4     FADD       float ptr [0xb412]
       01a2:7d4e 83 ec 04        SUB        SP,0x4
       01a2:7d51 8b dc           MOV        BX,SP
       01a2:7d53 90              NOP
       01a2:7d54 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:7d56 90              NOP
       01a2:7d57 9b              WAIT
       01a2:7d58 90              NOP
       01a2:7d59 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:7d5d 90              NOP
       01a2:7d5e d8 06 0a b4     FADD       float ptr [0xb40a]
       01a2:7d62 83 ec 04        SUB        SP,0x4
       01a2:7d65 8b dc           MOV        BX,SP
       01a2:7d67 90              NOP
       01a2:7d68 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:7d6a 90              NOP
       01a2:7d6b 9b              WAIT
       01a2:7d6c 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:7d71 33 c0           XOR        AX,AX
       01a2:7d73 50              PUSH       AX=>DAT_0e71_18ee                                = C0h
       01a2:7d74 b8 ff ff        MOV        AX,0xffff
       01a2:7d77 50              PUSH       AX=>DAT_0e71_18ec
       01a2:7d78 33 c0           XOR        AX,AX
       01a2:7d7a 50              PUSH       AX=>DAT_0e71_18ea                                = B9h
       01a2:7d7b 9a 80 10        CALLF      LINE
                 71 0e
       01a2:7d80 90              NOP
       01a2:7d81 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:7d85 90              NOP
       01a2:7d86 d8 06 c6 b4     FADD       float ptr [0xb4c6]
       01a2:7d8a 83 ec 04        SUB        SP,0x4
       01a2:7d8d 8b dc           MOV        BX,SP
       01a2:7d8f 90              NOP
       01a2:7d90 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:7d92 90              NOP
       01a2:7d93 9b              WAIT
       01a2:7d94 90              NOP
       01a2:7d95 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:7d99 90              NOP
       01a2:7d9a d8 06 1a b4     FADD       float ptr [0xb41a]
       01a2:7d9e 83 ec 04        SUB        SP,0x4
       01a2:7da1 8b dc           MOV        BX,SP
       01a2:7da3 90              NOP
       01a2:7da4 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:7da6 90              NOP
       01a2:7da7 9b              WAIT
       01a2:7da8 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:7dad 90              NOP
       01a2:7dae d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:7db2 90              NOP
       01a2:7db3 d8 06 46 b4     FADD       float ptr [0xb446]
       01a2:7db7 83 ec 04        SUB        SP,0x4
       01a2:7dba 8b dc           MOV        BX,SP
       01a2:7dbc 90              NOP
       01a2:7dbd d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:7dbf 90              NOP
       01a2:7dc0 9b              WAIT
       01a2:7dc1 90              NOP
       01a2:7dc2 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:7dc6 90              NOP
       01a2:7dc7 d8 06 36 b4     FADD       float ptr [0xb436]
       01a2:7dcb 83 ec 04        SUB        SP,0x4
       01a2:7dce 8b dc           MOV        BX,SP
       01a2:7dd0 90              NOP
       01a2:7dd1 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:7dd3 90              NOP
       01a2:7dd4 9b              WAIT
       01a2:7dd5 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:7dda 33 c0           XOR        AX,AX
       01a2:7ddc 50              PUSH       AX=>DAT_0e71_18ee                                = C0h
       01a2:7ddd b8 ff ff        MOV        AX,0xffff
       01a2:7de0 50              PUSH       AX=>DAT_0e71_18ec
       01a2:7de1 33 c0           XOR        AX,AX
       01a2:7de3 50              PUSH       AX=>DAT_0e71_18ea                                = B9h
       01a2:7de4 9a 80 10        CALLF      LINE
                 71 0e
       01a2:7de9 90              NOP
       01a2:7dea d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:7dee 90              NOP
       01a2:7def d8 06 0e b4     FADD       float ptr [0xb40e]
       01a2:7df3 83 ec 04        SUB        SP,0x4
       01a2:7df6 8b dc           MOV        BX,SP
       01a2:7df8 90              NOP
       01a2:7df9 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:7dfb 90              NOP
       01a2:7dfc 9b              WAIT
       01a2:7dfd 90              NOP
       01a2:7dfe d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:7e02 90              NOP
       01a2:7e03 d8 06 1a b4     FADD       float ptr [0xb41a]
       01a2:7e07 83 ec 04        SUB        SP,0x4
       01a2:7e0a 8b dc           MOV        BX,SP
       01a2:7e0c 90              NOP
       01a2:7e0d d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:7e0f 90              NOP
       01a2:7e10 9b              WAIT
       01a2:7e11 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:7e16 90              NOP
       01a2:7e17 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:7e1b 90              NOP
       01a2:7e1c d8 06 24 b0     FADD       float ptr { 27.0 }
       01a2:7e20 83 ec 04        SUB        SP,0x4
       01a2:7e23 8b dc           MOV        BX,SP
       01a2:7e25 90              NOP
       01a2:7e26 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:7e28 90              NOP
       01a2:7e29 9b              WAIT
       01a2:7e2a 90              NOP
       01a2:7e2b d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:7e2f 90              NOP
       01a2:7e30 d8 06 36 b4     FADD       float ptr [0xb436]
       01a2:7e34 83 ec 04        SUB        SP,0x4
       01a2:7e37 8b dc           MOV        BX,SP
       01a2:7e39 90              NOP
       01a2:7e3a d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:7e3c 90              NOP
       01a2:7e3d 9b              WAIT
       01a2:7e3e 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:7e43 33 c0           XOR        AX,AX
       01a2:7e45 50              PUSH       AX=>DAT_0e71_18ee                                = C0h
       01a2:7e46 b8 ff ff        MOV        AX,0xffff
       01a2:7e49 50              PUSH       AX=>DAT_0e71_18ec
       01a2:7e4a 33 c0           XOR        AX,AX
       01a2:7e4c 50              PUSH       AX=>DAT_0e71_18ea                                = B9h
       01a2:7e4d 9a 80 10        CALLF      LINE
                 71 0e
       01a2:7e52 90              NOP
       01a2:7e53 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:7e57 90              NOP
       01a2:7e58 d8 06 0e b4     FADD       float ptr [0xb40e]
       01a2:7e5c 83 ec 04        SUB        SP,0x4
       01a2:7e5f 8b dc           MOV        BX,SP
       01a2:7e61 90              NOP
       01a2:7e62 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:7e64 90              NOP
       01a2:7e65 9b              WAIT
       01a2:7e66 90              NOP
       01a2:7e67 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:7e6b 90              NOP
       01a2:7e6c d8 06 1a b4     FADD       float ptr [0xb41a]
       01a2:7e70 83 ec 04        SUB        SP,0x4
       01a2:7e73 8b dc           MOV        BX,SP
       01a2:7e75 90              NOP
       01a2:7e76 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:7e78 90              NOP
       01a2:7e79 9b              WAIT
       01a2:7e7a 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:7e7f 90              NOP
       01a2:7e80 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:7e84 90              NOP
       01a2:7e85 d8 06 36 b0     FADD       float ptr { 30.0 }
       01a2:7e89 83 ec 04        SUB        SP,0x4
       01a2:7e8c 8b dc           MOV        BX,SP
       01a2:7e8e 90              NOP
       01a2:7e8f d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:7e91 90              NOP
       01a2:7e92 9b              WAIT
       01a2:7e93 90              NOP
       01a2:7e94 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:7e98 90              NOP
       01a2:7e99 d8 06 42 b4     FADD       float ptr [0xb442]
       01a2:7e9d 83 ec 04        SUB        SP,0x4
       01a2:7ea0 8b dc           MOV        BX,SP
       01a2:7ea2 90              NOP
       01a2:7ea3 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:7ea5 90              NOP
       01a2:7ea6 9b              WAIT
       01a2:7ea7 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:7eac 33 c0           XOR        AX,AX
       01a2:7eae 50              PUSH       AX=>DAT_0e71_18ee                                = C0h
       01a2:7eaf b8 ff ff        MOV        AX,0xffff
       01a2:7eb2 50              PUSH       AX=>DAT_0e71_18ec
       01a2:7eb3 33 c0           XOR        AX,AX
       01a2:7eb5 50              PUSH       AX=>DAT_0e71_18ea                                = B9h
       01a2:7eb6 9a 80 10        CALLF      LINE
                 71 0e
       01a2:7ebb 90              NOP
       01a2:7ebc d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:7ec0 90              NOP
       01a2:7ec1 d8 06 ca b4     FADD       float ptr [0xb4ca]
       01a2:7ec5 83 ec 04        SUB        SP,0x4
       01a2:7ec8 8b dc           MOV        BX,SP
       01a2:7eca 90              NOP
       01a2:7ecb d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:7ecd 90              NOP
       01a2:7ece 9b              WAIT
       01a2:7ecf 90              NOP
       01a2:7ed0 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:7ed4 90              NOP
       01a2:7ed5 d8 06 1a b4     FADD       float ptr [0xb41a]
       01a2:7ed9 83 ec 04        SUB        SP,0x4
       01a2:7edc 8b dc           MOV        BX,SP
       01a2:7ede 90              NOP
       01a2:7edf d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:7ee1 90              NOP
       01a2:7ee2 9b              WAIT
       01a2:7ee3 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:7ee8 90              NOP
       01a2:7ee9 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:7eed 90              NOP
       01a2:7eee d8 06 ca b4     FADD       float ptr [0xb4ca]
       01a2:7ef2 83 ec 04        SUB        SP,0x4
       01a2:7ef5 8b dc           MOV        BX,SP
       01a2:7ef7 90              NOP
       01a2:7ef8 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:7efa 90              NOP
       01a2:7efb 9b              WAIT
       01a2:7efc 90              NOP
       01a2:7efd d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:7f01 90              NOP
       01a2:7f02 d8 06 0a b4     FADD       float ptr [0xb40a]
       01a2:7f06 83 ec 04        SUB        SP,0x4
       01a2:7f09 8b dc           MOV        BX,SP
       01a2:7f0b 90              NOP
       01a2:7f0c d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:7f0e 90              NOP
       01a2:7f0f 9b              WAIT
       01a2:7f10 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:7f15 33 c0           XOR        AX,AX
       01a2:7f17 50              PUSH       AX=>DAT_0e71_18ee                                = C0h
       01a2:7f18 b8 ff ff        MOV        AX,0xffff
       01a2:7f1b 50              PUSH       AX=>DAT_0e71_18ec
       01a2:7f1c 33 c0           XOR        AX,AX
       01a2:7f1e 50              PUSH       AX=>DAT_0e71_18ea                                = B9h
       01a2:7f1f 9a 80 10        CALLF      LINE
                 71 0e
       01a2:7f24 90              NOP
       01a2:7f25 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:7f29 90              NOP
       01a2:7f2a d8 06 10 a6     FADD       float ptr { 18.0 }
       01a2:7f2e 83 ec 04        SUB        SP,0x4
       01a2:7f31 8b dc           MOV        BX,SP
       01a2:7f33 90              NOP
       01a2:7f34 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:7f36 90              NOP
       01a2:7f37 9b              WAIT
       01a2:7f38 90              NOP
       01a2:7f39 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:7f3d 90              NOP
       01a2:7f3e d8 06 2a b4     FADD       float ptr [0xb42a]
       01a2:7f42 83 ec 04        SUB        SP,0x4
       01a2:7f45 8b dc           MOV        BX,SP
       01a2:7f47 90              NOP
       01a2:7f48 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:7f4a 90              NOP
       01a2:7f4b 9b              WAIT
       01a2:7f4c 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:7f51 90              NOP
       01a2:7f52 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:7f56 90              NOP
       01a2:7f57 d8 06 3a b4     FADD       float ptr [0xb43a]
       01a2:7f5b 83 ec 04        SUB        SP,0x4
       01a2:7f5e 8b dc           MOV        BX,SP
       01a2:7f60 90              NOP
       01a2:7f61 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:7f63 90              NOP
       01a2:7f64 9b              WAIT
       01a2:7f65 90              NOP
       01a2:7f66 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:7f6a 90              NOP
       01a2:7f6b d8 06 42 b4     FADD       float ptr [0xb442]
       01a2:7f6f 83 ec 04        SUB        SP,0x4
       01a2:7f72 8b dc           MOV        BX,SP
       01a2:7f74 90              NOP
       01a2:7f75 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:7f77 90              NOP
       01a2:7f78 9b              WAIT
       01a2:7f79 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:7f7e 33 c0           XOR        AX,AX
       01a2:7f80 50              PUSH       AX=>DAT_0e71_18ee                                = C0h
       01a2:7f81 b8 ff ff        MOV        AX,0xffff
       01a2:7f84 50              PUSH       AX=>DAT_0e71_18ec
       01a2:7f85 33 c0           XOR        AX,AX
       01a2:7f87 50              PUSH       AX=>DAT_0e71_18ea                                = B9h
       01a2:7f88 9a 80 10        CALLF      LINE
                 71 0e
       01a2:7f8d 90              NOP
       01a2:7f8e d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:7f92 90              NOP
       01a2:7f93 d8 06 fa b4     FADD       float ptr [0xb4fa]
       01a2:7f97 83 ec 04        SUB        SP,0x4
       01a2:7f9a 8b dc           MOV        BX,SP
       01a2:7f9c 90              NOP
       01a2:7f9d d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:7f9f 90              NOP
       01a2:7fa0 9b              WAIT
       01a2:7fa1 90              NOP
       01a2:7fa2 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:7fa6 90              NOP
       01a2:7fa7 d8 06 2a b4     FADD       float ptr [0xb42a]
       01a2:7fab 83 ec 04        SUB        SP,0x4
       01a2:7fae 8b dc           MOV        BX,SP
       01a2:7fb0 90              NOP
       01a2:7fb1 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:7fb3 90              NOP
       01a2:7fb4 9b              WAIT
       01a2:7fb5 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:7fba 90              NOP
       01a2:7fbb d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:7fbf 90              NOP
       01a2:7fc0 d8 06 62 b4     FADD       float ptr [0xb462]
       01a2:7fc4 83 ec 04        SUB        SP,0x4
       01a2:7fc7 8b dc           MOV        BX,SP
       01a2:7fc9 90              NOP
       01a2:7fca d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:7fcc 90              NOP
       01a2:7fcd 9b              WAIT
       01a2:7fce 90              NOP
       01a2:7fcf d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:7fd3 90              NOP
       01a2:7fd4 d8 06 36 b4     FADD       float ptr [0xb436]
       01a2:7fd8 83 ec 04        SUB        SP,0x4
       01a2:7fdb 8b dc           MOV        BX,SP
       01a2:7fdd 90              NOP
       01a2:7fde d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:7fe0 90              NOP
       01a2:7fe1 9b              WAIT
       01a2:7fe2 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:7fe7 33 c0           XOR        AX,AX
       01a2:7fe9 50              PUSH       AX=>DAT_0e71_18ee                                = C0h
       01a2:7fea b8 ff ff        MOV        AX,0xffff
       01a2:7fed 50              PUSH       AX=>DAT_0e71_18ec
       01a2:7fee 33 c0           XOR        AX,AX
       01a2:7ff0 50              PUSH       AX=>DAT_0e71_18ea                                = B9h
       01a2:7ff1 9a 80 10        CALLF      LINE
                 71 0e
       01a2:7ff6 90              NOP
       01a2:7ff7 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:7ffb 90              NOP
       01a2:7ffc d8 06 70 af     FADD       float ptr { 16.0 }
       01a2:8000 83 ec 04        SUB        SP,0x4
       01a2:8003 8b dc           MOV        BX,SP
       01a2:8005 90              NOP
       01a2:8006 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:8008 90              NOP
       01a2:8009 9b              WAIT
       01a2:800a 90              NOP
       01a2:800b d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:800f 90              NOP
       01a2:8010 d8 06 32 b4     FADD       float ptr [0xb432]
       01a2:8014 83 ec 04        SUB        SP,0x4
       01a2:8017 8b dc           MOV        BX,SP
       01a2:8019 90              NOP
       01a2:801a d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:801c 90              NOP
       01a2:801d 9b              WAIT
       01a2:801e 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:8023 90              NOP
       01a2:8024 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:8028 90              NOP
       01a2:8029 d8 06 66 b4     FADD       float ptr [0xb466]
       01a2:802d 83 ec 04        SUB        SP,0x4
       01a2:8030 8b dc           MOV        BX,SP
       01a2:8032 90              NOP
       01a2:8033 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:8035 90              NOP
       01a2:8036 9b              WAIT
       01a2:8037 90              NOP
       01a2:8038 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:803c 90              NOP
       01a2:803d d8 06 42 b4     FADD       float ptr [0xb442]
       01a2:8041 83 ec 04        SUB        SP,0x4
       01a2:8044 8b dc           MOV        BX,SP
       01a2:8046 90              NOP
       01a2:8047 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:8049 90              NOP
       01a2:804a 9b              WAIT
       01a2:804b 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:8050 33 c0           XOR        AX,AX
       01a2:8052 50              PUSH       AX=>DAT_0e71_18ee                                = C0h
       01a2:8053 b8 ff ff        MOV        AX,0xffff
       01a2:8056 50              PUSH       AX=>DAT_0e71_18ec
       01a2:8057 33 c0           XOR        AX,AX
       01a2:8059 50              PUSH       AX=>DAT_0e71_18ea                                = B9h
       01a2:805a 9a 80 10        CALLF      LINE
                 71 0e
       01a2:805f 90              NOP
       01a2:8060 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:8064 90              NOP
       01a2:8065 d8 06 f6 b3     FADD       float ptr [0xb3f6]
       01a2:8069 83 ec 04        SUB        SP,0x4
       01a2:806c 8b dc           MOV        BX,SP
       01a2:806e 90              NOP
       01a2:806f d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:8071 90              NOP
       01a2:8072 9b              WAIT
       01a2:8073 90              NOP
       01a2:8074 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:8078 90              NOP
       01a2:8079 d8 06 32 b4     FADD       float ptr [0xb432]
       01a2:807d 83 ec 04        SUB        SP,0x4
       01a2:8080 8b dc           MOV        BX,SP
       01a2:8082 90              NOP
       01a2:8083 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:8085 90              NOP
       01a2:8086 9b              WAIT
       01a2:8087 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:808c 90              NOP
       01a2:808d d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:8091 90              NOP
       01a2:8092 d8 06 ee b3     FADD       float ptr [0xb3ee]
       01a2:8096 83 ec 04        SUB        SP,0x4
       01a2:8099 8b dc           MOV        BX,SP
       01a2:809b 90              NOP
       01a2:809c d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:809e 90              NOP
       01a2:809f 9b              WAIT
       01a2:80a0 90              NOP
       01a2:80a1 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:80a5 90              NOP
       01a2:80a6 d8 06 0a b4     FADD       float ptr [0xb40a]
       01a2:80aa 83 ec 04        SUB        SP,0x4
       01a2:80ad 8b dc           MOV        BX,SP
       01a2:80af 90              NOP
       01a2:80b0 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:80b2 90              NOP
       01a2:80b3 9b              WAIT
       01a2:80b4 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:80b9 33 c0           XOR        AX,AX
       01a2:80bb 50              PUSH       AX=>DAT_0e71_18ee                                = C0h
       01a2:80bc b8 ff ff        MOV        AX,0xffff
       01a2:80bf 50              PUSH       AX=>DAT_0e71_18ec
       01a2:80c0 33 c0           XOR        AX,AX
       01a2:80c2 50              PUSH       AX=>DAT_0e71_18ea                                = B9h
       01a2:80c3 9a 80 10        CALLF      LINE
                 71 0e
       01a2:80c8 90              NOP
       01a2:80c9 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:80cd 90              NOP
       01a2:80ce d8 06 5a b4     FADD       float ptr [0xb45a]
       01a2:80d2 83 ec 04        SUB        SP,0x4
       01a2:80d5 8b dc           MOV        BX,SP
       01a2:80d7 90              NOP
       01a2:80d8 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:80da 90              NOP
       01a2:80db 9b              WAIT
       01a2:80dc 90              NOP
       01a2:80dd d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:80e1 90              NOP
       01a2:80e2 d8 06 3e b4     FADD       float ptr [0xb43e]
       01a2:80e6 83 ec 04        SUB        SP,0x4
       01a2:80e9 8b dc           MOV        BX,SP
       01a2:80eb 90              NOP
       01a2:80ec d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:80ee 90              NOP
       01a2:80ef 9b              WAIT
       01a2:80f0 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:80f5 90              NOP
       01a2:80f6 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:80fa 90              NOP
       01a2:80fb d8 06 0c a6     FADD       float ptr [0xa60c]
       01a2:80ff 83 ec 04        SUB        SP,0x4
       01a2:8102 8b dc           MOV        BX,SP
       01a2:8104 90              NOP
       01a2:8105 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:8107 90              NOP
       01a2:8108 9b              WAIT
       01a2:8109 90              NOP
       01a2:810a d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:810e 90              NOP
       01a2:810f d8 06 36 b4     FADD       float ptr [0xb436]
       01a2:8113 83 ec 04        SUB        SP,0x4
       01a2:8116 8b dc           MOV        BX,SP
       01a2:8118 90              NOP
       01a2:8119 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:811b 90              NOP
       01a2:811c 9b              WAIT
       01a2:811d 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:8122 33 c0           XOR        AX,AX
       01a2:8124 50              PUSH       AX=>DAT_0e71_18ee                                = C0h
       01a2:8125 b8 ff ff        MOV        AX,0xffff
       01a2:8128 50              PUSH       AX=>DAT_0e71_18ec
       01a2:8129 33 c0           XOR        AX,AX
       01a2:812b 50              PUSH       AX=>DAT_0e71_18ea                                = B9h
       01a2:812c 9a 80 10        CALLF      LINE
                 71 0e
       01a2:8131 90              NOP
       01a2:8132 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:8136 90              NOP
       01a2:8137 d8 06 ce b4     FADD       float ptr [0xb4ce]
       01a2:813b 83 ec 04        SUB        SP,0x4
       01a2:813e 8b dc           MOV        BX,SP
       01a2:8140 90              NOP
       01a2:8141 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:8143 90              NOP
       01a2:8144 9b              WAIT
       01a2:8145 90              NOP
       01a2:8146 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:814a 90              NOP
       01a2:814b d8 06 3e b4     FADD       float ptr [0xb43e]
       01a2:814f 83 ec 04        SUB        SP,0x4
       01a2:8152 8b dc           MOV        BX,SP
       01a2:8154 90              NOP
       01a2:8155 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:8157 90              NOP
       01a2:8158 9b              WAIT
       01a2:8159 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:815e 90              NOP
       01a2:815f d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:8163 90              NOP
       01a2:8164 d8 06 ce b4     FADD       float ptr [0xb4ce]
       01a2:8168 83 ec 04        SUB        SP,0x4
       01a2:816b 8b dc           MOV        BX,SP
       01a2:816d 90              NOP
       01a2:816e d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:8170 90              NOP
       01a2:8171 9b              WAIT
       01a2:8172 90              NOP
       01a2:8173 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:8177 90              NOP
       01a2:8178 d8 06 36 b4     FADD       float ptr [0xb436]
       01a2:817c 83 ec 04        SUB        SP,0x4
       01a2:817f 8b dc           MOV        BX,SP
       01a2:8181 90              NOP
       01a2:8182 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:8184 90              NOP
       01a2:8185 9b              WAIT
       01a2:8186 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:818b 33 c0           XOR        AX,AX
       01a2:818d 50              PUSH       AX=>DAT_0e71_18ee                                = C0h
       01a2:818e b8 ff ff        MOV        AX,0xffff
       01a2:8191 50              PUSH       AX=>DAT_0e71_18ec
       01a2:8192 33 c0           XOR        AX,AX
       01a2:8194 50              PUSH       AX=>DAT_0e71_18ea                                = B9h
       01a2:8195 9a 80 10        CALLF      LINE
                 71 0e
       01a2:819a 90              NOP
       01a2:819b d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:819f 90              NOP
       01a2:81a0 d8 06 7c a6     FADD       float ptr [0xa67c]
       01a2:81a4 83 ec 04        SUB        SP,0x4
       01a2:81a7 8b dc           MOV        BX,SP
       01a2:81a9 90              NOP
       01a2:81aa d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:81ac 90              NOP
       01a2:81ad 9b              WAIT
       01a2:81ae 90              NOP
       01a2:81af d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:81b3 90              NOP
       01a2:81b4 d8 06 fa b3     FADD       float ptr [0xb3fa]
       01a2:81b8 83 ec 04        SUB        SP,0x4
       01a2:81bb 8b dc           MOV        BX,SP
       01a2:81bd 90              NOP
       01a2:81be d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:81c0 90              NOP
       01a2:81c1 9b              WAIT
       01a2:81c2 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:81c7 90              NOP
       01a2:81c8 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:81cc 90              NOP
       01a2:81cd d8 06 78 a6     FADD       float ptr [0xa678]
       01a2:81d1 83 ec 04        SUB        SP,0x4
       01a2:81d4 8b dc           MOV        BX,SP
       01a2:81d6 90              NOP
       01a2:81d7 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:81d9 90              NOP
       01a2:81da 9b              WAIT
       01a2:81db 90              NOP
       01a2:81dc d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:81e0 90              NOP
       01a2:81e1 d8 06 42 b4     FADD       float ptr [0xb442]
       01a2:81e5 83 ec 04        SUB        SP,0x4
       01a2:81e8 8b dc           MOV        BX,SP
       01a2:81ea 90              NOP
       01a2:81eb d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:81ed 90              NOP
       01a2:81ee 9b              WAIT
       01a2:81ef 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:81f4 33 c0           XOR        AX,AX
       01a2:81f6 50              PUSH       AX=>DAT_0e71_18ee                                = C0h
       01a2:81f7 b8 ff ff        MOV        AX,0xffff
       01a2:81fa 50              PUSH       AX=>DAT_0e71_18ec
       01a2:81fb 33 c0           XOR        AX,AX
       01a2:81fd 50              PUSH       AX=>DAT_0e71_18ea                                = B9h
       01a2:81fe 9a 80 10        CALLF      LINE
                 71 0e
       01a2:8203 90              NOP
       01a2:8204 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:8208 90              NOP
       01a2:8209 d8 06 4a b4     FADD       float ptr [0xb44a]
       01a2:820d 83 ec 04        SUB        SP,0x4
       01a2:8210 8b dc           MOV        BX,SP
       01a2:8212 90              NOP
       01a2:8213 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:8215 90              NOP
       01a2:8216 9b              WAIT
       01a2:8217 90              NOP
       01a2:8218 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:821c 90              NOP
       01a2:821d d8 06 fa b3     FADD       float ptr [0xb3fa]
       01a2:8221 83 ec 04        SUB        SP,0x4
       01a2:8224 8b dc           MOV        BX,SP
       01a2:8226 90              NOP
       01a2:8227 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:8229 90              NOP
       01a2:822a 9b              WAIT
       01a2:822b 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:8230 90              NOP
       01a2:8231 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:8235 90              NOP
       01a2:8236 d8 06 fe b4     FADD       float ptr [0xb4fe]
       01a2:823a 83 ec 04        SUB        SP,0x4
       01a2:823d 8b dc           MOV        BX,SP
       01a2:823f 90              NOP
       01a2:8240 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:8242 90              NOP
       01a2:8243 9b              WAIT
       01a2:8244 90              NOP
       01a2:8245 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:8249 90              NOP
       01a2:824a d8 06 0a b4     FADD       float ptr [0xb40a]
       01a2:824e 83 ec 04        SUB        SP,0x4
       01a2:8251 8b dc           MOV        BX,SP
       01a2:8253 90              NOP
       01a2:8254 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:8256 90              NOP
       01a2:8257 9b              WAIT
       01a2:8258 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:825d 33 c0           XOR        AX,AX
       01a2:825f 50              PUSH       AX=>DAT_0e71_18ee                                = C0h
       01a2:8260 b8 ff ff        MOV        AX,0xffff
       01a2:8263 50              PUSH       AX=>DAT_0e71_18ec
       01a2:8264 33 c0           XOR        AX,AX
       01a2:8266 50              PUSH       AX=>DAT_0e71_18ea                                = B9h
       01a2:8267 9a 80 10        CALLF      LINE
                 71 0e
       01a2:826c 90              NOP
       01a2:826d d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:8271 90              NOP
       01a2:8272 d8 06 8c af     FADD       float ptr { 10.0 }
       01a2:8276 83 ec 04        SUB        SP,0x4
       01a2:8279 8b dc           MOV        BX,SP
       01a2:827b 90              NOP
       01a2:827c d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:827e 90              NOP
       01a2:827f 9b              WAIT
       01a2:8280 90              NOP
       01a2:8281 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:8285 90              NOP
       01a2:8286 d8 06 4a b4     FADD       float ptr [0xb44a]
       01a2:828a 83 ec 04        SUB        SP,0x4
       01a2:828d 8b dc           MOV        BX,SP
       01a2:828f 90              NOP
       01a2:8290 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:8292 90              NOP
       01a2:8293 9b              WAIT
       01a2:8294 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:8299 90              NOP
       01a2:829a d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:829e 90              NOP
       01a2:829f d8 06 94 af     FADD       float ptr { 9.0 }
       01a2:82a3 83 ec 04        SUB        SP,0x4
       01a2:82a6 8b dc           MOV        BX,SP
       01a2:82a8 90              NOP
       01a2:82a9 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:82ab 90              NOP
       01a2:82ac 9b              WAIT
       01a2:82ad 90              NOP
       01a2:82ae d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:82b2 90              NOP
       01a2:82b3 d8 06 42 b4     FADD       float ptr [0xb442]
       01a2:82b7 83 ec 04        SUB        SP,0x4
       01a2:82ba 8b dc           MOV        BX,SP
       01a2:82bc 90              NOP
       01a2:82bd d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:82bf 90              NOP
       01a2:82c0 9b              WAIT
       01a2:82c1 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:82c6 33 c0           XOR        AX,AX
       01a2:82c8 50              PUSH       AX=>DAT_0e71_18ee                                = C0h
       01a2:82c9 b8 ff ff        MOV        AX,0xffff
       01a2:82cc 50              PUSH       AX=>DAT_0e71_18ec
       01a2:82cd 33 c0           XOR        AX,AX
       01a2:82cf 50              PUSH       AX=>DAT_0e71_18ea                                = B9h
       01a2:82d0 9a 80 10        CALLF      LINE
                 71 0e
       01a2:82d5 90              NOP
       01a2:82d6 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:82da 90              NOP
       01a2:82db d8 06 fa b3     FADD       float ptr [0xb3fa]
       01a2:82df 83 ec 04        SUB        SP,0x4
       01a2:82e2 8b dc           MOV        BX,SP
       01a2:82e4 90              NOP
       01a2:82e5 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:82e7 90              NOP
       01a2:82e8 9b              WAIT
       01a2:82e9 90              NOP
       01a2:82ea d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:82ee 90              NOP
       01a2:82ef d8 06 4a b4     FADD       float ptr [0xb44a]
       01a2:82f3 83 ec 04        SUB        SP,0x4
       01a2:82f6 8b dc           MOV        BX,SP
       01a2:82f8 90              NOP
       01a2:82f9 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:82fb 90              NOP
       01a2:82fc 9b              WAIT
       01a2:82fd 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:8302 90              NOP
       01a2:8303 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:8307 90              NOP
       01a2:8308 d8 06 4a b4     FADD       float ptr [0xb44a]
       01a2:830c 83 ec 04        SUB        SP,0x4
       01a2:830f 8b dc           MOV        BX,SP
       01a2:8311 90              NOP
       01a2:8312 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:8314 90              NOP
       01a2:8315 9b              WAIT
       01a2:8316 90              NOP
       01a2:8317 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:831b 90              NOP
       01a2:831c d8 06 0a b4     FADD       float ptr [0xb40a]
       01a2:8320 83 ec 04        SUB        SP,0x4
       01a2:8323 8b dc           MOV        BX,SP
       01a2:8325 90              NOP
       01a2:8326 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:8328 90              NOP
       01a2:8329 9b              WAIT
       01a2:832a 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:832f 33 c0           XOR        AX,AX
       01a2:8331 50              PUSH       AX=>DAT_0e71_18ee                                = C0h
       01a2:8332 b8 ff ff        MOV        AX,0xffff
       01a2:8335 50              PUSH       AX=>DAT_0e71_18ec
       01a2:8336 33 c0           XOR        AX,AX
       01a2:8338 50              PUSH       AX=>DAT_0e71_18ea                                = B9h
       01a2:8339 9a 80 10        CALLF      LINE
                 71 0e
       01a2:833e 90              NOP
       01a2:833f d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:8343 90              NOP
       01a2:8344 d8 06 14 a6     FADD       float ptr { 8.0 }
       01a2:8348 83 ec 04        SUB        SP,0x4
       01a2:834b 8b dc           MOV        BX,SP
       01a2:834d 90              NOP
       01a2:834e d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:8350 90              NOP
       01a2:8351 9b              WAIT
       01a2:8352 90              NOP
       01a2:8353 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:8357 90              NOP
       01a2:8358 d8 06 24 b0     FADD       float ptr { 27.0 }
       01a2:835c 83 ec 04        SUB        SP,0x4
       01a2:835f 8b dc           MOV        BX,SP
       01a2:8361 90              NOP
       01a2:8362 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:8364 90              NOP
       01a2:8365 9b              WAIT
       01a2:8366 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:836b 90              NOP
       01a2:836c d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:8370 90              NOP
       01a2:8371 d8 06 94 af     FADD       float ptr { 9.0 }
       01a2:8375 83 ec 04        SUB        SP,0x4
       01a2:8378 8b dc           MOV        BX,SP
       01a2:837a 90              NOP
       01a2:837b d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:837d 90              NOP
       01a2:837e 9b              WAIT
       01a2:837f 90              NOP
       01a2:8380 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:8384 90              NOP
       01a2:8385 d8 06 0a b5     FADD       float ptr [0xb50a]
       01a2:8389 83 ec 04        SUB        SP,0x4
       01a2:838c 8b dc           MOV        BX,SP
       01a2:838e 90              NOP
       01a2:838f d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:8391 90              NOP
       01a2:8392 9b              WAIT
       01a2:8393 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:8398 33 c0           XOR        AX,AX
       01a2:839a 50              PUSH       AX=>DAT_0e71_18ee                                = C0h
       01a2:839b b8 ff ff        MOV        AX,0xffff
       01a2:839e 50              PUSH       AX=>DAT_0e71_18ec
       01a2:839f 33 c0           XOR        AX,AX
       01a2:83a1 50              PUSH       AX=>DAT_0e71_18ea                                = B9h
       01a2:83a2 9a 80 10        CALLF      LINE
                 71 0e
       01a2:83a7 90              NOP
       01a2:83a8 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:83ac 90              NOP
       01a2:83ad d8 06 80 af     FADD       float ptr { 6.0 }
       01a2:83b1 83 ec 04        SUB        SP,0x4
       01a2:83b4 8b dc           MOV        BX,SP
       01a2:83b6 90              NOP
       01a2:83b7 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:83b9 90              NOP
       01a2:83ba 9b              WAIT
       01a2:83bb 90              NOP
       01a2:83bc d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:83c0 90              NOP
       01a2:83c1 d8 06 f6 b4     FADD       float ptr [0xb4f6]
       01a2:83c5 83 ec 04        SUB        SP,0x4
       01a2:83c8 8b dc           MOV        BX,SP
       01a2:83ca 90              NOP
       01a2:83cb d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:83cd 90              NOP
       01a2:83ce 9b              WAIT
       01a2:83cf 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:83d4 90              NOP
       01a2:83d5 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:83d9 90              NOP
       01a2:83da d8 06 8c af     FADD       float ptr { 10.0 }
       01a2:83de 83 ec 04        SUB        SP,0x4
       01a2:83e1 8b dc           MOV        BX,SP
       01a2:83e3 90              NOP
       01a2:83e4 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:83e6 90              NOP
       01a2:83e7 9b              WAIT
       01a2:83e8 90              NOP
       01a2:83e9 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:83ed 90              NOP
       01a2:83ee d8 06 42 b4     FADD       float ptr [0xb442]
       01a2:83f2 83 ec 04        SUB        SP,0x4
       01a2:83f5 8b dc           MOV        BX,SP
       01a2:83f7 90              NOP
       01a2:83f8 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:83fa 90              NOP
       01a2:83fb 9b              WAIT
       01a2:83fc 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:8401 33 c0           XOR        AX,AX
       01a2:8403 50              PUSH       AX=>DAT_0e71_18ee                                = C0h
       01a2:8404 b8 ff ff        MOV        AX,0xffff
       01a2:8407 50              PUSH       AX=>DAT_0e71_18ec
       01a2:8408 33 c0           XOR        AX,AX
       01a2:840a 50              PUSH       AX=>DAT_0e71_18ea                                = B9h
       01a2:840b 9a 80 10        CALLF      LINE
                 71 0e
       01a2:8410 90              NOP
       01a2:8411 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:8415 90              NOP
       01a2:8416 d8 06 3e b4     FADD       float ptr [0xb43e]
       01a2:841a 83 ec 04        SUB        SP,0x4
       01a2:841d 8b dc           MOV        BX,SP
       01a2:841f 90              NOP
       01a2:8420 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:8422 90              NOP
       01a2:8423 9b              WAIT
       01a2:8424 90              NOP
       01a2:8425 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:8429 90              NOP
       01a2:842a d8 06 24 b0     FADD       float ptr { 27.0 }
       01a2:842e 83 ec 04        SUB        SP,0x4
       01a2:8431 8b dc           MOV        BX,SP
       01a2:8433 90              NOP
       01a2:8434 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:8436 90              NOP
       01a2:8437 9b              WAIT
       01a2:8438 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:843d 90              NOP
       01a2:843e d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:8442 90              NOP
       01a2:8443 d8 06 f6 b3     FADD       float ptr [0xb3f6]
       01a2:8447 83 ec 04        SUB        SP,0x4
       01a2:844a 8b dc           MOV        BX,SP
       01a2:844c 90              NOP
       01a2:844d d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:844f 90              NOP
       01a2:8450 9b              WAIT
       01a2:8451 90              NOP
       01a2:8452 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:8456 90              NOP
       01a2:8457 d8 06 36 b4     FADD       float ptr [0xb436]
       01a2:845b 83 ec 04        SUB        SP,0x4
       01a2:845e 8b dc           MOV        BX,SP
       01a2:8460 90              NOP
       01a2:8461 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:8463 90              NOP
       01a2:8464 9b              WAIT
       01a2:8465 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:846a 33 c0           XOR        AX,AX
       01a2:846c 50              PUSH       AX=>DAT_0e71_18ee                                = C0h
       01a2:846d b8 ff ff        MOV        AX,0xffff
       01a2:8470 50              PUSH       AX=>DAT_0e71_18ec
       01a2:8471 33 c0           XOR        AX,AX
       01a2:8473 50              PUSH       AX=>DAT_0e71_18ea                                = B9h
       01a2:8474 9a 80 10        CALLF      LINE
                 71 0e
       01a2:8479 90              NOP
       01a2:847a d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:847e 90              NOP
       01a2:847f d8 06 2a b4     FADD       float ptr [0xb42a]
       01a2:8483 83 ec 04        SUB        SP,0x4
       01a2:8486 8b dc           MOV        BX,SP
       01a2:8488 90              NOP
       01a2:8489 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:848b 90              NOP
       01a2:848c 9b              WAIT
       01a2:848d 90              NOP
       01a2:848e d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:8492 90              NOP
       01a2:8493 d8 06 4e b4     FADD       float ptr [0xb44e]
       01a2:8497 83 ec 04        SUB        SP,0x4
       01a2:849a 8b dc           MOV        BX,SP
       01a2:849c 90              NOP
       01a2:849d d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:849f 90              NOP
       01a2:84a0 9b              WAIT
       01a2:84a1 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:84a6 90              NOP
       01a2:84a7 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:84ab 90              NOP
       01a2:84ac d8 06 ce b4     FADD       float ptr [0xb4ce]
       01a2:84b0 83 ec 04        SUB        SP,0x4
       01a2:84b3 8b dc           MOV        BX,SP
       01a2:84b5 90              NOP
       01a2:84b6 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:84b8 90              NOP
       01a2:84b9 9b              WAIT
       01a2:84ba 90              NOP
       01a2:84bb d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:84bf 90              NOP
       01a2:84c0 d8 06 42 b4     FADD       float ptr [0xb442]
       01a2:84c4 83 ec 04        SUB        SP,0x4
       01a2:84c7 8b dc           MOV        BX,SP
       01a2:84c9 90              NOP
       01a2:84ca d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:84cc 90              NOP
       01a2:84cd 9b              WAIT
       01a2:84ce 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:84d3 33 c0           XOR        AX,AX
       01a2:84d5 50              PUSH       AX=>DAT_0e71_18ee                                = C0h
       01a2:84d6 b8 ff ff        MOV        AX,0xffff
       01a2:84d9 50              PUSH       AX=>DAT_0e71_18ec
       01a2:84da 33 c0           XOR        AX,AX
       01a2:84dc 50              PUSH       AX=>DAT_0e71_18ea                                = B9h
       01a2:84dd 9a 80 10        CALLF      LINE
                 71 0e
       01a2:84e2 90              NOP
       01a2:84e3 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:84e7 90              NOP
       01a2:84e8 d8 06 10 a6     FADD       float ptr { 18.0 }
       01a2:84ec 83 ec 04        SUB        SP,0x4
       01a2:84ef 8b dc           MOV        BX,SP
       01a2:84f1 90              NOP
       01a2:84f2 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:84f4 90              NOP
       01a2:84f5 9b              WAIT
       01a2:84f6 90              NOP
       01a2:84f7 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:84fb 90              NOP
       01a2:84fc d8 06 2a b4     FADD       float ptr [0xb42a]
       01a2:8500 83 ec 04        SUB        SP,0x4
       01a2:8503 8b dc           MOV        BX,SP
       01a2:8505 90              NOP
       01a2:8506 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:8508 90              NOP
       01a2:8509 9b              WAIT
       01a2:850a 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:850f 90              NOP
       01a2:8510 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:8514 90              NOP
       01a2:8515 d8 06 46 b4     FADD       float ptr [0xb446]
       01a2:8519 83 ec 04        SUB        SP,0x4
       01a2:851c 8b dc           MOV        BX,SP
       01a2:851e 90              NOP
       01a2:851f d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:8521 90              NOP
       01a2:8522 9b              WAIT
       01a2:8523 90              NOP
       01a2:8524 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:8528 90              NOP
       01a2:8529 d8 06 42 b4     FADD       float ptr [0xb442]
       01a2:852d 83 ec 04        SUB        SP,0x4
       01a2:8530 8b dc           MOV        BX,SP
       01a2:8532 90              NOP
       01a2:8533 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:8535 90              NOP
       01a2:8536 9b              WAIT
       01a2:8537 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:853c 33 c0           XOR        AX,AX
       01a2:853e 50              PUSH       AX=>DAT_0e71_18ee                                = C0h
       01a2:853f b8 ff ff        MOV        AX,0xffff
       01a2:8542 50              PUSH       AX=>DAT_0e71_18ec
       01a2:8543 33 c0           XOR        AX,AX
       01a2:8545 50              PUSH       AX=>DAT_0e71_18ea                                = B9h
       01a2:8546 9a 80 10        CALLF      LINE
                 71 0e
       01a2:854b 90              NOP
       01a2:854c d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:8550 90              NOP
       01a2:8551 d8 06 fa b4     FADD       float ptr [0xb4fa]
       01a2:8555 83 ec 04        SUB        SP,0x4
       01a2:8558 8b dc           MOV        BX,SP
       01a2:855a 90              NOP
       01a2:855b d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:855d 90              NOP
       01a2:855e 9b              WAIT
       01a2:855f 90              NOP
       01a2:8560 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:8564 90              NOP
       01a2:8565 d8 06 2a b4     FADD       float ptr [0xb42a]
       01a2:8569 83 ec 04        SUB        SP,0x4
       01a2:856c 8b dc           MOV        BX,SP
       01a2:856e 90              NOP
       01a2:856f d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:8571 90              NOP
       01a2:8572 9b              WAIT
       01a2:8573 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:8578 90              NOP
       01a2:8579 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:857d 90              NOP
       01a2:857e d8 06 4e b4     FADD       float ptr [0xb44e]
       01a2:8582 83 ec 04        SUB        SP,0x4
       01a2:8585 8b dc           MOV        BX,SP
       01a2:8587 90              NOP
       01a2:8588 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:858a 90              NOP
       01a2:858b 9b              WAIT
       01a2:858c 90              NOP
       01a2:858d d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:8591 90              NOP
       01a2:8592 d8 06 36 b4     FADD       float ptr [0xb436]
       01a2:8596 83 ec 04        SUB        SP,0x4
       01a2:8599 8b dc           MOV        BX,SP
       01a2:859b 90              NOP
       01a2:859c d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:859e 90              NOP
       01a2:859f 9b              WAIT
       01a2:85a0 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:85a5 33 c0           XOR        AX,AX
       01a2:85a7 50              PUSH       AX=>DAT_0e71_18ee                                = C0h
       01a2:85a8 b8 ff ff        MOV        AX,0xffff
       01a2:85ab 50              PUSH       AX=>DAT_0e71_18ec
       01a2:85ac 33 c0           XOR        AX,AX
       01a2:85ae 50              PUSH       AX=>DAT_0e71_18ea                                = B9h
       01a2:85af 9a 80 10        CALLF      LINE
                 71 0e
       01a2:85b4 90              NOP
       01a2:85b5 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:85b9 90              NOP
       01a2:85ba d8 06 70 af     FADD       float ptr { 16.0 }
       01a2:85be 83 ec 04        SUB        SP,0x4
       01a2:85c1 8b dc           MOV        BX,SP
       01a2:85c3 90              NOP
       01a2:85c4 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:85c6 90              NOP
       01a2:85c7 9b              WAIT
       01a2:85c8 90              NOP
       01a2:85c9 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:85cd 90              NOP
       01a2:85ce d8 06 32 b4     FADD       float ptr [0xb432]
       01a2:85d2 83 ec 04        SUB        SP,0x4
       01a2:85d5 8b dc           MOV        BX,SP
       01a2:85d7 90              NOP
       01a2:85d8 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:85da 90              NOP
       01a2:85db 9b              WAIT
       01a2:85dc 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:85e1 90              NOP
       01a2:85e2 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:85e6 90              NOP
       01a2:85e7 d8 06 5e b4     FADD       float ptr [0xb45e]
       01a2:85eb 83 ec 04        SUB        SP,0x4
       01a2:85ee 8b dc           MOV        BX,SP
       01a2:85f0 90              NOP
       01a2:85f1 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:85f3 90              NOP
       01a2:85f4 9b              WAIT
       01a2:85f5 90              NOP
       01a2:85f6 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:85fa 90              NOP
       01a2:85fb d8 06 42 b4     FADD       float ptr [0xb442]
       01a2:85ff 83 ec 04        SUB        SP,0x4
       01a2:8602 8b dc           MOV        BX,SP
       01a2:8604 90              NOP
       01a2:8605 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:8607 90              NOP
       01a2:8608 9b              WAIT
       01a2:8609 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:860e 33 c0           XOR        AX,AX
       01a2:8610 50              PUSH       AX=>DAT_0e71_18ee                                = C0h
       01a2:8611 b8 ff ff        MOV        AX,0xffff
       01a2:8614 50              PUSH       AX=>DAT_0e71_18ec
       01a2:8615 33 c0           XOR        AX,AX
       01a2:8617 50              PUSH       AX=>DAT_0e71_18ea                                = B9h
       01a2:8618 9a 80 10        CALLF      LINE
                 71 0e
       01a2:861d 90              NOP
       01a2:861e d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:8622 90              NOP
       01a2:8623 d8 06 f6 b3     FADD       float ptr [0xb3f6]
       01a2:8627 83 ec 04        SUB        SP,0x4
       01a2:862a 8b dc           MOV        BX,SP
       01a2:862c 90              NOP
       01a2:862d d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:862f 90              NOP
       01a2:8630 9b              WAIT
       01a2:8631 90              NOP
       01a2:8632 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:8636 90              NOP
       01a2:8637 d8 06 32 b4     FADD       float ptr [0xb432]
       01a2:863b 83 ec 04        SUB        SP,0x4
       01a2:863e 8b dc           MOV        BX,SP
       01a2:8640 90              NOP
       01a2:8641 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:8643 90              NOP
       01a2:8644 9b              WAIT
       01a2:8645 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:864a 90              NOP
       01a2:864b d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:864f 90              NOP
       01a2:8650 d8 06 36 b0     FADD       float ptr { 30.0 }
       01a2:8654 83 ec 04        SUB        SP,0x4
       01a2:8657 8b dc           MOV        BX,SP
       01a2:8659 90              NOP
       01a2:865a d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:865c 90              NOP
       01a2:865d 9b              WAIT
       01a2:865e 90              NOP
       01a2:865f d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:8663 90              NOP
       01a2:8664 d8 06 0a b4     FADD       float ptr [0xb40a]
       01a2:8668 83 ec 04        SUB        SP,0x4
       01a2:866b 8b dc           MOV        BX,SP
       01a2:866d 90              NOP
       01a2:866e d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:8670 90              NOP
       01a2:8671 9b              WAIT
       01a2:8672 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:8677 33 c0           XOR        AX,AX
       01a2:8679 50              PUSH       AX=>DAT_0e71_18ee                                = C0h
       01a2:867a b8 ff ff        MOV        AX,0xffff
       01a2:867d 50              PUSH       AX=>DAT_0e71_18ec
       01a2:867e 33 c0           XOR        AX,AX
       01a2:8680 50              PUSH       AX=>DAT_0e71_18ea                                = B9h
       01a2:8681 9a 80 10        CALLF      LINE
                 71 0e
       01a2:8686 90              NOP
       01a2:8687 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:868b 90              NOP
       01a2:868c d8 06 5a b4     FADD       float ptr [0xb45a]
       01a2:8690 83 ec 04        SUB        SP,0x4
       01a2:8693 8b dc           MOV        BX,SP
       01a2:8695 90              NOP
       01a2:8696 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:8698 90              NOP
       01a2:8699 9b              WAIT
       01a2:869a 90              NOP
       01a2:869b d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:869f 90              NOP
       01a2:86a0 d8 06 3e b4     FADD       float ptr [0xb43e]
       01a2:86a4 83 ec 04        SUB        SP,0x4
       01a2:86a7 8b dc           MOV        BX,SP
       01a2:86a9 90              NOP
       01a2:86aa d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:86ac 90              NOP
       01a2:86ad 9b              WAIT
       01a2:86ae 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:86b3 90              NOP
       01a2:86b4 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:86b8 90              NOP
       01a2:86b9 d8 06 3a b4     FADD       float ptr [0xb43a]
       01a2:86bd 83 ec 04        SUB        SP,0x4
       01a2:86c0 8b dc           MOV        BX,SP
       01a2:86c2 90              NOP
       01a2:86c3 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:86c5 90              NOP
       01a2:86c6 9b              WAIT
       01a2:86c7 90              NOP
       01a2:86c8 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:86cc 90              NOP
       01a2:86cd d8 06 36 b4     FADD       float ptr [0xb436]
       01a2:86d1 83 ec 04        SUB        SP,0x4
       01a2:86d4 8b dc           MOV        BX,SP
       01a2:86d6 90              NOP
       01a2:86d7 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:86d9 90              NOP
       01a2:86da 9b              WAIT
       01a2:86db 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:86e0 33 c0           XOR        AX,AX
       01a2:86e2 50              PUSH       AX=>DAT_0e71_18ee                                = C0h
       01a2:86e3 b8 ff ff        MOV        AX,0xffff
       01a2:86e6 50              PUSH       AX=>DAT_0e71_18ec
       01a2:86e7 33 c0           XOR        AX,AX
       01a2:86e9 50              PUSH       AX=>DAT_0e71_18ea                                = B9h
       01a2:86ea 9a 80 10        CALLF      LINE
                 71 0e
       01a2:86ef 90              NOP
       01a2:86f0 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:86f4 90              NOP
       01a2:86f5 d8 06 ce b4     FADD       float ptr [0xb4ce]
       01a2:86f9 83 ec 04        SUB        SP,0x4
       01a2:86fc 8b dc           MOV        BX,SP
       01a2:86fe 90              NOP
       01a2:86ff d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:8701 90              NOP
       01a2:8702 9b              WAIT
       01a2:8703 90              NOP
       01a2:8704 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:8708 90              NOP
       01a2:8709 d8 06 3e b4     FADD       float ptr [0xb43e]
       01a2:870d 83 ec 04        SUB        SP,0x4
       01a2:8710 8b dc           MOV        BX,SP
       01a2:8712 90              NOP
       01a2:8713 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:8715 90              NOP
       01a2:8716 9b              WAIT
       01a2:8717 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:871c 90              NOP
       01a2:871d d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:8721 90              NOP
       01a2:8722 d8 06 62 b4     FADD       float ptr [0xb462]
       01a2:8726 83 ec 04        SUB        SP,0x4
       01a2:8729 8b dc           MOV        BX,SP
       01a2:872b 90              NOP
       01a2:872c d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:872e 90              NOP
       01a2:872f 9b              WAIT
       01a2:8730 90              NOP
       01a2:8731 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:8735 90              NOP
       01a2:8736 d8 06 36 b4     FADD       float ptr [0xb436]
       01a2:873a 83 ec 04        SUB        SP,0x4
       01a2:873d 8b dc           MOV        BX,SP
       01a2:873f 90              NOP
       01a2:8740 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:8742 90              NOP
       01a2:8743 9b              WAIT
       01a2:8744 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:8749 33 c0           XOR        AX,AX
       01a2:874b 50              PUSH       AX=>DAT_0e71_18ee                                = C0h
       01a2:874c b8 ff ff        MOV        AX,0xffff
       01a2:874f 50              PUSH       AX=>DAT_0e71_18ec
       01a2:8750 33 c0           XOR        AX,AX
       01a2:8752 50              PUSH       AX=>DAT_0e71_18ea                                = B9h
       01a2:8753 9a 80 10        CALLF      LINE
                 71 0e
       01a2:8758 90              NOP
       01a2:8759 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:875d 90              NOP
       01a2:875e d8 06 7c a6     FADD       float ptr [0xa67c]
       01a2:8762 83 ec 04        SUB        SP,0x4
       01a2:8765 8b dc           MOV        BX,SP
       01a2:8767 90              NOP
       01a2:8768 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:876a 90              NOP
       01a2:876b 9b              WAIT
       01a2:876c 90              NOP
       01a2:876d d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:8771 90              NOP
       01a2:8772 d8 06 fa b3     FADD       float ptr [0xb3fa]
       01a2:8776 83 ec 04        SUB        SP,0x4
       01a2:8779 8b dc           MOV        BX,SP
       01a2:877b 90              NOP
       01a2:877c d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:877e 90              NOP
       01a2:877f 9b              WAIT
       01a2:8780 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:8785 90              NOP
       01a2:8786 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:878a 90              NOP
       01a2:878b d8 06 10 a6     FADD       float ptr { 18.0 }
       01a2:878f 83 ec 04        SUB        SP,0x4
       01a2:8792 8b dc           MOV        BX,SP
       01a2:8794 90              NOP
       01a2:8795 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:8797 90              NOP
       01a2:8798 9b              WAIT
       01a2:8799 90              NOP
       01a2:879a d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:879e 90              NOP
       01a2:879f d8 06 42 b4     FADD       float ptr [0xb442]
       01a2:87a3 83 ec 04        SUB        SP,0x4
       01a2:87a6 8b dc           MOV        BX,SP
       01a2:87a8 90              NOP
       01a2:87a9 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:87ab 90              NOP
       01a2:87ac 9b              WAIT
       01a2:87ad 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:87b2 33 c0           XOR        AX,AX
       01a2:87b4 50              PUSH       AX=>DAT_0e71_18ee                                = C0h
       01a2:87b5 b8 ff ff        MOV        AX,0xffff
       01a2:87b8 50              PUSH       AX=>DAT_0e71_18ec
       01a2:87b9 33 c0           XOR        AX,AX
       01a2:87bb 50              PUSH       AX=>DAT_0e71_18ea                                = B9h
       01a2:87bc 9a 80 10        CALLF      LINE
                 71 0e
       01a2:87c1 90              NOP
       01a2:87c2 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:87c6 90              NOP
       01a2:87c7 d8 06 4a b4     FADD       float ptr [0xb44a]
       01a2:87cb 83 ec 04        SUB        SP,0x4
       01a2:87ce 8b dc           MOV        BX,SP
       01a2:87d0 90              NOP
       01a2:87d1 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:87d3 90              NOP
       01a2:87d4 9b              WAIT
       01a2:87d5 90              NOP
       01a2:87d6 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:87da 90              NOP
       01a2:87db d8 06 fa b3     FADD       float ptr [0xb3fa]
       01a2:87df 83 ec 04        SUB        SP,0x4
       01a2:87e2 8b dc           MOV        BX,SP
       01a2:87e4 90              NOP
       01a2:87e5 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:87e7 90              NOP
       01a2:87e8 9b              WAIT
       01a2:87e9 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:87ee 90              NOP
       01a2:87ef d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:87f3 90              NOP
       01a2:87f4 d8 06 fa b4     FADD       float ptr [0xb4fa]
       01a2:87f8 83 ec 04        SUB        SP,0x4
       01a2:87fb 8b dc           MOV        BX,SP
       01a2:87fd 90              NOP
       01a2:87fe d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:8800 90              NOP
       01a2:8801 9b              WAIT
       01a2:8802 90              NOP
       01a2:8803 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:8807 90              NOP
       01a2:8808 d8 06 0a b4     FADD       float ptr [0xb40a]
       01a2:880c 83 ec 04        SUB        SP,0x4
       01a2:880f 8b dc           MOV        BX,SP
       01a2:8811 90              NOP
       01a2:8812 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:8814 90              NOP
       01a2:8815 9b              WAIT
       01a2:8816 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:881b 33 c0           XOR        AX,AX
       01a2:881d 50              PUSH       AX=>DAT_0e71_18ee                                = C0h
       01a2:881e b8 ff ff        MOV        AX,0xffff
       01a2:8821 50              PUSH       AX=>DAT_0e71_18ec
       01a2:8822 33 c0           XOR        AX,AX
       01a2:8824 50              PUSH       AX=>DAT_0e71_18ea                                = B9h
       01a2:8825 9a 80 10        CALLF      LINE
                 71 0e
       01a2:882a 90              NOP
       01a2:882b d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:882f 90              NOP
       01a2:8830 d8 06 8c af     FADD       float ptr { 10.0 }
       01a2:8834 83 ec 04        SUB        SP,0x4
       01a2:8837 8b dc           MOV        BX,SP
       01a2:8839 90              NOP
       01a2:883a d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:883c 90              NOP
       01a2:883d 9b              WAIT
       01a2:883e 90              NOP
       01a2:883f d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:8843 90              NOP
       01a2:8844 d8 06 4a b4     FADD       float ptr [0xb44a]
       01a2:8848 83 ec 04        SUB        SP,0x4
       01a2:884b 8b dc           MOV        BX,SP
       01a2:884d 90              NOP
       01a2:884e d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:8850 90              NOP
       01a2:8851 9b              WAIT
       01a2:8852 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:8857 90              NOP
       01a2:8858 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:885c 90              NOP
       01a2:885d d8 06 0c a6     FADD       float ptr [0xa60c]
       01a2:8861 83 ec 04        SUB        SP,0x4
       01a2:8864 8b dc           MOV        BX,SP
       01a2:8866 90              NOP
       01a2:8867 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:8869 90              NOP
       01a2:886a 9b              WAIT
       01a2:886b 90              NOP
       01a2:886c d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:8870 90              NOP
       01a2:8871 d8 06 42 b4     FADD       float ptr [0xb442]
       01a2:8875 83 ec 04        SUB        SP,0x4
       01a2:8878 8b dc           MOV        BX,SP
       01a2:887a 90              NOP
       01a2:887b d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:887d 90              NOP
       01a2:887e 9b              WAIT
       01a2:887f 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:8884 33 c0           XOR        AX,AX
       01a2:8886 50              PUSH       AX=>DAT_0e71_18ee                                = C0h
       01a2:8887 b8 ff ff        MOV        AX,0xffff
       01a2:888a 50              PUSH       AX=>DAT_0e71_18ec
       01a2:888b 33 c0           XOR        AX,AX
       01a2:888d 50              PUSH       AX=>DAT_0e71_18ea                                = B9h
       01a2:888e 9a 80 10        CALLF      LINE
                 71 0e
       01a2:8893 90              NOP
       01a2:8894 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:8898 90              NOP
       01a2:8899 d8 06 fa b3     FADD       float ptr [0xb3fa]
       01a2:889d 83 ec 04        SUB        SP,0x4
       01a2:88a0 8b dc           MOV        BX,SP
       01a2:88a2 90              NOP
       01a2:88a3 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:88a5 90              NOP
       01a2:88a6 9b              WAIT
       01a2:88a7 90              NOP
       01a2:88a8 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:88ac 90              NOP
       01a2:88ad d8 06 4a b4     FADD       float ptr [0xb44a]
       01a2:88b1 83 ec 04        SUB        SP,0x4
       01a2:88b4 8b dc           MOV        BX,SP
       01a2:88b6 90              NOP
       01a2:88b7 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:88b9 90              NOP
       01a2:88ba 9b              WAIT
       01a2:88bb 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:88c0 90              NOP
       01a2:88c1 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:88c5 90              NOP
       01a2:88c6 d8 06 ee b3     FADD       float ptr [0xb3ee]
       01a2:88ca 83 ec 04        SUB        SP,0x4
       01a2:88cd 8b dc           MOV        BX,SP
       01a2:88cf 90              NOP
       01a2:88d0 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:88d2 90              NOP
       01a2:88d3 9b              WAIT
       01a2:88d4 90              NOP
       01a2:88d5 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:88d9 90              NOP
       01a2:88da d8 06 0a b4     FADD       float ptr [0xb40a]
       01a2:88de 83 ec 04        SUB        SP,0x4
       01a2:88e1 8b dc           MOV        BX,SP
       01a2:88e3 90              NOP
       01a2:88e4 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:88e6 90              NOP
       01a2:88e7 9b              WAIT
       01a2:88e8 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:88ed 33 c0           XOR        AX,AX
       01a2:88ef 50              PUSH       AX=>DAT_0e71_18ee                                = C0h
       01a2:88f0 b8 ff ff        MOV        AX,0xffff
       01a2:88f3 50              PUSH       AX=>DAT_0e71_18ec
       01a2:88f4 33 c0           XOR        AX,AX
       01a2:88f6 50              PUSH       AX=>DAT_0e71_18ea                                = B9h
       01a2:88f7 9a 80 10        CALLF      LINE
                 71 0e
       01a2:88fc 90              NOP
       01a2:88fd d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:8901 90              NOP
       01a2:8902 d8 06 14 a6     FADD       float ptr { 8.0 }
       01a2:8906 83 ec 04        SUB        SP,0x4
       01a2:8909 8b dc           MOV        BX,SP
       01a2:890b 90              NOP
       01a2:890c d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:890e 90              NOP
       01a2:890f 9b              WAIT
       01a2:8910 90              NOP
       01a2:8911 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:8915 90              NOP
       01a2:8916 d8 06 24 b0     FADD       float ptr { 27.0 }
       01a2:891a 83 ec 04        SUB        SP,0x4
       01a2:891d 8b dc           MOV        BX,SP
       01a2:891f 90              NOP
       01a2:8920 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:8922 90              NOP
       01a2:8923 9b              WAIT
       01a2:8924 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:8929 90              NOP
       01a2:892a d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:892e 90              NOP
       01a2:892f d8 06 20 a6     FADD       float ptr [0xa620]
       01a2:8933 83 ec 04        SUB        SP,0x4
       01a2:8936 8b dc           MOV        BX,SP
       01a2:8938 90              NOP
       01a2:8939 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:893b 90              NOP
       01a2:893c 9b              WAIT
       01a2:893d 90              NOP
       01a2:893e d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:8942 90              NOP
       01a2:8943 d8 06 0a b5     FADD       float ptr [0xb50a]
       01a2:8947 83 ec 04        SUB        SP,0x4
       01a2:894a 8b dc           MOV        BX,SP
       01a2:894c 90              NOP
       01a2:894d d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:894f 90              NOP
       01a2:8950 9b              WAIT
       01a2:8951 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:8956 33 c0           XOR        AX,AX
       01a2:8958 50              PUSH       AX=>DAT_0e71_18ee                                = C0h
       01a2:8959 b8 ff ff        MOV        AX,0xffff
       01a2:895c 50              PUSH       AX=>DAT_0e71_18ec
       01a2:895d 33 c0           XOR        AX,AX
       01a2:895f 50              PUSH       AX=>DAT_0e71_18ea                                = B9h
       01a2:8960 9a 80 10        CALLF      LINE
                 71 0e
       01a2:8965 90              NOP
       01a2:8966 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:896a 90              NOP
       01a2:896b d8 06 80 af     FADD       float ptr { 6.0 }
       01a2:896f 83 ec 04        SUB        SP,0x4
       01a2:8972 8b dc           MOV        BX,SP
       01a2:8974 90              NOP
       01a2:8975 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:8977 90              NOP
       01a2:8978 9b              WAIT
       01a2:8979 90              NOP
       01a2:897a d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:897e 90              NOP
       01a2:897f d8 06 f6 b4     FADD       float ptr [0xb4f6]
       01a2:8983 83 ec 04        SUB        SP,0x4
       01a2:8986 8b dc           MOV        BX,SP
       01a2:8988 90              NOP
       01a2:8989 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:898b 90              NOP
       01a2:898c 9b              WAIT
       01a2:898d 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:8992 90              NOP
       01a2:8993 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:8997 90              NOP
       01a2:8998 d8 06 7c a6     FADD       float ptr [0xa67c]
       01a2:899c 83 ec 04        SUB        SP,0x4
       01a2:899f 8b dc           MOV        BX,SP
       01a2:89a1 90              NOP
       01a2:89a2 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:89a4 90              NOP
       01a2:89a5 9b              WAIT
       01a2:89a6 90              NOP
       01a2:89a7 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:89ab 90              NOP
       01a2:89ac d8 06 42 b4     FADD       float ptr [0xb442]
       01a2:89b0 83 ec 04        SUB        SP,0x4
       01a2:89b3 8b dc           MOV        BX,SP
       01a2:89b5 90              NOP
       01a2:89b6 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:89b8 90              NOP
       01a2:89b9 9b              WAIT
       01a2:89ba 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:89bf 33 c0           XOR        AX,AX
       01a2:89c1 50              PUSH       AX=>DAT_0e71_18ee                                = C0h
       01a2:89c2 b8 ff ff        MOV        AX,0xffff
       01a2:89c5 50              PUSH       AX=>DAT_0e71_18ec
       01a2:89c6 33 c0           XOR        AX,AX
       01a2:89c8 50              PUSH       AX=>DAT_0e71_18ea                                = B9h
       01a2:89c9 9a 80 10        CALLF      LINE
                 71 0e
       01a2:89ce 90              NOP
       01a2:89cf d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:89d3 90              NOP
       01a2:89d4 d8 06 3e b4     FADD       float ptr [0xb43e]
       01a2:89d8 83 ec 04        SUB        SP,0x4
       01a2:89db 8b dc           MOV        BX,SP
       01a2:89dd 90              NOP
       01a2:89de d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:89e0 90              NOP
       01a2:89e1 9b              WAIT
       01a2:89e2 90              NOP
       01a2:89e3 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:89e7 90              NOP
       01a2:89e8 d8 06 24 b0     FADD       float ptr { 27.0 }
       01a2:89ec 83 ec 04        SUB        SP,0x4
       01a2:89ef 8b dc           MOV        BX,SP
       01a2:89f1 90              NOP
       01a2:89f2 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:89f4 90              NOP
       01a2:89f5 9b              WAIT
       01a2:89f6 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:89fb 90              NOP
       01a2:89fc d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:8a00 90              NOP
       01a2:8a01 d8 06 ee b3     FADD       float ptr [0xb3ee]
       01a2:8a05 83 ec 04        SUB        SP,0x4
       01a2:8a08 8b dc           MOV        BX,SP
       01a2:8a0a 90              NOP
       01a2:8a0b d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:8a0d 90              NOP
       01a2:8a0e 9b              WAIT
       01a2:8a0f 90              NOP
       01a2:8a10 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:8a14 90              NOP
       01a2:8a15 d8 06 36 b4     FADD       float ptr [0xb436]
       01a2:8a19 83 ec 04        SUB        SP,0x4
       01a2:8a1c 8b dc           MOV        BX,SP
       01a2:8a1e 90              NOP
       01a2:8a1f d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:8a21 90              NOP
       01a2:8a22 9b              WAIT
       01a2:8a23 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:8a28 33 c0           XOR        AX,AX
       01a2:8a2a 50              PUSH       AX=>DAT_0e71_18ee                                = C0h
       01a2:8a2b b8 ff ff        MOV        AX,0xffff
       01a2:8a2e 50              PUSH       AX=>DAT_0e71_18ec
       01a2:8a2f 33 c0           XOR        AX,AX
       01a2:8a31 50              PUSH       AX=>DAT_0e71_18ea                                = B9h
       01a2:8a32 9a 80 10        CALLF      LINE
                 71 0e
       01a2:8a37 90              NOP
       01a2:8a38 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:8a3c 90              NOP
       01a2:8a3d d8 06 2a b4     FADD       float ptr [0xb42a]
       01a2:8a41 83 ec 04        SUB        SP,0x4
       01a2:8a44 8b dc           MOV        BX,SP
       01a2:8a46 90              NOP
       01a2:8a47 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:8a49 90              NOP
       01a2:8a4a 9b              WAIT
       01a2:8a4b 90              NOP
       01a2:8a4c d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:8a50 90              NOP
       01a2:8a51 d8 06 4e b4     FADD       float ptr [0xb44e]
       01a2:8a55 83 ec 04        SUB        SP,0x4
       01a2:8a58 8b dc           MOV        BX,SP
       01a2:8a5a 90              NOP
       01a2:8a5b d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:8a5d 90              NOP
       01a2:8a5e 9b              WAIT
       01a2:8a5f 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:8a64 90              NOP
       01a2:8a65 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:8a69 90              NOP
       01a2:8a6a d8 06 f6 b3     FADD       float ptr [0xb3f6]
       01a2:8a6e 83 ec 04        SUB        SP,0x4
       01a2:8a71 8b dc           MOV        BX,SP
       01a2:8a73 90              NOP
       01a2:8a74 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:8a76 90              NOP
       01a2:8a77 9b              WAIT
       01a2:8a78 90              NOP
       01a2:8a79 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:8a7d 90              NOP
       01a2:8a7e d8 06 42 b4     FADD       float ptr [0xb442]
       01a2:8a82 83 ec 04        SUB        SP,0x4
       01a2:8a85 8b dc           MOV        BX,SP
       01a2:8a87 90              NOP
       01a2:8a88 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:8a8a 90              NOP
       01a2:8a8b 9b              WAIT
       01a2:8a8c 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:8a91 33 c0           XOR        AX,AX
       01a2:8a93 50              PUSH       AX=>DAT_0e71_18ee                                = C0h
       01a2:8a94 b8 ff ff        MOV        AX,0xffff
       01a2:8a97 50              PUSH       AX=>DAT_0e71_18ec
       01a2:8a98 33 c0           XOR        AX,AX
       01a2:8a9a 50              PUSH       AX=>DAT_0e71_18ea                                = B9h
       01a2:8a9b 9a 80 10        CALLF      LINE
                 71 0e
       01a2:8aa0 90              NOP
       01a2:8aa1 d9 06 50 a5     FLD        float ptr { 1.0 }
       01a2:8aa5 e9 69 05        JMP        LAB_01a2_9011
                             LAB_01a2_8aa8                                   XREF[1]:     01a2:902b(j)  
       01a2:8aa8 9a 48 7d        CALLF      RND
                 71 0e
       01a2:8aad 8b f0           MOV        SI,AX
       01a2:8aaf 90              NOP
       01a2:8ab0 d9 04           FLD        float ptr [SI]
       01a2:8ab2 90              NOP
       01a2:8ab3 d8 0e 0e b5     FMUL       float ptr [0xb50e]
       01a2:8ab7 90              NOP
       01a2:8ab8 d8 06 b0 a6     FADD       float ptr [0xa6b0]
       01a2:8abc 90              NOP
       01a2:8abd d9 1e 3e a2     FSTP       float ptr [0xa23e]
       01a2:8ac1 90              NOP
       01a2:8ac2 9b              WAIT
       01a2:8ac3 90              NOP
       01a2:8ac4 d9 06 3e a2     FLD        float ptr [0xa23e]
       01a2:8ac8 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:8acd 50              PUSH       AX=>DAT_0e71_18ee                                = C0h
       01a2:8ace ff 36 52 a5     PUSH       word ptr [0xa552]=>DAT_0e71_18ec
       01a2:8ad2 ff 36 50 a5     PUSH       word ptr { 1.0 }=>DAT_0e71_18ea                 = B9h
       01a2:8ad6 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:8adb 90              NOP
       01a2:8adc d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:8ae0 90              NOP
       01a2:8ae1 d8 06 5e b4     FADD       float ptr [0xb45e]
       01a2:8ae5 83 ec 04        SUB        SP,0x4
       01a2:8ae8 8b dc           MOV        BX,SP
       01a2:8aea 90              NOP
       01a2:8aeb d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:8aed 90              NOP
       01a2:8aee 9b              WAIT
       01a2:8aef 90              NOP
       01a2:8af0 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:8af4 90              NOP
       01a2:8af5 d8 06 0e b4     FADD       float ptr [0xb40e]
       01a2:8af9 83 ec 04        SUB        SP,0x4
       01a2:8afc 8b dc           MOV        BX,SP
       01a2:8afe 90              NOP
       01a2:8aff d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:8b01 90              NOP
       01a2:8b02 9b              WAIT
       01a2:8b03 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:8b08 b8 0f 00        MOV        AX,0xf
       01a2:8b0b 50              PUSH       AX=>DAT_0e71_18ee                                = C0h
       01a2:8b0c 9a 74 12        CALLF      SUB_0e71_1274
                 71 0e
       01a2:8b11 90              NOP
       01a2:8b12 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:8b16 90              NOP
       01a2:8b17 d8 06 12 b4     FADD       float ptr [0xb412]
       01a2:8b1b 83 ec 04        SUB        SP,0x4
       01a2:8b1e 8b dc           MOV        BX,SP
       01a2:8b20 90              NOP
       01a2:8b21 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:8b23 90              NOP
       01a2:8b24 9b              WAIT
       01a2:8b25 90              NOP
       01a2:8b26 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:8b2a 90              NOP
       01a2:8b2b d8 06 0e b4     FADD       float ptr [0xb40e]
       01a2:8b2f 83 ec 04        SUB        SP,0x4
       01a2:8b32 8b dc           MOV        BX,SP
       01a2:8b34 90              NOP
       01a2:8b35 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:8b37 90              NOP
       01a2:8b38 9b              WAIT
       01a2:8b39 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:8b3e b8 0f 00        MOV        AX,0xf
       01a2:8b41 50              PUSH       AX=>DAT_0e71_18ee                                = C0h
       01a2:8b42 9a 74 12        CALLF      SUB_0e71_1274
                 71 0e
       01a2:8b47 90              NOP
       01a2:8b48 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:8b4c 90              NOP
       01a2:8b4d d8 06 3a b4     FADD       float ptr [0xb43a]
       01a2:8b51 83 ec 04        SUB        SP,0x4
       01a2:8b54 8b dc           MOV        BX,SP
       01a2:8b56 90              NOP
       01a2:8b57 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:8b59 90              NOP
       01a2:8b5a 9b              WAIT
       01a2:8b5b 90              NOP
       01a2:8b5c d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:8b60 90              NOP
       01a2:8b61 d8 06 0e b4     FADD       float ptr [0xb40e]
       01a2:8b65 83 ec 04        SUB        SP,0x4
       01a2:8b68 8b dc           MOV        BX,SP
       01a2:8b6a 90              NOP
       01a2:8b6b d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:8b6d 90              NOP
       01a2:8b6e 9b              WAIT
       01a2:8b6f 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:8b74 33 c0           XOR        AX,AX
       01a2:8b76 50              PUSH       AX=>DAT_0e71_18ee                                = C0h
       01a2:8b77 9a 74 12        CALLF      SUB_0e71_1274
                 71 0e
       01a2:8b7c 90              NOP
       01a2:8b7d d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:8b81 90              NOP
       01a2:8b82 d8 06 ca b4     FADD       float ptr [0xb4ca]
       01a2:8b86 83 ec 04        SUB        SP,0x4
       01a2:8b89 8b dc           MOV        BX,SP
       01a2:8b8b 90              NOP
       01a2:8b8c d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:8b8e 90              NOP
       01a2:8b8f 9b              WAIT
       01a2:8b90 90              NOP
       01a2:8b91 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:8b95 90              NOP
       01a2:8b96 d8 06 0e b4     FADD       float ptr [0xb40e]
       01a2:8b9a 83 ec 04        SUB        SP,0x4
       01a2:8b9d 8b dc           MOV        BX,SP
       01a2:8b9f 90              NOP
       01a2:8ba0 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:8ba2 90              NOP
       01a2:8ba3 9b              WAIT
       01a2:8ba4 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:8ba9 33 c0           XOR        AX,AX
       01a2:8bab 50              PUSH       AX=>DAT_0e71_18ee                                = C0h
       01a2:8bac 9a 74 12        CALLF      SUB_0e71_1274
                 71 0e
       01a2:8bb1 90              NOP
       01a2:8bb2 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:8bb6 90              NOP
       01a2:8bb7 d8 06 5a b4     FADD       float ptr [0xb45a]
       01a2:8bbb 83 ec 04        SUB        SP,0x4
       01a2:8bbe 8b dc           MOV        BX,SP
       01a2:8bc0 90              NOP
       01a2:8bc1 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:8bc3 90              NOP
       01a2:8bc4 9b              WAIT
       01a2:8bc5 90              NOP
       01a2:8bc6 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:8bca 90              NOP
       01a2:8bcb d8 06 f6 b3     FADD       float ptr [0xb3f6]
       01a2:8bcf 83 ec 04        SUB        SP,0x4
       01a2:8bd2 8b dc           MOV        BX,SP
       01a2:8bd4 90              NOP
       01a2:8bd5 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:8bd7 90              NOP
       01a2:8bd8 9b              WAIT
       01a2:8bd9 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:8bde ff 36 26 a6     PUSH       word ptr [0xa626]=>DAT_0e71_18ee                 = C0h
       01a2:8be2 ff 36 24 a6     PUSH       word ptr { 3.0 }=>DAT_0e71_18ec
       01a2:8be6 b8 07 00        MOV        AX,0x7
       01a2:8be9 50              PUSH       AX=>DAT_0e71_18ea                                = B9h
       01a2:8bea 9a b4 0d        CALLF      CIRCLE
                 71 0e
       01a2:8bef 90              NOP
       01a2:8bf0 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:8bf4 90              NOP
       01a2:8bf5 d8 06 5a b4     FADD       float ptr [0xb45a]
       01a2:8bf9 83 ec 04        SUB        SP,0x4
       01a2:8bfc 8b dc           MOV        BX,SP
       01a2:8bfe 90              NOP
       01a2:8bff d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:8c01 90              NOP
       01a2:8c02 9b              WAIT
       01a2:8c03 90              NOP
       01a2:8c04 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:8c08 90              NOP
       01a2:8c09 d8 06 f6 b3     FADD       float ptr [0xb3f6]
       01a2:8c0d 83 ec 04        SUB        SP,0x4
       01a2:8c10 8b dc           MOV        BX,SP
       01a2:8c12 90              NOP
       01a2:8c13 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:8c15 90              NOP
       01a2:8c16 9b              WAIT
       01a2:8c17 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:8c1c b8 07 00        MOV        AX,0x7
       01a2:8c1f 50              PUSH       AX=>DAT_0e71_18ee                                = C0h
       01a2:8c20 50              PUSH       AX=>DAT_0e71_18ec
       01a2:8c21 9a 35 17        CALLF      PAINT
                 71 0e
       01a2:8c26 90              NOP
       01a2:8c27 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:8c2b 90              NOP
       01a2:8c2c d8 06 ce b4     FADD       float ptr [0xb4ce]
       01a2:8c30 83 ec 04        SUB        SP,0x4
       01a2:8c33 8b dc           MOV        BX,SP
       01a2:8c35 90              NOP
       01a2:8c36 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:8c38 90              NOP
       01a2:8c39 9b              WAIT
       01a2:8c3a 90              NOP
       01a2:8c3b d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:8c3f 90              NOP
       01a2:8c40 d8 06 f6 b3     FADD       float ptr [0xb3f6]
       01a2:8c44 83 ec 04        SUB        SP,0x4
       01a2:8c47 8b dc           MOV        BX,SP
       01a2:8c49 90              NOP
       01a2:8c4a d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:8c4c 90              NOP
       01a2:8c4d 9b              WAIT
       01a2:8c4e 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:8c53 ff 36 26 a6     PUSH       word ptr [0xa626]=>DAT_0e71_18ee                 = C0h
       01a2:8c57 ff 36 24 a6     PUSH       word ptr { 3.0 }=>DAT_0e71_18ec
       01a2:8c5b b8 07 00        MOV        AX,0x7
       01a2:8c5e 50              PUSH       AX=>DAT_0e71_18ea                                = B9h
       01a2:8c5f 9a b4 0d        CALLF      CIRCLE
                 71 0e
       01a2:8c64 90              NOP
       01a2:8c65 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:8c69 90              NOP
       01a2:8c6a d8 06 ce b4     FADD       float ptr [0xb4ce]
       01a2:8c6e 83 ec 04        SUB        SP,0x4
       01a2:8c71 8b dc           MOV        BX,SP
       01a2:8c73 90              NOP
       01a2:8c74 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:8c76 90              NOP
       01a2:8c77 9b              WAIT
       01a2:8c78 90              NOP
       01a2:8c79 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:8c7d 90              NOP
       01a2:8c7e d8 06 f6 b3     FADD       float ptr [0xb3f6]
       01a2:8c82 83 ec 04        SUB        SP,0x4
       01a2:8c85 8b dc           MOV        BX,SP
       01a2:8c87 90              NOP
       01a2:8c88 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:8c8a 90              NOP
       01a2:8c8b 9b              WAIT
       01a2:8c8c 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:8c91 b8 07 00        MOV        AX,0x7
       01a2:8c94 50              PUSH       AX=>DAT_0e71_18ee                                = C0h
       01a2:8c95 50              PUSH       AX=>DAT_0e71_18ec
       01a2:8c96 9a 35 17        CALLF      PAINT
                 71 0e
       01a2:8c9b 90              NOP
       01a2:8c9c d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:8ca0 90              NOP
       01a2:8ca1 d8 06 f6 b4     FADD       float ptr [0xb4f6]
       01a2:8ca5 83 ec 04        SUB        SP,0x4
       01a2:8ca8 8b dc           MOV        BX,SP
       01a2:8caa 90              NOP
       01a2:8cab d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:8cad 90              NOP
       01a2:8cae 9b              WAIT
       01a2:8caf 90              NOP
       01a2:8cb0 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:8cb4 90              NOP
       01a2:8cb5 d8 06 24 b0     FADD       float ptr { 27.0 }
       01a2:8cb9 83 ec 04        SUB        SP,0x4
       01a2:8cbc 8b dc           MOV        BX,SP
       01a2:8cbe 90              NOP
       01a2:8cbf d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:8cc1 90              NOP
       01a2:8cc2 9b              WAIT
       01a2:8cc3 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:8cc8 90              NOP
       01a2:8cc9 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:8ccd 90              NOP
       01a2:8cce d8 06 10 a6     FADD       float ptr { 18.0 }
       01a2:8cd2 83 ec 04        SUB        SP,0x4
       01a2:8cd5 8b dc           MOV        BX,SP
       01a2:8cd7 90              NOP
       01a2:8cd8 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:8cda 90              NOP
       01a2:8cdb 9b              WAIT
       01a2:8cdc 90              NOP
       01a2:8cdd d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:8ce1 90              NOP
       01a2:8ce2 d8 06 46 b4     FADD       float ptr [0xb446]
       01a2:8ce6 83 ec 04        SUB        SP,0x4
       01a2:8ce9 8b dc           MOV        BX,SP
       01a2:8ceb 90              NOP
       01a2:8cec d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:8cee 90              NOP
       01a2:8cef 9b              WAIT
       01a2:8cf0 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:8cf5 b8 07 00        MOV        AX,0x7
       01a2:8cf8 50              PUSH       AX=>DAT_0e71_18ee                                = C0h
       01a2:8cf9 b8 ff ff        MOV        AX,0xffff
       01a2:8cfc 50              PUSH       AX=>DAT_0e71_18ec
       01a2:8cfd 33 c0           XOR        AX,AX
       01a2:8cff 50              PUSH       AX=>DAT_0e71_18ea                                = B9h
       01a2:8d00 9a 80 10        CALLF      LINE
                 71 0e
       01a2:8d05 90              NOP
       01a2:8d06 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:8d0a 90              NOP
       01a2:8d0b d8 06 f6 b4     FADD       float ptr [0xb4f6]
       01a2:8d0f 83 ec 04        SUB        SP,0x4
       01a2:8d12 8b dc           MOV        BX,SP
       01a2:8d14 90              NOP
       01a2:8d15 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:8d17 90              NOP
       01a2:8d18 9b              WAIT
       01a2:8d19 90              NOP
       01a2:8d1a d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:8d1e 90              NOP
       01a2:8d1f d8 06 24 b0     FADD       float ptr { 27.0 }
       01a2:8d23 83 ec 04        SUB        SP,0x4
       01a2:8d26 8b dc           MOV        BX,SP
       01a2:8d28 90              NOP
       01a2:8d29 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:8d2b 90              NOP
       01a2:8d2c 9b              WAIT
       01a2:8d2d 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:8d32 90              NOP
       01a2:8d33 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:8d37 90              NOP
       01a2:8d38 d8 06 62 b4     FADD       float ptr [0xb462]
       01a2:8d3c 83 ec 04        SUB        SP,0x4
       01a2:8d3f 8b dc           MOV        BX,SP
       01a2:8d41 90              NOP
       01a2:8d42 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:8d44 90              NOP
       01a2:8d45 9b              WAIT
       01a2:8d46 90              NOP
       01a2:8d47 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:8d4b 90              NOP
       01a2:8d4c d8 06 46 b4     FADD       float ptr [0xb446]
       01a2:8d50 83 ec 04        SUB        SP,0x4
       01a2:8d53 8b dc           MOV        BX,SP
       01a2:8d55 90              NOP
       01a2:8d56 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:8d58 90              NOP
       01a2:8d59 9b              WAIT
       01a2:8d5a 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:8d5f b8 07 00        MOV        AX,0x7
       01a2:8d62 50              PUSH       AX=>DAT_0e71_18ee                                = C0h
       01a2:8d63 b8 ff ff        MOV        AX,0xffff
       01a2:8d66 50              PUSH       AX=>DAT_0e71_18ec
       01a2:8d67 33 c0           XOR        AX,AX
       01a2:8d69 50              PUSH       AX=>DAT_0e71_18ea                                = B9h
       01a2:8d6a 9a 80 10        CALLF      LINE
                 71 0e
       01a2:8d6f e8 1e af        CALL       FUN_01a2_3c90                                    undefined FUN_01a2_3c90()
       01a2:8d72 90              NOP
       01a2:8d73 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:8d77 90              NOP
       01a2:8d78 d8 06 5e b4     FADD       float ptr [0xb45e]
       01a2:8d7c 83 ec 04        SUB        SP,0x4
       01a2:8d7f 8b dc           MOV        BX,SP
       01a2:8d81 90              NOP
       01a2:8d82 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:8d84 90              NOP
       01a2:8d85 9b              WAIT
       01a2:8d86 90              NOP
       01a2:8d87 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:8d8b 90              NOP
       01a2:8d8c d8 06 0e b4     FADD       float ptr [0xb40e]
       01a2:8d90 83 ec 04        SUB        SP,0x4
       01a2:8d93 8b dc           MOV        BX,SP
       01a2:8d95 90              NOP
       01a2:8d96 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:8d98 90              NOP
       01a2:8d99 9b              WAIT
       01a2:8d9a 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:8d9f 33 c0           XOR        AX,AX
       01a2:8da1 50              PUSH       AX=>DAT_0e71_18ee                                = C0h
       01a2:8da2 9a 74 12        CALLF      SUB_0e71_1274
                 71 0e
       01a2:8da7 90              NOP
       01a2:8da8 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:8dac 90              NOP
       01a2:8dad d8 06 12 b4     FADD       float ptr [0xb412]
       01a2:8db1 83 ec 04        SUB        SP,0x4
       01a2:8db4 8b dc           MOV        BX,SP
       01a2:8db6 90              NOP
       01a2:8db7 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:8db9 90              NOP
       01a2:8dba 9b              WAIT
       01a2:8dbb 90              NOP
       01a2:8dbc d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:8dc0 90              NOP
       01a2:8dc1 d8 06 0e b4     FADD       float ptr [0xb40e]
       01a2:8dc5 83 ec 04        SUB        SP,0x4
       01a2:8dc8 8b dc           MOV        BX,SP
       01a2:8dca 90              NOP
       01a2:8dcb d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:8dcd 90              NOP
       01a2:8dce 9b              WAIT
       01a2:8dcf 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:8dd4 33 c0           XOR        AX,AX
       01a2:8dd6 50              PUSH       AX=>DAT_0e71_18ee                                = C0h
       01a2:8dd7 9a 74 12        CALLF      SUB_0e71_1274
                 71 0e
       01a2:8ddc 90              NOP
       01a2:8ddd d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:8de1 90              NOP
       01a2:8de2 d8 06 3a b4     FADD       float ptr [0xb43a]
       01a2:8de6 83 ec 04        SUB        SP,0x4
       01a2:8de9 8b dc           MOV        BX,SP
       01a2:8deb 90              NOP
       01a2:8dec d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:8dee 90              NOP
       01a2:8def 9b              WAIT
       01a2:8df0 90              NOP
       01a2:8df1 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:8df5 90              NOP
       01a2:8df6 d8 06 0e b4     FADD       float ptr [0xb40e]
       01a2:8dfa 83 ec 04        SUB        SP,0x4
       01a2:8dfd 8b dc           MOV        BX,SP
       01a2:8dff 90              NOP
       01a2:8e00 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:8e02 90              NOP
       01a2:8e03 9b              WAIT
       01a2:8e04 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:8e09 b8 0f 00        MOV        AX,0xf
       01a2:8e0c 50              PUSH       AX=>DAT_0e71_18ee                                = C0h
       01a2:8e0d 9a 74 12        CALLF      SUB_0e71_1274
                 71 0e
       01a2:8e12 90              NOP
       01a2:8e13 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:8e17 90              NOP
       01a2:8e18 d8 06 ca b4     FADD       float ptr [0xb4ca]
       01a2:8e1c 83 ec 04        SUB        SP,0x4
       01a2:8e1f 8b dc           MOV        BX,SP
       01a2:8e21 90              NOP
       01a2:8e22 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:8e24 90              NOP
       01a2:8e25 9b              WAIT
       01a2:8e26 90              NOP
       01a2:8e27 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:8e2b 90              NOP
       01a2:8e2c d8 06 0e b4     FADD       float ptr [0xb40e]
       01a2:8e30 83 ec 04        SUB        SP,0x4
       01a2:8e33 8b dc           MOV        BX,SP
       01a2:8e35 90              NOP
       01a2:8e36 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:8e38 90              NOP
       01a2:8e39 9b              WAIT
       01a2:8e3a 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:8e3f b8 0f 00        MOV        AX,0xf
       01a2:8e42 50              PUSH       AX=>DAT_0e71_18ee                                = C0h
       01a2:8e43 9a 74 12        CALLF      SUB_0e71_1274
                 71 0e
       01a2:8e48 90              NOP
       01a2:8e49 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:8e4d 90              NOP
       01a2:8e4e d8 06 f6 b4     FADD       float ptr [0xb4f6]
       01a2:8e52 83 ec 04        SUB        SP,0x4
       01a2:8e55 8b dc           MOV        BX,SP
       01a2:8e57 90              NOP
       01a2:8e58 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:8e5a 90              NOP
       01a2:8e5b 9b              WAIT
       01a2:8e5c 90              NOP
       01a2:8e5d d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:8e61 90              NOP
       01a2:8e62 d8 06 24 b0     FADD       float ptr { 27.0 }
       01a2:8e66 83 ec 04        SUB        SP,0x4
       01a2:8e69 8b dc           MOV        BX,SP
       01a2:8e6b 90              NOP
       01a2:8e6c d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:8e6e 90              NOP
       01a2:8e6f 9b              WAIT
       01a2:8e70 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:8e75 90              NOP
       01a2:8e76 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:8e7a 90              NOP
       01a2:8e7b d8 06 10 a6     FADD       float ptr { 18.0 }
       01a2:8e7f 83 ec 04        SUB        SP,0x4
       01a2:8e82 8b dc           MOV        BX,SP
       01a2:8e84 90              NOP
       01a2:8e85 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:8e87 90              NOP
       01a2:8e88 9b              WAIT
       01a2:8e89 90              NOP
       01a2:8e8a d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:8e8e 90              NOP
       01a2:8e8f d8 06 46 b4     FADD       float ptr [0xb446]
       01a2:8e93 83 ec 04        SUB        SP,0x4
       01a2:8e96 8b dc           MOV        BX,SP
       01a2:8e98 90              NOP
       01a2:8e99 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:8e9b 90              NOP
       01a2:8e9c 9b              WAIT
       01a2:8e9d 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:8ea2 33 c0           XOR        AX,AX
       01a2:8ea4 50              PUSH       AX=>DAT_0e71_18ee                                = C0h
       01a2:8ea5 b8 ff ff        MOV        AX,0xffff
       01a2:8ea8 50              PUSH       AX=>DAT_0e71_18ec
       01a2:8ea9 33 c0           XOR        AX,AX
       01a2:8eab 50              PUSH       AX=>DAT_0e71_18ea                                = B9h
       01a2:8eac 9a 80 10        CALLF      LINE
                 71 0e
       01a2:8eb1 90              NOP
       01a2:8eb2 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:8eb6 90              NOP
       01a2:8eb7 d8 06 f6 b4     FADD       float ptr [0xb4f6]
       01a2:8ebb 83 ec 04        SUB        SP,0x4
       01a2:8ebe 8b dc           MOV        BX,SP
       01a2:8ec0 90              NOP
       01a2:8ec1 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:8ec3 90              NOP
       01a2:8ec4 9b              WAIT
       01a2:8ec5 90              NOP
       01a2:8ec6 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:8eca 90              NOP
       01a2:8ecb d8 06 24 b0     FADD       float ptr { 27.0 }
       01a2:8ecf 83 ec 04        SUB        SP,0x4
       01a2:8ed2 8b dc           MOV        BX,SP
       01a2:8ed4 90              NOP
       01a2:8ed5 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:8ed7 90              NOP
       01a2:8ed8 9b              WAIT
       01a2:8ed9 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:8ede 90              NOP
       01a2:8edf d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:8ee3 90              NOP
       01a2:8ee4 d8 06 62 b4     FADD       float ptr [0xb462]
       01a2:8ee8 83 ec 04        SUB        SP,0x4
       01a2:8eeb 8b dc           MOV        BX,SP
       01a2:8eed 90              NOP
       01a2:8eee d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:8ef0 90              NOP
       01a2:8ef1 9b              WAIT
       01a2:8ef2 90              NOP
       01a2:8ef3 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:8ef7 90              NOP
       01a2:8ef8 d8 06 46 b4     FADD       float ptr [0xb446]
       01a2:8efc 83 ec 04        SUB        SP,0x4
       01a2:8eff 8b dc           MOV        BX,SP
       01a2:8f01 90              NOP
       01a2:8f02 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:8f04 90              NOP
       01a2:8f05 9b              WAIT
       01a2:8f06 9a cd 5b        CALLF      GRAPHICS_setpt2_float
                 71 0e
       01a2:8f0b 33 c0           XOR        AX,AX
       01a2:8f0d 50              PUSH       AX=>DAT_0e71_18ee                                = C0h
       01a2:8f0e b8 ff ff        MOV        AX,0xffff
       01a2:8f11 50              PUSH       AX=>DAT_0e71_18ec
       01a2:8f12 33 c0           XOR        AX,AX
       01a2:8f14 50              PUSH       AX=>DAT_0e71_18ea                                = B9h
       01a2:8f15 9a 80 10        CALLF      LINE
                 71 0e
       01a2:8f1a 90              NOP
       01a2:8f1b d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:8f1f 90              NOP
       01a2:8f20 d8 06 5a b4     FADD       float ptr [0xb45a]
       01a2:8f24 83 ec 04        SUB        SP,0x4
       01a2:8f27 8b dc           MOV        BX,SP
       01a2:8f29 90              NOP
       01a2:8f2a d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:8f2c 90              NOP
       01a2:8f2d 9b              WAIT
       01a2:8f2e 90              NOP
       01a2:8f2f d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:8f33 90              NOP
       01a2:8f34 d8 06 f6 b3     FADD       float ptr [0xb3f6]
       01a2:8f38 83 ec 04        SUB        SP,0x4
       01a2:8f3b 8b dc           MOV        BX,SP
       01a2:8f3d 90              NOP
       01a2:8f3e d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:8f40 90              NOP
       01a2:8f41 9b              WAIT
       01a2:8f42 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:8f47 ff 36 26 a6     PUSH       word ptr [0xa626]=>DAT_0e71_18ee                 = C0h
       01a2:8f4b ff 36 24 a6     PUSH       word ptr { 3.0 }=>DAT_0e71_18ec
       01a2:8f4f b8 05 00        MOV        AX,0x5
       01a2:8f52 50              PUSH       AX=>DAT_0e71_18ea                                = B9h
       01a2:8f53 9a b4 0d        CALLF      CIRCLE
                 71 0e
       01a2:8f58 90              NOP
       01a2:8f59 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:8f5d 90              NOP
       01a2:8f5e d8 06 5a b4     FADD       float ptr [0xb45a]
       01a2:8f62 83 ec 04        SUB        SP,0x4
       01a2:8f65 8b dc           MOV        BX,SP
       01a2:8f67 90              NOP
       01a2:8f68 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:8f6a 90              NOP
       01a2:8f6b 9b              WAIT
       01a2:8f6c 90              NOP
       01a2:8f6d d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:8f71 90              NOP
       01a2:8f72 d8 06 f6 b3     FADD       float ptr [0xb3f6]
       01a2:8f76 83 ec 04        SUB        SP,0x4
       01a2:8f79 8b dc           MOV        BX,SP
       01a2:8f7b 90              NOP
       01a2:8f7c d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:8f7e 90              NOP
       01a2:8f7f 9b              WAIT
       01a2:8f80 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:8f85 b8 05 00        MOV        AX,0x5
       01a2:8f88 50              PUSH       AX=>DAT_0e71_18ee                                = C0h
       01a2:8f89 50              PUSH       AX=>DAT_0e71_18ec
       01a2:8f8a 9a 35 17        CALLF      PAINT
                 71 0e
       01a2:8f8f 90              NOP
       01a2:8f90 d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:8f94 90              NOP
       01a2:8f95 d8 06 ce b4     FADD       float ptr [0xb4ce]
       01a2:8f99 83 ec 04        SUB        SP,0x4
       01a2:8f9c 8b dc           MOV        BX,SP
       01a2:8f9e 90              NOP
       01a2:8f9f d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:8fa1 90              NOP
       01a2:8fa2 9b              WAIT
       01a2:8fa3 90              NOP
       01a2:8fa4 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:8fa8 90              NOP
       01a2:8fa9 d8 06 f6 b3     FADD       float ptr [0xb3f6]
       01a2:8fad 83 ec 04        SUB        SP,0x4
       01a2:8fb0 8b dc           MOV        BX,SP
       01a2:8fb2 90              NOP
       01a2:8fb3 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:8fb5 90              NOP
       01a2:8fb6 9b              WAIT
       01a2:8fb7 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:8fbc ff 36 26 a6     PUSH       word ptr [0xa626]=>DAT_0e71_18ee                 = C0h
       01a2:8fc0 ff 36 24 a6     PUSH       word ptr { 3.0 }=>DAT_0e71_18ec
       01a2:8fc4 b8 05 00        MOV        AX,0x5
       01a2:8fc7 50              PUSH       AX=>DAT_0e71_18ea                                = B9h
       01a2:8fc8 9a b4 0d        CALLF      CIRCLE
                 71 0e
       01a2:8fcd 90              NOP
       01a2:8fce d9 06 2e a2     FLD        float ptr [0xa22e]
       01a2:8fd2 90              NOP
       01a2:8fd3 d8 06 ce b4     FADD       float ptr [0xb4ce]
       01a2:8fd7 83 ec 04        SUB        SP,0x4
       01a2:8fda 8b dc           MOV        BX,SP
       01a2:8fdc 90              NOP
       01a2:8fdd d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18ec
       01a2:8fdf 90              NOP
       01a2:8fe0 9b              WAIT
       01a2:8fe1 90              NOP
       01a2:8fe2 d9 06 32 a2     FLD        float ptr [0xa232]
       01a2:8fe6 90              NOP
       01a2:8fe7 d8 06 f6 b3     FADD       float ptr [0xb3f6]
       01a2:8feb 83 ec 04        SUB        SP,0x4
       01a2:8fee 8b dc           MOV        BX,SP
       01a2:8ff0 90              NOP
       01a2:8ff1 d9 1f           FSTP       float ptr [BX]=>DAT_0e71_18e8                    = 9Eh
       01a2:8ff3 90              NOP
       01a2:8ff4 9b              WAIT
       01a2:8ff5 9a b5 5b        CALLF      GRAPHICS_setpt1_float
                 71 0e
       01a2:8ffa b8 05 00        MOV        AX,0x5
       01a2:8ffd 50              PUSH       AX=>DAT_0e71_18ee                                = C0h
       01a2:8ffe 50              PUSH       AX=>DAT_0e71_18ec
       01a2:8fff 9a 35 17        CALLF      PAINT
                 71 0e
       01a2:9004 e8 89 ac        CALL       FUN_01a2_3c90                                    undefined FUN_01a2_3c90()
       01a2:9007 90              NOP
       01a2:9008 d9 06 96 a4     FLD        float ptr [0xa496]
       01a2:900c 90              NOP
       01a2:900d d8 06 50 a5     FADD       float ptr { 1.0 }
                             LAB_01a2_9011                                   XREF[1]:     01a2:8aa5(j)  
       01a2:9011 90              NOP
       01a2:9012 d9 1e 96 a4     FSTP       float ptr [0xa496]
       01a2:9016 90              NOP
       01a2:9017 9b              WAIT
       01a2:9018 90              NOP
       01a2:9019 d9 06 7c af     FLD        float ptr { 5.0 }
       01a2:901d 90              NOP
       01a2:901e d9 06 96 a4     FLD        float ptr [0xa496]
       01a2:9022 90              NOP
       01a2:9023 9b              WAIT
       01a2:9024 9a 1d 04        CALLF      FPCOMPARE_2stack                                 undefined FPCOMPARE_2stack()
                 75 0d
       01a2:9029 77 03           JA         LAB_01a2_902e
       01a2:902b e9 7a fa        JMP        LAB_01a2_8aa8
                             LAB_01a2_902e                                   XREF[1]:     01a2:9029(j)  
       01a2:902e c3              RET
                             **************************************************************
                             *                          FUNCTION                          *
                             **************************************************************
                             undefined FUN_01a2_902f()
                               assume DS = 0x1997
             undefined         <UNASSIGNED>   <RETURN>
                             FUN_01a2_902f                                   XREF[1]:     FUN_01a2_19fa:01a2:28ea(c)  
       01a2:902f 90              NOP
       01a2:9030 d9 06 a6 b4     FLD        float ptr [0xb4a6]
       01a2:9034 e9 23 00        JMP        LAB_01a2_905a
       01a2:9037 90              ??         90h
                             LAB_01a2_9038                                   XREF[1]:     01a2:9072(j)  
       01a2:9038 90              NOP
       01a2:9039 d9 06 96 a4     FLD        float ptr [0xa496]
       01a2:903d 9a d8 03        CALLF      Implicit_FP_to_INT                                    undefined Implicit_FP_to_INT()
                 75 0d
       01a2:9042 50              PUSH       AX
       01a2:9043 ff 36 52 a5     PUSH       word ptr [0xa552]
       01a2:9047 ff 36 50 a5     PUSH       word ptr { 1.0 }
       01a2:904b 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:9050 90              NOP
       01a2:9051 d9 06 96 a4     FLD        float ptr [0xa496]
       01a2:9055 90              NOP
       01a2:9056 d8 06 12 b5     FADD       float ptr [0xb512]
                             LAB_01a2_905a                                   XREF[1]:     01a2:9034(j)  
       01a2:905a 90              NOP
       01a2:905b d9 1e 96 a4     FSTP       float ptr [0xa496]
       01a2:905f 90              NOP
       01a2:9060 9b              WAIT
       01a2:9061 90              NOP
       01a2:9062 d9 06 7a b4     FLD        float ptr [0xb47a]
       01a2:9066 90              NOP
       01a2:9067 d9 06 96 a4     FLD        float ptr [0xa496]
       01a2:906b 90              NOP
       01a2:906c 9b              WAIT
       01a2:906d 9a 1d 04        CALLF      FPCOMPARE_2stack                                 undefined FPCOMPARE_2stack()
                 75 0d
       01a2:9072 73 c4           JNC        LAB_01a2_9038
       01a2:9074 9a 00 07        CALLF      TIMER                                            undefined TIMER()
                 71 0e
       01a2:9079 8b f0           MOV        SI,AX
       01a2:907b 90              NOP
       01a2:907c d9 04           FLD        float ptr [SI]
       01a2:907e 90              NOP
       01a2:907f d8 06 f6 b4     FADD       float ptr [0xb4f6]
       01a2:9083 90              NOP
       01a2:9084 d9 1e ae a4     FSTP       float ptr [0xa4ae]
       01a2:9088 90              NOP
       01a2:9089 9b              WAIT
       01a2:908a b8 16 b5        MOV        AX,0xb516
       01a2:908d 50              PUSH       AX
       01a2:908e b8 c6 a4        MOV        AX,0xa4c6
       01a2:9091 50              PUSH       AX
       01a2:9092 9a 78 7c        CALLF      SET_STRING
                 71 0e
       01a2:9097 b8 40 b5        MOV        AX,0xb540
       01a2:909a 50              PUSH       AX
       01a2:909b b8 ca a4        MOV        AX,0xa4ca
       01a2:909e 50              PUSH       AX
       01a2:909f 9a 78 7c        CALLF      SET_STRING
                 71 0e
       01a2:90a4 e8 12 2a        CALL       FUN_01a2_bab9                                    undefined FUN_01a2_bab9()
       01a2:90a7 e8 cc 9c        CALL       FUN_01a2_2d76                                    undefined FUN_01a2_2d76()
       01a2:90aa e9 cb 8d        JMP        LAB_01a2_1e78
                             **************************************************************
                             *                          FUNCTION                          *
                             **************************************************************
                             undefined FUN_01a2_90ad()
                               assume DS = 0x1997
             undefined         <UNASSIGNED>   <RETURN>
                             FUN_01a2_90ad                                   XREF[1]:     FUN_01a2_19fa:01a2:29d0(c)  
       01a2:90ad b8 d0 07        MOV        AX,0x7d0
       01a2:90b0 50              PUSH       AX
       01a2:90b1 ff 36 26 a6     PUSH       word ptr [0xa626]
       01a2:90b5 ff 36 24 a6     PUSH       word ptr { 3.0 }
       01a2:90b9 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:90be 9a 00 07        CALLF      TIMER                                            undefined TIMER()
                 71 0e
       01a2:90c3 8b f0           MOV        SI,AX
       01a2:90c5 90              NOP
       01a2:90c6 d9 04           FLD        float ptr [SI]
       01a2:90c8 90              NOP
       01a2:90c9 d8 06 f6 b4     FADD       float ptr [0xb4f6]
       01a2:90cd 90              NOP
       01a2:90ce d9 1e ae a4     FSTP       float ptr [0xa4ae]
       01a2:90d2 90              NOP
       01a2:90d3 9b              WAIT
       01a2:90d4 b8 6a b5        MOV        AX,0xb56a
       01a2:90d7 50              PUSH       AX
       01a2:90d8 b8 c6 a4        MOV        AX,0xa4c6
       01a2:90db 50              PUSH       AX
       01a2:90dc 9a 78 7c        CALLF      SET_STRING
                 71 0e
       01a2:90e1 b8 90 b5        MOV        AX,0xb590
       01a2:90e4 50              PUSH       AX
       01a2:90e5 b8 ca a4        MOV        AX,0xa4ca
       01a2:90e8 50              PUSH       AX
       01a2:90e9 9a 78 7c        CALLF      SET_STRING
                 71 0e
       01a2:90ee e8 c8 29        CALL       FUN_01a2_bab9                                    undefined FUN_01a2_bab9()
       01a2:90f1 e8 82 9c        CALL       FUN_01a2_2d76                                    undefined FUN_01a2_2d76()
       01a2:90f4 e9 81 8d        JMP        LAB_01a2_1e78
                             **************************************************************
                             *                          FUNCTION                          *
                             **************************************************************
                             undefined FUN_01a2_90f7()
                               assume DS = 0x1997
             undefined         <UNASSIGNED>   <RETURN>
                             FUN_01a2_90f7                                   XREF[1]:     FUN_01a2_19fa:01a2:2ab6(c)  
       01a2:90f7 b8 d0 07        MOV        AX,0x7d0
       01a2:90fa 50              PUSH       AX
       01a2:90fb ff 36 26 a6     PUSH       word ptr [0xa626]
       01a2:90ff ff 36 24 a6     PUSH       word ptr { 3.0 }
       01a2:9103 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:9108 90              NOP
       01a2:9109 d9 06 ae a4     FLD        float ptr [0xa4ae]
       01a2:910d 9a 00 07        CALLF      TIMER                                            undefined TIMER()
                 71 0e
       01a2:9112 8b f0           MOV        SI,AX
       01a2:9114 90              NOP
       01a2:9115 d9 04           FLD        float ptr [SI]
       01a2:9117 90              NOP
       01a2:9118 9b              WAIT
       01a2:9119 9a 1d 04        CALLF      FPCOMPARE_2stack                                 undefined FPCOMPARE_2stack()
                 75 0d
       01a2:911e 77 03           JA         LAB_01a2_9123
       01a2:9120 e9 19 00        JMP        LAB_01a2_913c
                             LAB_01a2_9123                                   XREF[1]:     01a2:911e(j)  
       01a2:9123 9a 00 07        CALLF      TIMER                                            undefined TIMER()
                 71 0e
       01a2:9128 8b f0           MOV        SI,AX
       01a2:912a 90              NOP
       01a2:912b d9 04           FLD        float ptr [SI]
       01a2:912d 90              NOP
       01a2:912e d8 06 2a b4     FADD       float ptr [0xb42a]
       01a2:9132 90              NOP
       01a2:9133 d9 1e ae a4     FSTP       float ptr [0xa4ae]
       01a2:9137 90              NOP
       01a2:9138 9b              WAIT
       01a2:9139 e9 11 00        JMP        LAB_01a2_914d
                             LAB_01a2_913c                                   XREF[1]:     01a2:9120(j)  
       01a2:913c 90              NOP
       01a2:913d d9 06 ae a4     FLD        float ptr [0xa4ae]
       01a2:9141 90              NOP
       01a2:9142 d8 06 2a b4     FADD       float ptr [0xb42a]
       01a2:9146 90              NOP
       01a2:9147 d9 1e ae a4     FSTP       float ptr [0xa4ae]
       01a2:914b 90              NOP
       01a2:914c 9b              WAIT
                             LAB_01a2_914d                                   XREF[1]:     01a2:9139(j)  
       01a2:914d b8 ba b5        MOV        AX,0xb5ba
       01a2:9150 50              PUSH       AX
       01a2:9151 b8 c6 a4        MOV        AX,0xa4c6
       01a2:9154 50              PUSH       AX
       01a2:9155 9a 78 7c        CALLF      SET_STRING
                 71 0e
       01a2:915a b8 ec b5        MOV        AX,0xb5ec
       01a2:915d 50              PUSH       AX
       01a2:915e b8 ca a4        MOV        AX,0xa4ca
       01a2:9161 50              PUSH       AX
       01a2:9162 9a 78 7c        CALLF      SET_STRING
                 71 0e
       01a2:9167 e8 4f 29        CALL       FUN_01a2_bab9                                    undefined FUN_01a2_bab9()
       01a2:916a e8 09 9c        CALL       FUN_01a2_2d76                                    undefined FUN_01a2_2d76()
       01a2:916d e9 08 8d        JMP        LAB_01a2_1e78
                             **************************************************************
                             *                          FUNCTION                          *
                             **************************************************************
                             undefined __cdecl16near FUN_01a2_9170()
                               assume DS = 0x1997
             undefined         <UNASSIGNED>   <RETURN>
                             FUN_01a2_9170                                   XREF[3]:     FUN_01a2_19fa:01a2:1fed(c), 
                                                                                          FUN_01a2_19fa:01a2:2cea(c), 
                                                                                          FUN_01a2_9c28:01a2:a5a5(c)  
       01a2:9170 90              NOP
       01a2:9171 d9 06 50 a5     FLD        float ptr { 1.0 }
       01a2:9175 90              NOP
       01a2:9176 d9 1e 4e a4     FSTP       float ptr [0xa44e]
       01a2:917a 90              NOP
       01a2:917b 9b              WAIT
       01a2:917c e8 d8 aa        CALL       FUN_01a2_3c57                                    undefined FUN_01a2_3c57()
       01a2:917f b8 01 00        MOV        AX,0x1
       01a2:9182 50              PUSH       AX
       01a2:9183 b8 1b 00        MOV        AX,0x1b
       01a2:9186 50              PUSH       AX
       01a2:9187 b8 01 00        MOV        AX,0x1
       01a2:918a 50              PUSH       AX
       01a2:918b b8 06 00        MOV        AX,0x6
       01a2:918e 50              PUSH       AX
       01a2:918f b8 04 00        MOV        AX,0x4
       01a2:9192 50              PUSH       AX
       01a2:9193 9a b2 61        CALLF      LOCATE
                 71 0e
       01a2:9198 b8 01 00        MOV        AX,0x1
       01a2:919b 50              PUSH       AX
       01a2:919c b8 0a 00        MOV        AX,0xa
       01a2:919f 50              PUSH       AX
       01a2:91a0 b8 02 00        MOV        AX,0x2
       01a2:91a3 50              PUSH       AX
       01a2:91a4 9a 86 61        CALLF      COLOR
                 71 0e
       01a2:91a9 b8 b0 04        MOV        AX,0x4b0
       01a2:91ac 50              PUSH       AX
       01a2:91ad ff 36 b6 a6     PUSH       word ptr [0xa6b6]
       01a2:91b1 ff 36 b4 a6     PUSH       word ptr { 2.0 }
       01a2:91b5 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:91ba b8 1e b6        MOV        AX,0xb61e
       01a2:91bd 50              PUSH       AX
       01a2:91be 9a c8 76        CALLF      PRINT_STR_NEWLINE
                 71 0e
       01a2:91c3 b8 e8 03        MOV        AX,0x3e8
       01a2:91c6 50              PUSH       AX
       01a2:91c7 ff 36 b6 a6     PUSH       word ptr [0xa6b6]
       01a2:91cb ff 36 b4 a6     PUSH       word ptr { 2.0 }
       01a2:91cf 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:91d4 e8 80 aa        CALL       FUN_01a2_3c57                                    undefined FUN_01a2_3c57()
       01a2:91d7 b8 01 00        MOV        AX,0x1
       01a2:91da 50              PUSH       AX
       01a2:91db b8 1b 00        MOV        AX,0x1b
       01a2:91de 50              PUSH       AX
       01a2:91df b8 01 00        MOV        AX,0x1
       01a2:91e2 50              PUSH       AX
       01a2:91e3 b8 06 00        MOV        AX,0x6
       01a2:91e6 50              PUSH       AX
       01a2:91e7 b8 04 00        MOV        AX,0x4
       01a2:91ea 50              PUSH       AX
       01a2:91eb 9a b2 61        CALLF      LOCATE
                 71 0e
       01a2:91f0 b8 40 b6        MOV        AX,0xb640
       01a2:91f3 50              PUSH       AX
       01a2:91f4 9a c8 76        CALLF      PRINT_STR_NEWLINE
                 71 0e
       01a2:91f9 e8 5b aa        CALL       FUN_01a2_3c57                                    undefined FUN_01a2_3c57()
       01a2:91fc b8 01 00        MOV        AX,0x1
       01a2:91ff 50              PUSH       AX
       01a2:9200 b8 1b 00        MOV        AX,0x1b
       01a2:9203 50              PUSH       AX
       01a2:9204 b8 01 00        MOV        AX,0x1
       01a2:9207 50              PUSH       AX
       01a2:9208 b8 06 00        MOV        AX,0x6
       01a2:920b 50              PUSH       AX
       01a2:920c b8 04 00        MOV        AX,0x4
       01a2:920f 50              PUSH       AX
       01a2:9210 9a b2 61        CALLF      LOCATE
                 71 0e
       01a2:9215 b8 01 00        MOV        AX,0x1
       01a2:9218 50              PUSH       AX
       01a2:9219 b8 02 00        MOV        AX,0x2
       01a2:921c 50              PUSH       AX
       01a2:921d 50              PUSH       AX
       01a2:921e 9a 86 61        CALLF      COLOR
                 71 0e
       01a2:9223 b8 b0 04        MOV        AX,0x4b0
       01a2:9226 50              PUSH       AX
       01a2:9227 ff 36 b6 a6     PUSH       word ptr [0xa6b6]
       01a2:922b ff 36 b4 a6     PUSH       word ptr { 2.0 }
       01a2:922f 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:9234 b8 1e b6        MOV        AX,0xb61e
       01a2:9237 50              PUSH       AX
       01a2:9238 9a c8 76        CALLF      PRINT_STR_NEWLINE
                 71 0e
       01a2:923d b8 e8 03        MOV        AX,0x3e8
       01a2:9240 50              PUSH       AX
       01a2:9241 ff 36 b6 a6     PUSH       word ptr [0xa6b6]
       01a2:9245 ff 36 b4 a6     PUSH       word ptr { 2.0 }
       01a2:9249 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:924e e8 06 aa        CALL       FUN_01a2_3c57                                    undefined FUN_01a2_3c57()
       01a2:9251 b8 01 00        MOV        AX,0x1
       01a2:9254 50              PUSH       AX
       01a2:9255 b8 1b 00        MOV        AX,0x1b
       01a2:9258 50              PUSH       AX
       01a2:9259 b8 01 00        MOV        AX,0x1
       01a2:925c 50              PUSH       AX
       01a2:925d b8 06 00        MOV        AX,0x6
       01a2:9260 50              PUSH       AX
       01a2:9261 b8 04 00        MOV        AX,0x4
       01a2:9264 50              PUSH       AX
       01a2:9265 9a b2 61        CALLF      LOCATE
                 71 0e
       01a2:926a b8 40 b6        MOV        AX,0xb640
       01a2:926d 50              PUSH       AX
       01a2:926e 9a c8 76        CALLF      PRINT_STR_NEWLINE
                 71 0e
       01a2:9273 e8 e1 a9        CALL       FUN_01a2_3c57                                    undefined FUN_01a2_3c57()
       01a2:9276 b8 01 00        MOV        AX,0x1
       01a2:9279 50              PUSH       AX
       01a2:927a b8 1b 00        MOV        AX,0x1b
       01a2:927d 50              PUSH       AX
       01a2:927e b8 01 00        MOV        AX,0x1
       01a2:9281 50              PUSH       AX
       01a2:9282 b8 06 00        MOV        AX,0x6
       01a2:9285 50              PUSH       AX
       01a2:9286 b8 04 00        MOV        AX,0x4
       01a2:9289 50              PUSH       AX
       01a2:928a 9a b2 61        CALLF      LOCATE
                 71 0e
       01a2:928f b8 01 00        MOV        AX,0x1
       01a2:9292 50              PUSH       AX
       01a2:9293 b8 0a 00        MOV        AX,0xa
       01a2:9296 50              PUSH       AX
       01a2:9297 b8 02 00        MOV        AX,0x2
       01a2:929a 50              PUSH       AX
       01a2:929b 9a 86 61        CALLF      COLOR
                 71 0e
       01a2:92a0 b8 b0 04        MOV        AX,0x4b0
       01a2:92a3 50              PUSH       AX
       01a2:92a4 ff 36 b6 a6     PUSH       word ptr [0xa6b6]
       01a2:92a8 ff 36 b4 a6     PUSH       word ptr { 2.0 }
       01a2:92ac 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:92b1 b8 1e b6        MOV        AX,0xb61e
       01a2:92b4 50              PUSH       AX
       01a2:92b5 9a c8 76        CALLF      PRINT_STR_NEWLINE
                 71 0e
       01a2:92ba b8 e8 03        MOV        AX,0x3e8
       01a2:92bd 50              PUSH       AX
       01a2:92be ff 36 b6 a6     PUSH       word ptr [0xa6b6]
       01a2:92c2 ff 36 b4 a6     PUSH       word ptr { 2.0 }
       01a2:92c6 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:92cb e8 89 a9        CALL       FUN_01a2_3c57                                    undefined FUN_01a2_3c57()
       01a2:92ce b8 01 00        MOV        AX,0x1
       01a2:92d1 50              PUSH       AX
       01a2:92d2 b8 1b 00        MOV        AX,0x1b
       01a2:92d5 50              PUSH       AX
       01a2:92d6 b8 01 00        MOV        AX,0x1
       01a2:92d9 50              PUSH       AX
       01a2:92da b8 06 00        MOV        AX,0x6
       01a2:92dd 50              PUSH       AX
       01a2:92de b8 04 00        MOV        AX,0x4
       01a2:92e1 50              PUSH       AX
       01a2:92e2 9a b2 61        CALLF      LOCATE
                 71 0e
       01a2:92e7 b8 40 b6        MOV        AX,0xb640
       01a2:92ea 50              PUSH       AX
       01a2:92eb 9a c8 76        CALLF      PRINT_STR_NEWLINE
                 71 0e
       01a2:92f0 e8 64 a9        CALL       FUN_01a2_3c57                                    undefined FUN_01a2_3c57()
       01a2:92f3 b8 01 00        MOV        AX,0x1
       01a2:92f6 50              PUSH       AX
       01a2:92f7 b8 1b 00        MOV        AX,0x1b
       01a2:92fa 50              PUSH       AX
       01a2:92fb b8 01 00        MOV        AX,0x1
       01a2:92fe 50              PUSH       AX
       01a2:92ff b8 06 00        MOV        AX,0x6
       01a2:9302 50              PUSH       AX
       01a2:9303 b8 04 00        MOV        AX,0x4
       01a2:9306 50              PUSH       AX
       01a2:9307 9a b2 61        CALLF      LOCATE
                 71 0e
       01a2:930c b8 01 00        MOV        AX,0x1
       01a2:930f 50              PUSH       AX
       01a2:9310 b8 02 00        MOV        AX,0x2
       01a2:9313 50              PUSH       AX
       01a2:9314 50              PUSH       AX
       01a2:9315 9a 86 61        CALLF      COLOR
                 71 0e
       01a2:931a b8 b0 04        MOV        AX,0x4b0
       01a2:931d 50              PUSH       AX
       01a2:931e ff 36 b6 a6     PUSH       word ptr [0xa6b6]
       01a2:9322 ff 36 b4 a6     PUSH       word ptr { 2.0 }
       01a2:9326 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:932b b8 1e b6        MOV        AX,0xb61e
       01a2:932e 50              PUSH       AX
       01a2:932f 9a c8 76        CALLF      PRINT_STR_NEWLINE
                 71 0e
       01a2:9334 b8 e8 03        MOV        AX,0x3e8
       01a2:9337 50              PUSH       AX
       01a2:9338 ff 36 b6 a6     PUSH       word ptr [0xa6b6]
       01a2:933c ff 36 b4 a6     PUSH       word ptr { 2.0 }
       01a2:9340 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:9345 e8 0f a9        CALL       FUN_01a2_3c57                                    undefined FUN_01a2_3c57()
       01a2:9348 e8 0c a9        CALL       FUN_01a2_3c57                                    undefined FUN_01a2_3c57()
       01a2:934b b8 e8 03        MOV        AX,0x3e8
       01a2:934e 50              PUSH       AX
       01a2:934f ff 36 7e af     PUSH       word ptr [0xaf7e]
       01a2:9353 ff 36 7c af     PUSH       word ptr { 5.0 }
       01a2:9357 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:935c b8 bc 02        MOV        AX,0x2bc
       01a2:935f 50              PUSH       AX
       01a2:9360 ff 36 7e af     PUSH       word ptr [0xaf7e]
       01a2:9364 ff 36 7c af     PUSH       word ptr { 5.0 }
       01a2:9368 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:936d b8 e8 03        MOV        AX,0x3e8
       01a2:9370 50              PUSH       AX
       01a2:9371 ff 36 7e af     PUSH       word ptr [0xaf7e]
       01a2:9375 ff 36 7c af     PUSH       word ptr { 5.0 }
       01a2:9379 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:937e b8 bc 02        MOV        AX,0x2bc
       01a2:9381 50              PUSH       AX
       01a2:9382 ff 36 7e af     PUSH       word ptr [0xaf7e]
       01a2:9386 ff 36 7c af     PUSH       word ptr { 5.0 }
       01a2:938a 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:938f b8 e8 03        MOV        AX,0x3e8
       01a2:9392 50              PUSH       AX
       01a2:9393 ff 36 7e af     PUSH       word ptr [0xaf7e]
       01a2:9397 ff 36 7c af     PUSH       word ptr { 5.0 }
       01a2:939b 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:93a0 33 c0           XOR        AX,AX
       01a2:93a2 50              PUSH       AX
       01a2:93a3 9a 25 62        CALLF      CLS
                 71 0e
       01a2:93a8 e8 ac a8        CALL       FUN_01a2_3c57                                    undefined FUN_01a2_3c57()
       01a2:93ab b8 32 00        MOV        AX,0x32
       01a2:93ae 50              PUSH       AX
       01a2:93af b8 96 00        MOV        AX,0x96
       01a2:93b2 50              PUSH       AX
       01a2:93b3 9a 91 5b        CALLF      GRAPHICS_SETPT1
                 71 0e
       01a2:93b8 b8 4e 02        MOV        AX,0x24e
       01a2:93bb 50              PUSH       AX
       01a2:93bc b8 90 01        MOV        AX,0x190
       01a2:93bf 50              PUSH       AX
       01a2:93c0 9a ab 5b        CALLF      GRAPHICS_SETPT2
                 71 0e
       01a2:93c5 b8 03 00        MOV        AX,0x3
       01a2:93c8 50              PUSH       AX
       01a2:93c9 b8 ff ff        MOV        AX,0xffff
       01a2:93cc 50              PUSH       AX
       01a2:93cd b8 02 00        MOV        AX,0x2
       01a2:93d0 50              PUSH       AX
       01a2:93d1 9a 80 10        CALLF      LINE
                 71 0e
       01a2:93d6 b8 30 00        MOV        AX,0x30
       01a2:93d9 50              PUSH       AX
       01a2:93da b8 94 00        MOV        AX,0x94
       01a2:93dd 50              PUSH       AX
       01a2:93de 9a 91 5b        CALLF      GRAPHICS_SETPT1
                 71 0e
       01a2:93e3 b8 50 02        MOV        AX,0x250
       01a2:93e6 50              PUSH       AX
       01a2:93e7 b8 92 01        MOV        AX,0x192
       01a2:93ea 50              PUSH       AX
       01a2:93eb 9a ab 5b        CALLF      GRAPHICS_SETPT2
                 71 0e
       01a2:93f0 b8 0e 00        MOV        AX,0xe
       01a2:93f3 50              PUSH       AX
       01a2:93f4 b8 ff ff        MOV        AX,0xffff
       01a2:93f7 50              PUSH       AX
       01a2:93f8 b8 01 00        MOV        AX,0x1
       01a2:93fb 50              PUSH       AX
       01a2:93fc 9a 80 10        CALLF      LINE
                 71 0e
       01a2:9401 b8 01 00        MOV        AX,0x1
       01a2:9404 50              PUSH       AX
       01a2:9405 b8 02 00        MOV        AX,0x2
       01a2:9408 50              PUSH       AX
       01a2:9409 b8 01 00        MOV        AX,0x1
       01a2:940c 50              PUSH       AX
       01a2:940d b8 19 00        MOV        AX,0x19
       01a2:9410 50              PUSH       AX
       01a2:9411 b8 04 00        MOV        AX,0x4
       01a2:9414 50              PUSH       AX
       01a2:9415 9a b2 61        CALLF      LOCATE
                 71 0e
       01a2:941a b8 01 00        MOV        AX,0x1
       01a2:941d 50              PUSH       AX
       01a2:941e b8 0d 00        MOV        AX,0xd
       01a2:9421 50              PUSH       AX
       01a2:9422 b8 02 00        MOV        AX,0x2
       01a2:9425 50              PUSH       AX
       01a2:9426 9a 86 61        CALLF      COLOR
                 71 0e
       01a2:942b e8 29 a8        CALL       FUN_01a2_3c57                                    undefined FUN_01a2_3c57()
       01a2:942e b8 5e b6        MOV        AX,0xb65e
       01a2:9431 50              PUSH       AX
       01a2:9432 9a c8 76        CALLF      PRINT_STR_NEWLINE
                 71 0e
       01a2:9437 b8 01 00        MOV        AX,0x1
       01a2:943a 50              PUSH       AX
       01a2:943b b8 04 00        MOV        AX,0x4
       01a2:943e 50              PUSH       AX
       01a2:943f b8 01 00        MOV        AX,0x1
       01a2:9442 50              PUSH       AX
       01a2:9443 b8 16 00        MOV        AX,0x16
       01a2:9446 50              PUSH       AX
       01a2:9447 b8 04 00        MOV        AX,0x4
       01a2:944a 50              PUSH       AX
       01a2:944b 9a b2 61        CALLF      LOCATE
                 71 0e
       01a2:9450 b8 01 00        MOV        AX,0x1
       01a2:9453 50              PUSH       AX
       01a2:9454 b8 0f 00        MOV        AX,0xf
       01a2:9457 50              PUSH       AX
       01a2:9458 b8 02 00        MOV        AX,0x2
       01a2:945b 50              PUSH       AX
       01a2:945c 9a 86 61        CALLF      COLOR
                 71 0e
       01a2:9461 e8 f3 a7        CALL       FUN_01a2_3c57                                    undefined FUN_01a2_3c57()
       01a2:9464 e8 f0 a7        CALL       FUN_01a2_3c57                                    undefined FUN_01a2_3c57()
       01a2:9467 e8 ed a7        CALL       FUN_01a2_3c57                                    undefined FUN_01a2_3c57()
       01a2:946a b8 86 b6        MOV        AX,0xb686
       01a2:946d 50              PUSH       AX
       01a2:946e 9a c3 76        CALLF      PRINT_STR_SEMICOLON
                 71 0e
       01a2:9473 b8 01 00        MOV        AX,0x1
       01a2:9476 50              PUSH       AX
       01a2:9477 b8 0c 00        MOV        AX,0xc
       01a2:947a 50              PUSH       AX
       01a2:947b b8 02 00        MOV        AX,0x2
       01a2:947e 50              PUSH       AX
       01a2:947f 9a 86 61        CALLF      COLOR
                 71 0e
       01a2:9484 b8 a0 b6        MOV        AX,0xb6a0
       01a2:9487 50              PUSH       AX
       01a2:9488 9a c3 76        CALLF      PRINT_STR_SEMICOLON
                 71 0e
       01a2:948d b8 01 00        MOV        AX,0x1
       01a2:9490 50              PUSH       AX
       01a2:9491 b8 0f 00        MOV        AX,0xf
       01a2:9494 50              PUSH       AX
       01a2:9495 b8 02 00        MOV        AX,0x2
       01a2:9498 50              PUSH       AX
       01a2:9499 9a 86 61        CALLF      COLOR
                 71 0e
       01a2:949e b8 ac b6        MOV        AX,0xb6ac
       01a2:94a1 50              PUSH       AX
       01a2:94a2 9a c8 76        CALLF      PRINT_STR_NEWLINE
                 71 0e
       01a2:94a7 e8 ad a7        CALL       FUN_01a2_3c57                                    undefined FUN_01a2_3c57()
       01a2:94aa e8 aa a7        CALL       FUN_01a2_3c57                                    undefined FUN_01a2_3c57()
       01a2:94ad b8 01 00        MOV        AX,0x1
       01a2:94b0 50              PUSH       AX
       01a2:94b1 b8 0a 00        MOV        AX,0xa
       01a2:94b4 50              PUSH       AX
       01a2:94b5 b8 02 00        MOV        AX,0x2
       01a2:94b8 50              PUSH       AX
       01a2:94b9 9a 86 61        CALLF      COLOR
                 71 0e
       01a2:94be b8 01 00        MOV        AX,0x1
       01a2:94c1 50              PUSH       AX
       01a2:94c2 b8 06 00        MOV        AX,0x6
       01a2:94c5 50              PUSH       AX
       01a2:94c6 b8 01 00        MOV        AX,0x1
       01a2:94c9 50              PUSH       AX
       01a2:94ca b8 12 00        MOV        AX,0x12
       01a2:94cd 50              PUSH       AX
       01a2:94ce b8 04 00        MOV        AX,0x4
       01a2:94d1 50              PUSH       AX
       01a2:94d2 9a b2 61        CALLF      LOCATE
                 71 0e
       01a2:94d7 b8 bc b6        MOV        AX,0xb6bc
       01a2:94da 50              PUSH       AX
       01a2:94db 9a c8 76        CALLF      PRINT_STR_NEWLINE
                 71 0e
       01a2:94e0 90              NOP
       01a2:94e1 d9 06 50 a5     FLD        float ptr { 1.0 }
       01a2:94e5 e9 0d 00        JMP        LAB_01a2_94f5
                             LAB_01a2_94e8                                   XREF[1]:     01a2:950d(j)  
       01a2:94e8 e8 6c a7        CALL       FUN_01a2_3c57                                    undefined FUN_01a2_3c57()
       01a2:94eb 90              NOP
       01a2:94ec d9 06 ce a4     FLD        float ptr [0xa4ce]
       01a2:94f0 90              NOP
       01a2:94f1 d8 06 50 a5     FADD       float ptr { 1.0 }
                             LAB_01a2_94f5                                   XREF[1]:     01a2:94e5(j)  
       01a2:94f5 90              NOP
       01a2:94f6 d9 1e ce a4     FSTP       float ptr [0xa4ce]
       01a2:94fa 90              NOP
       01a2:94fb 9b              WAIT
       01a2:94fc 90              NOP
       01a2:94fd d9 06 94 af     FLD        float ptr { 9.0 }
       01a2:9501 90              NOP
       01a2:9502 d9 06 ce a4     FLD        float ptr [0xa4ce]
       01a2:9506 90              NOP
       01a2:9507 9b              WAIT
       01a2:9508 9a 1d 04        CALLF      FPCOMPARE_2stack                                 undefined FPCOMPARE_2stack()
                 75 0d
       01a2:950d 76 d9           JBE        LAB_01a2_94e8
       01a2:950f b8 01 00        MOV        AX,0x1
       01a2:9512 50              PUSH       AX
       01a2:9513 b8 08 00        MOV        AX,0x8
       01a2:9516 50              PUSH       AX
       01a2:9517 b8 01 00        MOV        AX,0x1
       01a2:951a 50              PUSH       AX
       01a2:951b b8 1d 00        MOV        AX,0x1d
       01a2:951e 50              PUSH       AX
       01a2:951f b8 04 00        MOV        AX,0x4
       01a2:9522 50              PUSH       AX
       01a2:9523 9a b2 61        CALLF      LOCATE
                 71 0e
       01a2:9528 b8 01 00        MOV        AX,0x1
       01a2:952b 50              PUSH       AX
       01a2:952c b8 02 00        MOV        AX,0x2
       01a2:952f 50              PUSH       AX
       01a2:9530 50              PUSH       AX
       01a2:9531 9a 86 61        CALLF      COLOR
                 71 0e
       01a2:9536 b8 f2 b6        MOV        AX,0xb6f2
       01a2:9539 50              PUSH       AX
       01a2:953a 9a c3 76        CALLF      PRINT_STR_SEMICOLON
                 71 0e
       01a2:953f b8 01 00        MOV        AX,0x1
       01a2:9542 50              PUSH       AX
       01a2:9543 b8 0e 00        MOV        AX,0xe
       01a2:9546 50              PUSH       AX
       01a2:9547 b8 02 00        MOV        AX,0x2
       01a2:954a 50              PUSH       AX
       01a2:954b 9a 86 61        CALLF      COLOR
                 71 0e
       01a2:9550 b8 fe b6        MOV        AX,0xb6fe
       01a2:9553 50              PUSH       AX
       01a2:9554 9a c8 76        CALLF      PRINT_STR_NEWLINE
                 71 0e
       01a2:9559 e8 fb a6        CALL       FUN_01a2_3c57                                    undefined FUN_01a2_3c57()
       01a2:955c b8 6e 00        MOV        AX,0x6e
       01a2:955f 50              PUSH       AX
       01a2:9560 ff 36 b6 a6     PUSH       word ptr [0xa6b6]
       01a2:9564 ff 36 b4 a6     PUSH       word ptr { 2.0 }
       01a2:9568 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:956d b8 82 00        MOV        AX,0x82
       01a2:9570 50              PUSH       AX
       01a2:9571 ff 36 26 a6     PUSH       word ptr [0xa626]
       01a2:9575 ff 36 24 a6     PUSH       word ptr { 3.0 }
       01a2:9579 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:957e e8 d6 a6        CALL       FUN_01a2_3c57                                    undefined FUN_01a2_3c57()
       01a2:9581 e8 d3 a6        CALL       FUN_01a2_3c57                                    undefined FUN_01a2_3c57()
       01a2:9584 90              NOP
       01a2:9585 d9 06 54 b1     FLD        float ptr [0xb154]
       01a2:9589 90              NOP
       01a2:958a d9 1e 2e a2     FSTP       float ptr [0xa22e]
       01a2:958e 90              NOP
       01a2:958f 9b              WAIT
       01a2:9590 90              NOP
       01a2:9591 d9 06 10 b7     FLD        float ptr [0xb710]
       01a2:9595 90              NOP
       01a2:9596 d9 1e 32 a2     FSTP       float ptr [0xa232]
       01a2:959a 90              NOP
       01a2:959b 9b              WAIT
       01a2:959c e8 de cd        CALL       FUN_01a2_637d                                    undefined FUN_01a2_637d()
       01a2:959f e8 b5 a6        CALL       FUN_01a2_3c57                                    undefined FUN_01a2_3c57()
       01a2:95a2 e8 b2 a6        CALL       FUN_01a2_3c57                                    undefined FUN_01a2_3c57()
       01a2:95a5 e8 af a6        CALL       FUN_01a2_3c57                                    undefined FUN_01a2_3c57()
       01a2:95a8 b8 50 00        MOV        AX,0x50
       01a2:95ab 50              PUSH       AX
       01a2:95ac ff 36 26 a6     PUSH       word ptr [0xa626]
       01a2:95b0 ff 36 24 a6     PUSH       word ptr { 3.0 }
       01a2:95b4 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:95b9 b8 78 00        MOV        AX,0x78
       01a2:95bc 50              PUSH       AX
       01a2:95bd ff 36 26 a6     PUSH       word ptr [0xa626]
       01a2:95c1 ff 36 24 a6     PUSH       word ptr { 3.0 }
       01a2:95c5 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:95ca b8 50 00        MOV        AX,0x50
       01a2:95cd 50              PUSH       AX
       01a2:95ce ff 36 b6 a6     PUSH       word ptr [0xa6b6]
       01a2:95d2 ff 36 b4 a6     PUSH       word ptr { 2.0 }
       01a2:95d6 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:95db b8 6e 00        MOV        AX,0x6e
       01a2:95de 50              PUSH       AX
       01a2:95df ff 36 b6 a6     PUSH       word ptr [0xa6b6]
       01a2:95e3 ff 36 b4 a6     PUSH       word ptr { 2.0 }
       01a2:95e7 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:95ec b8 82 00        MOV        AX,0x82
       01a2:95ef 50              PUSH       AX
       01a2:95f0 ff 36 26 a6     PUSH       word ptr [0xa626]
       01a2:95f4 ff 36 24 a6     PUSH       word ptr { 3.0 }
       01a2:95f8 9a ac 1d        CALLF      SOUND
                 71 0e
       01a2:95fd e8 57 a6        CALL       FUN_01a2_3c57                                    undefined FUN_01a2_3c57()
       01a2:9600 e8 54 a6        CALL       FUN_01a2_3c57                                    undefined FUN_01a2_3c57()
       01a2:9603 b8 2b 01        MOV        AX,0x12b
       01a2:9606 50              PUSH       AX
       01a2:9607 b8 52 01        MOV        AX,0x152
       01a2:960a 50              PUSH       AX
       01a2:960b 9a 91 5b        CALLF      GRAPHICS_SETPT1
                 71 0e
       01a2:9610 ff 36 26 a6     PUSH       word ptr [0xa626]
       01a2:9614 ff 36 24 a6     PUSH       word ptr { 3.0 }
       01a2:9618 33 c0           XOR        AX,AX
       01a2:961a 50              PUSH       AX
       01a2:961b 9a b4 0d        CALLF      CIRCLE
                 71 0e
       01a2:9620 e8 34 a6        CALL       FUN_01a2_3c57                                    undefined FUN_01a2_3c57()
       01a2:9623 b8 1d 01        MOV        AX,0x11d
       01a2:9626 50              PUSH       AX
       01a2:9627 b8 49 01        MOV        AX,0x149
       01a2:962a 50              PUSH       AX
       01a2:962b 9a 91 5b        CALLF      GRAPHICS_SETPT1
                 71 0e
       01a2:9630 ff 36 7e af     PUSH       word ptr [0xaf7e]
       01a2:9634 ff 36 7c af     PUSH       word ptr { 5.0 }
       01a2:9638 33 c0           XOR        AX,AX
       01a2:963a 50              PUSH       AX
       01a2:963b 9a b4 0d        CALLF      CIRCLE
                 71 0e
       01a2:9640 e8 14 a6        CALL       FUN_01a2_3c57                                    undefined FUN_01a2_3c57()
       01a2:9643 b8 0b 01        MOV        AX,0x10b
       01a2:9646 50              PUSH       AX
       01a2:9647 b8 3c 01        MOV        AX,0x13c
       01a2:964a 50              PUSH       AX
       01a2:964b 9a 91 5b        CALLF      GRAPHICS_SETPT1
                 71 0e
       01a2:9650 ff 36 16 a6     PUSH       word ptr [0xa616]
       01a2:9654 ff 36 14 a6     PUSH       word ptr { 8.0 }
       01a2:9658 33 c0           XOR        AX,AX
       01a2:965a 50              PUSH       AX
       01a2:965b 9a b4 0d        CALLF      CIRCLE
                 71 0e
       01a2:9660 e8 f4 a5        CALL       FUN_01a2_3c57                                    undefined FUN_01a2_3c57()
       01a2:9663 b8 50 00        MOV        AX,0x50
       01a2:9666 50              PUSH       AX
       01a2:9667 b8 22 01        MOV        AX,0x122
       01a2:966a 50              PUSH       AX
       01a2:966b 9a 91 5b        CALLF      GRAPHICS_SETPT1
                 71 0e
       01a2:9670 b8 6e 00        MOV        AX,0x6e
       01a2:9673 50              PUSH       AX
       01a2:9674 b8 aa 00        MOV        AX,0xaa
       01a2:9677 50              PUSH       AX
       01a2:9678 9a ab 5b        CALLF      GRAPHICS_SETPT2
                 71 0e
       01a2:967d 33 c0           XOR        AX,AX
       01a2:967f 50              PUSH       AX
       01a2:9680 b8 ff ff        MOV        AX,0xffff
       01a2:9683 50              PUSH       AX
       01a2:9684 33 c0           XOR        AX,AX
       01a2:9686 50              PUSH       AX
       01a2:9687 9a 80 10        CALLF      LINE
                 71 0e
       01a2:968c b8 6e 00        MOV        AX,0x6e
       01a2:968f 50              PUSH       AX
       01a2:9690 b8 aa 00        MOV        AX,0xaa
       01a2:9693 50              PUSH       AX
       01a2:9694 9a 91 5b        CALLF      GRAPHICS_SETPT1
                 71 0e
       01a2:9699 b8 8c 00        MOV        AX,0x8c
       01a2:969c 50              PUSH       AX
       01a2:969d b8 22 01        MOV        AX,0x122
       01a2:96a0 50              PUSH       AX
       01a2:96a1 9a ab 5b        CALLF      GRAPHICS_SETPT2
                 71 0e
       01a2:96a6 33 c0           XOR        AX,AX
       01a2:96a8 50              PUSH       AX
       01a2:96a9 b8 ff ff        MOV        AX,0xffff
       01a2:96ac 50              PUSH       AX
       01a2:96ad 33 c0           XOR        AX,AX
       01a2:96af 50              PUSH       AX
       01a2:96b0 9a 80 10        CALLF      LINE
                 71 0e
       01a2:96b5 b8 5f 00        MOV        AX,0x5f
       01a2:96b8 50              PUSH       AX
       01a2:96b9 b8 e6 00        MOV        AX,0xe6
       01a2:96bc 50              PUSH       AX
       01a2:96bd 9a 91 5b        CALLF      GRAPHICS_SETPT1
                 71 0e
       01a2:96c2 b8 7d 00        MOV        AX,0x7d
       01a2:96c5 50              PUSH       AX
       01a2:96c6 b8 e6 00        MOV        AX,0xe6
       01a2:96c9 50              PUSH       AX
       01a2:96ca 9a ab 5b        CALLF      GRAPHICS_SETPT2
                 71 0e
       01a2:96cf 33 c0           XOR        AX,AX
       01a2:96d1 50              PUSH       AX
       01a2:96d2 b8 ff ff        MOV        AX,0xffff
       01a2:96d5 50              PUSH       AX
       01a2:96d6 33 c0           XOR        AX,AX
       01a2:96d8 50              PUSH       AX
       01a2:96d9 9a 80 10        CALLF      LINE
                 71 0e
       01a2:96de e8 af a5        CALL       FUN_01a2_3c90                                    undefined FUN_01a2_3c90()
       01a2:96e1 b8 96 00        MOV        AX,0x96
       01a2:96e4 50              PUSH       AX
       01a2:96e5 b8 22 01        MOV        AX,0x122
       01a2:96e8 50              PUSH       AX
       01a2:96e9 9a 91 5b        CALLF      GRAPHICS_SETPT1
                 71 0e
       01a2:96ee b8 c3 00        MOV        AX,0xc3
       01a2:96f1 50              PUSH       AX
       01a2:96f2 b8 aa 00        MOV        AX,0xaa
       01a2:96f5 50              PUSH       AX
       01a2:96f6 9a ab 5b        CALLF      GRAPHICS_SETPT2
                 71 0e
       01a2:96fb 33 c0           XOR        AX,AX
       01a2:96fd 50              PUSH       AX
       01a2:96fe b8 ff ff        MOV        AX,0xffff
       01a2:9701 50              PUSH       AX
       01a2:9702 b8 01 00        MOV        AX,0x1
       01a2:9705 50              PUSH       AX
       01a2:9706 9a 80 10        CALLF      LINE
                 71 0e
       01a2:970b b8 96 00        MOV        AX,0x96
       01a2:970e 50              PUSH       AX
       01a2:970f b8 e6 00        MOV        AX,0xe6
       01a2:9712 50              PUSH       AX
       01a2:9713 9a 91 5b        CALLF      GRAPHICS_SETPT1
                 71 0e
       01a2:9718 b8 c3 00        MOV        AX,0xc3
       01a2:971b 50              PUSH       AX
       01a2:971c b8 e6 00        MOV        AX,0xe6
       01a2:971f 50              PUSH       AX
       01a2:9720 9a ab 5b        CALLF      GRAPHICS_SETPT2
                 71 0e
       01a2:9725 33 c0           XOR        AX,AX
       01a2:9727 50              PUSH       AX
       01a2:9728 b8 ff ff        MOV        AX,0xffff
       01a2:972b 50              PUSH       AX
       01a2:972c 33 c0           XOR        AX,AX
       01a2:972e 50              PUSH       AX
       01a2:972f 9a 80 10        CALLF      LINE
                 71 0e
       01a2:9734 b8 96 00        MOV        AX,0x96
       01a2:9737 50              PUSH       AX
       01a2:9738 b8 19 01        MOV        AX,0x119
       01a2:973b 50              PUSH       AX
       01a2:973c 9a 91 5b        CALLF      GRAPHICS_SETPT1
                 71 0e
       01a2:9741 b8 96 00        MOV        AX,0x96
       01a2:9744 50              PUSH       AX
       01a2:9745 b8 e7 00        MOV        AX,0xe7
       01a2:9748 50              PUSH       AX
       01a2:9749 9a ab 5b        CALLF      GRAPHICS_SETPT2
                 71 0e
       01a2:974e b8 03 00        MOV        AX,0x3
       01a2:9751 50              PUSH       AX
       01a2:9752 b8 ff ff        MOV        AX,0xffff
       01a2:9755 50              PUSH       AX
       01a2:9756 33 c0           XOR        AX,AX
       01a2:9758 50              PUSH       AX
       01a2:9759 9a 80 10        CALLF      LINE
                 71 0e
       01a2:975e b8 c3 00        MOV        AX,0xc3
       01a2:9761 50              PUSH       AX
       01a2:9762 b8 b3 00        MOV        AX,0xb3
       01a2:9765 50              PUSH       AX
       01a2:9766 9a 91 5b        CALLF      GRAPHICS_SETPT1
                 71 0e
       01a2:976b b8 c3 00        MOV        AX,0xc3
       01a2:976e 50              PUSH       AX
       01a2:976f b8 e5 00        MOV        AX,0xe5
       01a2:9772 50              PUSH       AX
       01a2:9773 9a ab 5b        CALLF      GRAPHICS_SETPT2
                 71 0e
       01a2:9778 b8 03 00        MOV        AX,0x3
       01a2:977b 50              PUSH       AX
       01a2:977c b8 ff ff        MOV        AX,0xffff
       01a2:977f 50              PUSH       AX
       01a2:9780 33 c0           XOR        AX,AX
       01a2:9782 50              PUSH       AX
       01a2:9783 9a 80 10        CALLF      LINE
                 71 0e
       01a2:9788 e8 05 a5        CALL       FUN_01a2_3c90                                    undefined FUN_01a2_3c90()
       01a2:978b b8 d2 00        MOV        AX,0xd2
       01a2:978e 50              PUSH       AX
       01a2:978f b8 22 01        MOV        AX,0x122
       01a2:9792 50              PUSH       AX
       01a2:9793 9a 91 5b        CALLF      GRAPHICS_SETPT1
                 71 0e
       01a2:9798 b8 ff 00        MOV        AX,0xff
       01a2:979b 50              PUSH       AX
       01a2:979c b8 aa 00        MOV        AX,0xaa
       01a2:979f 50              PUSH       AX
       01a2:97a0 9a ab 5b        CALLF      GRAPHICS_SETPT2
                 71 0e
       01a2:97a5 33 c0           XOR        AX,AX
       01a2:97a7 50              PUSH       AX
       01a2:97a8 b8 ff ff        MOV        AX,0xffff
       01a2:97ab 50              PUSH       AX
       01a2:97ac b8 01 00        MOV        AX,0x1
       01a2:97af 50              PUSH       AX
       01a2:97b0 9a 80 10        CALLF      LINE
                 71 0e
       01a2:97b5 b8 d2 00        MOV        AX,0xd2
       01a2:97b8 50              PUSH       AX
       01a2:97b9 b8 e6 00        MOV        AX,0xe6
       01a2:97bc 50              PUSH       AX
       01a2:97bd 9a 91 5b        CALLF      GRAPHICS_SETPT1
                 71 0e
       01a2:97c2 b8 ff 00        MOV        AX,0xff
       01a2:97c5 50              PUSH       AX
       01a2:97c6 b8 e6 00        MOV        AX,0xe6
       01a2:97c9 50              PUSH       AX
       01a2:97ca 9a ab 5b        CALLF      GRAPHICS_SETPT2
                 71 0e
       01a2:97cf 33 c0           XOR        AX,AX
       01a2:97d1 50              PUSH       AX
       01a2:97d2 b8 ff ff        MOV        AX,0xffff
       01a2:97d5 50              PUSH       AX
       01a2:97d6 33 c0           XOR        AX,AX
       01a2:97d8 50              PUSH       AX
       01a2:97d9 9a 80 10        CALLF      LINE
                 71 0e
       01a2:97de b8 d2 00        MOV        AX,0xd2
       01a2:97e1 50              PUSH       AX
       01a2:97e2 b8 19 01        MOV        AX,0x119
       01a2:97e5 50              PUSH       AX
       01a2:97e6 9a 91 5b        CALLF      GRAPHICS_SETPT1
                 71 0e
       01a2:97eb b8 d2 00        MOV        AX,0xd2
       01a2:97ee 50              PUSH       AX
       01a2:97ef b8 e7 00        MOV        AX,0xe7
       01a2:97f2 50              PUSH       AX
       01a2:97f3 9a ab 5b        CALLF      GRAPHICS_SETPT2
                 71 0e
       01a2:97f8 b8 03 00        MOV        AX,0x3
       01a2:97fb 50              PUSH       AX
       01a2:97fc b8 ff ff        MOV        AX,0xffff
       01a2:97ff 50              PUSH       AX
       01a2:9800 33 c0           XOR        AX,AX
       01a2:9802 50              PUSH       AX
       01a2:9803 9a 80 10        CALLF      LINE
                 71 0e
       01a2:9808 b8 ff 00        MOV        AX,0xff
       01a2:980b 50              PUSH       AX
       01a2:980c b8 b3 00        MOV        AX,0xb3
       01a2:980f 50              PUSH       AX
       01a2:9810 9a 91 5b        CALLF      GRAPHICS_SETPT1
                 71 0e
       01a2:9815 b8 ff 00        MOV        AX,0xff
       01a2:9818 50              PUSH       AX
       01a2:9819 b8 e5 00        MOV        AX,0xe5
       01a2:981c 50              PUSH       AX
       01a2:981d 9a ab 5b        CALLF      GRAPHICS_SETPT2
                 71 0e
       01a2:9822 b8 03 00        MOV        AX,0x3
       01a2:9825 50              PUSH       AX
       01a2:9826 b8 ff ff        MOV        AX,0xffff
       01a2:9829 50              PUSH       AX
       01a2:982a 33 c0           XOR        AX,AX
       01a2:982c 50              PUSH       AX
       01a2:982d 9a 80 10        CALLF      LINE
                 71 0e
       01a2:9832 e8 5b a4        CALL       FUN_01a2_3c90                                    undefined FUN_01a2_3c90()
       01a2:9835 b8 0e 01        MOV        AX,0x10e
       01a2:9838 50              PUSH       AX
       01a2:9839 b8 22 01        MOV        AX,0x122
       01a2:983c 50              PUSH       AX
       01a2:983d 9a 91 5b        CALLF      GRAPHICS_SETPT1
                 71 0e
       01a2:9842 b8 3b 01        MOV        AX,0x13b
       01a2:9845 50              PUSH       AX
       01a2:9846 b8 aa 00        MOV        AX,0xaa
       01a2:9849 50              PUSH       AX
       01a2:984a 9a ab 5b        CALLF      GRAPHICS_SETPT2
                 71 0e
       01a2:984f 33 c0           XOR        AX,AX
       01a2:9851 50              PUSH       AX
       01a2:9852 b8 ff ff        MOV        AX,0xffff
       01a2:9855 50              PUSH       AX
       01a2:9856 b8 01 00        MOV        AX,0x1
       01a2:9859 50              PUSH       AX
       01a2:985a 9a 80 10        CALLF      LINE
                 71 0e
       01a2:985f b8 0e 01        MOV        AX,0x10e
       01a2:9862 50              PUSH       AX
       01a2:9863 b8 f0 00        MOV        AX,0xf0
       01a2:9866 50              PUSH       AX
       01a2:9867 9a 91 5b        CALLF      GRAPHICS_SETPT1
                 71 0e
       01a2:986c b8 3b 01        MOV        AX,0x13b
       01a2:986f 50              PUSH       AX
       01a2:9870 b8 f0 00        MOV        AX,0xf0
       01a2:9873 50              PUSH       AX
       01a2:9874 9a ab 5b        CALLF      GRAPHICS_SETPT2
                 71 0e
       01a2:9879 33 c0           XOR        AX,AX
       01a2:987b 50              PUSH       AX
       01a2:987c b8 ff ff        MOV        AX,0xffff
       01a2:987f 50              PUSH       AX
       01a2:9880 33 c0           XOR        AX,AX
       01a2:9882 50              PUSH       AX
       01a2:9883 9a 80 10        CALLF      LINE
                 71 0e
       01a2:9888 b8 0f 01        MOV        AX,0x10f
       01a2:988b 50              PUSH       AX
       01a2:988c b8 22 01        MOV        AX,0x122
       01a2:988f 50              PUSH       AX
       01a2:9890 9a 91 5b        CALLF      GRAPHICS_SETPT1
                 71 0e
       01a2:9895 b8 3a 01        MOV        AX,0x13a
       01a2:9898 50              PUSH       AX
       01a2:9899 b8 22 01        MOV        AX,0x122
       01a2:989c 50              PUSH       AX
       01a2:989d 9a ab 5b        CALLF      GRAPHICS_SETPT2
                 71 0e
       01a2:98a2 b8 03 00        MOV        AX,0x3
       01a2:98a5 50              PUSH       AX
       01a2:98a6 b8 ff ff        MOV        AX,0xffff
       01a2:98a9 50              PUSH       AX
       01a2:98aa 33 c0           XOR        AX,AX
       01a2:98ac 50              PUSH       AX
       01a2:98ad 9a 80 10        CALLF      LINE
                 71 0e
       01a2:98b2 b8 0f 01        MOV        AX,0x10f
       01a2:98b5 50              PUSH       AX
       01a2:98b6 b8 aa 00        MOV        AX,0xaa
       01a2:98b9 50              PUSH       AX
       01a2:98ba 9a 91 5b        CALLF      GRAPHICS_SETPT1
                 71 0e
       01a2:98bf b8 3a 01        MOV        AX,0x13a
       01a2:98c2 50              PUSH       AX
       01a2:98c3 b8 aa 00        MOV        AX,0xaa
       01a2:98c6 50              PUSH       AX
       01a2:98c7 9a ab 5b        CALLF      GRAPHICS_SETPT2
                 71 0e
       01a2:98cc b8 03 00        MOV        AX,0x3
       01a2:98cf 50              PUSH       AX
       01a2:98d0 b8 ff ff        MOV        AX,0xffff
       01a2:98d3 50              PUSH       AX
       01a2:98d4 33 c0           XOR        AX,AX
       01a2:98d6 50              PUSH       AX
       01a2:98d7 9a 80 10        CALLF      LINE
                 71 0e
       01a2:98dc e8 b1 a3        CALL       FUN_01a2_3c90                                    undefined FUN_01a2_3c90()
       01a2:98df b8 4a 01        MOV        AX,0x14a
       01a2:98e2 50              PUSH       AX
       01a2:98e3 b8 22 01        MOV        AX,0x122
       01a2:98e6 50              PUSH       AX
       01a2:98e7 9a 91 5b        CALLF      GRAPHICS_SETPT1
                 71 0e
       01a2:98ec b8 77 01        MOV        AX,0x177
       01a2:98ef 50              PUSH       AX
       01a2:98f0 b8 aa 00        MOV        AX,0xaa
       01a2:98f3 50              PUSH       AX
       01a2:98f4 9a ab 5b        CALLF      GRAPHICS_SETPT2
                 71 0e
       01a2:98f9 33 c0           XOR        AX,AX
       01a2:98fb 50              PUSH       AX
       01a2:98fc b8 ff ff        MOV        AX,0xffff
       01a2:98ff 50              PUSH       AX
       01a2:9900 b8 01 00        MOV        AX,0x1
       01a2:9903 50              PUSH       AX
       01a2:9904 9a 80 10        CALLF      LINE
                 71 0e
       01a2:9909 e8 84 a3        CALL       FUN_01a2_3c90                                    undefined FUN_01a2_3c90()
       01a2:990c b8 86 01        MOV        AX,0x186
       01a2:990f 50              PUSH       AX
       01a2:9910 b8 22 01        MOV        AX,0x122
       01a2:9913 50              PUSH       AX
       01a2:9914 9a 91 5b        CALLF      GRAPHICS_SETPT1
                 71 0e
       01a2:9919 b8 86 01        MOV        AX,0x186
       01a2:991c 50              PUSH       AX
       01a2:991d b8 aa 00        MOV        AX,0xaa
       01a2:9920 50              PUSH       AX
       01a2:9921 9a ab 5b        CALLF      GRAPHICS_SETPT2
                 71 0e
       01a2:9926 33 c0           XOR        AX,AX
       01a2:9928 50              PUSH       AX
       01a2:9929 b8 ff ff        MOV        AX,0xffff
       01a2:992c 50              PUSH       AX
       01a2:992d 33 c0           XOR        AX,AX
       01a2:992f 50              PUSH       AX
       01a2:9930 9a 80 10        CALLF      LINE
                 71 0e
       01a2:9935 b8 86 01        MOV        AX,0x186
       01a2:9938 50              PUSH       AX
       01a2:9939 b8 22 01        MOV        AX,0x122
       01a2:993c 50              PUSH       AX
       01a2:993d 9a 91 5b        CALLF      GRAPHICS_SETPT1
                 71 0e
       01a2:9942 b8 b3 01        MOV        AX,0x1b3
       01a2:9945 50              PUSH       AX
       01a2:9946 b8 22 01        MOV        AX,0x122
       01a2:9949 50              PUSH       AX
       01a2:994a 9a ab 5b        CALLF      GRAPHICS_SETPT2
                 71 0e
       01a2:994f 33 c0           XOR        AX,AX
       01a2:9951 50              PUSH       AX
       01a2:9952 b8 ff ff        MOV        AX,0xffff
       01a2:9955 50              PUSH       AX
       01a2:9956 33 c0           XOR        AX,AX
       01a2:9958 50              PUSH       AX
       01a2:9959 9a 80 10        CALLF      LINE
                 71 0e
       01a2:995e b8 b3 01        MOV        AX,0x1b3
       01a2:9961 50              PUSH       AX
       01a2:9962 b8 22 01        MOV        AX,0x122
       01a2:9965 50              PUSH       AX
       01a2:9966 9a 91 5b        CALLF      GRAPHICS_SETPT1
                 71 0e
       01a2:996b b8 b3 01        MOV        AX,0x1b3
       01a2:996e 50              PUSH       AX
       01a2:996f b8 18 01        MOV        AX,0x118
       01a2:9972 50              PUSH       AX
       01a2:9973 9a ab 5b        CALLF      GRAPHICS_SETPT2
                 71 0e
       01a2:9978 33 c0           XOR        AX,AX
       01a2:997a 50              PUSH       AX
       01a2:997b b8 ff ff        MOV        AX,0xffff
       01a2:997e 50              PUSH       AX
       01a2:997f 33 c0           XOR        AX,AX
       01a2:9981 50              PUSH       AX
       01a2:9982 9a 80 10        CALLF      LINE
                 71 0e
       01a2:9987 e8 06 a3        CALL       FUN_01a2_3c90                                    undefined FUN_01a2_3c90()
       01a2:998a b8 c7 01        MOV        AX,0x1c7
       01a2:998d 50              PUSH       AX
       01a2:998e b8 22 01        MOV        AX,0x122
       01a2:9991 50              PUSH       AX
       01a2:9992 9a 91 5b        CALLF      GRAPHICS_SETPT1
                 71 0e
       01a2:9997 b8 f4 01        MOV        AX,0x1f4
       01a2:999a 50              PUSH       AX
       01a2:999b b8 aa 00        MOV        AX,0xaa
       01a2:999e 50              PUSH       AX
       01a2:999f 9a ab 5b        CALLF      GRAPHICS_SETPT2
                 71 0e
       01a2:99a4 33 c0           XOR        AX,AX
       01a2:99a6 50              PUSH       AX
       01a2:99a7 b8 ff ff        MOV        AX,0xffff
       01a2:99aa 50              PUSH       AX
       01a2:99ab b8 01 00        MOV        AX,0x1
       01a2:99ae 50              PUSH       AX
       01a2:99af 9a 80 10        CALLF      LINE
                 71 0e
       01a2:99b4 b8 c7 01        MOV        AX,0x1c7
       01a2:99b7 50              PUSH       AX
       01a2:99b8 b8 e6 00        MOV        AX,0xe6
       01a2:99bb 50              PUSH       AX
       01a2:99bc 9a 91 5b        CALLF      GRAPHICS_SETPT1
                 71 0e
       01a2:99c1 b8 f4 01        MOV        AX,0x1f4
       01a2:99c4 50              PUSH       AX
       01a2:99c5 b8 e6 00        MOV        AX,0xe6
       01a2:99c8 50              PUSH       AX
       01a2:99c9 9a ab 5b        CALLF      GRAPHICS_SETPT2
                 71 0e
       01a2:99ce 33 c0           XOR        AX,AX
       01a2:99d0 50              PUSH       AX
       01a2:99d1 b8 ff ff        MOV        AX,0xffff
       01a2:99d4 50              PUSH       AX
       01a2:99d5 33 c0           XOR        AX,AX
       01a2:99d7 50              PUSH       AX
       01a2:99d8 9a 80 10        CALLF      LINE
                 71 0e
       01a2:99dd b8 f4 01        MOV        AX,0x1f4
       01a2:99e0 50              PUSH       AX
       01a2:99e1 b8 21 01        MOV        AX,0x121
       01a2:99e4 50              PUSH       AX
       01a2:99e5 9a 91 5b        CALLF      GRAPHICS_SETPT1
                 71 0e
       01a2:99ea b8 f4 01        MOV        AX,0x1f4
       01a2:99ed 50              PUSH       AX
       01a2:99ee b8 ab 00        MOV        AX,0xab
       01a2:99f1 50              PUSH       AX
       01a2:99f2 9a ab 5b        CALLF      GRAPHICS_SETPT2
                 71 0e
       01a2:99f7 b8 03 00        MOV        AX,0x3
       01a2:99fa 50              PUSH       AX
       01a2:99fb b8 ff ff        MOV        AX,0xffff
       01a2:99fe 50              PUSH       AX
       01a2:99ff 33 c0           XOR        AX,AX
       01a2:9a01 50              PUSH       AX
       01a2:9a02 9a 80 10        CALLF      LINE
                 71 0e
       01a2:9a07 e8 86 a2        CALL       FUN_01a2_3c90                                    undefined FUN_01a2_3c90()
       01a2:9a0a b8 0f 02        MOV        AX,0x20f
       01a2:9a0d 50              PUSH       AX
       01a2:9a0e b8 aa 00        MOV        AX,0xaa
       01a2:9a11 50              PUSH       AX
       01a2:9a12 9a 91 5b        CALLF      GRAPHICS_SETPT1
                 71 0e
       01a2:9a17 b8 0f 02        MOV        AX,0x20f
       01a2:9a1a 50              PUSH       AX
       01a2:9a1b b8 13 01        MOV        AX,0x113
       01a2:9a1e 50              PUSH       AX
       01a2:9a1f 9a ab 5b        CALLF      GRAPHICS_SETPT2
                 71 0e
       01a2:9a24 33 c0           XOR        AX,AX
       01a2:9a26 50              PUSH       AX
       01a2:9a27 b8 ff ff        MOV        AX,0xffff
       01a2:9a2a 50              PUSH       AX
       01a2:9a2b 33 c0           XOR        AX,AX
       01a2:9a2d 50              PUSH       AX
       01a2:9a2e 9a 80 10        CALLF      LINE
                 71 0e
       01a2:9a33 b8 0e 02        MOV        AX,0x20e
       01a2:9a36 50              PUSH       AX
       01a2:9a37 b8 20 01        MOV        AX,0x120
       01a2:9a3a 50              PUSH       AX
       01a2:9a3b 9a 91 5b        CALLF      GRAPHICS_SETPT1
                 71 0e
       01a2:9a40 b8 10 02        MOV        AX,0x210
       01a2:9a43 50              PUSH       AX
       01a2:9a44 b8 22 01        MOV        AX,0x122
       01a2:9a47 50              PUSH       AX
       01a2:9a48 9a ab 5b        CALLF      GRAPHICS_SETPT2
                 71 0e
       01a2:9a4d 33 c0           XOR        AX,AX
       01a2:9a4f 50              PUSH       AX
       01a2:9a50 b8 ff ff        MOV        AX,0xffff
       01a2:9a53 50              PUSH       AX
       01a2:9a54 b8 01 00        MOV        AX,0x1
       01a2:9a57 50              PUSH       AX
       01a2:9a58 9a 80 10        CALLF      LINE
                 71 0e
       01a2:9a5d e8 30 a2        CALL       FUN_01a2_3c90                                    undefined FUN_01a2_3c90()
       01a2:9a60 b8 26 02        MOV        AX,0x226
       01a2:9a63 50              PUSH       AX
       01a2:9a64 b8 aa 00        MOV        AX,0xaa
       01a2:9a67 50              PUSH       AX
       01a2:9a68 9a 91 5b        CALLF      GRAPHICS_SETPT1
                 71 0e
       01a2:9a6d b8 26 02        MOV        AX,0x226
       01a2:9a70 50              PUSH       AX
       01a2:9a71 b8 13 01        MOV        AX,0x113
       01a2:9a74 50              PUSH       AX
       01a2:9a75 9a ab 5b        CALLF      GRAPHICS_SETPT2
                 71 0e
       01a2:9a7a 33 c0           XOR        AX,AX
       01a2:9a7c 50              PUSH       AX
       01a2:9a7d b8 ff ff        MOV        AX,0xffff
       01a2:9a80 50              PUSH       AX
       01a2:9a81 33 c0           XOR        AX,AX
       01a2:9a83 50              PUSH       AX
       01a2:9a84 9a 80 10        CALLF      LINE
                 71 0e
       01a2:9a89 b8 25 02        MOV        AX,0x225
       01a2:9a8c 50              PUSH       AX
       01a2:9a8d b8 20 01        MOV        AX,0x120
       01a2:9a90 50              PUSH       AX
       01a2:9a91 9a 91 5b        CALLF      GRAPHICS_SETPT1
                 71 0e
       01a2:9a96 b8 27 02        MOV        AX,0x227
       01a2:9a99 50              PUSH       AX
       01a2:9a9a b8 22 01        MOV        AX,0x122
       01a2:9a9d 50              PUSH       AX
       01a2:9a9e 9a ab 5b        CALLF      GRAPHICS_SETPT2
                 71 0e
       01a2:9aa3 33 c0           XOR        AX,AX
       01a2:9aa5 50              PUSH       AX
       01a2:9aa6 b8 ff ff        MOV        AX,0xffff
       01a2:9aa9 50              PUSH       AX
       01a2:9aaa b8 01 00        MOV        AX,0x1
       01a2:9aad 50              PUSH       AX
       01a2:9aae 9a 80 10        CALLF      LINE
                 71 0e
       01a2:9ab3 90              NOP
       01a2:9ab4 d9 06 50 a5     FLD        float ptr { 1.0 }
       01a2:9ab8 e9 0e 00        JMP        LAB_01a2_9ac9
       01a2:9abb 90              ??         90h
                             LAB_01a2_9abc                                   XREF[1]:     01a2:9ae1(j)  
       01a2:9abc e8 98 a1        CALL       FUN_01a2_3c57                                    undefined FUN_01a2_3c57()
       01a2:9abf 90              NOP
       01a2:9ac0 d9 06 96 a4     FLD        float ptr [0xa496]
       01a2:9ac4 90              NOP
       01a2:9ac5 d8 06 50 a5     FADD       float ptr { 1.0 }
                             LAB_01a2_9ac9                                   XREF[1]:     01a2:9ab8(j)  
       01a2:9ac9 90              NOP
       01a2:9aca d9 1e 96 a4     FSTP       float ptr [0xa496]
       01a2:9ace 90              NOP
       01a2:9acf 9b              WAIT
       01a2:9ad0 90              NOP
       01a2:9ad1 d9 06 74 a6     FLD        float ptr { 4.0 }
       01a2:9ad5 90              NOP
       01a2:9ad6 d9 06 96 a4     FLD        float ptr [0xa496]
       01a2:9ada 90              NOP
       01a2:9adb 9b              WAIT
       01a2:9adc 9a 1d 04        CALLF      FPCOMPARE_2stack                                 undefined FPCOMPARE_2stack()
                 75 0d
       01a2:9ae1 76 d9           JBE        LAB_01a2_9abc
       01a2:9ae3 e8 bc 21        CALL       FUN_01a2_bca2                                    undefined FUN_01a2_bca2()
       01a2:9ae6 c3              RET
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

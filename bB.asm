game
.L00 ;  rem  ---- Sample Program 10 ----

.
 ; 

.L01 ;  rem  This program demonstrates how to move an animated sprite.

.L02 ;  rem  It combines Sample Program 3 and Sample Program 5.

.
 ; 

.L03 ;  rem  Any non-indented command is taken as a label. This is

.L04 ;  rem  something you can jump to with the 'goto' or 'gosub'

.L05 ;  rem  command.

.
 ; 

.L06 ;  rem  Declare Variables:

.L07 ;  rem  I'm going to declare x and y variables for the player's

.L08 ;  rem  position, so I can move him with the joystick later.

.
 ; 

.L09 ;  x = 50

	LDA #50
	STA x
.L010 ;  y = 50

	LDA #50
	STA y
.
 ; 

.main
 ; main

.
 ; 

.L011 ;  rem  COLUP0=<xx> sets the color of the player 0 sprite. Valid

.L012 ;  rem  range is 0-254.

.L013 ;  rem  Sample Program 3 used 28 (decimal), which is yellow.

.L014 ;  rem  Sample Program 5 used $28 (hexadecimal), which is orange.

.L015 ;  rem  This sample program uses hexadecimal for the color values.

.
 ; 

.L016 ;  COLUP0 = $28

	LDA #$28
	STA COLUP0
.
 ; 

.L017 ;  rem  Change the background color with COLUBK.

.
 ; 

.L018 ;  COLUBK = $02

	LDA #$02
	STA COLUBK
.
 ; 

.L019 ;  rem  f will be used for the frame counter. In Sample Program 5,

.L020 ;  rem  this was y instead of f; but Sample Program 3 uses y for

.L021 ;  rem  the vertical position of player0, so we need to use a

.L022 ;  rem  different variable-- and "f" is a nice little abbreviation

.L023 ;  rem  for "frame"!

.
 ; 

.L024 ;  f = f + 1

	INC f
.
 ; 

.L025 ;  rem  Here is where you define the shape of the player sprite.

.L026 ;  rem  It's limited to 8 pixels wide, but you can make it as

.L027 ;  rem  tall/long as you want. You have to draw the sprite upside

.L028 ;  rem  down; it's flipped when it's displayed onscreen.

.
 ; 

.L029 ;  rem  The 'player0' must be indented, the 'end' must NOT be

.L030 ;  rem  indented.

.
 ; 

.L031 ;  rem  The frame counter will be used in animating the sprite.

.L032 ;  rem  We'll draw a different picture for the sprite, depending on

.L033 ;  rem  what the value of f is. Generally, the animation should

.L034 ;  rem  cycle through at least 3 different images to give a decent

.L035 ;  rem  illusion of movement.

.
 ; 

.L036 ;  if f = 10 then player0:

	LDA f
	CMP #10
     BNE .skipL036
.condpart0
	LDX #<player0then_0
	STX player0pointerlo
	LDA #>player0then_0
	STA player0pointerhi
	LDA #10
	STA player0height
.skipL036
.
 ; 

.L037 ;  if f = 20 then player0:

	LDA f
	CMP #20
     BNE .skipL037
.condpart1
	LDX #<player1then_0
	STX player0pointerlo
	LDA #>player1then_0
	STA player0pointerhi
	LDA #10
	STA player0height
.skipL037
.
 ; 

.L038 ;  if f = 30 then player0:

	LDA f
	CMP #30
     BNE .skipL038
.condpart2
	LDX #<player2then_0
	STX player0pointerlo
	LDA #>player2then_0
	STA player0pointerhi
	LDA #10
	STA player0height
.skipL038
.
 ; 

.L039 ;  rem  The next statement ensures that f cycles continuously from

.L040 ;  rem  1 to 30 when we perform the "f=f+1" statement up above.

.
 ; 

.L041 ;  if f = 30 then f = 0

	LDA f
	CMP #30
     BNE .skipL041
.condpart3
	LDA #0
	STA f
.skipL041
.
 ; 

.L042 ;  rem  Put the player on the screen at horizontal position x

.L043 ;  rem  (which we initialized to 50). Valid range is 1 to 159.

.
 ; 

.L044 ;  player0x = x

	LDA x
	STA player0x
.
 ; 

.L045 ;  rem  Put the player on the screen at vertical position y (which

.L046 ;  rem  we initialized to 50). Valid range is 1 to ~90.

.
 ; 

.L047 ;  player0y = y

	LDA y
	STA player0y
.
 ; 

.L048 ;  rem  This command instructs the program to write the data for

.L049 ;  rem  the display (picture) to the TV screen.

.
 ; 

.L050 ;  drawscreen

 jsr drawscreen
.
 ; 

.L051 ;  rem  Make the guy move.

.
 ; 

.L052 ;  if joy0right then x = x + 1

 bit SWCHA
	BMI .skipL052
.condpart4
	INC x
.skipL052
.L053 ;  if joy0left then x = x - 1

 bit SWCHA
	BVS .skipL053
.condpart5
	DEC x
.skipL053
.L054 ;  if joy0up then y = y - 1

 lda #$10
 bit SWCHA
	BNE .skipL054
.condpart6
	DEC y
.skipL054
.L055 ;  if joy0down then y = y + 1

 lda #$20
 bit SWCHA
	BNE .skipL055
.condpart7
	INC y
.skipL055
.
 ; 

.L056 ;  goto main

 jmp .main

 if (<*) > (<(*+10))
	repeat ($100-<*)
	.byte 0
	repend
	endif
player0then_0
	.byte         %00011100
	.byte         %00011000
	.byte         %00011000
	.byte         %00100000
	.byte         %00011000
	.byte         %01011111
	.byte         %01100100
	.byte         %00010000
	.byte         %00011000
	.byte         %00111100
	.byte         %00011000
 if (<*) > (<(*+10))
	repeat ($100-<*)
	.byte 0
	repend
	endif
player1then_0
	.byte         %01000011
	.byte         %01100010
	.byte         %00110110
	.byte         %00011100
	.byte         %00101000
	.byte         %00111100
	.byte         %00100100
	.byte         %00010000
	.byte         %00011000
	.byte         %00111100
	.byte         %00011000
 if (<*) > (<(*+10))
	repeat ($100-<*)
	.byte 0
	repend
	endif
player2then_0
	.byte         %00011100
	.byte         %00011000
	.byte         %00011000
	.byte         %00100000
	.byte         %01011010
	.byte         %01111100
	.byte         %00100100
	.byte         %00010000
	.byte         %00011000
	.byte         %00111100
	.byte         %00011000
 if ECHOFIRST
       echo "    ",[(scoretable - *)]d , "bytes of ROM space left")
 endif 
ECHOFIRST = 1
 
 
 

game
.L00 ;  rem Generated 11/20/2020 11:29:39 AM by Visual bB Version 1.0.0.568

.L01 ;  rem **********************************

.L02 ;  rem *<filename>                      *

.L03 ;  rem *<description>                   *

.L04 ;  rem *<author>                        *

.L05 ;  rem *<contact info>                  *

.L06 ;  rem *<license>                       *

.L07 ;  rem **********************************

.
 ; 

.L08 ;  rem Generated 11/16/2020 11:39:59 AM by Visual bB Version 1.0.0.568

.L09 ;  rem **********************************

.L010 ;  rem *<filename>                      *

.L011 ;  rem *<description>                   *

.L012 ;  rem *<author>                        *

.L013 ;  rem *<contact info>                  *

.L014 ;  rem *<license>                       *

.L015 ;  rem **********************************

.
 ; 

.L016 ;  playfield:

  ifconst pfres
	  ldx #(11>pfres)*(pfres*pfwidth-1)+(11<=pfres)*43
  else
	  ldx #((11*pfwidth-1)*((11*pfwidth-1)<47))+(47*((11*pfwidth-1)>=47))
  endif
	jmp pflabel0
PF_data0
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
pflabel0
	lda PF_data0,x
	sta playfield,x
	dex
	bpl pflabel0
.
 ; 

.
 ; 

.L017 ;  COLUBK  =  0

	LDA #0
	STA COLUBK
.L018 ;  COLUPF  =  246

	LDA #246
	STA COLUPF
.L019 ;  scorecolor  =  $68

	LDA #$68
	STA scorecolor
.
 ; 

.L020 ;  player0x  =  50  :  player0y  =  85

	LDA #50
	STA player0x
	LDA #85
	STA player0y
.L021 ;  player1x  =  20  :  player1y  =  12

	LDA #20
	STA player1x
	LDA #12
	STA player1y
.L022 ;  missile0height  =  1  :  missile0y  =  255

	LDA #1
	STA missile0height
	LDA #255
	STA missile0y
.L023 ;  NUSIZ0  =  16

	LDA #16
	STA NUSIZ0
.
 ; 

.sprites
 ; sprites

.
 ; 

.L024 ;  COLUP0  =  194

	LDA #194
	STA COLUP0
.L025 ;  player0:

	LDX #<playerL025_0
	STX player0pointerlo
	LDA #>playerL025_0
	STA player0pointerhi
	LDA #7
	STA player0height
.
 ; 

.L026 ;  COLUP1 = 54

	LDA #54
	STA COLUP1
.L027 ;  player1:

	LDX #<playerL027_1
	STX player1pointerlo
	LDA #>playerL027_1
	STA player1pointerhi
	LDA #7
	STA player1height
.
 ; 

.
 ; 

.L028 ;  if missile0y  >  240 then goto skip

	LDA #240
	CMP missile0y
     BCS .skipL028
.condpart0
 jmp .skip

.skipL028
.L029 ;  missile0y  =  missile0y  -  2  :  goto draw_loop

	LDA missile0y
	SEC
	SBC #2
	STA missile0y
 jmp .draw_loop

.
 ; 

.skip
 ; skip

.L030 ;  if joy0fire then missile0y  =  player0y  -  7  :  missile0x  =  player0x  +  4

 bit INPT4
	BMI .skipL030
.condpart1
	LDA player0y
	SEC
	SBC #7
	STA missile0y
	LDA player0x
	CLC
	ADC #4
	STA missile0x
.skipL030
.
 ; 

.
 ; 

.draw_loop
 ; draw_loop

.L031 ;  drawscreen

 jsr drawscreen
.
 ; 

.L032 ;  rem if player1y<player0y then player1y = player1y+1

.L033 ;  rem if player1y>player0y then player1y = player1y-1

.L034 ;  rem if player1x<player0x then player1x = player1x+1

.L035 ;  rem if player1x>player0x then player1x = player1x-1

.L036 ;  rem player1x=player1x:player1y=player1y

.
 ; 

.L037 ;  rem if joy0up then player0y=player0y-1:goto jump

.L038 ;  rem if joy0down then player0y=player0y+1:goto jump

.L039 ;  if joy0left then player0x  =  player0x  -  1  :  rem goto jump

 bit SWCHA
	BVS .skipL039
.condpart2
	DEC player0x
.skipL039
.L040 ;  if joy0right then player0x  =  player0x  +  1  :  rem goto jump

 bit SWCHA
	BMI .skipL040
.condpart3
	INC player0x
.skipL040
.
 ; 

.L041 ;  if collision(missile0,player1) then score  =  score  +  10  :  player1x  =  rand  /  2  :  player1y  =  12  :  missile0y  =  255

	bit 	CXM0P
	BPL .skipL041
.condpart4
	SED
	CLC
	LDA score+2
	ADC #$10
	STA score+2
	LDA score+1
	ADC #$00
	STA score+1
	LDA score
	ADC #$00
	STA score
	CLD
 jsr randomize
	lsr
	STA player1x
	LDA #12
	STA player1y
	LDA #255
	STA missile0y
.skipL041
.L042 ;  rem if collision(player0,player1) then score=score-1: player1x=rand/2:player1y=0:missile0y=255

.
 ; 

.L043 ;  rem jump

.L044 ;  goto sprites

 jmp .sprites

.
 ; 

.
 ; 

 if (<*) > (<(*+7))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL025_0
	.byte  %11111110
	.byte  %11111110
	.byte  %01111100
	.byte  %00010000
	.byte  %00000000
	.byte  %00000000
	.byte  %00000000
	.byte  %00000000
 if (<*) > (<(*+7))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL027_1
	.byte  %00000000
	.byte  %10000010
	.byte  %01000100
	.byte  %11111110
	.byte  %11111110
	.byte  %10111010
	.byte  %01111100
	.byte  %10000010
 if ECHOFIRST
       echo "    ",[(scoretable - *)]d , "bytes of ROM space left")
 endif 
ECHOFIRST = 1
 
 
 

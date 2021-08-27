game
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L00 ;  includesfile multisprite_bankswitch.inc

.L01 ;  set kernel_options no_blank_lines

.L02 ;  set kernel multisprite

.L03 ;  set romsize 8k

.
 ; 

.
 ; 

.
 ; 

.L04 ;  scorecolor  =  14

	LDA #14
	STA scorecolor
.
 ; 

.L05 ;  dim _sc3  =  score + 2

.
 ; 

.
 ; 

.L06 ;  dim inv_x  =  a  :  a  =  84

	LDA #84
	STA a
.L07 ;  dim inv_y  =  b  :  b  =  76

	LDA #76
	STA b
.L08 ;  dim inv_delay  =  c  :  c  =  0

	LDA #0
	STA c
.L09 ;  dim inv_dir  =  f  :  f  =  1

	LDA #1
	STA f
.L010 ;  dim inv_shot_x  =  g  :  g  =  0

	LDA #0
	STA g
.L011 ;  dim inv_shot_y  =  h  :  h  =  0

	LDA #0
	STA h
.L012 ;  dim inv_fire_delay  =  k  :  k  =  0

	LDA #0
	STA k
.L013 ;  dim inv_fired  =  l  :  l  =  0

	LDA #0
	STA l
.L014 ;  dim inv_hit  =  n  :  n  =  0

	LDA #0
	STA n
.L015 ;  dim inv_blast_delay  =  o  :  o  =  0

	LDA #0
	STA o
.
 ; 

.
 ; 

.L016 ;  dim tur_x  =  d  :  d  =  84

	LDA #84
	STA d
.L017 ;  dim tur_y  =  e  :  e  =  14

	LDA #14
	STA e
.L018 ;  dim shot_x  =  i  :  i  =  tur_x

	LDA tur_x
	STA i
.L019 ;  dim shot_y  =  j  :  j  =  tur_y

	LDA tur_y
	STA j
.L020 ;  dim tur_fired  =  m  :  m  =  0

	LDA #0
	STA m
.
 ; 

.
 ; 

.
 ; 

.main
 ; main

.
 ; 

.L021 ;  gosub draw__move_turret

 jsr .draw__move_turret

.L022 ;  gosub draw__move_turret_shot

 jsr .draw__move_turret_shot

.L023 ;  gosub draw__move_invader

 jsr .draw__move_invader

.L024 ;  gosub draw__move_inv_shot

 jsr .draw__move_inv_shot

.L025 ;  gosub col_shot_inv

 jsr .col_shot_inv

.
 ; 

.L026 ;  if _sc3  >=  70 then goto game_over

	LDA _sc3
	CMP #70
     BCC .skipL026
.condpart0
 jmp .game_over

.skipL026
.
 ; 

.L027 ;  drawscreen

 sta temp7
 lda #>(ret_point1-1)
 pha
 lda #<(ret_point1-1)
 pha
 lda #>(drawscreen-1)
 pha
 lda #<(drawscreen-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #2
 jmp BS_jsr
ret_point1
.
 ; 

.L028 ;  goto main

 jmp .main

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.draw__move_invader
 ; draw__move_invader

.
 ; 

.L029 ;  inv_delay  =  inv_delay  +  1

	INC inv_delay
.
 ; 

.
 ; 

.L030 ;  if inv_delay  =  15  &&  inv_hit  =  0 then player0:  

	LDA inv_delay
	CMP #15
     BNE .skipL030
.condpart1
	LDA inv_hit
	CMP #0
     BNE .skip1then
.condpart2
	LDX #<player2then_0
	STX player0pointerlo
	LDA #>player2then_0
	STA player0pointerhi
	LDA #9
	STA player0height
.skip1then
.skipL030
.
 ; 

.
 ; 

.L031 ;  if inv_delay  =  30  &&  inv_hit  =  0 then player0:  

	LDA inv_delay
	CMP #30
     BNE .skipL031
.condpart3
	LDA inv_hit
	CMP #0
     BNE .skip3then
.condpart4
	LDX #<player4then_0
	STX player0pointerlo
	LDA #>player4then_0
	STA player0pointerhi
	LDA #9
	STA player0height
.skip3then
.skipL031
.
 ; 

.L032 ;  if inv_delay  >  30 then inv_delay  =  0

	LDA #30
	CMP inv_delay
     BCS .skipL032
.condpart5
	LDA #0
	STA inv_delay
.skipL032
.
 ; 

.
 ; 

.L033 ;  COLUP0  =  52

	LDA #52
	STA COLUP0
.
 ; 

.
 ; 

.L034 ;  if inv_hit  =  0  &&  inv_dir  =  1  &&  inv_delay  =  15 then inv_x  =  inv_x  +  1

	LDA inv_hit
	CMP #0
     BNE .skipL034
.condpart6
	LDA inv_dir
	CMP #1
     BNE .skip6then
.condpart7
	LDA inv_delay
	CMP #15
     BNE .skip7then
.condpart8
	INC inv_x
.skip7then
.skip6then
.skipL034
.L035 ;  if inv_hit  =  0  &&  inv_dir  =  1  &&  inv_delay  =  30 then inv_x  =  inv_x  +  1

	LDA inv_hit
	CMP #0
     BNE .skipL035
.condpart9
	LDA inv_dir
	CMP #1
     BNE .skip9then
.condpart10
	LDA inv_delay
	CMP #30
     BNE .skip10then
.condpart11
	INC inv_x
.skip10then
.skip9then
.skipL035
.
 ; 

.L036 ;  if inv_x  >  143 then inv_dir  =  0  :  inv_x  =  143  :  inv_y  =  inv_y  -  5

	LDA #143
	CMP inv_x
     BCS .skipL036
.condpart12
	LDA #0
	STA inv_dir
	LDA #143
	STA inv_x
	LDA inv_y
	SEC
	SBC #5
	STA inv_y
.skipL036
.
 ; 

.
 ; 

.L037 ;  if inv_hit  =  0  &&  inv_dir  =  0  &&  inv_delay  =  15 then inv_x  =  inv_x  -  1

	LDA inv_hit
	CMP #0
     BNE .skipL037
.condpart13
	LDA inv_dir
	CMP #0
     BNE .skip13then
.condpart14
	LDA inv_delay
	CMP #15
     BNE .skip14then
.condpart15
	DEC inv_x
.skip14then
.skip13then
.skipL037
.L038 ;  if inv_hit  =  0  &&  inv_dir  =  0  &&  inv_delay  =  30 then inv_x  =  inv_x  -  1

	LDA inv_hit
	CMP #0
     BNE .skipL038
.condpart16
	LDA inv_dir
	CMP #0
     BNE .skip16then
.condpart17
	LDA inv_delay
	CMP #30
     BNE .skip17then
.condpart18
	DEC inv_x
.skip17then
.skip16then
.skipL038
.
 ; 

.L039 ;  if inv_x  <  26 then inv_dir  =  1  :  inv_x  =  26  :  inv_y  =  inv_y  -  5

	LDA inv_x
	CMP #26
     BCS .skipL039
.condpart19
	LDA #1
	STA inv_dir
	LDA #26
	STA inv_x
	LDA inv_y
	SEC
	SBC #5
	STA inv_y
.skipL039
.
 ; 

.
 ; 

.L040 ;  player0x  =  inv_x  -  8  :  player0y  =  inv_y

	LDA inv_x
	SEC
	SBC #8
	STA player0x
	LDA inv_y
	STA player0y
.L041 ;  return

	tsx
	lda 2,x ; check return address
	eor #(>*) ; vs. current PCH
	and #$E0 ;  mask off all but top 3 bits
	beq *+5 ; if equal, do normal return
	JMP BS_return
	RTS
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.draw__move_inv_shot
 ; draw__move_inv_shot

.
 ; 

.L042 ;  player2:

	LDX #<playerL042_2
	STX player2pointerlo
	LDA #>playerL042_2
	STA player2pointerhi
	LDA #9
	STA player2height
.
 ; 

.L043 ;  COLUP2  =  14

	LDA #14
	STA COLUP2
.
 ; 

.L044 ;  inv_fire_delay  =  inv_fire_delay  +  1

	INC inv_fire_delay
.
 ; 

.L045 ;  if inv_fired  =  0  &&  inv_fire_delay  =  180 then inv_shot_x  =  inv_x  :  inv_shot_y  =  inv_y  -  9

	LDA inv_fired
	CMP #0
     BNE .skipL045
.condpart20
	LDA inv_fire_delay
	CMP #180
     BNE .skip20then
.condpart21
	LDA inv_x
	STA inv_shot_x
	LDA inv_y
	SEC
	SBC #9
	STA inv_shot_y
.skip20then
.skipL045
.L046 ;  if inv_fired  =  0  &&  inv_fire_delay  =  180 then player2x  =  inv_shot_x  :  player2y  =  inv_shot_y

	LDA inv_fired
	CMP #0
     BNE .skipL046
.condpart22
	LDA inv_fire_delay
	CMP #180
     BNE .skip22then
.condpart23
	LDA inv_shot_x
	STA player2x
	LDA inv_shot_y
	STA player2y
.skip22then
.skipL046
.L047 ;  if inv_fired  =  0  &&  inv_fire_delay  =  180 then inv_fired  =  1

	LDA inv_fired
	CMP #0
     BNE .skipL047
.condpart24
	LDA inv_fire_delay
	CMP #180
     BNE .skip24then
.condpart25
	LDA #1
	STA inv_fired
.skip24then
.skipL047
.
 ; 

.L048 ;  if inv_fired  =  1 then inv_shot_y  =  inv_shot_y  -  2  :  player2y  =  inv_shot_y

	LDA inv_fired
	CMP #1
     BNE .skipL048
.condpart26
	LDA inv_shot_y
	SEC
	SBC #2
	STA inv_shot_y
	LDA inv_shot_y
	STA player2y
.skipL048
.
 ; 

.L049 ;  if inv_shot_y  <  12 then inv_fired  =  0  :  inv_fire_delay  =  0  :  inv_shot_y  =  88  :  player2y  =  inv_shot_y

	LDA inv_shot_y
	CMP #12
     BCS .skipL049
.condpart27
	LDA #0
	STA inv_fired
	STA inv_fire_delay
	LDA #88
	STA inv_shot_y
	LDA inv_shot_y
	STA player2y
.skipL049
.
 ; 

.L050 ;  return

	tsx
	lda 2,x ; check return address
	eor #(>*) ; vs. current PCH
	and #$E0 ;  mask off all but top 3 bits
	beq *+5 ; if equal, do normal return
	JMP BS_return
	RTS
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.col_shot_inv
 ; col_shot_inv

.L051 ;  if shot_x  +  3  >=  inv_x  &&  shot_x  +  3  <=  inv_x  +  6  &&  shot_y  >  inv_y then inv_hit  =  1

; complex condition detected
	LDA shot_x
	CLC
	ADC #3
; todo: this LDA is spurious and should be prevented ->	LDA  1,x
	CMP inv_x
     BCC .skipL051
.condpart28
; complex condition detected
	LDA inv_x
	CLC
	ADC #6
  PHA
	LDA shot_x
	CLC
	ADC #3
  PHA
  TSX
  PLA
  PLA
; todo: this LDA is spurious and should be prevented ->	LDA  2,x
	CMP  1,x
     BCC .skip28then
.condpart29
	LDA inv_y
	CMP shot_y
     BCS .skip29then
.condpart30
	LDA #1
	STA inv_hit
.skip29then
.skip28then
.skipL051
.
 ; 

.L052 ;  if inv_hit  =  1 then inv_blast_delay  =  inv_blast_delay  +  1

	LDA inv_hit
	CMP #1
     BNE .skipL052
.condpart31
	INC inv_blast_delay
.skipL052
.
 ; 

.L053 ;  if inv_blast_delay  >  30 then score  =  score  +  10  :  inv_hit  =  0  :  gosub reset_blast

	LDA #30
	CMP inv_blast_delay
     BCS .skipL053
.condpart32
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
	LDA #0
	STA inv_hit
 jsr .reset_blast

.skipL053
.
 ; 

.L054 ;  if inv_hit  =  1 then player0:  

	LDA inv_hit
	CMP #1
     BNE .skipL054
.condpart33
	LDX #<player33then_0
	STX player0pointerlo
	LDA #>player33then_0
	STA player0pointerhi
	LDA #9
	STA player0height
.skipL054
.
 ; 

.L055 ;  return

	tsx
	lda 2,x ; check return address
	eor #(>*) ; vs. current PCH
	and #$E0 ;  mask off all but top 3 bits
	beq *+5 ; if equal, do normal return
	JMP BS_return
	RTS
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.reset_blast
 ; reset_blast

.L056 ;  player0:  

	LDX #<playerL056_0
	STX player0pointerlo
	LDA #>playerL056_0
	STA player0pointerhi
	LDA #9
	STA player0height
.
 ; 

.
 ; 

.L057 ;  inv_blast_delay  =  0  :  inv_x  =   ( rand & 117 )   +  26  :  inv_y  =  76

	LDA #0
	STA inv_blast_delay
; complex statement detected
 sta temp7
 lda #>(ret_point2-1)
 pha
 lda #<(ret_point2-1)
 pha
 lda #>(randomize-1)
 pha
 lda #<(randomize-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #2
 jmp BS_jsr
ret_point2
	AND #117
	CLC
	ADC #26
	STA inv_x
	LDA #76
	STA inv_y
.
 ; 

.L058 ;  return

	tsx
	lda 2,x ; check return address
	eor #(>*) ; vs. current PCH
	and #$E0 ;  mask off all but top 3 bits
	beq *+5 ; if equal, do normal return
	JMP BS_return
	RTS
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.draw__move_turret
 ; draw__move_turret

.L059 ;  player1:

	LDX #<playerL059_1
	STX player1pointerlo
	LDA #>playerL059_1
	STA player1pointerhi
	LDA #9
	STA player1height
.
 ; 

.
 ; 

.L060 ;  _COLUP1  =  196

	LDA #196
	STA _COLUP1
.
 ; 

.L061 ;  if joy0left  &&  tur_x  >=  26 then tur_x  =  tur_x  -  1

 bit SWCHA
	BVS .skipL061
.condpart34
	LDA tur_x
	CMP #26
     BCC .skip34then
.condpart35
	DEC tur_x
.skip34then
.skipL061
.L062 ;  if joy0right  &&  tur_x  <=  143 then tur_x  =  tur_x  +  1

 bit SWCHA
	BMI .skipL062
.condpart36
	LDA #143
	CMP tur_x
     BCC .skip36then
.condpart37
	INC tur_x
.skip36then
.skipL062
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L063 ;  player1x  =  tur_x  :  player1y  =  tur_y

	LDA tur_x
	STA player1x
	LDA tur_y
	STA player1y
.
 ; 

.L064 ;  return

	tsx
	lda 2,x ; check return address
	eor #(>*) ; vs. current PCH
	and #$E0 ;  mask off all but top 3 bits
	beq *+5 ; if equal, do normal return
	JMP BS_return
	RTS
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.draw__move_turret_shot
 ; draw__move_turret_shot

.L065 ;  player3:

	LDX #<playerL065_3
	STX player3pointerlo
	LDA #>playerL065_3
	STA player3pointerhi
	LDA #9
	STA player3height
.
 ; 

.L066 ;  COLUP3  =  14

	LDA #14
	STA COLUP3
.
 ; 

.L067 ;  if joy0fire  &&  tur_fired  =  0 then tur_fired  =  1  :  shot_x  =  tur_x  :  shot_y  =  tur_y  +  1  :  player3x  =  shot_x  :  player3y  =  shot_y

 bit INPT4
	BMI .skipL067
.condpart38
	LDA tur_fired
	CMP #0
     BNE .skip38then
.condpart39
	LDA #1
	STA tur_fired
	LDA tur_x
	STA shot_x
	LDA tur_y
	CLC
	ADC #1
	STA shot_y
	LDA shot_x
	STA player3x
	LDA shot_y
	STA player3y
.skip38then
.skipL067
.
 ; 

.L068 ;  if tur_fired  =  1 then shot_y  =  shot_y  +  2  :  player3x  =  shot_x  :  player3y  =  shot_y

	LDA tur_fired
	CMP #1
     BNE .skipL068
.condpart40
	LDA shot_y
	CLC
	ADC #2
	STA shot_y
	LDA shot_x
	STA player3x
	LDA shot_y
	STA player3y
.skipL068
.
 ; 

.L069 ;  if shot_y  >  77 then tur_fired  =  0  :  shot_y  =  0  :  player3y  =  shot_y

	LDA #77
	CMP shot_y
     BCS .skipL069
.condpart41
	LDA #0
	STA tur_fired
	STA shot_y
	LDA shot_y
	STA player3y
.skipL069
.
 ; 

.L070 ;  return

	tsx
	lda 2,x ; check return address
	eor #(>*) ; vs. current PCH
	and #$E0 ;  mask off all but top 3 bits
	beq *+5 ; if equal, do normal return
	JMP BS_return
	RTS
.
 ; 

.
 ; 

.
 ; 

.game_over
 ; game_over

.
 ; 

.L071 ;  if joy0up then reboot

 lda #$10
 bit SWCHA
	BNE .skipL071
.condpart42
	JMP ($FFFC)
.skipL071
.
 ; 

.L072 ;  score  =  50

	LDA #$50
	STA score+2
	LDA #$00
	STA score+1
	LDA #$00
	STA score
.
 ; 

.L073 ;  player2:

	LDX #<playerL073_2
	STX player2pointerlo
	LDA #>playerL073_2
	STA player2pointerhi
	LDA #26
	STA player2height
.
 ; 

.L074 ;  player3:

	LDX #<playerL074_3
	STX player3pointerlo
	LDA #>playerL074_3
	STA player3pointerhi
	LDA #26
	STA player3height
.
 ; 

.L075 ;  player0x  =  0  :  player0y  =  0

	LDA #0
	STA player0x
	STA player0y
.L076 ;  player1x  =  0  :  player1y  =  0

	LDA #0
	STA player1x
	STA player1y
.L077 ;  COLUP0  =  0

	LDA #0
	STA COLUP0
.L078 ;  COLUP1  =  0

	LDA #0
	STA COLUP1
.
 ; 

.L079 ;  player2x  =  85  :  player2y  =  66

	LDA #85
	STA player2x
	LDA #66
	STA player2y
.L080 ;  player3x  =  85  :  player3y  =  39

	LDA #85
	STA player3x
	LDA #39
	STA player3y
.
 ; 

.L081 ;  drawscreen

 sta temp7
 lda #>(ret_point3-1)
 pha
 lda #<(ret_point3-1)
 pha
 lda #>(drawscreen-1)
 pha
 lda #<(drawscreen-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #2
 jmp BS_jsr
ret_point3
.
 ; 

.L082 ;  goto game_over

 jmp .game_over

 if ECHO1
 echo "    ",[(start_bank1 - *)]d , "bytes of ROM space left in bank 1")
 endif
ECHO1 = 1
 ORG $1FF4-bscode_length
 RORG $DFF4-bscode_length
start_bank1 ldx #$ff
 ifconst FASTFETCH ; using DPC+
 stx FASTFETCH
 endif 
 txs
 if bankswitch == 64
   lda #(((>(start-1)) & $0F) | $F0)
 else
   lda #>(start-1)
 endif
 pha
 lda #<(start-1)
 pha
 pha
 txa
 pha
 tsx
 if bankswitch != 64
   lda 4,x ; get high byte of return address
   rol
   rol
   rol
   rol
   and #bs_mask ;1 3 or 7 for F8/F6/F4
   tax
   inx
 else
   lda 4,x ; get high byte of return address
   tay
   ora #$10 ; change our bank nibble into a valid rom mirror
   sta 4,x
   tya
   lsr 
   lsr 
   lsr 
   lsr 
   tax
   inx
 endif
 lda bankswitch_hotspot-1,x
 pla
 tax
 pla
 rts
 if ((* & $1FFF) > ((bankswitch_hotspot & $1FFF) - 1))
   echo "WARNING: size parameter in banksw.asm too small - the program probably will not work."
   echo "Change to",[(*-begin_bscode+1)&$FF]d,"and try again."
 endif
 ORG $1FFC
 RORG $DFFC
 .word (start_bank1 & $ffff)
 .word (start_bank1 & $ffff)
 ORG $2000
 RORG $F000
; bB.asm file is split here
 if (<*) > (<(*+8))
	repeat ($100-<*)
	.byte 0
	repend
	endif
 if (<*) < 90
	repeat (90-<*)
	.byte 0
	repend
	endif
player2then_0
	.byte 0
	.byte  %00000000
	.byte  %10000010
	.byte  %01000100
	.byte  %11111110
	.byte  %11111110
	.byte  %10111010
	.byte  %01111100
	.byte  %10000010
 if (<*) > (<(*+8))
	repeat ($100-<*)
	.byte 0
	repend
	endif
 if (<*) < 90
	repeat (90-<*)
	.byte 0
	repend
	endif
player4then_0
	.byte 0
	.byte  %00000000
	.byte  %00101000
	.byte  %01000100
	.byte  %11111110
	.byte  %11111110
	.byte  %10111010
	.byte  %01111100
	.byte  %01000100
 if (<*) > (<(*+7))
	repeat ($100-<*)
	.byte 0
	repend
	endif
 if (<*) < 90
	repeat (90-<*)
	.byte 0
	repend
	endif
playerL042_2
	.byte  %00000000
	.byte  %00000000
	.byte  %00010000
	.byte  %00100000
	.byte  %00010000
	.byte  %00001000
	.byte  %00010000
	.byte  %00000000
 if (<*) > (<(*+8))
	repeat ($100-<*)
	.byte 0
	repend
	endif
 if (<*) < 90
	repeat (90-<*)
	.byte 0
	repend
	endif
player33then_0
	.byte 0
	.byte  %00000000
	.byte  %10010010
	.byte  %01010100
	.byte  %00000000
	.byte  %11010110
	.byte  %00000000
	.byte  %01010100
	.byte  %10010010
 if (<*) > (<(*+8))
	repeat ($100-<*)
	.byte 0
	repend
	endif
 if (<*) < 90
	repeat (90-<*)
	.byte 0
	repend
	endif
playerL056_0
	.byte 0
	.byte  %00000000
	.byte  %10000010
	.byte  %01000100
	.byte  %11111110
	.byte  %11111110
	.byte  %10111010
	.byte  %01111100
	.byte  %10000010
 if (<*) > (<(*+7))
	repeat ($100-<*)
	.byte 0
	repend
	endif
 if (<*) < 90
	repeat (90-<*)
	.byte 0
	repend
	endif
playerL059_1
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
 if (<*) < 90
	repeat (90-<*)
	.byte 0
	repend
	endif
playerL065_3
	.byte  %00000000
	.byte  %00000000
	.byte  %00000000
	.byte  %00010000
	.byte  %00010000
	.byte  %00000000
	.byte  %00000000
	.byte  %00000000
 if (<*) > (<(*+24))
	repeat ($100-<*)
	.byte 0
	repend
	endif
 if (<*) < 90
	repeat (90-<*)
	.byte 0
	repend
	endif
playerL073_2
	.byte  %00000000
	.byte  %00000000
	.byte  %00000000
	.byte  %00000000
	.byte  %00000000
	.byte  %11111000
	.byte  %10000000
	.byte  %11000000
	.byte  %10000000
	.byte  %11111000
	.byte  %00000000
	.byte  %10001000
	.byte  %10001000
	.byte  %10101000
	.byte  %11111000
	.byte  %00000000
	.byte  %10001000
	.byte  %11111000
	.byte  %10001000
	.byte  %11111000
	.byte  %00000000
	.byte  %11111000
	.byte  %10001000
	.byte  %10000000
	.byte  %11111000
 if (<*) > (<(*+24))
	repeat ($100-<*)
	.byte 0
	repend
	endif
 if (<*) < 90
	repeat (90-<*)
	.byte 0
	repend
	endif
playerL074_3
	.byte  %00000000
	.byte  %00000000
	.byte  %00000000
	.byte  %00000000
	.byte  %00000000
	.byte  %10001000
	.byte  %11110000
	.byte  %10001000
	.byte  %11111000
	.byte  %00000000
	.byte  %11111000
	.byte  %10000000
	.byte  %11000000
	.byte  %10000000
	.byte  %11111000
	.byte  %00000000
	.byte  %00100000
	.byte  %01010000
	.byte  %10001000
	.byte  %10001000
	.byte  %00000000
	.byte  %11111000
	.byte  %10001000
	.byte  %10001000
	.byte  %11111000
 if ECHOFIRST
       echo "    ",[(scoretable - *)]d , "bytes of ROM space left in bank 2")
 endif 
ECHOFIRST = 1
 
 
 

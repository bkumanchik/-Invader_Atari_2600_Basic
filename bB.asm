game
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

.
 ; 

.L02 ;  set kernel multisprite

.L03 ;  set romsize 8k

.
 ; 

.
 ; 

.L04 ;  const pfscore  =  0

.
 ; 

.
 ; 

.
 ; 

.L05 ;  dim sound  =  t  :  sound  =  32

	LDA #32
	STA sound
.
 ; 

.L06 ;  dim reducing_lives  =  p  :  p  =  0

	LDA #0
	STA p
.
 ; 

.L07 ;  pfscore2  =  %00101010

	LDA #%00101010
	STA pfscore2
.
 ; 

.
 ; 

.L08 ;  dim inv_x  =  a  :  a  =  84

	LDA #84
	STA a
.L09 ;  dim inv_y  =  b  :  b  =  76

	LDA #76
	STA b
.L010 ;  dim inv_delay  =  c  :  c  =  0

	LDA #0
	STA c
.L011 ;  dim inv_dir  =  f  :  f  =  1

	LDA #1
	STA f
.L012 ;  dim inv_shot_x  =  g  :  g  =  inv_x

	LDA inv_x
	STA g
.L013 ;  dim inv_shot_y  =  h  :  h  =  inv_y

	LDA inv_y
	STA h
.L014 ;  dim inv_fire_delay  =  k  :  k  =  0

	LDA #0
	STA k
.L015 ;  dim inv_fired  =  l  :  l  =  0

	LDA #0
	STA l
.L016 ;  dim inv_hit  =  n  :  n  =  0

	LDA #0
	STA n
.L017 ;  dim inv_blast_delay  =  o  :  o  =  0

	LDA #0
	STA o
.
 ; 

.
 ; 

.L018 ;  dim tur_x  =  d  :  d  =  84

	LDA #84
	STA d
.L019 ;  dim tur_y  =  e  :  e  =  14

	LDA #14
	STA e
.L020 ;  dim shot_x  =  i  :  i  =  tur_x

	LDA tur_x
	STA i
.L021 ;  dim shot_y  =  j  :  j  =  tur_y

	LDA tur_y
	STA j
.L022 ;  dim tur_fired  =  m  :  m  =  0

	LDA #0
	STA m
.L023 ;  dim tur_hit  =  q  :  q  =  0

	LDA #0
	STA q
.L024 ;  dim tur_anim_playing  =  r  :  r  =  0

	LDA #0
	STA r
.L025 ;  dim tur_anim_frame  =  s  :  s  =  0

	LDA #0
	STA s
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

.main
 ; main

.
 ; 

.
 ; 

.L026 ;  AUDV0  =  0

	LDA #0
	STA AUDV0
.
 ; 

.
 ; 

.
 ; 

.L027 ;  if sound  <=  31 then sound  =  sound  +  1  :  AUDC0  =  8  :  AUDV0  =  4  :  AUDF0  =  sound  - 2

	LDA #31
	CMP sound
     BCC .skipL027
.condpart0
	INC sound
	LDA #8
	STA AUDC0
	LDA #4
	STA AUDV0
	LDA sound
	SEC
	SBC #2
	STA AUDF0
.skipL027
.
 ; 

.L028 ;  if sound  >=  33  &&  sound  <=  64 then sound  =  sound  +  1  :  AUDC0  =  4  :  AUDV0  =  3  :  AUDF0  =  sound  - 34

	LDA sound
	CMP #33
     BCC .skipL028
.condpart1
	LDA #64
	CMP sound
     BCC .skip1then
.condpart2
	INC sound
	LDA #4
	STA AUDC0
	LDA #3
	STA AUDV0
	LDA sound
	SEC
	SBC #34
	STA AUDF0
.skip1then
.skipL028
.
 ; 

.L029 ;  if sound  >=  66  &&  sound  <=  97 then sound  =  sound  +  1  :  AUDC0  =  2  :  AUDV0  =  6  :  AUDF0  =  sound  - 67

	LDA sound
	CMP #66
     BCC .skipL029
.condpart3
	LDA #97
	CMP sound
     BCC .skip3then
.condpart4
	INC sound
	LDA #2
	STA AUDC0
	LDA #6
	STA AUDV0
	LDA sound
	SEC
	SBC #67
	STA AUDF0
.skip3then
.skipL029
.
 ; 

.
 ; 

.L030 ;  if !joy0fire then u{3}  =  1

 bit INPT4
	BPL .skipL030
.condpart5
	LDA u
	ORA #8
	STA u
.skipL030
.
 ; 

.
 ; 

.L031 ;  if tur_hit  =  0 then gosub draw__move_turret

	LDA tur_hit
	CMP #0
     BNE .skipL031
.condpart6
 jsr .draw__move_turret

.skipL031
.L032 ;  if tur_hit  =  0 then gosub draw__move_turret_shot

	LDA tur_hit
	CMP #0
     BNE .skipL032
.condpart7
 jsr .draw__move_turret_shot

.skipL032
.L033 ;  gosub draw__move_invader

 jsr .draw__move_invader

.L034 ;  gosub draw__move_inv_shot

 jsr .draw__move_inv_shot

.L035 ;  gosub col_shot_inv

 jsr .col_shot_inv

.L036 ;  gosub col_inv_shot_turret

 jsr .col_inv_shot_turret

.L037 ;  if tur_hit  =  1 then gosub play_tur_anim

	LDA tur_hit
	CMP #1
     BNE .skipL037
.condpart8
 jsr .play_tur_anim

.skipL037
.
 ; 

.L038 ;  if pfscore2  <  2 then goto game_over

	LDA pfscore2
	CMP #2
     BCS .skipL038
.condpart9
 jmp .game_over

.skipL038
.
 ; 

.
 ; 

.L039 ;  pfscorecolor  =  196

	LDA #196
	STA pfscorecolor
.
 ; 

.
 ; 

.L040 ;  scorecolor  =  152

	LDA #152
	STA scorecolor
.
 ; 

.
 ; 

.L041 ;  drawscreen

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

.L042 ;  goto main

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

.L043 ;  inv_delay  =  inv_delay  +  1

	INC inv_delay
.
 ; 

.
 ; 

.L044 ;  if inv_delay  =  15  &&  inv_hit  =  0 then player0:  

	LDA inv_delay
	CMP #15
     BNE .skipL044
.condpart10
	LDA inv_hit
	CMP #0
     BNE .skip10then
.condpart11
	LDX #<player11then_0
	STX player0pointerlo
	LDA #>player11then_0
	STA player0pointerhi
	LDA #9
	STA player0height
.skip10then
.skipL044
.
 ; 

.
 ; 

.L045 ;  if inv_delay  =  30  &&  inv_hit  =  0 then player0:  

	LDA inv_delay
	CMP #30
     BNE .skipL045
.condpart12
	LDA inv_hit
	CMP #0
     BNE .skip12then
.condpart13
	LDX #<player13then_0
	STX player0pointerlo
	LDA #>player13then_0
	STA player0pointerhi
	LDA #9
	STA player0height
.skip12then
.skipL045
.
 ; 

.L046 ;  if inv_delay  >  30 then inv_delay  =  0

	LDA #30
	CMP inv_delay
     BCS .skipL046
.condpart14
	LDA #0
	STA inv_delay
.skipL046
.
 ; 

.
 ; 

.L047 ;  COLUP0  =  52

	LDA #52
	STA COLUP0
.
 ; 

.
 ; 

.L048 ;  if inv_hit  =  0  &&  inv_dir  =  1  &&  inv_delay  =  15 then inv_x  =  inv_x  +  1

	LDA inv_hit
	CMP #0
     BNE .skipL048
.condpart15
	LDA inv_dir
	CMP #1
     BNE .skip15then
.condpart16
	LDA inv_delay
	CMP #15
     BNE .skip16then
.condpart17
	INC inv_x
.skip16then
.skip15then
.skipL048
.L049 ;  if inv_hit  =  0  &&  inv_dir  =  1  &&  inv_delay  =  30 then inv_x  =  inv_x  +  1

	LDA inv_hit
	CMP #0
     BNE .skipL049
.condpart18
	LDA inv_dir
	CMP #1
     BNE .skip18then
.condpart19
	LDA inv_delay
	CMP #30
     BNE .skip19then
.condpart20
	INC inv_x
.skip19then
.skip18then
.skipL049
.
 ; 

.L050 ;  if inv_x  >  143 then inv_dir  =  0  :  inv_x  =  143  :  inv_y  =  inv_y  -  5

	LDA #143
	CMP inv_x
     BCS .skipL050
.condpart21
	LDA #0
	STA inv_dir
	LDA #143
	STA inv_x
	LDA inv_y
	SEC
	SBC #5
	STA inv_y
.skipL050
.
 ; 

.
 ; 

.L051 ;  if inv_hit  =  0  &&  inv_dir  =  0  &&  inv_delay  =  15 then inv_x  =  inv_x  -  1

	LDA inv_hit
	CMP #0
     BNE .skipL051
.condpart22
	LDA inv_dir
	CMP #0
     BNE .skip22then
.condpart23
	LDA inv_delay
	CMP #15
     BNE .skip23then
.condpart24
	DEC inv_x
.skip23then
.skip22then
.skipL051
.L052 ;  if inv_hit  =  0  &&  inv_dir  =  0  &&  inv_delay  =  30 then inv_x  =  inv_x  -  1

	LDA inv_hit
	CMP #0
     BNE .skipL052
.condpart25
	LDA inv_dir
	CMP #0
     BNE .skip25then
.condpart26
	LDA inv_delay
	CMP #30
     BNE .skip26then
.condpart27
	DEC inv_x
.skip26then
.skip25then
.skipL052
.
 ; 

.L053 ;  if inv_x  <  26 then inv_dir  =  1  :  inv_x  =  26  :  inv_y  =  inv_y  -  5

	LDA inv_x
	CMP #26
     BCS .skipL053
.condpart28
	LDA #1
	STA inv_dir
	LDA #26
	STA inv_x
	LDA inv_y
	SEC
	SBC #5
	STA inv_y
.skipL053
.
 ; 

.
 ; 

.L054 ;  player0x  =  inv_x  -  8  :  player0y  =  inv_y

	LDA inv_x
	SEC
	SBC #8
	STA player0x
	LDA inv_y
	STA player0y
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

.draw__move_inv_shot
 ; draw__move_inv_shot

.
 ; 

.L056 ;  player2:

	LDX #<playerL056_2
	STX player2pointerlo
	LDA #>playerL056_2
	STA player2pointerhi
	LDA #9
	STA player2height
.
 ; 

.L057 ;  COLUP2  =  14

	LDA #14
	STA COLUP2
.
 ; 

.L058 ;  inv_fire_delay  =  inv_fire_delay  +  1

	INC inv_fire_delay
.
 ; 

.L059 ;  if inv_fired  =  0  &&  inv_fire_delay  =  180 then inv_shot_x  =  inv_x  :  inv_shot_y  =  inv_y  -  9

	LDA inv_fired
	CMP #0
     BNE .skipL059
.condpart29
	LDA inv_fire_delay
	CMP #180
     BNE .skip29then
.condpart30
	LDA inv_x
	STA inv_shot_x
	LDA inv_y
	SEC
	SBC #9
	STA inv_shot_y
.skip29then
.skipL059
.L060 ;  if inv_fired  =  0  &&  inv_fire_delay  =  180 then player2x  =  inv_shot_x  :  player2y  =  inv_shot_y

	LDA inv_fired
	CMP #0
     BNE .skipL060
.condpart31
	LDA inv_fire_delay
	CMP #180
     BNE .skip31then
.condpart32
	LDA inv_shot_x
	STA player2x
	LDA inv_shot_y
	STA player2y
.skip31then
.skipL060
.L061 ;  if inv_fired  =  0  &&  inv_fire_delay  =  180 then inv_fired  =  1

	LDA inv_fired
	CMP #0
     BNE .skipL061
.condpart33
	LDA inv_fire_delay
	CMP #180
     BNE .skip33then
.condpart34
	LDA #1
	STA inv_fired
.skip33then
.skipL061
.
 ; 

.L062 ;  if inv_fired  =  1 then inv_shot_y  =  inv_shot_y  -  2  :  player2y  =  inv_shot_y

	LDA inv_fired
	CMP #1
     BNE .skipL062
.condpart35
	LDA inv_shot_y
	SEC
	SBC #2
	STA inv_shot_y
	LDA inv_shot_y
	STA player2y
.skipL062
.
 ; 

.L063 ;  if inv_shot_y  <  12 then inv_fired  =  0  :  inv_fire_delay  =  0  :  inv_shot_y  =  88  :  player2y  =  inv_shot_y

	LDA inv_shot_y
	CMP #12
     BCS .skipL063
.condpart36
	LDA #0
	STA inv_fired
	STA inv_fire_delay
	LDA #88
	STA inv_shot_y
	LDA inv_shot_y
	STA player2y
.skipL063
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

.col_shot_inv
 ; col_shot_inv

.L065 ;  if shot_x  +  3  >=  inv_x  &&  shot_x  +  3  <=  inv_x  +  6  &&  shot_y  >  inv_y then inv_hit  =  1  :  sound  =  0

; complex condition detected
	LDA shot_x
	CLC
	ADC #3
; todo: this LDA is spurious and should be prevented ->	LDA  1,x
	CMP inv_x
     BCC .skipL065
.condpart37
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
     BCC .skip37then
.condpart38
	LDA inv_y
	CMP shot_y
     BCS .skip38then
.condpart39
	LDA #1
	STA inv_hit
	LDA #0
	STA sound
.skip38then
.skip37then
.skipL065
.
 ; 

.L066 ;  if inv_hit  =  1 then inv_blast_delay  =  inv_blast_delay  +  1

	LDA inv_hit
	CMP #1
     BNE .skipL066
.condpart40
	INC inv_blast_delay
.skipL066
.
 ; 

.L067 ;  if inv_blast_delay  >  40 then score  =  score  +  10  :  inv_hit  =  0  :  gosub reset_blast

	LDA #40
	CMP inv_blast_delay
     BCS .skipL067
.condpart41
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

.skipL067
.
 ; 

.L068 ;  if inv_hit  =  1 then player0:  

	LDA inv_hit
	CMP #1
     BNE .skipL068
.condpart42
	LDX #<player42then_0
	STX player0pointerlo
	LDA #>player42then_0
	STA player0pointerhi
	LDA #9
	STA player0height
.skipL068
.
 ; 

.L069 ;  return

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

.L070 ;  player0:  

	LDX #<playerL070_0
	STX player0pointerlo
	LDA #>playerL070_0
	STA player0pointerhi
	LDA #9
	STA player0height
.
 ; 

.
 ; 

.L071 ;  inv_blast_delay  =  0  :  inv_x  =   ( rand & 117 )   +  26  :  inv_y  =  76

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

.L072 ;  return

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

.L073 ;  player1:

	LDX #<playerL073_1
	STX player1pointerlo
	LDA #>playerL073_1
	STA player1pointerhi
	LDA #9
	STA player1height
.
 ; 

.
 ; 

.L074 ;  _COLUP1  =  196

	LDA #196
	STA _COLUP1
.
 ; 

.L075 ;  if joy0left  &&  tur_x  >=  26 then tur_x  =  tur_x  -  1

 bit SWCHA
	BVS .skipL075
.condpart43
	LDA tur_x
	CMP #26
     BCC .skip43then
.condpart44
	DEC tur_x
.skip43then
.skipL075
.L076 ;  if joy0right  &&  tur_x  <=  143 then tur_x  =  tur_x  +  1

 bit SWCHA
	BMI .skipL076
.condpart45
	LDA #143
	CMP tur_x
     BCC .skip45then
.condpart46
	INC tur_x
.skip45then
.skipL076
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L077 ;  if tur_hit  =  0 then player1x  =  tur_x  :  player1y  =  tur_y

	LDA tur_hit
	CMP #0
     BNE .skipL077
.condpart47
	LDA tur_x
	STA player1x
	LDA tur_y
	STA player1y
.skipL077
.
 ; 

.L078 ;  return

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

.L079 ;  player3:

	LDX #<playerL079_3
	STX player3pointerlo
	LDA #>playerL079_3
	STA player3pointerhi
	LDA #9
	STA player3height
.
 ; 

.L080 ;  COLUP3  =  14

	LDA #14
	STA COLUP3
.
 ; 

.L081 ;  if joy0fire  &&  tur_fired  =  0 then tur_fired  =  1  :  shot_x  =  tur_x  :  shot_y  =  tur_y  +  1  :  player3x  =  shot_x  :  player3y  =  shot_y  :  sound  =  33

 bit INPT4
	BMI .skipL081
.condpart48
	LDA tur_fired
	CMP #0
     BNE .skip48then
.condpart49
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
	LDA #33
	STA sound
.skip48then
.skipL081
.
 ; 

.L082 ;  if tur_fired  =  1 then shot_y  =  shot_y  +  2  :  player3x  =  shot_x  :  player3y  =  shot_y

	LDA tur_fired
	CMP #1
     BNE .skipL082
.condpart50
	LDA shot_y
	CLC
	ADC #2
	STA shot_y
	LDA shot_x
	STA player3x
	LDA shot_y
	STA player3y
.skipL082
.
 ; 

.L083 ;  if shot_y  >  77  &&  ! joy0fire then tur_fired  =  0  :  shot_y  =  0  :  player3y  =  shot_y

	LDA #77
	CMP shot_y
     BCS .skipL083
.condpart51
 bit INPT4
	BPL .skip51then
.condpart52
	LDA #0
	STA tur_fired
	STA shot_y
	LDA shot_y
	STA player3y
.skip51then
.skipL083
.
 ; 

.L084 ;  return

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

.col_inv_shot_turret
 ; col_inv_shot_turret

.
 ; 

.L085 ;  if inv_shot_x  +  4  >=  tur_x  &&  inv_shot_x  +  2  <=  tur_x  +  6  &&  inv_shot_y  -  5  <  tur_y  - 5 then tur_hit  =  1  :  sound  =  66

; complex condition detected
	LDA inv_shot_x
	CLC
	ADC #4
; todo: this LDA is spurious and should be prevented ->	LDA  1,x
	CMP tur_x
     BCC .skipL085
.condpart53
; complex condition detected
	LDA tur_x
	CLC
	ADC #6
  PHA
	LDA inv_shot_x
	CLC
	ADC #2
  PHA
  TSX
  PLA
  PLA
; todo: this LDA is spurious and should be prevented ->	LDA  2,x
	CMP  1,x
     BCC .skip53then
.condpart54
; complex condition detected
	LDA inv_shot_y
	SEC
	SBC #5
  PHA
	LDA tur_y
	SEC
	SBC #5
  PHA
  TSX
  PLA
  PLA
	CMP  1,x
     BCS .skip54then
.condpart55
	LDA #1
	STA tur_hit
	LDA #66
	STA sound
.skip54then
.skip53then
.skipL085
.
 ; 

.L086 ;  return

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

.play_tur_anim
 ; play_tur_anim

.
 ; 

.L087 ;  tur_anim_frame  =  tur_anim_frame  +  1

	INC tur_anim_frame
.
 ; 

.L088 ;  if tur_anim_frame  =  10 then player1:

	LDA tur_anim_frame
	CMP #10
     BNE .skipL088
.condpart56
	LDX #<player56then_1
	STX player1pointerlo
	LDA #>player56then_1
	STA player1pointerhi
	LDA #9
	STA player1height
.skipL088
.
 ; 

.L089 ;  if tur_anim_frame  =  20 then player1:

	LDA tur_anim_frame
	CMP #20
     BNE .skipL089
.condpart57
	LDX #<player57then_1
	STX player1pointerlo
	LDA #>player57then_1
	STA player1pointerhi
	LDA #9
	STA player1height
.skipL089
.
 ; 

.L090 ;  if tur_anim_frame  =  30 then player1:

	LDA tur_anim_frame
	CMP #30
     BNE .skipL090
.condpart58
	LDX #<player58then_1
	STX player1pointerlo
	LDA #>player58then_1
	STA player1pointerhi
	LDA #9
	STA player1height
.skipL090
.
 ; 

.L091 ;  if tur_anim_frame  =  40 then player1:

	LDA tur_anim_frame
	CMP #40
     BNE .skipL091
.condpart59
	LDX #<player59then_1
	STX player1pointerlo
	LDA #>player59then_1
	STA player1pointerhi
	LDA #9
	STA player1height
.skipL091
.
 ; 

.L092 ;  if tur_anim_frame  =  50 then player1:

	LDA tur_anim_frame
	CMP #50
     BNE .skipL092
.condpart60
	LDX #<player60then_1
	STX player1pointerlo
	LDA #>player60then_1
	STA player1pointerhi
	LDA #9
	STA player1height
.skipL092
.
 ; 

.L093 ;  if tur_anim_frame  =  60 then player1:

	LDA tur_anim_frame
	CMP #60
     BNE .skipL093
.condpart61
	LDX #<player61then_1
	STX player1pointerlo
	LDA #>player61then_1
	STA player1pointerhi
	LDA #9
	STA player1height
.skipL093
.
 ; 

.L094 ;  if tur_anim_frame  =  60 then tur_anim_frame  =  0  :  tur_hit  =  0  :  pfscore2  =  pfscore2  /  4  :  tur_x  =  84  :  tur_y  =  14

	LDA tur_anim_frame
	CMP #60
     BNE .skipL094
.condpart62
	LDA #0
	STA tur_anim_frame
	STA tur_hit
	LDA pfscore2
	lsr
	lsr
	STA pfscore2
	LDA #84
	STA tur_x
	LDA #14
	STA tur_y
.skipL094
.
 ; 

.L095 ;  return

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

.L096 ;  if joy0up then reboot

 lda #$10
 bit SWCHA
	BNE .skipL096
.condpart63
	JMP ($FFFC)
.skipL096
.
 ; 

.L097 ;  player2:

	LDX #<playerL097_2
	STX player2pointerlo
	LDA #>playerL097_2
	STA player2pointerhi
	LDA #26
	STA player2height
.
 ; 

.L098 ;  player3:

	LDX #<playerL098_3
	STX player3pointerlo
	LDA #>playerL098_3
	STA player3pointerhi
	LDA #26
	STA player3height
.
 ; 

.L099 ;  player0x  =  0  :  player0y  =  0

	LDA #0
	STA player0x
	STA player0y
.L0100 ;  player1x  =  0  :  player1y  =  0

	LDA #0
	STA player1x
	STA player1y
.L0101 ;  COLUP0  =  0

	LDA #0
	STA COLUP0
.L0102 ;  COLUP1  =  0

	LDA #0
	STA COLUP1
.
 ; 

.L0103 ;  player2x  =  85  :  player2y  =  66

	LDA #85
	STA player2x
	LDA #66
	STA player2y
.L0104 ;  player3x  =  85  :  player3y  =  39

	LDA #85
	STA player3x
	LDA #39
	STA player3y
.
 ; 

.L0105 ;  drawscreen

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

.L0106 ;  goto game_over

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
player11then_0
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
player13then_0
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
playerL056_2
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
player42then_0
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
playerL070_0
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
playerL073_1
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
playerL079_3
	.byte  %00000000
	.byte  %00000000
	.byte  %00000000
	.byte  %00010000
	.byte  %00010000
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
player56then_1
	.byte  %10110110
	.byte  %01001010
	.byte  %00100100
	.byte  %10010000
	.byte  %01000100
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
player57then_1
	.byte  %11101010
	.byte  %00010100
	.byte  %01000000
	.byte  %00000100
	.byte  %00100000
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
player58then_1
	.byte  %10110110
	.byte  %01001010
	.byte  %00100100
	.byte  %10010000
	.byte  %01000100
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
player59then_1
	.byte  %11101010
	.byte  %00010100
	.byte  %01000000
	.byte  %00000100
	.byte  %00100000
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
player60then_1
	.byte  %10110110
	.byte  %01001010
	.byte  %00100100
	.byte  %10010000
	.byte  %01000100
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
player61then_1
	.byte  %11101010
	.byte  %00010100
	.byte  %01000000
	.byte  %00000100
	.byte  %00100000
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
playerL097_2
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
playerL098_3
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
 
 
 

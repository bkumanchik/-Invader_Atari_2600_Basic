

 
   dim _sc1 = score
   dim _sc2 = score+1
   dim _sc3 = score+2

 rem /** Declare the variable for sound. **/
 dim sounda = a
 sounda = 32
 rem  The C variable is just used for displaying what frequency is being played and the goto's are just for saving cycles, don't know what () does but I've seen it used like that 

main
 scorecolor = scorecolor + 1
 AUDV0 = 0
 if sounda >=132 then goto _skip_0_131
 rem /** increase value.  Kill sound if frequency 31 has been played  **/
 if sounda <= 31 then sounda = sounda + 1 : AUDC0 = 8 : AUDV0 = 4 : AUDF0 = sounda-1 :c=sounda-1
 if sounda >=33 && sounda <= 64 then sounda = sounda + 1 : AUDC0 = 4 : AUDV0 = 4 : AUDF0 = (sounda-34) :c=sounda-34 
 if sounda >=66 && sounda <= 97 then sounda = sounda + 1 : AUDC0 = 2 : AUDV0 = 4 : AUDF0 = (sounda-67) :c=sounda-67
 if sounda >=99 && sounda <= 130 then sounda = sounda + 1 : AUDC0 = 1 : AUDV0 = 4 : AUDF0 = (sounda-100) :c=sounda-100
 goto _skip_132_255
_skip_0_131
 if sounda >=132 && sounda <= 163 then sounda = sounda + 1 : AUDC0 = 7 : AUDV0 = 4 : AUDF0 = (sounda-133) :c=sounda-133
 rem /** decrease value.  Kill sound if frequency 0 has been played  **/
 if sounda >=165 && sounda <= 196 then sounda = sounda - 1 : AUDC0 = 7 : AUDV0 = 4 : AUDF0 = (sounda-164) :c=sounda-164
 if sounda >=198 && sounda <= 229 then sounda = sounda - 1 : AUDC0 = 8 : AUDV0 = 4 : AUDF0 = (sounda-197) :c=sounda-197
 rem  Short loop
 if sounda >=231 then sounda = sounda - 1 : AUDC0 = 10 : AUDV0 = 4 : AUDF0 = sounda-230 :c=sounda-230
 if sounda =230 then sounda=255
_skip_132_255


   if  !joy0fire && !joy0right &&  !joy0up && !joy0down &&  !joy0left && !joy1left &&  !joy1up &&  !joy1down then b{3}=1

 rem /** start playback of sound effects by putting a value in the sound variables **/
 if b{3} &&  joy0fire then b{3}=0:sounda = 0
 if b{3} &&  joy0right then b{3}=0:sounda = 33
 if b{3} &&  joy0up then b{3}=0:sounda = 66
 if b{3} &&  joy0down then b{3}=0:sounda = 99
 if b{3} &&  joy0left then b{3}=0:sounda = 132

 if b{3} &&  joy1left then b{3}=0:sounda = 196
 if b{3} &&  joy1up then b{3}=0:sounda = 229
 if b{3} &&  joy1down then b{3}=0:sounda = 255
 rem  Kill loop or any other sound
 if joy1fire then sounda=32:c=0
 rem  32 65  98 131 164 and 197 works the same so you can just leave the counter there after the sound has played 

   temp4 = sounda

   _sc1 = 0 : _sc2 = _sc2 & 15
   if temp4 >= 100 then _sc1 = _sc1 + 16 : temp4 = temp4 - 100
   if temp4 >= 100 then _sc1 = _sc1 + 16 : temp4 = temp4 - 100
   if temp4 >= 50 then _sc1 = _sc1 + 5 : temp4 = temp4 - 50
   if temp4 >= 30 then _sc1 = _sc1 + 3 : temp4 = temp4 - 30
   if temp4 >= 20 then _sc1 = _sc1 + 2 : temp4 = temp4 - 20
   if temp4 >= 10 then _sc1 = _sc1 + 1 : temp4 = temp4 - 10
   _sc2 = (temp4 * 4 * 4) | _sc2

   temp4 = c

   _sc2 = _sc2 & 240 : _sc3 = 0
   if temp4 >= 100 then _sc2 = _sc2 + 1 : temp4 = temp4 - 100
   if temp4 >= 100 then _sc2 = _sc2 + 1 : temp4 = temp4 - 100
   if temp4 >= 50 then _sc3 = _sc3 + 80 : temp4 = temp4 - 50
   if temp4 >= 30 then _sc3 = _sc3 + 48 : temp4 = temp4 - 30
   if temp4 >= 20 then _sc3 = _sc3 + 32 : temp4 = temp4 - 20
   if temp4 >= 10 then _sc3 = _sc3 + 16 : temp4 = temp4 - 10
   _sc3 = _sc3 | temp4

   drawscreen

 rem /** Start main program loop again **/
 goto main


 ; Declare the variable for sound
 dim sound = t : sound = 32

main
 
 ; audio volume 0 off
 AUDV0 = 0
 
 ; three sounds, increase value, kill sound if frequency 31 has been played
 ; boom sound
 if sound <= 31                then sound = sound + 1 : AUDC0 = 8 : AUDV0 = 4 : AUDF0 = sound -1
 ; pew sound
 if sound >= 33 && sound <= 64 then sound = sound + 1 : AUDC0 = 4 : AUDV0 = 4 : AUDF0 = sound -34
 ; explosion sound
 if sound >= 66 && sound <= 97 then sound = sound + 1 : AUDC0 = 2 : AUDV0 = 4 : AUDF0 = sound -67
  

 if !joy0fire && !joy0up && !joy0down && !joy0left && !joy0right then b{3}=1
 ; start playback of sound effects by putting a value in the sound variables
 if b{3} && joy0fire  then b{3}=0 : sound = 0
 if b{3} && joy0right then b{3}=0 : sound = 33
 if b{3} && joy0up    then b{3}=0 : sound = 66
 
 ; kill loop or any other sound
 if joy1fire then sound = 32


 if !joy0fire && !joy0up && !joy0down && !joy0left && !joy0right then b{3}=1
 ;if !joy0fire && !joy0up && !joy0down && !joy0left && !joy0right then AUDC0 = 1 : AUDV0 = 0 : AUDF0 = 1

 ;if joy0fire  then AUDC0 = 8 : AUDV0 = 4 : AUDF0 = 31
 ;if joy0right then AUDC0 = 4 : AUDV0 = 4 : AUDF0 = -2
 ;if joy0up    then AUDC0 = 2 : AUDV0 = 4 : AUDF0 = -35

 ;if joy0fire  then sound = 0
 ;if joy0right then sound = 33
 ;if joy0up    then sound = 66
 
 
   drawscreen


 ; start main program loop again
 goto main

 rem /** Declare the 2 variables for sound.  Putting higher values in changes the duration and sound **/
 dim sounda = a
 dim soundb = b

main
 rem /** if a sound variable is greater than 0 play sound effect and decrease its value.  Kill sound if 0 **/
 if sounda > 0 then sounda = sounda - 1 : AUDC0 = 8 : AUDV0 = 4 : AUDF0 = sounda else AUDV0 = 0
 if soundb > 0 then soundb = soundb - 1 : AUDC1 = 2 : AUDV1 = 4 : AUDF1 = soundb else AUDV1 = 0

 rem /** if FIRE or up is pressed start playback of sound effects by putting a value in the sound variables **/
 if joy0fire then sounda = 50
 if joy0up then soundb = 50

 rem /** Start main program loop again **/
 goto main
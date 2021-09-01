

 rem /** Declare the variable for sound. **/
 dim sounda = a : sounda = 32
 

main ; main loop -----------------------------------------------------
 
 AUDV0 = 0 

 if joy0right then AUDC0 = 4 : AUDV0 = 4 : AUDF0 = (sounda-34)
 ;if joy0right then AUDC0 = 1 : AUDV0 = 1 : AUDF0 = 2


 drawscreen

 goto main ; end main loop -------------------------------------------






 ; enables pf score bars
 const pfscore = 0

 dim reducing_lives = p : p = 0 ; reducing_lives - set to false

 ; sets pfscore2 (right bar - 1 is left bar) 
 pfscore2 = %00101010 ; 3 lives instead of the default 4 (%10101010)



main ; main loop -----------------------------------------------------
 ; pf score color - green
 pfscorecolor = 196 

 ; score color - white
 scorecolor = 14 
 
 ; if fire button pressed is true and reducing lives is false then gosub reduce_lives
 if joy0fire && reducing_lives = 0 then gosub reduce_lives

 ; if fire button pressed is false then set reducing lives to false
 if ! joy0fire then reducing_lives = 0

 drawscreen

 goto main ; end main loop -------------------------------------------



; reduce lives 
reduce_lives

 ; set reducing lives back to true
 reducing_lives = 1
 ; reduce life counter - divide by 4
 pfscore2 = pfscore2 / 4

 return



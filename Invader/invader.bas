 rem Generated 11/20/2020 11:29:39 AM by Visual bB Version 1.0.0.568
 rem **********************************
 rem *<filename>                      *
 rem *<description>                   *
 rem *<author>                        *
 rem *<contact info>                  *
 rem *<license>                       *
 rem **********************************

 rem Generated 11/16/2020 11:39:59 AM by Visual bB Version 1.0.0.568
 rem **********************************
 rem *<filename>                      *
 rem *<description>                   *
 rem *<author>                        *
 rem *<contact info>                  *
 rem *<license>                       *
 rem **********************************

 playfield:
 ................................
 ................................
 ................................
 ................................
 ................................
 ................................
 ................................
 ................................
 ................................
 ................................
 ................................
end


 COLUBK = 0 
 COLUPF = 246 
 scorecolor = $68 

 player0x = 50 : player0y = 85
 player1x = 20 : player1y = 12
 missile0height = 1 : missile0y = 255
 NUSIZ0 = 16

sprites

 COLUP0 = 194
 player0:
 %11111110
 %11111110
 %01111100
 %00010000
 %00000000
 %00000000
 %00000000
 %00000000
end

 COLUP1=54
 player1:
 %00000000
 %10000010
 %01000100
 %11111110
 %11111110
 %10111010
 %01111100
 %10000010
end


 if missile0y > 240 then goto skip
 missile0y = missile0y - 2 : goto draw_loop

skip
 if joy0fire then missile0y = player0y - 7 : missile0x = player0x + 4


draw_loop
 drawscreen

 rem if player1y<player0y then player1y = player1y+1
 rem if player1y>player0y then player1y = player1y-1
 rem if player1x<player0x then player1x = player1x+1
 rem if player1x>player0x then player1x = player1x-1
 rem player1x=player1x:player1y=player1y

 rem if joy0up then player0y=player0y-1:goto jump
 rem if joy0down then player0y=player0y+1:goto jump
 if joy0left then player0x = player0x - 1 : rem goto jump
 if joy0right then player0x = player0x + 1 : rem goto jump

 if collision(missile0,player1) then score = score + 10 : player1x = rand / 2 : player1y = 12 : missile0y = 255
 rem if collision(player0,player1) then score=score-1: player1x=rand/2:player1y=0:missile0y=255

 rem jump
 goto sprites



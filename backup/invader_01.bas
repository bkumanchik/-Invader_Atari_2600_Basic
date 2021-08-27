 ; Started 8/25/21 Invader Atari 2600 Batari Basic using Visual bB IDE 

 

 ; misc. variables --
 scorecolor = 14 
 
 ; invader variables --
 dim invader_x = a : a = 76
 dim invader_y = b : b = 11 
 dim inv_delay = c : c = 0
 dim inv_dir   = f : f = 1
 
 ; turret variables --
 dim turret_x = d : d = 76
 dim turret_y = e : e = 85

 ; player1x = 20 : player1y = 12
 ; missile0height = 1 : missile0y = 255
 
 ; NUSIZ0 = 16



 rem -- main loop -------------------------------------------------------------------------------
main 
 gosub draw__move_turret
 gosub draw__move_invader
 ; gosub draw__move_inv_shot

 drawscreen
 
 


 goto main
 ; end main loop ---------------------------------------------------------------------------




 ; ----- subroutines ----- 
draw__move_invader

 inv_delay = inv_delay + 1

 ; invader_a sprite
 if inv_delay = 12 then player0:  
 %00000000
 %10000010
 %01000100
 %11111110
 %11111110
 %10111010
 %01111100
 %10000010
end

 ; invader_b sprite
 if inv_delay = 24 then player0:  
 %00000000
 %00101000
 %01000100
 %11111110
 %11111110
 %10111010
 %01111100
 %01000100
end
 
 if inv_delay > 24 then inv_delay = 0 

 ; invader color orange
 COLUP0 = 52
 
 ; move invader right
 if inv_dir = 1 && inv_delay = 12 then invader_x = invader_x + 1
 if inv_dir = 1 && inv_delay = 24 then invader_x = invader_x + 1
 ; check for right edge then drop and reverse direction
 if invader_x > 135 then inv_dir = 0 : invader_x = 135 : invader_y = invader_y + 5

 ; move invader left
 if inv_dir = 0 && inv_delay = 12 then invader_x = invader_x - 1
 if inv_dir = 0 && inv_delay = 24 then invader_x = invader_x - 1
 ; check for left edge then drop and reverse direction
 if invader_x < 20 then inv_dir = 1 : invader_x = 20 : invader_y = invader_y + 5

 player0x = invader_x : player0y = invader_y
 return





 rem draw__move_inv_shot
 rem 
 rem  player2:
 rem  %00000000
 rem  %00000000
 rem  %00010000
 rem  %00100000
 rem  %00010000
 rem  %00001000
 rem  %00010000
 rem  %00000000
 rem end
 rem 
 rem  COLUP0 = 14
 rem 
 rem  player0x = invader_x : player0y = invader_y
 rem 
 rem  return
 rem 




draw__move_turret

 player1:
 %11111110
 %11111110
 %01111100
 %00010000
 %00000000
 %00000000
 %00000000
 %00000000
end

 ; turret color green
 COLUP1 = 196
 
 if joy0left && turret_x > 20 then turret_x = turret_x - 1 
 if joy0right && turret_x < 135 then turret_x = turret_x + 1
 
 player1x = turret_x : player1y = turret_y 
 
 return








 rem  if missile0y > 240 then goto skip
 rem  missile0y = missile0y - 2 : goto draw_loop
 
 rem  if joy0fire then missile0y = player0y - 7 : missile0x = player0x + 4
 



 rem if player1y<player0y then player1y = player1y+1
 rem if player1y>player0y then player1y = player1y-1
 rem if player1x<player0x then player1x = player1x+1
 rem if player1x>player0x then player1x = player1x-1
 rem player1x=player1x:player1y=player1y


 if collision(missile0,player1) then score = score + 10 : player1x = rand / 2 : player1y = 12 : missile0y = 255
 rem if collision(player0,player1) then score=score-1: player1x=rand/2:player1y=0:missile0y=255

 rem jump



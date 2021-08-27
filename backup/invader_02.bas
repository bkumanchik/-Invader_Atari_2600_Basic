 ; Started 8/25/21 Invader Atari 2600 Batari Basic using Visual bB IDE 

 
 
 ; Kernel setup (for using more than 2 players - allows sprites 0 through 5) 
 includesfile multisprite_bankswitch.inc 
 set kernel multisprite
 set romsize 8k

 ; misc. variables --
 scorecolor = 14 
 
 ; invader variables --
 dim invader_x  = a : a = 76
 dim invader_y  = b : b = 77 ; 88(top of screen) - 11(original sprite distance from top) 
 dim inv_delay  = c : c = 0
 dim inv_dir    = f : f = 0
 dim inv_shot_x = g : g = 76
 dim inv_shot_y = h : h = 44
 
 ; turret variables --
 dim turret_x = d : d = 76
 dim turret_y = e : e = 14 ; 0(bottom of screen) - 8(sprite height) - 3(original sprite distance from bottom)
 dim shot_x   = i : i = 76
 dim shot_y   = j : j = turret_y +13

 ; player1x = 20 : player1y = 12
 ; missile0height = 1 : missile0y = 255
 
 ; NUSIZ0 = 16



 rem -- main loop -------------------------------------------------------------------------------
main 
 
 gosub draw__move_turret 
 gosub draw__move_turret_shot
 gosub draw__move_invader
 gosub draw__move_inv_shot

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
 if invader_x > 135 then inv_dir = 0 : invader_x = 135 : invader_y = invader_y - 5

 ; move invader left
 if inv_dir = 0 && inv_delay = 12 then invader_x = invader_x - 1
 if inv_dir = 0 && inv_delay = 24 then invader_x = invader_x - 1
 ; check for left edge then drop and reverse direction
 if invader_x < 18 then inv_dir = 1 : invader_x = 20 : invader_y = invader_y - 5

 player0x = invader_x : player0y = invader_y
 return





draw__move_inv_shot

 player2:
 %00000000
 %00000000
 %00010000
 %00100000
 %00010000
 %00001000
 %00010000
 %00000000
end

 COLUP2 = 14

 player2x = inv_shot_x : player2y = inv_shot_y

 return





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
 _COLUP1 = 196 ; (use underscore for sprite #1 color when using more than 2 players)
 
 if joy0left  && turret_x >= 26 then turret_x = turret_x - 1 
 if joy0right && turret_x <= 143 then turret_x = turret_x + 1

 ;if joy0up   then turret_y = turret_y + 1
 ;if joy0down then turret_y = turret_y - 1
 
 player1x = turret_x : player1y = turret_y 
 
 return





draw__move_turret_shot

 player3:
 %00000000
 %00000000
 %00000000
 %00010000
 %00010000
 %00000000
 %00000000
 %00000000



end

 COLUP3 = 14

 player3x = shot_x : player3y = shot_y

 return


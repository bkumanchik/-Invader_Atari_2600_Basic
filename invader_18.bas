; Started 8/25/21 Invader Atari 2600 Batari Basic using Visual bB IDE 


; to do: turret explosion - reset in center, sound

 
 ; Kernel setup (for using more than 2 players - allows sprites 0 through 5) (swaps Y direction for screen)
 includesfile multisprite_bankswitch.inc
 set kernel_options no_blank_lines

 set kernel multisprite
 set romsize 8k

 ; enables pf score bars
 const pfscore = 0


; misc. variables --
 dim reducing_lives   = p : p = 0 ; reducing_lives - set to false
 ; sets pfscore2 (right bar - 1 is left bar) 
 pfscore2 = %00101010 ; 3 lives instead of the default 4 (%10101010)
 
; invader variables --
 dim inv_x            = a : a = 84
 dim inv_y            = b : b = 76 ; 88(top of screen) - 11(original sprite distance from top) 
 dim inv_delay        = c : c = 0
 dim inv_dir          = f : f = 1
 dim inv_shot_x       = g : g = inv_x
 dim inv_shot_y       = h : h = inv_y
 dim inv_fire_delay   = k : k = 0
 dim inv_fired        = l : l = 0
 dim inv_hit          = n : n = 0
 dim inv_blast_delay  = o : o = 0
 
; turret variables --
 dim tur_x            = d : d = 84
 dim tur_y            = e : e = 14 ; 0(bottom of screen) - 8(sprite height) - 3(original sprite distance from bottom)
 dim shot_x           = i : i = tur_x
 dim shot_y           = j : j = tur_y
 dim tur_fired        = m : m = 0
 dim tur_hit	    = q : q = 0 
 dim tur_anim_playing = r : r = 0
 dim tur_anim_frame   = s : s = 0
 dim tur_anim_delay   = t : t = 0


; -- main loop -------------------------------------------------------------------------------
main 
 
 gosub draw__move_turret 
 gosub draw__move_turret_shot
 gosub draw__move_invader
 gosub draw__move_inv_shot
 gosub col_shot_inv
 gosub col_inv_shot_turret

 if pfscore2 < 2 then goto game_over

 ; pf score color - green
 pfscorecolor = 196 

 ; score color - white
 scorecolor = 152


 drawscreen

 goto main
; -- end main loop ---------------------------------------------------------------------------



; ----- subroutines ----- 
 
; draw and move invader
draw__move_invader

 inv_delay = inv_delay + 1

 ; invader_a sprite
 if inv_delay = 15 && inv_hit = 0 then player0:  
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
 if inv_delay = 30 && inv_hit = 0 then player0:  
 %00000000
 %00101000
 %01000100
 %11111110
 %11111110
 %10111010
 %01111100
 %01000100
end
 
 if inv_delay > 30 then inv_delay = 0 

 ; invader color orange
 COLUP0 = 52
 
 ; move invader right - if not hit
 if inv_hit = 0 && inv_dir = 1 && inv_delay = 15 then inv_x = inv_x + 1
 if inv_hit = 0 && inv_dir = 1 && inv_delay = 30 then inv_x = inv_x + 1
 ; check for right edge then drop and reverse direction
 if inv_x > 143 then inv_dir = 0 : inv_x = 143 : inv_y = inv_y - 5

 ; move invader left - if not hit
 if inv_hit = 0 && inv_dir = 0 && inv_delay = 15 then inv_x = inv_x - 1
 if inv_hit = 0 && inv_dir = 0 && inv_delay = 30 then inv_x = inv_x - 1
 ; check for left edge then drop and reverse direction
 if inv_x < 26 then inv_dir = 1 : inv_x = 26 : inv_y = inv_y - 5

 ; (the - 8 is a correction for sprite0 with bank switching enabled)
 player0x = inv_x - 8 : player0y = inv_y
 return



; draw and move invader shot 
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
 
 inv_fire_delay = inv_fire_delay + 1

 if inv_fired = 0 && inv_fire_delay = 180 then inv_shot_x = inv_x : inv_shot_y = inv_y - 9
 if inv_fired = 0 && inv_fire_delay = 180 then player2x = inv_shot_x : player2y = inv_shot_y
 if inv_fired = 0 && inv_fire_delay = 180 then inv_fired = 1

 if inv_fired = 1 then inv_shot_y = inv_shot_y - 2 : player2y = inv_shot_y
 
 if inv_shot_y < 12 then inv_fired = 0 : inv_fire_delay = 0 : inv_shot_y = 88 : player2y = inv_shot_y

 return



; check collision between turret shot and invader
col_shot_inv 
 if shot_x + 3 >= inv_x && shot_x + 3 <= inv_x + 6 && shot_y > inv_y then inv_hit = 1 

 if inv_hit = 1 then inv_blast_delay = inv_blast_delay + 1

 if inv_blast_delay > 30 then score = score + 10 : inv_hit = 0 : gosub reset_blast 

 if inv_hit = 1 then player0:  
 %00000000
 %10010010
 %01010100
 %00000000
 %11010110
 %00000000
 %01010100
 %10010010
end 

 return



; reset invader sprite and position
reset_blast
 player0:  
 %00000000
 %10000010
 %01000100
 %11111110
 %11111110
 %10111010
 %01111100
 %10000010
end
 
 ; reset random x position between 26 and 143
 inv_blast_delay = 0 : inv_x = (rand&117) + 26 : inv_y = 76 
 
 return



; draw and move turret
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
 
 if joy0left  && tur_x >= 26 then tur_x = tur_x - 1 
 if joy0right && tur_x <= 143 then tur_x = tur_x + 1

 ;if joy0up   then tur_y = tur_y + 1
 ;if joy0down then tur_y = tur_y - 1
 
 player1x = tur_x : player1y = tur_y 
 
 return



; draw and move turret shot 
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

 if joy0fire && tur_fired = 0 then tur_fired = 1 : shot_x = tur_x : shot_y = tur_y + 1 : player3x = shot_x : player3y = shot_y

 if tur_fired = 1 then shot_y = shot_y + 2 : player3x = shot_x : player3y = shot_y

 if shot_y > 77 && ! joy0fire then tur_fired = 0 : shot_y = 0 : player3y = shot_y

 return

 

 ; check collision between invader shot and turret
col_inv_shot_turret

 if inv_shot_x + 4 >= tur_x  && inv_shot_x + 2 <= tur_x + 6 && inv_shot_y - 5 < tur_y -5 then tur_hit = 1

 if tur_hit = 1 then tur_anim_playing = 1 : gosub play_tur_anim

 return



play_tur_anim

 

 ; pfscore2 = pfscore2 / 4
 ; if inv_blast_delay > 30 then score = score + 10 : inv_hit = 0 : gosub reset_blast
  


 return



game_over

 if joy0up then reboot

 ;score = 50
 
 player2:
 %00000000
 %00000000
 %00000000
 %00000000
 %00000000
 %11111000
 %10000000
 %11000000
 %10000000
 %11111000
 %00000000
 %10001000
 %10001000
 %10101000
 %11111000
 %00000000
 %10001000
 %11111000
 %10001000
 %11111000
 %00000000
 %11111000
 %10001000
 %10000000
 %11111000
end
 
 player3:
 %00000000
 %00000000
 %00000000
 %00000000
 %00000000
 %10001000
 %11110000
 %10001000
 %11111000
 %00000000
 %11111000
 %10000000
 %11000000
 %10000000
 %11111000
 %00000000
 %00100000
 %01010000
 %10001000
 %10001000
 %00000000
 %11111000
 %10001000
 %10001000
 %11111000
end 

 player0x = 0 : player0y = 0 
 player1x = 0 : player1y = 0
 COLUP0 = 0
 COLUP1 = 0

 player2x = 85 : player2y = 66
 player3x = 85 : player3y = 39

 drawscreen

 goto game_over

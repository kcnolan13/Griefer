if not varRead("controllable") or in_snare(id) return false


///Roll
if hold > 0 exit
//don't roll if sliding
if (slide_right = 1 || slide_left = 1)
exit

//roll
if pressing_left() or (not pressing_right() and varRead("animation_xscale") = -1)
    hsp = -15/mass*varRead("speed_multiplier")
else
    hsp = 15/mass*varRead("speed_multiplier")
    
roll_dir = sign(hsp)
    
varWrite("animation_speed",SPD_ROLL*sign(hsp)*sign(varRead("animation_xscale")))
    
if net_manager.local_player = id
    audio_play_sound(snd_roll,2,false)

rolling = 1
redirect_counter = 15
animation_roll()
sprite_index = spr_player_crawl
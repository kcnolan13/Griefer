if not varRead("controllable") or in_snare(id) return false


///Roll
if hold > 0 or roll_timer > 0
    exit
    
update_physics = true

//roll
if pressing_left() or (not pressing_right() and varRead("animation_xscale") = -1)
    hsp = -1*roll_speed/mass*varRead("speed_multiplier")
else
    hsp = roll_speed/mass*varRead("speed_multiplier")
    
if slide_right
{
    hsp = abs(hsp)
    bail_slide_timer = 0
    wall_delay = wall_delay_max
    slide_right = 0
}
else if slide_left
{
    hsp = -1*abs(hsp)
    bail_slide_timer = 0
    wall_delay = wall_delay_max
    slide_left = 0
}

roll_dir = sign(hsp)

varWrite("animation_speed",SPD_ROLL*sign(hsp)*sign(varRead("animation_xscale")))

if net_manager.local_player = id
    audio(snd_roll,1)

roll_timer = roll_timer_max
rolling = 1
redirect_counter = 15
animation_roll()
sprite_index = spr_player_crawl

if was_standing
    continue_standing = true

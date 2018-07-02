/// @description initialize
event_inherited()

//graphics
varWrite("flash_hitscan",flash_hitscan_simple_long)
varWrite("sprite",spr_none)
varWrite("headshot_difficulty",4)
traj_draw = true
traj_length = 64*25
traj_intensity = 1
traj_yscale = 0.75
traj_xscale = 0.25
traj_life = 25
traj_color = make_color_rgb(255,255,255);
traj_intensity_divisor = 1.25
traj_intensity_flicker = 0
traj_scale_divisor = 1
traj_scale_flicker = 0
traj_sprite = spr_hitscan_trail //must be width 300ish
traj_xscale_divisor = 1.25

//engine
varWrite("sound",snd_double)
//if not audio_is_playing(varRead("sound"))
    bullet_sound()

varWrite("body_death_type","die")
varWrite("gib_distance",64*6)
varWrite("headshot_distance",64*2.5)
varWrite("hitscan",false)
varWrite("deceleration",4)
varWrite("min_speed",45)

//damage
varWrite("damage_body",48)
varWrite("damage_head",52)

//damage falloff
varWrite("falloff_x1",64*2)
varWrite("falloff_y1",1)
varWrite("falloff_x2",64*13)
varWrite("falloff_y2",0.25)
varWrite("falloff_x3",64*32)
varWrite("falloff_y3",0.05)


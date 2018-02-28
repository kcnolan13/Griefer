/// @description initialize
event_inherited()

//graphics
varWrite("sprite",spr_none)//spr_bullet_lmg
traj_draw = true
traj_length = 64*8
traj_intensity = 1
traj_yscale = 0.9
traj_xscale = 0.4
traj_life = 15
traj_color = make_color_rgb(210,255,210)
traj_intensity_divisor = 1.4
traj_intensity_flicker = 0
traj_scale_divisor = 1
traj_scale_flicker = 0
traj_sprite = spr_hitscan_trail //must be width 300ish
traj_xscale_divisor = 1.8

//engine
varWrite("sound",snd_lmg)
    bullet_sound()

varWrite("body_death_type","die")
varWrite("gib_distance",-1)
varWrite("hitscan",false)

//damage
varWrite("damage_body",32)
varWrite("damage_head",40)

//damage falloff
varWrite("falloff_x1",64*6)
varWrite("falloff_y1",1)
varWrite("falloff_x2",64*8)
varWrite("falloff_y2",0.9)
varWrite("falloff_x3",64*25)
varWrite("falloff_y3",0.6)


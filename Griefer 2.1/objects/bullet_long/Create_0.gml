/// @description initialize
event_inherited()

//graphics
varWrite("flash_hitscan",flash_hitscan_simple_long)
varWrite("sprite",spr_none)
traj_draw = true
traj_length = 64*8
traj_intensity = 1
traj_yscale = 0.6
traj_xscale = 0.25
traj_life = 15
traj_color = make_color_rgb(255,235,200);
traj_intensity_divisor = 1.4
traj_intensity_flicker = 0
traj_scale_divisor = 1
traj_scale_flicker = 0
traj_sprite = spr_hitscan_trail //must be width 300ish
traj_xscale_divisor = 1.825

//engine
varWrite("sound",snd_longshot)
    bullet_sound()

varWrite("body_death_type","die")
varWrite("gib_distance",-1)
varWrite("hitscan",true)
varWrite("gravity",0)

//damage
varWrite("damage_body",125)
varWrite("damage_head",1000)

//damage falloff
/*
varWrite("falloff_x1",64*4)
varWrite("falloff_y1",1)
varWrite("falloff_x2",64*15)
varWrite("falloff_y2",0.9)
varWrite("falloff_x3",64*20)
varWrite("falloff_y3",0.6)*/

/* */
/*  */

/// @description initialize
event_inherited()

//graphics
varWrite("flash_hitscan",flash_hitscan_simple_vulcan)
varWrite("sprite",spr_none)
traj_draw = true
traj_length = 64*8
traj_intensity = 1
traj_yscale = 0.3
traj_xscale = 0.25
traj_life = 10
traj_color = make_color_rgb(255,180,255);
traj_intensity_divisor = 1.8
traj_intensity_flicker = 0
traj_scale_divisor = 1
traj_scale_flicker = 0
traj_sprite = spr_hitscan_trail //must be width 300ish
traj_xscale_divisor = 1.825

//engine
varWrite("sound",snd_vulcan)
    bullet_sound()

varWrite("body_death_type","die")
varWrite("gib_distance",-1)
varWrite("hitscan",true)
varWrite("gravity",0)

//damage
varWrite("damage_body",13)
varWrite("damage_head",18)

//damage falloff
/*
varWrite("falloff_x1",64*4)
varWrite("falloff_y1",1)
varWrite("falloff_x2",64*15)
varWrite("falloff_y2",0.9)
varWrite("falloff_x3",64*20)
varWrite("falloff_y3",0.6)*/

/*///initialize
event_inherited()

//graphics
varWrite("sprite",spr_none)//spr_bullet_lmg
traj_draw = true
traj_length = 64*10
traj_intensity = 1
traj_yscale = 0.5
traj_xscale = 0.4
traj_life = 20
traj_color = make_color_rgb(255,210,255)
traj_intensity_divisor = 1.3
traj_intensity_flicker = 0
traj_scale_divisor = 1
traj_scale_flicker = 0
traj_sprite = spr_hitscan_trail //must be width 300ish
traj_xscale_divisor = 1.8

//engine
varWrite("sound",snd_vulcan)
    bullet_sound()

varWrite("body_death_type","die")
varWrite("gib_distance",-1)
varWrite("hitscan",true)

//damage
varWrite("damage_body",22)
varWrite("damage_head",25)

//damage falloff
varWrite("falloff_x1",64*6)
varWrite("falloff_y1",1)
varWrite("falloff_x2",64*8)
varWrite("falloff_y2",0.9)
varWrite("falloff_x3",64*25)
varWrite("falloff_y3",0.6)*/

/* */
/*  */

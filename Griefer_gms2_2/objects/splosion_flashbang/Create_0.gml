/// @description configure splosion
event_inherited()

//DAMAGE
audio(snd_flashbang,1)
radius = 64*6
damage = 150
varWrite("falloff_x1",radius/3)
varWrite("falloff_y1",1)
varWrite("falloff_x2",radius*2/3)
varWrite("falloff_y2",0.8)
varWrite("falloff_x3",radius)
varWrite("falloff_y3",0)

//engine
varWrite("body_death_type","die")
varWrite("gib_distance",radius/4)

//visuals
sprite = spr_light_mask_splosion;
rubble_obj = rubble
intensity = 9
xscale = radius/360/1.5
yscale = radius/360/1.5
life = 30                           //make sure around long enough to deal damage
color = make_color_rgb(255,255,255)
intensity_divisor = 1.18
intensity_flicker = 0.2
scale_divisor = 1.025
scale_flicker = 0.05

//sync muzzle flash with light params
flash_update_light()


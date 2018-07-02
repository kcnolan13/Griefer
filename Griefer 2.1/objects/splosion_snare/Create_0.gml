/// @description properties
event_inherited()

initialize_physics()

audio(snd_snare,1)
counter = 0
part_off = 64*1.5

pnames_snared = 0
snare_index = 0

speed_multiplier = random_range(0.12,0.15)

snare_radius = 64*3.5

life = 30*6
part_life = 5*30

sys_smoke = part_system_create()

ps = part_type_create()
part_type_alpha3(ps,0.25,1,0)
part_type_shape(ps,pt_shape_smoke)
part_type_colour_mix(ps,make_color_rgb(0,0,0),make_color_rgb(50,110,210))
part_type_life(ps,3/4*part_life,part_life)
part_type_size(ps,1,8,0.025,0)
part_type_direction(ps,0,360,0,0.25)

part_type_blend(ps,true)
part_system_depth(sys_smoke,depth)

em = part_emitter_create(sys_smoke)
part_emitter_region(sys_smoke,em,x-random(part_off),x+random(part_off),y-random(part_off),y+random(part_off),ps_shape_ellipse,ps_distr_gaussian)

part_emitter_burst(sys_smoke,em,ps,6)

//engine
varWrite("body_death_type","die")
varWrite("gib_distance",-1)

//visuals
sprite = spr_light_mask_splosion;
rubble_obj = rubble
intensity = 8
xscale = radius/360/1.5
yscale = radius/360/1.5
color = make_color_rgb(150,75,225)
intensity_divisor = 1.9
intensity_flicker = 0.2
scale_divisor = 1.025
scale_flicker = 0.05

//DAMAGE
radius = 64*6
damage = 0
varWrite("falloff_x1",0)
varWrite("falloff_y1",0)
varWrite("falloff_x2",radius*2.25/3)
varWrite("falloff_y2",0)
varWrite("falloff_x3",radius)
varWrite("falloff_y3",0)


//sync muzzle flash with light params
flash_update_light()


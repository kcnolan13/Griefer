/// @description ALL IT NEEDS TO DO IS MAKE SMOKE -- NO PARENTS!!
netvars = ds_map_create()
initialize_physics()

audio(snd_smoke,1)
counter = 0
part_off = 64*2

life = 30*15/2
part_life = 10*30

sys_smoke = part_system_create()

ps = part_type_create()
part_type_alpha3(ps,0.1,1,0)
part_type_shape(ps,pt_shape_smoke)
part_type_colour_mix(ps,make_color_rgb(0,0,0),make_color_rgb(200,200,200))
part_type_life(ps,3/4*part_life,part_life)
part_type_size(ps,10,30,0.025,0)
part_type_direction(ps,60,120,0,0.25)
part_system_depth(sys_smoke,depth)

em = part_emitter_create(sys_smoke)
part_emitter_region(sys_smoke,em,x-random(part_off),x+random(part_off),y-random(part_off),y+random(part_off),ps_shape_ellipse,ps_distr_gaussian)

part_emitter_burst(sys_smoke,em,ps,4)

computed_challenge = false


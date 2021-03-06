/// @description particle systems
counter = 0

sys_flame = part_system_create()
flame_part_life = 5*30
part_flame = part_type_create()
part_system_depth(sys_flame,-82)
part_type_alpha3(part_flame,0.25,1,0)
part_type_shape(part_flame,pt_shape_smoke)
part_type_colour_mix(part_flame,make_color_rgb(60,40,0),make_color_rgb(255,90,40))
part_type_life(part_flame,3/4*flame_part_life,flame_part_life)
part_type_size(part_flame,0.1,7,0.025,0)
part_type_direction(part_flame,45,135,0,0.25)
part_type_blend(part_flame,true)

part_flame_small = part_type_create()
part_type_alpha3(part_flame_small,1,1,0)
part_type_shape(part_flame_small,pt_shape_smoke)
part_type_colour_mix(part_flame_small,make_color_rgb(60,40,0),make_color_rgb(255,90,40))
part_type_life(part_flame_small,1/6*flame_part_life,1/4*flame_part_life)
part_type_size(part_flame_small,0.1,1,0.025,0)
part_type_direction(part_flame_small,60,120,0,0.25)
part_type_speed(part_flame_small,0,6,0.015,0.1)
part_type_blend(part_flame_small,true)

part_ink_trail = part_type_create()
part_type_alpha3(part_ink_trail,0.25,1,0)
part_type_shape(part_ink_trail,pt_shape_smoke)
part_type_colour_mix(part_ink_trail,make_color_rgb(0,0,0),make_color_rgb(60,25,112))
part_type_life(part_ink_trail,10,60)
part_type_size(part_ink_trail,0.3,1.5,0.025,0)
part_type_direction(part_ink_trail,60,120,0,0.25)
part_type_speed(part_ink_trail,0,3,0.015,0.1)
part_type_blend(part_ink_trail,true)

part_snare_trail = part_type_create()
part_type_alpha3(part_snare_trail,0.25,1,0)
part_type_shape(part_snare_trail,pt_shape_smoke)
part_type_colour_mix(part_snare_trail,make_color_rgb(0,0,0),make_color_rgb(25,100,200))
part_type_life(part_snare_trail,5,20)
part_type_size(part_snare_trail,0.6,0.6,-0.025,0)
part_type_direction(part_snare_trail,0,360,0,0.25)
part_type_speed(part_snare_trail,0,5,0.015,0.1)
part_type_blend(part_snare_trail,true)

part_frag_trail = part_type_create()
part_type_alpha3(part_frag_trail,0.25,1,0)
part_type_shape(part_frag_trail,pt_shape_smoke)
part_type_colour_mix(part_frag_trail,make_color_rgb(0,0,0),make_color_rgb(255,100,100))
part_type_life(part_frag_trail,8,8)
part_type_size(part_frag_trail,0.9,0.9,-0.1,0)
part_type_direction(part_frag_trail,60,120,0,0.25)
part_type_speed(part_frag_trail,0,0,0.015,0.1)
part_type_blend(part_frag_trail,true)

part_sticky_trail = part_type_create()
part_type_alpha3(part_sticky_trail,0.25,1,0)
part_type_shape(part_sticky_trail,pt_shape_smoke)
part_type_colour_mix(part_sticky_trail,make_color_rgb(0,0,0),make_color_rgb(100,255,100))
part_type_life(part_sticky_trail,10,10)
part_type_size(part_sticky_trail,0.6,0.6,-0.075,0)
part_type_direction(part_sticky_trail,60,120,0,0.25)
part_type_speed(part_sticky_trail,0,0,0.015,0.1)
part_type_blend(part_sticky_trail,true)

part_smoke_trail = part_type_create()
part_type_alpha3(part_smoke_trail,0.25,0.6,0)
part_type_shape(part_smoke_trail,pt_shape_smoke)
part_type_colour2(part_smoke_trail,c_white,c_black)
part_type_life(part_smoke_trail,10,60)
part_type_size(part_smoke_trail,0.1,1,0.025,0)
part_type_direction(part_smoke_trail,60,120,0,0.25)
part_type_speed(part_smoke_trail,0,3,0.015,0.1)
part_type_blend(part_smoke_trail,false)

part_flame_trail = part_type_create()
part_type_alpha3(part_flame_trail,1,1,0)
part_type_shape(part_flame_trail,pt_shape_smoke)
part_type_colour_mix(part_flame_trail,make_color_rgb(60,40,0),make_color_rgb(255,90,40))
part_type_life(part_flame_trail,10,45)
part_type_size(part_flame_trail,0.05,0.5,0.025,0)
part_type_direction(part_flame_trail,60,120,0,0.25)
part_type_speed(part_flame_trail,0,5,0.015,0.1)
part_type_blend(part_flame_trail,true)


sys_missile = 0
sys_missile = part_system_create()
missile_part1 = part_type_create()
part_system_depth(sys_missile,-82)
part_type_shape(missile_part1,pt_shape_smoke)
part_type_size(missile_part1,0.3,0.4,0.01,0)
part_type_colour2(missile_part1,c_white,c_black)
part_type_alpha3(missile_part1,0.7,0.3,0)
part_type_life(missile_part1,2,65)
part_type_direction(missile_part1,0,360,0,0)
part_type_speed(missile_part1,0,5,-0.5,0)

sys_rocket = 0
sys_rocket = part_system_create()
rocket_part1 = part_type_create()
part_system_depth(sys_rocket,-82)
part_type_shape(rocket_part1,pt_shape_smoke)
part_type_size(rocket_part1,0.45,0.55,0.01,0)
part_type_colour2(rocket_part1,c_white,c_black)
part_type_alpha3(rocket_part1,0.7,0.3,0)
part_type_life(rocket_part1,2,70)
part_type_direction(rocket_part1,0,360,0,0)
part_type_speed(rocket_part1,0,8,-0.5,0)

sys_fog = part_system_create()
fog_part1 = part_type_create()
part_system_depth(sys_fog,-91)
part_type_shape(fog_part1,pt_shape_cloud)
part_type_size(fog_part1,5,10,0,0)

if instance_exists(dust)
    part_type_color_mix(fog_part1,make_color_rgb(255,178,110),c_black)
else if instance_exists(purple_haze)
    part_type_color_mix(fog_part1,make_color_rgb(255,0,255),c_black)
else if instance_exists(green_haze)
    part_type_color_mix(fog_part1,c_orange,c_black)
else
    part_type_color_mix(fog_part1,c_white,c_black)
    
part_type_alpha3(fog_part1,0,0.45,0)
part_type_life(fog_part1,80,180)
part_type_direction(fog_part1,150,210,0,0.25)
part_type_speed(fog_part1,0.25,5,-0.025,0)
if instance_exists(fog)
{
    repeat(20*room_width/1024)
    part_particles_create(sys_fog,random(room_width),random(room_height),fog_part1,1)
}


sys_snow = part_system_create()
snow_part1 = part_type_create()
part_system_depth(sys_snow,-30)
part_type_shape(snow_part1,pt_shape_smoke)
part_type_size(snow_part1,0.05,0.1,0,0)
part_type_color3(snow_part1,c_white,make_color_rgb(100,100,100),c_white)
part_type_alpha3(snow_part1,1,0.5,0)
part_type_life(snow_part1,120,580)
part_type_direction(snow_part1,260,280,0,0.25)
part_type_speed(snow_part1,1,8,-0.01,0)
if instance_exists(snow)
{
    repeat(10*room_width/1024)
    part_particles_create(sys_snow,random(room_width),random(room_height),snow_part1,1)
}


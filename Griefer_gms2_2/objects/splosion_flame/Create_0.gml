/// @description properties
event_inherited()

if not part_system_exists(particle_controller.sys_flame)
{
    instance_destroy()
    exit
}

initialize_physics()

//audio(snd_ink,2)
audio(snd_flame,1)
counter = 0
part_off = 64*2

speed_multiplier = 1//random_range(0.9,0.91)
damage_burning = 0.25*6.5/8

life = 30*8/4
part_life = particle_controller.flame_part_life
linger_time = 10*30 // was 10

em = part_emitter_create(particle_controller.sys_flame)
part_emitter_region(particle_controller.sys_flame,em,x-random(part_off),x+random(part_off),y-random(part_off),y+random(part_off),ps_shape_ellipse,ps_distr_gaussian)

part_emitter_burst(particle_controller.sys_flame,em,particle_controller.part_flame,6)

part_system_depth(particle_controller.sys_flame,depth)

//engine
varWrite("body_death_type","die")
varWrite("gib_distance",-1)

//visuals
sprite = spr_light_mask_splosion;
rubble_obj = rubble
intensity = 8
xscale = 0//radius/360/1.5
yscale = 0//radius/360/1.5
color = make_color_rgb(255,150,75)
intensity_divisor = 10
intensity_flicker = 0.2
scale_divisor = 1.025
scale_flicker = 0.05

//DAMAGE
radius = 64*6
damage = 2
varWrite("falloff_x1",radius/4)
varWrite("falloff_y1",1)
varWrite("falloff_x2",radius*2.25/3)
varWrite("falloff_y2",0.7)
varWrite("falloff_x3",radius)
varWrite("falloff_y3",0)

//sync muzzle flash with light params
flash_update_light()



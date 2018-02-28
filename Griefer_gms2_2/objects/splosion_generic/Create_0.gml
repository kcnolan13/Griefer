/// @description configure splosion
netvars = NO_HANDLE
event_inherited()

is_stick_kill = false

//DAMAGE
radius = 360
varWrite("falloff_x1",radius/4)
varWrite("falloff_y1",1)
varWrite("falloff_x2",radius/2)
varWrite("falloff_y2",0.75)
varWrite("falloff_x3",radius)
varWrite("falloff_y3",0)

//visuals
sprite = spr_light_mask_splosion;
rubble_obj = rubble
intensity = 10
xscale = radius/360
yscale = radius/360
life = 20                           //make sure around long enough to deal damage
color = make_color_rgb(255,205,148)
intensity_divisor = 1.5
intensity_flicker = 0.2
scale_divisor = 1.025
scale_flicker = 0.05

//engine
alarm[0] = 1
varWrite("senderId",MY_PLAYER_NULL)
varWrite("local",false)
varWrite("body_death_type","die")
varWrite("gib_distance",radius/4)

if DEBUG
    printf("BOOM!!")
    
glr_lightsimple_set_rotation(light, 90)
light.splosion_light = true
    
//sync muzzle flash with light params
if object_index = splosion_generic
    flash_update_light()


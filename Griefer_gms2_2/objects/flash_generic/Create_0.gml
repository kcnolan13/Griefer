/// @description configure light

//visuals
sprite = spr_light_mask_point;
intensity = 10
xscale = 0.4
yscale = 0.4
life = 20                         
color = make_color_rgb(255,205,148)
intensity_divisor = 1
intensity_flicker = 0
scale_divisor = 1
scale_flicker = 0

loc = true

//NET VARS
netvars = ds_map_create()
varWrite("angle",0)
varWrite("xscale",-1)
varWrite("yscale",-1)
varWrite("image_blend",c_white)

//engine
visible = false
sprite_index = spr_none
current_xscale = xscale
current_yscale = yscale
current_intensity = intensity
delay = 1
enabled = false
prev_xscale = -1
prev_yscale = -1
prev_angle = -1
prev_intensity = -1

//spawn the light
light = glr_lightsimple_create(sprite, 0, x, y, color, 1)

//if SUPER_DEBUG
    //printf("glare light count: "+glr_light_get_count())

if object_index = flash_generic
    flash_update_light()


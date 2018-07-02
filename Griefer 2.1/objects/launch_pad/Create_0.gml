/// @description properties and light and stuff
color = make_color_rgb(150,150,255)
intensity_max = 6
intensity_min = 1
intensity = intensity_min
intensity_dir = 1
intensity_lerp_real = 0.15

light = glr_lightsimple_create(spr_light_mask_point,-1, x, y-sprite_get_height(sprite_index)/3, color, 1)
light.yscale = 0.0375
light.xscale = 0.27*image_xscale

launch_speed = 60

light.splosion_light = true


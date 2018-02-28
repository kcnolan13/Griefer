/// @description configure light
event_inherited()

//MUST BE DEFINED IN CHILD
sprite = spr_light_mask_point;
intensity = 10
xscale = 0.075
yscale = 0.075
life = 10
color = make_color_rgb(50,200,50)
intensity_divisor = 1.2
intensity_flicker = 0
scale_divisor = 1
scale_flicker = 0

//sync muzzle flash with light params
flash_update_light()


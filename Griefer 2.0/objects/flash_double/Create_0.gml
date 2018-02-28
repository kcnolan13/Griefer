/// @description configure light
event_inherited()

//MUST BE DEFINED IN CHILD
sprite = spr_light_mask_flash;
intensity = 2
xscale = 0.9
yscale = 0.9
life = 20
color = make_color_rgb(255,255,255)
intensity_divisor = 1.18
intensity_flicker = 0
scale_divisor = 1
scale_flicker = 0

//sync muzzle flash with light params
flash_update_light()


/// @description configure light
event_inherited()

//MUST BE DEFINED IN CHILD
sprite = spr_light_mask_flash;
intensity = 2
xscale = 0.25
yscale = 0.25
life = 2
color = make_color_rgb(255,205,148);
intensity_divisor = 1.25
intensity_flicker = 0
scale_divisor = 1
scale_flicker = 0

//sync muzzle flash with light params
flash_update_light()

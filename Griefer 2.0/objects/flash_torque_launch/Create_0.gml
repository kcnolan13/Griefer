/// @description configure light
event_inherited()

//MUST BE DEFINED IN CHILD
sprite = spr_light_mask_flash;
intensity = 6
xscale = 0.7
yscale = 0.7
life = 22
color = global.torque_col
intensity_divisor = 1.18
intensity_flicker = 0
scale_divisor = 1
scale_flicker = 0

//sync muzzle flash with light params
flash_update_light()


/// @description configure light
event_inherited()

//MUST BE DEFINED IN CHILD
sprite = spr_light_mask_point;
intensity = 8
xscale = 0.12
yscale = 0.12
life = 20
color = global.torque_col
intensity_divisor = 1.15
intensity_flicker = 0
scale_divisor = 1
scale_flicker = 0

//sync muzzle flash with light params
flash_update_light()

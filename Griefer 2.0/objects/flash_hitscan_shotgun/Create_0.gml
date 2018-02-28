/// @description configure light
event_inherited()

//visuals
sprite = spr_none//spr_light_mask_hitscan;
intensity = 1.25
xscale = 1
yscale = 0.5
life = 20
color = make_color_rgb(255,255,255);
intensity_divisor = 1.05
intensity_flicker = 0
scale_divisor = 1
scale_flicker = 0

//sync muzzle flash with light params
flash_update_light()


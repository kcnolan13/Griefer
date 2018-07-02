/// @description inherit and define properties
life = 0
event_inherited()

width = 355
height = 83
width_init = width
height_init = height

border_inscribe = true
draw_rect = false

header_font = fnt_hud_big
header_text = "Map 1"
header_text_color = c_white
header_yoff = -1
header_color = c_black
header_alpha = 0.78
header_height = 24

header_text_random = "Random"
image_random = snap_random

font = fnt_hud_medium
text = ""
alpha_max = 0.75
halign = fa_center
valign = fa_center
snap_2view = false

alpha = 0
scale = 1
scale_highlighted = 1.00
scale_lerp_real = 0.25

draw_image_gradient = true
image_gradient_alpha = 0.125
grad1 = c_white
grad2 = c_white
grad3 = c_dkgray
grad4 = c_dkgray

map_num = rm_double
is_random = false

image = spr_none
image_crop = true
image_crop_align = fa_top
//image_stretch_x = true
img_xscale = width/sprite_get_width(snap_double)
img_yscale = img_xscale
//image_stretch_y = true
text_yoff = height/2-20

alarm[0] = 1

exit_child = false

hue = 0
sat = 0
val = 0
notif_scale = 1.25

active_color = make_colour_hsv(0,0,150)


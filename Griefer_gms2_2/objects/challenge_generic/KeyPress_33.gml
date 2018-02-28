/// @description blend mode

dat_blend_mode++
    if dat_blend_mode > bm_src_alpha_sat
dat_blend_mode = bm_zero

alarm[1] = 1
    

exit;
///draw allow
draw_allow ++
if draw_allow > 3
    draw_allow = 0
    


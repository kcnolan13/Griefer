/// @description sync with bound global vars
event_inherited()

if not in_match() or not global.map_editor
    fade_out = true
    
if is_texture and not uses_capture and not instance_exists(capture_master) and not fade_out
{
    printf("ERROR: capture master does not exist step bn_meditor")
    fade_out = true
}   


if id = fx.bn_alpha_grad {
    slider_value = fx.lvl_alpha_grad
} else if id = fx.bn_grad1 {
    color = fx.lvl_grad1
} else if id = fx.bn_grad2 {
    color = fx.lvl_grad2
} else if id = fx.bn_grad3 {
    color = fx.lvl_grad3
} else if id = fx.bn_grad4 {
    color = fx.lvl_grad4
} else if id = fx.bn_alpha_tex {
    slider_value = fx.lvl_alpha_tex
} else if id = fx.bn_tex_above {
    slider_value = fx.lvl_tex_above
} else if id = fx.bn_tex {
    image = fx.lvl_tex
} else if id = fx.bn_map_col0 {
    color = global.map_colors[room,0]
} else if id = fx.bn_map_col1 {
    color = global.map_colors[room,1]
} else if id = fx.bn_map_texs {
    image = global.map_texs[room]
} else if id = fx.bn_col_alphas {
    slider_value = global.col_alphas[room]
} else if id = fx.bn_export {
    slider_value = 1
}


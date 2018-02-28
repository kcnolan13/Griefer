/// @description Initialize
instance_create(x,y,lighting)

global.color_picker = c_white
global.color_primary = c_blue

//map_editor handles
bn_alpha_grad = NO_HANDLE
bn_grad1 = NO_HANDLE
bn_grad2 = NO_HANDLE
bn_grad3 = NO_HANDLE
bn_grad4 = NO_HANDLE
bn_alpha_tex = NO_HANDLE
bn_tex_above = NO_HANDLE
bn_tex = NO_HANDLE
bn_map_col0 = NO_HANDLE
bn_map_col1 = NO_HANDLE
bn_map_texs = NO_HANDLE
bn_col_alphas = NO_HANDLE
bn_export = NO_HANDLE

fade_time = 5*30
//blend for source blood pixel color
blood_src =  bm_src_alpha  
//blend for destination pixel color (pixel to be drawn to)
blood_dest = bm_one

blood_surf_src = bm_src_alpha
blood_surf_dest = bm_inv_src_alpha

draw_app_surface = 1
draw_surf_mode = 0

bfade_delay = 0
bfade_max = 30*3
surf_tex = -99
surf_blood = NO_HANDLE
surf_blocks = NO_HANDLE
surf_blocks_inverse = NO_HANDLE

lvl_tex = bg_none
lvl_grad1 = c_white
lvl_grad2 = c_white
lvl_grad3 = c_black
lvl_grad4 = c_black
lvl_alpha_grad = 0.825
lvl_alpha_tex = 0.4
lvl_tex_above = true

draw_mode = 0


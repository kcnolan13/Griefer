index1 = bm_src_alpha
index2 = bm_inv_src_alpha

if room != rm_login and not truthval(global.gc[GC_SURFACES,1])
    return false

if net_manager.tg_blood.active
{
    if DEBUG
        printf("allocating surf_blood")
    surf_blood = surface_create(room_width,room_height)
    
    surf_tex = surface_create(room_width,room_height)
    
    if DEBUG
        printf("allocating surf_blocks_inverse")
    surf_blocks_inverse = surface_create(room_width,room_height)
    
    if DEBUG
        printf("allocating surf_blocks")
    surf_blocks = surface_create(room_width,room_height)
    
    surface_set_target(surf_blocks)
    draw_clear_alpha(c_black,0)
    surface_reset_target()
    build_solid_profile(surf_blocks)
    
    if surface_exists(surf_blocks_inverse) and surface_exists(surf_blocks)
    {
        surface_set_target(surf_blocks_inverse)
        draw_set_color(c_white)
        draw_set_alpha(1)
        draw_rectangle(0,0,room_width,room_height,false)
        draw_set_blend_mode(bm_subtract)
        draw_surface(surf_blocks,0,0)
        draw_set_blend_mode(bm_normal)
        surface_reset_target()
    } else {
        printf("ERROR: Failed to create blood surface")
    }
    
    surface_set_target(surf_tex)
    draw_set_blend_mode(bm_normal)
    if lvl_tex_above
    {   //draw grad first
        if lvl_alpha_grad > 0
        {
            draw_set_alpha(lvl_alpha_grad)
            draw_rectangle_colour(0,0,room_width,room_height,lvl_grad1,lvl_grad2,lvl_grad3,lvl_grad4,false)
        }
        if lvl_alpha_tex > 0
        {
            draw_set_alpha(lvl_alpha_tex)
            draw_background_tiled(lvl_tex,0,0)
        }
    }
    else
    {
        if lvl_alpha_tex > 0
        {
            draw_set_alpha(lvl_alpha_tex)
            draw_background_tiled(lvl_tex,0,0)
        }
        if lvl_alpha_grad > 0
        {
            draw_set_alpha(lvl_alpha_grad)
            draw_rectangle_colour(0,0,room_width,room_height,lvl_grad1,lvl_grad2,lvl_grad3,lvl_grad4,false)
        }
    }
    draw_set_alpha(1)
    surface_reset_target()
}

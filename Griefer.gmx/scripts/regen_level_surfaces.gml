index1 = bm_src_alpha
index2 = bm_inv_src_alpha

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
    switch (room)
    {
    
        case rm_pillar2:
            draw_set_blend_mode(bm_normal)
            draw_set_alpha(0.825)
            draw_rectangle_colour(0,0,room_width,room_height,c_green,c_purple,c_red,c_blue,false)
            draw_set_alpha(0.4)
            draw_background_tiled(bg_cave2_overlay,0,0)
        break
        
        case rm_tunnel:
            draw_set_blend_mode(bm_normal)
            draw_set_alpha(0.9)
            draw_rectangle_colour(0,0,room_width,room_height,c_aqua,c_lime,c_red,c_fuchsia,false)
            draw_set_alpha(0.4)
            draw_background_tiled(bg_tunnel_overlay,0,0)
        break
    
        case rm_trench:
            draw_set_blend_mode(bm_normal)
            draw_set_alpha(0.6)
            draw_background_tiled(bg_crosscut_overlay2,0,0)
        break
        
        case rm_tower:
            draw_set_blend_mode(bm_normal)
            draw_set_alpha(0.4)
            draw_rectangle_colour(0,0,room_width,room_height,c_white,c_white,c_black,c_black,false)
            draw_set_alpha(0.4)
            draw_background_tiled(bg_tunnel_overlay,0,0)
        break
        
        case rm_map2:
            draw_set_blend_mode(bm_normal)
            draw_set_alpha(0.5)
            draw_background_tiled(bg_rocky_overlay,0,0)
        break
        
        case rm_bridge:
            draw_set_blend_mode(bm_normal)
            draw_set_alpha(0.65)
            draw_background_tiled(bg_bridge_overlay,0,0)
        break
        
        case rm_double:
            draw_set_blend_mode(bm_normal)
            draw_set_alpha(0.65)
            draw_background_tiled(bg_double_overlay2,0,0)
        break
        
        case rm_pillar:
            draw_set_blend_mode(bm_normal)
            draw_set_alpha(1)
            draw_rectangle_colour(0,0,room_width,room_height,c_white,c_white,c_black,c_black,false)
            draw_set_alpha(0.5)
            draw_background_tiled(bg_tower_overlay2,0,0)
        break
        
        case rm_torque:
            draw_set_blend_mode(bm_normal)
            draw_set_alpha(0.4)
            draw_background_tiled(bg_torque_overlay,0,0)
        break
        
        case rm_rocky:
            draw_set_blend_mode(bm_normal)
            draw_set_alpha(0.5)
            draw_background_tiled(bg_rocky_overlay,0,0)
        break
    
        case rm_snow2:
            draw_set_blend_mode(bm_normal)
            draw_set_alpha(0.8)
            draw_rectangle_colour(0,0,room_width,room_height,c_white,c_white,c_black,c_black,false)
            draw_set_alpha(0.5)
            draw_background_tiled(bg_floral_overlay,0,0)
        break
        
        case rm_cave2:
            draw_set_blend_mode(bm_normal)
            draw_set_alpha(0.75)
            draw_rectangle_colour(0,0,room_width,room_height,c_blue,c_purple,c_black,c_black,false)
            draw_set_alpha(0.3)
            draw_background_tiled(bg_cave2_overlay,0,0)
        break
    
        case rm_debug:
            draw_set_blend_mode(bm_normal)
            draw_set_alpha(0.75)
            draw_background_tiled(bg_debug_overlay,0,0)
        break
        
        case rm_chronic:
            draw_set_blend_mode(bm_normal)
            draw_set_alpha(0.65)
            draw_background_tiled(bg_chronic_overlay2,0,0)
        break
        
        case rm_map6:
            draw_set_blend_mode(bm_normal)
            draw_set_alpha(0.75)
            draw_background_tiled(bg_map6_overlay,0,0)
        break
    
        case rm_orange:
            draw_set_blend_mode(bm_normal)
            draw_set_alpha(0.6)
            draw_background_tiled(bg_orange_overlay,0,0)
        break
        
        case rm_snow:
            draw_set_blend_mode(bm_normal)
            draw_set_alpha(1)
            draw_rectangle_colour(0,0,room_width,room_height,c_white,c_white,c_black,c_black,false)
            draw_set_alpha(0.4)
            draw_background_tiled(bg_bridge_overlay,0,0)
        break
        
        case rm_crosscut:
            draw_set_blend_mode(bm_normal)
            draw_set_alpha(0.35)
            draw_background_tiled(bg_animal_overlay,0,0)
        break
        
        case rm_tree:
            draw_set_blend_mode(bm_normal)
            draw_set_alpha(0.5)
            draw_background_tiled(bg_rocky_overlay,0,0)
        break
        
         case rm_cave:
            draw_set_blend_mode(bm_normal)
            draw_set_alpha(0)
            draw_rectangle_colour(0,0,room_width,room_height,c_white,c_white,c_black,c_black,false)
            draw_set_alpha(0.5)
            draw_background_tiled(bg_yellow_overlay,0,0)
        break
        
        case rm_dust:
            draw_set_blend_mode(bm_normal)
            draw_set_alpha(0.5)
            draw_background_tiled(bg_tunnel_overlay,0,0)
        break
        
        default:
            //draw_set_blend_mode(bm_normal)
            //draw_set_alpha(0.75)
            //draw_background_tiled(bg_cross,0,0)
        break
    }
    draw_set_alpha(1)
    surface_reset_target()
    draw_set_blend_mode(bm_normal)
}
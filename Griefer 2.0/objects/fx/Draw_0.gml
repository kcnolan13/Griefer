/// @description draw fx
if not net_manager.tg_blood.active return false

if bfade_delay
    bfade_delay--    

if (surface_exists(surf_blood) and surface_exists(surf_blocks_inverse) and surface_exists(surf_tex))
{
    if room = rm_login or truthval(global.gc[GC_SURFACES,1])
    {
        if draw_surf_mode = 0 {
            surface_set_target(surf_tex)
            draw_set_blend_mode(bm_subtract)
            draw_surface_ext(surf_blocks_inverse,0,0,1,1,0,c_black,1)
            surface_reset_target()
            
            surface_set_target(surf_blood)
            draw_set_blend_mode(bm_subtract)
            draw_surface_ext(surf_blocks_inverse,0,0,1,1,0,c_black,1)
            
            draw_set_color(c_black)
            if bfade_delay
                draw_set_alpha(7/fade_time)
            else
                draw_set_alpha(12/fade_time)
    
            if nth_frame(5)
               draw_rectangle(0,0,room_width,room_height,false)
    
            draw_set_alpha(1)
            draw_set_color(c_white)
            draw_set_blend_mode(bm_normal)
            
            surface_reset_target()
            
            //draw_surface_ext(surf_blocks_inverse,0,0,1,1,0,c_white,1)
            //draw_set_blend_mode_ext(blood_surf_src,blood_surf_dest)
            draw_surface_part_ext(surf_tex,__view_get( e__VW.XView, 0 ),__view_get( e__VW.YView, 0 ),__view_get( e__VW.WView, 0 ),__view_get( e__VW.HView, 0 ),__view_get( e__VW.XView, 0 ),__view_get( e__VW.YView, 0 ),1,1,c_white,1)
            draw_surface_part_ext(surf_blood,__view_get( e__VW.XView, 0 ),__view_get( e__VW.YView, 0 ),__view_get( e__VW.WView, 0 ),__view_get( e__VW.HView, 0 ),__view_get( e__VW.XView, 0 ),__view_get( e__VW.YView, 0 ),1,1,c_white,1)
            draw_set_blend_mode(bm_normal)
        } else if draw_surf_mode =  1 {
            draw_surface_part_ext(surf_blocks,__view_get( e__VW.XView, 0 ),__view_get( e__VW.YView, 0 ),__view_get( e__VW.WView, 0 ),__view_get( e__VW.HView, 0 ),__view_get( e__VW.XView, 0 ),__view_get( e__VW.YView, 0 ),1,1,c_white,1)
        } else if draw_surf_mode =  2 {
            draw_surface_part_ext(surf_blocks_inverse,__view_get( e__VW.XView, 0 ),__view_get( e__VW.YView, 0 ),__view_get( e__VW.WView, 0 ),__view_get( e__VW.HView, 0 ),__view_get( e__VW.XView, 0 ),__view_get( e__VW.YView, 0 ),1,1,c_white,1)
        } else if draw_surf_mode =  3 {
            draw_surface_part_ext(surf_blood,__view_get( e__VW.XView, 0 ),__view_get( e__VW.YView, 0 ),__view_get( e__VW.WView, 0 ),__view_get( e__VW.HView, 0 ),__view_get( e__VW.XView, 0 ),__view_get( e__VW.YView, 0 ),1,1,c_white,1)
        }
    }
    else
    {
        free_level_surfaces()
    }
}


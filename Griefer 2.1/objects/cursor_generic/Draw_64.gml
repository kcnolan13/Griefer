/// @description draw code
if active and in_match() and not match_starting() and not match_ending() and not global.map_editor and not instance_exists(modal_controls)
{
    var draw_x = (cursor.x-__view_get( e__VW.XView, 0 ))*WVIEW/__view_get( e__VW.WView, 0 )
    var draw_y = (cursor.y-__view_get( e__VW.YView, 0 ))*HVIEW/__view_get( e__VW.HView, 0 )
    
    if core_active
    {
        draw_set_color(core_color)
        core_radius = core_scale
        if core_grow
            core_radius += sensitivity*inaccuracy/inaccuracy_divisor
            
        if core = "circle"
        {
            for (var i=0; i<core_linewidth; i+=0.5)
            {
                draw_circle(draw_x,draw_y,core_radius+i,true)
            }
        }
        else if core = "square"
        {
            for (var i=0; i<core_linewidth; i+=0.5)
            {
                draw_rectangle(draw_x-core_radius-i,draw_y-core_radius-i,draw_x+core_radius+i,draw_y+core_radius+i,true)
            }
        }
        else
        {
            draw_sprite_ext(core,-1,draw_x,draw_y,core_radius,core_radius,0,core_color,core_alpha)
        }
    }
    
    accent_radius = accent_radius_min
    if accent_grow
        accent_radius += sensitivity*inaccuracy/inaccuracy_divisor
        
    //printf("accent_radius = "+accent_radius+", inaccuracy = "+inaccuracy)
        
    ang = accent_rot
    for (var i=0; i<accent_num; i++)
    {
        draw_sprite_ext(accent,-1,draw_x+trigx(accent_radius+accent_xextra,ang),draw_y+trigy(accent_radius+accent_yextra,ang),accent_scale,accent_scale,ang,accent_color,accent_alpha)
        ang += 360/accent_num
    }

}


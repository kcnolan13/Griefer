/// @description draw_bpart_slot_complete_ext(bpart_obj, bpart_x, bpart_y, scale, bpart_alpha)
/// @function draw_bpart_slot_complete_ext
/// @param bpart_obj
/// @param  bpart_x
/// @param  bpart_y
/// @param  scale
/// @param  bpart_alpha
var bpart_obj = argument0
var bpart_x = argument1
var bpart_y = argument2
var scale = argument3
var bpart_alpha = argument4

var xorig = bpart_x
var yorig = bpart_y

if bpart_obj.disabled
    draw_bpart_slot_disabled_ext(bpart_x,bpart_y, scale, bpart_alpha)
else
{
    if bpart_obj.object_index != challenge_generic
        draw_bpart_slot_ext(bpart_x, bpart_y, scale, bpart_obj.color, bpart_alpha)
        
    if bpart_obj.object_index != challenge_generic and bpart_obj.object_index != net_manager and bpart_obj.object_index != xp_bar and bpart_obj.object_index != action_word
        draw_bpart_icon_ext(bpart_obj,bpart_x,bpart_y, scale, bpart_alpha)
    else
    {
        var dalph = 1
        if object_index = xp_bar or object_index = action_word
            dalph = bpart_alpha
            
        if bpart_obj.object_index = challenge_generic and surface_exists(surf_slot) and (bpart_obj.completed or bpart_obj.draw_ignore_incomplete)
        {
            draw_enable_alphablend(false)
            draw_surface_ext(surf_slot,bpart_x,bpart_y,scale/2,scale/2,0,c_white,1)  
            for (var i=0; i<2; i ++)
            {
                draw_rectangle(bpart_x-1+i,bpart_y-1+i,bpart_x+net_manager.armory_sl*scale+1-i,bpart_y+net_manager.armory_sl*scale+1-i,true)
            }
            draw_enable_alphablend(true)
        }
        else
        {
            var drawspr = bpart_obj.icon
            var square_xmid = 72/2*scale
            var square_ymid = 72/2*scale
            var proper_scale = scale*scale_2icon(drawspr)//*64/72
            var spr_xoff = (sprite_get_width(drawspr)/2-sprite_get_xoffset(drawspr))*proper_scale
            var spr_yoff = (sprite_get_height(drawspr)/2-sprite_get_yoffset(drawspr))*proper_scale
            if sprite_exists(drawspr)
                draw_sprite_ext(drawspr,-1,bpart_x+square_xmid-spr_xoff,bpart_y+square_ymid-spr_yoff,proper_scale,proper_scale,0,c_white,dalph)
        }
        
        var square_xmid = 72/2*scale
        var square_ymid = 72/2*scale
        
        if bpart_obj.object_index = challenge_generic
        {
            if not bpart_obj.completed and not bpart_obj.draw_ignore_incomplete
            {
                //draw_set_alpha(0.75)
                draw_sprite_ext(spr_bpart_generic,-1,bpart_x,bpart_y,scale,scale,0,c_black,4/5*dalph)
                //redraw the border
                draw_set_alpha(dalph)
                draw_set_color(c_white)
                for (var i=0; i<2; i++)
                {
                    draw_rectangle(bpart_x-1+i,bpart_y-1+i,bpart_x+net_manager.armory_sl*scale+1-i,bpart_y+net_manager.armory_sl*scale+1-i,true)
                }
                draw_sprite_ext(bpart_obj.icon_incomplete,-1,xorig-square_xmid/2,yorig-square_ymid/2,scale,scale,0,c_white,dalph)
                draw_set_alpha(1)
                
                //draw progress bar
                draw_challenge_unlock_bar(bpart_x+net_manager.armory_sl*scale/2,bpart_y+net_manager.armory_sl*3/4*scale,scale,bpart_obj.progress,bpart_obj.progress_max)
            }
        }
    }
}

///draw_bpart_slot_complete_ext(bpart_obj, bpart_x, bpart_y, scale, bpart_alpha)
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
    draw_bpart_slot_ext(bpart_x, bpart_y, scale, bpart_obj.color, bpart_alpha)
    if bpart_obj.object_index != challenge_generic and bpart_obj.object_index != net_manager and bpart_obj.object_index != xp_bar and bpart_obj.object_index != action_word
        draw_bpart_icon_ext(bpart_obj,bpart_x,bpart_y, scale, bpart_alpha)
    else
    {
        var drawspr = bpart_obj.icon
        var square_xmid = 72/2*scale
        var square_ymid = 72/2*scale
        var proper_scale = scale*scale_2icon(drawspr)//*64/72
        var spr_xoff = (sprite_get_width(drawspr)/2-sprite_get_xoffset(drawspr))*proper_scale
        var spr_yoff = (sprite_get_height(drawspr)/2-sprite_get_yoffset(drawspr))*proper_scale
        
        var dalph = 1
        if object_index = xp_bar or object_index = action_word
            dalph = bpart_alpha
            
        draw_sprite_ext(drawspr,-1,bpart_x+square_xmid-spr_xoff,bpart_y+square_ymid-spr_yoff,proper_scale,proper_scale,0,c_white,dalph)    
            
        if bpart_obj.object_index = challenge_generic
        {
            if not bpart_obj.completed
            {
                //draw_set_alpha(0.75)
                draw_sprite_ext(spr_bpart_generic,-1,bpart_x,bpart_y,scale,scale,0,c_black,4/5*dalph)
                //redraw the border
                draw_set_alpha(dalph)
                draw_set_color(c_white)
                draw_rectangle(bpart_x,bpart_y,bpart_x+net_manager.armory_sl*scale,bpart_y+net_manager.armory_sl*scale,true)
                draw_rectangle(bpart_x+1,bpart_y+1,bpart_x+1+net_manager.armory_sl*scale-2,bpart_y+1+net_manager.armory_sl*scale-2,true)
                draw_sprite_ext(bpart_obj.icon_incomplete,-1,xorig-square_xmid/2,yorig-square_ymid/2,scale,scale,0,c_white,dalph)
                draw_set_alpha(1)
            }
        }
    }
}
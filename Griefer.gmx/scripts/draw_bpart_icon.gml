///draw_bpart_icon(bpart_object, x, y, alpha)
var bpart_obj = argument0
var bpart_x = argument1
var bpart_y = argument2
var bpart_alpha = argument3

var dx = bpart_obj.icon_scale*(sprite_get_width(bpart_obj.icon)/2 - sprite_get_xoffset(bpart_obj.icon))
var dy = bpart_obj.icon_scale*(sprite_get_height(bpart_obj.icon)/2 - sprite_get_yoffset(bpart_obj.icon))

draw_sprite_ext(bpart_obj.icon,-1,bpart_obj.x-dx+net_manager.armory_sl/2,bpart_obj.y-dy+net_manager.armory_sl/2,bpart_obj.icon_scale,bpart_obj.icon_scale,0,c_white,bpart_alpha)
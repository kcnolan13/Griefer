/// @description draw_bpart_slot_disabled(x, y, alpha)
/// @function draw_bpart_slot_disabled
/// @param x
/// @param  y
/// @param  alpha
var bpart_x = argument0
var bpart_y = argument1
var bpart_alpha = argument2

draw_sprite_ext(spr_bpart_disabled,-1,bpart_x,bpart_y,1,1,0,c_white,bpart_alpha)
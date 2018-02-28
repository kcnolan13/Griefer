/// @description draw_bpart_slot_empty(x, y, scale, alpha)
/// @function draw_bpart_slot_empty
/// @param x
/// @param  y
/// @param  scale
/// @param  alpha
var bpart_x = argument0
var bpart_y = argument1
var scale = argument2
var bpart_alpha = argument3

draw_sprite_ext(spr_bpart_empty,-1,bpart_x,bpart_y,scale,scale,0,c_white,bpart_alpha)
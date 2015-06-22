///draw_bpart_slot_complete(bpart_obj, bpart_x, bpart_y, bpart_alpha)
var bpart_obj = argument0
var bpart_x = argument1
var bpart_y = argument2
var bpart_alpha = argument3

if bpart_obj.disabled
    draw_bpart_slot_disabled(bpart_x,bpart_y,bpart_alpha)
else
{
    draw_bpart_slot(bpart_x,bpart_y, bpart_obj.color, bpart_alpha)
    draw_bpart_icon(bpart_obj,bpart_x,bpart_y,bpart_alpha)
}
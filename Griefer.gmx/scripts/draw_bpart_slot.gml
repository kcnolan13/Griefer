///draw_bpart_slot(x, y, color, alpha)
var bpart_x = argument0
var bpart_y = argument1
var color = argument2
var bpart_alpha = argument3

//printf("slot color is: "+color)

draw_sprite_ext(spr_bpart_generic,-1,bpart_x,bpart_y,1,1,0,color,global.slot_alpha*bpart_alpha)
draw_set_alpha(bpart_alpha)

//if color != global.col_rarity[4]
draw_set_color(c_white)
//else
//draw_set_color(c_black)

draw_rectangle(bpart_x,bpart_y,bpart_x+net_manager.armory_sl,bpart_y+net_manager.armory_sl,true)
draw_rectangle(bpart_x+1,bpart_y+1,bpart_x+1+net_manager.armory_sl-2,bpart_y+1+net_manager.armory_sl-2,true)
draw_set_alpha(1)
draw_set_color(c_white)
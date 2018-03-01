/// @description draw id and coords
var spr = icon_cursor_small
var xscale = cursor_width/sprite_get_width(spr)
var yscale = xscale

draw_sprite_ext(spr,image_index,x,y,xscale,yscale,image_angle,image_blend,image_alpha)
draw_set_color(c_white)





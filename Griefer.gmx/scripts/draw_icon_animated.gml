///draw_icon_animated(x,y,scale,color,alpha)
var draw_x = argument0
var draw_y = argument1
var scale = argument2
var col = argument3
var alpha = argument4

var scl = scale*1.2

draw_sprite_ext(icon_animated,-1,draw_x+scale,draw_y,scl,scl,0,col,alpha)

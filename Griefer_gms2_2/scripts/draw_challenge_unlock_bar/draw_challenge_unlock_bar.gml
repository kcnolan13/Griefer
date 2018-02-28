/// @description draw_challenge_unlock_bar(x,y,scale,progress,progress_max)
/// @function draw_challenge_unlock_bar
/// @param x
/// @param y
/// @param scale
/// @param progress
/// @param progress_max
var drawx = argument0
var drawy = argument1
var scale = argument2
var progress = argument3
var progress_max = argument4

var width = 48*scale
var height = 6*scale

var percent_full = progress/max(0.0001,progress_max)

//draw the backing
draw_set_color(c_gray)
var alph = draw_get_alpha()
draw_set_alpha(alph*0.65)
draw_rectangle(drawx-width/2,drawy-height/2,drawx+width/2,drawy+height/2,false)
draw_set_alpha(alph)

draw_set_color(c_white)
if progress > 0
    draw_rectangle(drawx-width/2,drawy-height/2,drawx-width/2+width*percent_full,drawy+height/2,false)
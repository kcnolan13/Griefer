/// @description draw_bg_tiled_hor(back,drawx,drawy,xscale,yscale,blend,alpha)
/// @function draw_bg_tiled_hor
/// @param back
/// @param drawx
/// @param drawy
/// @param xscale
/// @param yscale
/// @param blend
/// @param alpha
var back = argument0
var drawx = argument1
var drawy = argument2
var xscale = argument3
var yscale = argument4
var blend = argument5
var alpha = argument6

//draw the first background
draw_background_ext(back, drawx, drawy, xscale, yscale, 0, blend, alpha)

var left = drawx

while (left > 0)
{
    //draw the ones to the left of the original
    draw_background_ext(back, left, drawy, xscale, yscale, 0, blend, alpha)
    left -= WVIEW
}

left = drawx+WVIEW

while (left < room_width)
{
    //draw the ones to the left of the original
    draw_background_ext(back, left, drawy, xscale, yscale, 0, blend, alpha)
    left += WVIEW
}

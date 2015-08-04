///draw_surf_tiled_hor(surf,drawx,drawy,xscale,yscale,blend,alpha)
var surf = argument0
var drawx = argument1
var drawy = argument2
var xscale = argument3
var yscale = argument4
var blend = argument5
var alpha = argument6

if not surface_exists(surf)
{
    printf("ERROR: draw_surf_tiled_hor drawing non-existent surface")
    return false
}

var w = surface_get_width(surf)
var h = surface_get_height(surf)

//draw the first background
draw_surface_ext(surf, drawx, drawy, xscale, yscale, 0, blend, alpha)
/*
var left = drawx

while (left > 0)
{
    //draw the ones to the left of the original
    draw_surface_ext(surf, left, drawy, xscale, yscale, 0, blend, alpha)
    left -= w
}

left = drawx+w

while (left < room_width)
{
    //draw the ones to the left of the original
    draw_surface_ext(surf, left, drawy, xscale, yscale, 0, blend, alpha)
    left += w
}*/

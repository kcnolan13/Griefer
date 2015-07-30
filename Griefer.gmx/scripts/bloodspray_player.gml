///bloodspray_player(x, y, mag, dir, col)
var xi = argument0
var yi = argument1
var mag = argument2
var dir = argument3
var col = argument4

if not truthval(global.gc[GC_VIOLENT_CONTENT,1])
{
    return noone
}

if mag > 1
    mag = 1

//spray_blood(xi, yi, mag, dir, 5, 4, 1, 10, 5, 10)
spray_blood(xi, yi, mag/4, dir, 360, 2, 1, 8, 2, 4,col)
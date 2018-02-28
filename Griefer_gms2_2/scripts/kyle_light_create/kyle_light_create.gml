/// @description kyle_light_create(sprite, subimg, x, y, color, intensity)
/// @function kyle_light_create
/// @param sprite
/// @param  subimg
/// @param  x
/// @param  y
/// @param  color
/// @param  intensity
var spr = argument0
var ind = argument1
var xi = argument2
var yi = argument3
var col = argument4
var intens = argument5

{
    ID = instance_create(xi,yi,kLight)
    ID.sprite = spr
    ID.color = col
    ID.intensity = intens
}

return ID
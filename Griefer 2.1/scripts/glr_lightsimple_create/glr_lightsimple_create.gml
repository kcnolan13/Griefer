/// @description glr_lightsimple_create(sprite, subimg, x, y, color, alpha, intensity)
/// @function glr_lightsimple_create
/// @param sprite
/// @param  subimg
/// @param  x
/// @param  y
/// @param  color
/// @param  alpha
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

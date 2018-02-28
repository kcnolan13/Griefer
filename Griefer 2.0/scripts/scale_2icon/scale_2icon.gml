/// @description scale_2icon(sprite_index)
/// @function scale_2icon
/// @param sprite_index
var spr = argument0
var w = sprite_get_width(spr)
padding = 4
desired_width = 72

return 72/(w-padding)
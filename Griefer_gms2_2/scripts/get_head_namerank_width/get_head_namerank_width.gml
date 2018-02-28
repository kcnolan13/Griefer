/// @description get_namerank_width(name,scale)
/// @function get_namerank_width
/// @param name
/// @param scale

var len = string_length(argument0)
var scale = argument1

var char_width = 14
var head_width = 64

return (len*char_width+head_width)*scale
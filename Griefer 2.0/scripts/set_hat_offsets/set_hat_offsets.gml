/// @description set_hat_offsets(spr_helmet,hat_xoff,hat_yoff)
/// @function set_hat_offsets
/// @param spr_helmet
/// @param hat_xoff
/// @param hat_yoff
var spr_helmet = argument0
var hat_xoff = argument1
var hat_yoff = argument2
global.hat_offsets[spr_helmet,0] = hat_xoff
global.hat_offsets[spr_helmet,1] = hat_yoff
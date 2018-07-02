/// @description get_hat_rot()
/// @function get_hat_rot
/// @param spr_helmet
var spr_helmet = argument0
return global.hat_offsets[spr_helmet,2]
/*
var hat_yoff = 0

var ind = ds_list_find_index(global.hat_yoffs,spr_helmet) 
if ind > -1 {
    return global.hat_yoffs[| ind]
} else {
	return 0
}*/
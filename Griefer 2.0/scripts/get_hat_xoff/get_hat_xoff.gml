/// @description get_hat_xoff()
/// @function get_hat_xoff
/// @param spr_helmet
var spr_helmet = argument0
return global.hat_offsets[spr_helmet,0]
/*var hat_xoff = 0
var ind = ds_list_find_index(global.hat_xoffs,spr_helmet) 
if ind > -1 {
    return global.hat_xoffs[| ind]
} else {
	return 0
}*/
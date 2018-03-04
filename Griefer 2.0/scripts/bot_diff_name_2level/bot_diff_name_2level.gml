/// @description bot_diff_name_2level(difficulty_name)
/// @function bot_diff_name_2level
/// @paramdiff_name
var diff_name = argument0

var lvl_index = array_index_of(global.bot_diff_names, diff_name)
if lvl_index >= 0 {
	return global.bot_diff_levels[lvl_index]	
} else {
	printf("ERROR bot diff name "+string(diff_name)+" not found in global.bot_diff_levels... array_index_of() returned "+string(lvl_index))	
	return "NULL"
}
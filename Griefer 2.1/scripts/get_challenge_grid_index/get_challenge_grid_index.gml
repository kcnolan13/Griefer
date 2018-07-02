/// @description get_challenge_grid_index(flag)
/// @function get_challenge_grid_index
/// @param flag
var flag = argument0

if flag == FL_PROGRESSION
	return 0
if flag == FL_COMPETITIVE
	return 1
if flag == FL_BOT
	return 2
if flag == FL_CHALLENGES
	return 3

printf("ERROR: could not get_challenge_grid_index for flag "+string(flag))
return BAD_READ
/// @description bot_mode_ind_2col_total(bot_mode_ind)
/// @function bot_mode_ind_2col_total
/// @param bot_mode_ind
var bot_mode_ind = argument0
var col = 0

if bot_mode_ind == 0 {
	col = COL_BOT_TOTAL
} else if bot_mode_ind == 1 {
	col = COL_BOT2_TOTAL	
} else if bot_mode_ind == 2 {
	col = COL_BOT3_TOTAL	
} else if bot_mode_ind == 3 {
	col = COL_BOT4_TOTAL	
}
else
{
    printf("ERROR: bad bot_mode_ind passed to bot_mode_ind_2col_total: "+string(bot_mode_ind))
}

return col
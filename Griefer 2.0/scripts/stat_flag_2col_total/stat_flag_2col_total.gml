/// @description stat_flag_2col_total(stat_flag)
/// @function stat_flag_2col_total
/// @param stat_flag
var fl = argument0

var col = -1

if fl = FL_NORMAL or fl = FL_COMPETITIVE or fl = COL_TOTAL
{
    col = COL_TOTAL
}
else if fl = FL_BOT or fl = COL_BOT_TOTAL
{
    col = COL_BOT_TOTAL
}
else if fl = FL_BOT2 or fl = COL_BOT2_TOTAL
{
    col = COL_BOT2_TOTAL
}
else if fl = FL_BOT3 or fl = COL_BOT3_TOTAL
{
    col = COL_BOT3_TOTAL
}
else if fl = FL_BOT4 or fl = COL_BOT4_TOTAL
{
    col = COL_BOT4_TOTAL
}
else
{
    printf("ERROR: bad flag passed to stat_flag_2col_total: "+string(fl))
    return false
}

return col
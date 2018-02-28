/// @description stat_update_string(stat_name,value,flag)
/// @function stat_update_string
/// @param stat_name
/// @param value
/// @param flag
stat_name = argument0
value = argument1
flag = argument2

if DEBUG
    printf("      sending stat update --> "+stat_name+" = "+value)

with (net_manager) {if show_trans_rate transmissions++}
statUpdateString(stat_name,string(value),flag)
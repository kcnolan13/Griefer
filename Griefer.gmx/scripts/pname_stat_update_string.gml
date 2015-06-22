///pname_stat_update_string(pName, stat_name, value, flag)
var playah = argument0
var stat_name = argument1
var value = argument2
var flag = argument3

if DEBUG
    printf("      sending stat update for "+playah+" --> "+stat_name+" = "+value)

with (net_manager) {if show_trans_rate transmissions++}
otherPlayerStatUpdateStr(playah,stat_name,value,flag)
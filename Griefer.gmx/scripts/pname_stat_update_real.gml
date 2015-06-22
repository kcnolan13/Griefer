///pname_stat_update_real(pName, stat_name, value, flag)
var playah = argument0
var stat_name = argument1
var value = argument2
var flag = argument3

if DEBUG
    printf("      sending stat update for "+playah+" --> "+stat_name+" = "+value)

with (net_manager) {if show_trans_rate transmissions++}
otherPlayerStatUpdateReal(playah,stat_name,value,flag)
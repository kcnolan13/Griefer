///stat_update_real(stat_name,value,flag)
stat_name = argument0
value = argument1
flag = argument2

if DEBUG
    printf("      sending stat update --> "+stat_name+" = "+value)
    
//if stat_name = "kills"
  //  simple_popup("KILLS","kills = "+string(value))

with (net_manager) {if show_trans_rate transmissions++}
statUpdateReal(stat_name,value,flag)

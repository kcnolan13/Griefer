/// @description accolade_update_real(accolade_name,value,flag)
/// @function accolade_update_real
/// @param accolade_name
/// @param value
/// @param flag
da_acc_name = argument0
value = argument1
flag = argument2

if DEBUG
    printf("      sending accolade update --> "+da_acc_name+" = "+value)

with (net_manager) {if show_trans_rate transmissions++}
sendBigMessageStrReal("accolade_update",string(da_acc_name),real(value),real(flag))
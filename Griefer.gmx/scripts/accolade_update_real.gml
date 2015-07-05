///accolade_update_real(accolade_name,value,flag)
acc_name = argument0
value = argument1
flag = argument2

if DEBUG
    printf("      sending accolade update --> "+acc_name+" = "+value)

with (net_manager) {if show_trans_rate transmissions++}
sendBigMessageStrReal("accolade_update",string(acc_name),real(value),real(flag))

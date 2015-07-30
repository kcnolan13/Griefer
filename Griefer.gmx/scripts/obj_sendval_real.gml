///obj_sendval_real(obj,variable,value,flag)
obj = argument0
variable = argument1
value = argument2
flag = argument3

if net_manager.bot_match
{
    return false
}

if not instance_exists(obj)
{
    printf("ERROR: sendval_real: obj does not exist")
    return false
}

with (net_manager) {if show_trans_rate transmissions++}
objUpdateReal(obj.object_index,objVarRead(obj,"uniqueId"),variable,value,flag)
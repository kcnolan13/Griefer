///obj_sendval_string(obj,variable,value,flag)
obj = argument0
variable = argument1
value = argument2
flag = argument2

if net_manager.bot_match
{
    return false
}

with (net_manager) {if show_trans_rate transmissions++}
objUpdateString(obj.object_index,objVarRead(obj,"uniqueId"),variable,value,flag)
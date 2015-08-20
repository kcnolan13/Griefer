///obj_update_string(obj,variable,flag)
obj = argument0
variable = argument1
flag = argument2

if net_manager.bot_match
{
    return false
}

with (net_manager) {if show_trans_rate transmissions++}
objUpdateString(obj.object_index,objVarRead(obj,"uniqueId"),variable,string(objVarRead(obj,variable)),flag)

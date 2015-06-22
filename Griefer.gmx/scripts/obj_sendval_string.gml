///obj_sendval_string(obj,variable,value,flag)
obj = argument0
variable = argument1
value = argument2
flag = argument2

with (net_manager) {if show_trans_rate transmissions++}
objUpdateString(obj.object_index,objVarRead(obj,"uniqueId"),variable,value,flag)
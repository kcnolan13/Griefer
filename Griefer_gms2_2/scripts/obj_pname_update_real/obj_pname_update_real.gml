/// @description obj_pname_update_real(obj,variable,flag)
/// @function obj_pname_update_real
/// @param obj
/// @param variable
/// @param flag
obj = argument0
variable = argument1
flag = argument2

if net_manager.bot_match
{
    return false
}

if obj.object_index = avatar //and SUPER_DEBUG
    printf("sending netVar update: updating "+objVarRead(obj,"pName")+"'s "+variable+"...")

var netvar_val = 999

if flag != FL_INSTANCE_DESTROY
    netvar_val = objVarRead(obj,variable)


with (net_manager) {if show_trans_rate transmissions++}

objUpdateReal(obj.object_index,hash_string(objVarRead(obj,"pName")),string(variable),real(netvar_val),flag)
printf("sent an objUpdate using pName: "+objVarRead(obj,"pName"))
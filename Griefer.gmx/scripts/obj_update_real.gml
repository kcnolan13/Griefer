///obj_update_real(obj,variable,flag)
obj = argument0
variable = argument1
flag = argument2

if net_manager.bot_match and variable != "nextMapVote"
{
    return false
}

if not instance_exists(obj) return false

if variable = "arm_animation_index"
    printf("sending netVar update: updating "+string(objVarRead(obj,"uniqueId"))+"'s "+variable+"..."+string(objVarRead(obj,variable)))

var netvar_val = 999

if flag != FL_INSTANCE_DESTROY
    netvar_val = objVarRead(obj,variable)

with (net_manager) {if show_trans_rate transmissions++}

objUpdateReal(obj.object_index,real(objVarRead(obj,"uniqueId")),string(variable),real(netvar_val),flag)

/// @description objUpdateReal(object_index,uniqueId,netvar,val,flag)
/// @function objUpdateReal
/// @param object_index
/// @param uniqueId
/// @param netvar
/// @param val
/// @param flag
var obj = argument0
var uid = argument1
var dat_var = argument2
var dat_val = argument3
var fl = argument4
//printf("invoking newObjUpdateReal: "+string(obj)+", "+string(uid)+", "+string(dat_var)+", "+string(dat_val)+", "+string(fl))
newObjUpdateReal(string(obj)+":"+string(uid),dat_var,dat_val,fl)
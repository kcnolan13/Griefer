///objPushBackReal(object_index,uniqueId,netvar,val,flag)
var obj = argument0
var uid = argument1
var dat_var = argument2
var dat_val = argument3
var fl = argument4

//printf("::: invoking newObjPushBackReal: "+string(obj)+", "+string(uid)+", "+string(dat_var)+", "+string(dat_val)+", "+string(fl))
newObjPushBackReal(string(obj)+":"+string(uid),dat_var,dat_val,fl)

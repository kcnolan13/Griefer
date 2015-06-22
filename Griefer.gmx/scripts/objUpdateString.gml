///objUpdateString(object_index,uniqueId,netvar,strVal,flag)
var obj = argument0
var uid = argument1
var dat_var = argument2
var dat_val = argument3
var fl = argument4

//printf("invoking newObjUpdateString: "+string(obj)+", "+string(uid)+", "+string(dat_var)+", "+string(dat_val)+", "+string(fl))
newObjUpdateString(string(obj)+":"+string(uid),dat_var,string(dat_val),fl)
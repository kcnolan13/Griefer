/// @description objVarWrite(obj,varName,value)
/// @function objVarWrite
/// @param obj
/// @param varName
/// @param value
obj = argument0
varName = argument1
value = argument2

if not instance_exists(obj)
{
    printf("ERROR: objVarWrite for nonexistent object #"+string(obj))
    return BAD_READ
}  


if (ds_map_exists(obj.netvars,varName))
    ds_map_replace(obj.netvars,varName,value)
else
    ds_map_add(obj.netvars,varName,value)
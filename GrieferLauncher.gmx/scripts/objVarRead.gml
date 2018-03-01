///objVarRead(obj,varName)
obj = argument0
varName = argument1

if not instance_exists(obj)
{
    printf("ERROR: objvarRead for nonexistent object #"+string(obj))
    return BAD_READ
}  

if ds_map_exists(obj.netvars,varName)
    return ds_map_find_value(obj.netvars,varName)
else
{
    if WARNINGS and instance_exists(obj) and varName != "pName"
        printf("WARNING: (object "+string(object_index)+"): tried to read (object "+string(obj.object_index)+")'s nonexistent netVar: "+varName)
        
    return BAD_READ
}

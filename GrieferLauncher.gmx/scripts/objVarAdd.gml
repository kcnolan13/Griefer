///objVarAdd(obj,varName,amount)
obj = argument0
varName = argument1
add_amount = argument2

if not instance_exists(obj)
{
    printf("ERROR: objVarAdd for nonexistent object #"+string(obj))
    return BAD_READ
}  


if (ds_map_exists(obj.netvars,varName))
{
    objVarWrite(obj,varName,objVarRead(obj,varName)+add_amount)
} else
{
    if WARNINGS and varName != "pName"
        printf("WARNING: (object "+string(object_index)+"): tried to increment (object "+string(obj.object_index)+")'s nonexistent netVar")
        
    return BAD_READ
}

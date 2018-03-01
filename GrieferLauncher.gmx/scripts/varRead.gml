///varRead(varName)
varName = string(argument0)

if ds_map_exists(netvars,varName)
    return ds_map_find_value(netvars,varName)
else
{
    if WARNINGS and string(varName) != "pName"
        printf("WARNING: (object "+string(object_index)+"): tried to read nonexistent netVar: "+varName)
        
    return BAD_READ
}

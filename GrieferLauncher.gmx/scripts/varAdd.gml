varName = argument0
add_amount = argument1

if (ds_map_exists(netvars,varName))
{
    varWrite(varName,typeconscious_add(varRead(varName),add_amount))
} else
{
    if WARNINGS and varName != "pName"
        printf("WARNING: (object "+string(object_index)+"): tried to increment nonexistent netVar")
        
    return BAD_READ
}

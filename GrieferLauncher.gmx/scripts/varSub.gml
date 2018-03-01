varName = argument0
sub_amount = argument1

if (ds_map_exists(netvars,varName))
{
    varWrite(varName,varRead(varName)-sub_amount)
} else 
{
    if WARNINGS and varName != "pName"
        printf("WARNING: (object "+string(object_index)+"): tried to decrement nonexistent netVar")
        
    return BAD_READ
}

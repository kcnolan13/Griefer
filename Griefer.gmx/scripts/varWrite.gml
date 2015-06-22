///varWrite(varName,value)
varName = argument0
value = argument1

if (ds_map_exists(netvars,varName))
    ds_map_replace(netvars,varName,value)
else
    ds_map_add(netvars,varName,value)
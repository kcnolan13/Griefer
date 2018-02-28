/// @description free memory
if part_emitter_exists(sys_smoke,em)
    part_emitter_destroy(sys_smoke,em)

if part_system_exists(sys_smoke)
    part_system_destroy(sys_smoke)
    
if part_type_exists(ps)
    part_type_destroy(ps)

ds_map_destroy(netvars)


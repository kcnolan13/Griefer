/// @description free memory and un-ink players
for (i=0; i<instance_number(player); i++)
{
    dat_playa = instance_find(player,i)
    if objVarRead(dat_playa,"speed_multiplier") = speed_multiplier
    {
        printf("ink destroy --> freeing player from ink")
        objVarWrite(dat_playa,"speed_multiplier",1)
        obj_update_real(dat_playa,"speed_multiplier",FL_NORMAL)
    }
}


if part_emitter_exists(sys_smoke,em)
    part_emitter_destroy(sys_smoke,em)

if part_system_exists(sys_smoke)
    part_system_destroy(sys_smoke)
    
if part_type_exists(ps)
    part_type_destroy(ps)

event_inherited()


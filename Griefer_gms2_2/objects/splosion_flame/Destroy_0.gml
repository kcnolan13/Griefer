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

if instance_exists(particle_controller)
{
    if part_emitter_exists(particle_controller.sys_flame,em)
        part_emitter_destroy(particle_controller.sys_flame,em)
}

event_inherited()


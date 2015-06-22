///dropper_spawn_weapon()
var dat_wep_do = instance_create_for_everyone(x,y,weapon)

objVarWrite(dat_wep_do,"spawner",id)
obj_update_real(dat_wep_do,"spawner",FL_NORMAL)

//printf("WEAPON SPAWN: "+objVarRead(dat_wep_do,"uniqueId")+" : "+objVarRead(dat_wep_do,"name")+" @ ("+x+", "+y+")")
respawn_counter = respawn_delay
///mega_stat_update(stat_name, value)
var stat = argument0
var val = argument1

printf("mega_stat_update("+string(stat)+", "+string(val)+")")

objVarWrite(net_manager,stat,val)

if instance_exists(net_manager.local_player)
{
    objVarWrite(net_manager.local_player,stat,val)
}

if not instance_exists(net_manager.my_doll)
{
    if WARNINGS printf("WARNING: your avatar does not exist: mega_stat_update("+stat+", "+val+")")
}

if instance_exists(net_manager.my_doll)
    objVarWrite(net_manager.my_doll,stat,val)
    
stat_update_real(stat,val,stat_manager.stat_flag)

if (in_match() or room = rm_lobby)
{
    if instance_exists(net_manager.my_doll)
        obj_update_real(net_manager.my_doll,stat,FL_NORMAL)
        
    if instance_exists(net_manager.local_player)
        obj_update_real(net_manager.local_player,stat,FL_NORMAL)
}

printf(" --finished mega_stat_update")
/// @description become controllable if local
if is_bot(id)
{
    //SYNC MOD VARS
    sync_mod_vars()
}

if is_my_avatar(id)
{
    if instance_exists(net_manager.my_doll)
    {
        objVarWrite(net_manager.my_doll,"uniqueId",varRead("uniqueId"))
    }
    
    varWrite("controllable",false)  //needs to wait for match to start actually
    net_manager.local_player = id
    
    varWrite("rank",objVarRead(net_manager,"rank"))
    varWrite("global_rank",objVarRead(net_manager,"global_rank"))
    
    varWrite("myX",random_range(-50,-400))
    varWrite("myY",random_range(-50,-400))
    x = varRead("myX")
    y = varRead("myY")
    obj_update_real(id,"myX",FL_NORMAL)
    obj_update_real(id,"myY",FL_NORMAL)
    
    //SYNC MOD VARS
    sync_mod_vars()
    
    //tell everyone else your initial stats
    obj_update_real(id,"match_kills",FL_NORMAL)
    obj_update_real(id,"match_deaths",FL_NORMAL)
    obj_update_real(id,"match_assists",FL_NORMAL)
    obj_update_real(id,"match_points",FL_NORMAL)
    
    //sync with local avatar (who should already know this stuff
    if varRead("points") < 0
        varWrite("points",objVarRead(net_manager,"points"))
    if varRead("kills") < 0
        varWrite("kills",objVarRead(net_manager,"kills"))
    if varRead("deaths") < 0
        varWrite("deaths",objVarRead(net_manager,"deaths"))
    if varRead("assists") < 0
        varWrite("assists",objVarRead(net_manager,"assists"))
    if varRead("headshots") < 0
        varWrite("headshots",objVarRead(net_manager,"headshots"))
    if varRead("wins") < 0
        varWrite("wins",objVarRead(net_manager,"wins"))
    if varRead("losses") < 0
        varWrite("losses",objVarRead(net_manager,"losses"))
    if varRead("sprees") < 0
        varWrite("sprees",objVarRead(net_manager,"sprees"))
}

net_manager.alarm[0] = 10


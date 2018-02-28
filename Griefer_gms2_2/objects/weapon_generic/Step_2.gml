/// @description fix to player and weapon contemplation
visible = true

if being_held()
{
     varWrite("myX",objVarRead(dat_jugador,"myX"))
     varWrite("myY",objVarRead(dat_jugador,"myY"))
}
else
{
    //PICKUP CONTEMPLATION
    for (var i=0; i<instance_number(player); i++)
    {
        var playa = instance_find(player,i)
        if (is_bot(playa) or playa = myPlayer()) and not being_held()
        {
            if interactable(playa) and playa.weapon_contemplating < 0
            {
                with playa
                {
                    if not find_my_weapon_by_name(objVarRead(other.id,"name"))
                        weapon_contemplating = other.id
                }
            }
            
            //AUTO ABSORPTION
            var players_wep = find_players_weapon_by_name(playa,varRead("name"))
            if players_wep
            {
                if objVarRead(players_wep,"ammo") < objVarRead(players_wep,"max_ammo") and super_interactable(playa) //and net_manager.local_player.weapon_contemplating = id
                {
                    printf("ammo = "+string(objVarRead(players_wep,"ammo"))+" , max_ammo = "+string(objVarRead(players_wep,"max_ammo"))+" , absorbing more!!")
                    with (playa) 
                    {
                        absorb_weapon(other.id)
                        exit //this weapon is now dead --> ds_map has been freed
                    }
                }
            }
            
            if not interactable(playa) and playa.weapon_contemplating = id
            {
                playa.weapon_contemplating = NO_HANDLE
            }
        
        }
    }
}


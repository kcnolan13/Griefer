if varRead("my_player") = MY_PLAYER_NULL
{
    for (var i=0; i<instance_number(player); i++)
    {
        contemplator = instance_find(player,i)
        if is_bot(contemplator) or contemplator = net_manager.local_player
        {
            if contemplator.weapon_contemplating = id
            {
                if net_manager.local_player = contemplator
                    audio_play_sound(snd_pickup,2,false)
                //printf("::: telling "+objVarRead(contemplator,"pName")+" to pick me up: "+string(varRead("name")))
                with (contemplator) pickup_weapon(weapon_contemplating)
                //printf("::: "+objVarRead(contemplator,"pName")+" picked me up: "+string(varRead("name")))
                contemplator.weapon_wheel_alpha = contemplator.weapon_wheel_alpha_max
                contemplator.weapon_contemplating = NO_HANDLE
                
                if exclude_bots = true
                    exclude_bots = false
                    
                return true
            }
        }
    }
}

if exclude_bots = true
    exclude_bots = false

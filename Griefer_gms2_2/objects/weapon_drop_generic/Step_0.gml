/// @description spawn weapons when ready ---> ONLY PLAYER 0 ACTUALLY DOES THIS
if not instance_exists(net_manager.local_player) 
{
    if rtime() > 30*3
        printf("ERROR: local player does not exist")
        
    //always exit
    exit
}

if net_manager.local_player.object_index != player
    printf("ERROR: net_manager.local_player.object_index = "+string(net_manager.local_player.object_index))

var wep_at_pos = instance_place(x,y,weapon)
if wep_at_pos = noone and not respawn_counter
{
    respawn_counter = respawn_delay
} else if wep_at_pos {
    respawn_counter = 0
}

if respawn_counter
{
    respawn_counter --
    if not respawn_counter
    {
        //attempt to spawn weapon
        var usable_weapon = find_usable_weapon_spawned_by(id)
        if not usable_weapon
        {
            //SPAWN
            dropper_spawn_weapon()            
        } else
        {
            //can still maybe spawn a new one
            if not wait_till_weapon_gone or true
            {
                var wep_at_pos = instance_place(x,y,weapon)
                if wep_at_pos != noone
                {
                    //still might be able to spawn
                    if objVarRead(wep_at_pos,"spawner") != id or objVarRead(wep_at_pos,"been_picked_up")
                    {
                        //SPAWN
                        dropper_spawn_weapon() 
                    } else
                    {
                        if DEBUG
                            printf("unable to respawn weapon --> already one at drop ... trying again in 10 sec.")

                        respawn_counter = 30*10
                    }
                }
                else
                {
                    //SPAWN
                    dropper_spawn_weapon() 
                }
            }
            else
            {
                if DEBUG
                    printf("unable to respawn weapon --> still usable ... trying again in 10 seconds")

                respawn_counter = 30*10
            }
        }
    }
}


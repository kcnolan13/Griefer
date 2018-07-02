/// @description challenge_bullet_kill(local_player, dead_player, bullet_obj_index, death_type)
/// @function challenge_bullet_kill
/// @param local_player
/// @param  dead_player
/// @param  bullet_obj_index
/// @param  death_type
var local_player = argument0
var dead_player = argument1
var bullet_obj = argument2
var death_type = argument3

printf("updating bullet kill challenges")

switch (bullet_obj)
{
    case bullet_shotgun:
       //printf("death_type was: "+death_type)
        if death_type = "die_splosion"
        {
            with challenge_manager
            {
                shotgun_gib_spree++
                shotgun_gib_timer = shotgun_gib_timer_max
            }
        }
    break
    
    case bullet_double:
       //printf("death_type was: "+death_type)
        if death_type = "die_splosion"
        {
            with challenge_manager
            {
                double_gib_spree++
                double_gib_timer = double_gib_timer_max
            }
        }
    break
    
    case bullet_long:
        printf("death_type was: "+death_type)
        if death_type = "die_headshot"
        {
            with challenge_manager
            {
                life_longshot_headshots++
            }
        }
    break
    
    case bullet_stomper:
        printf("death_type was: "+death_type)
        if death_type = "die_headshot"
        {
            with challenge_manager
            {
                life_stomper_headshots++
            }
        }
    break
    
    case bullet_pistol:
        if death_type = "die_headshot"
        {
            with challenge_manager
            {
                match_pistol_headshots++
            }
        }
    break
    
    case bullet_rifle:
        //if death_type = "die_headshot"
        {
            with challenge_manager
            {
                rifle_kills++
            }
        }
    break
    
    case bullet_tickler:
        //if death_type = "die_headshot"
        {
            with challenge_manager
            {
                tickler_kills++
            }
        }
    break
    
    case bullet_carbine:
        //if death_type = "die_headshot"
        {
            with challenge_manager
            {
                carbine_kills++
            }
        }
    break
    
    case splosion_boom:
        if death_type = "die_splosion"
        {
            with challenge_manager
            {
                boom_kills++
            }
        }
    break
    
    case splosion_rocket:
        if death_type = "die_splosion"
        {
            with challenge_manager
            {
                rocket_kills++
            }
        }
    break
    
    case bullet_boltok:
        printf("death_type was: "+death_type)
        if death_type = "die_headshot"
        {
            with challenge_manager
            {
                boltok_kills++
                //printf("boltok_kills = "+boltok_kills)
            }
        }
    break
    
    case bullet_vulcan:
        //if death_type = "die_headshot"
        {
            with challenge_manager
            {
                vulcan_kills++
            }
        }
    break
    
    case bullet_lmg:
        //if death_type = "die_headshot"
        {
            with challenge_manager
            {
                lmg_kills++
            }
        }
    break
    
    case bullet_smg:
        //if death_type = "die_headshot"
        {
            with challenge_manager
            {
                smg_kills++
            }
        }
    break
    
    default:
        //printf("he was not killed by bullet_shotgun, rather: "+bullet_obj.object_index)
    break

}
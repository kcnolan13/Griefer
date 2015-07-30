varWrite("you_dead_son",false) //true triggers this script --> no multiple deaths please

varWrite("alive",false)
obj_update_real(id,"alive",FL_NORMAL)

varWrite("fire_counter",0)
obj_update_real(id,"fire_counter",FL_NORMAL)

audio_stop_sound(snd_flashed)

//clear out your spree
if is_my_avatar(id)
{
    if varRead("rollover_kstreak")
    {
        varWrite("rollover_kstreak",0)
        stat_update_real("rollover_kstreak",0,stat_manager.stat_flag)
    }
        
    with challenge_manager {
        untouched_kills = 0
        spree_headshots = 0
        spree_gibs = 0
        spree_flashes = 0
        spree_kills = 0
        spree_assists = 0
        life_longshot_headshots = 0
        match_deaths++
        near_death_xps = 0
        near_death = false
        if match_deaths >= underwear_deaths and not challenge_is_complete(global.underwear_name)
            complete_challenge(global.underwear_name)
    }
}

//drop your current weapon and destroy the other.ids
drop_weapon_position(varRead("weapon_index"),varRead("drop_weapon_x"),varRead("drop_weapon_y"))
for (i=0; i<4; i++)
{
    if instance_exists(varRead("weapon"+string(i)))
        instance_destroy_for_everyone(varRead("weapon"+string(i)))
    
    varWrite("weapon"+string(i),NO_HANDLE)
}
varWrite("active_weapon",NO_HANDLE)

//go invisible, intangible, and get out of the way
varWrite("visible",false)
varWrite("controllable",false)
varWrite("myX",-500)
varWrite("myY",-500)

//increment deaths and let everyone know
varAdd("deaths",1)
varAdd("match_deaths",1)

//send local player's kills to server and other.id clients
update_flag = FL_NORMAL
if is_bot(id)
    update_flag = FL_BOT
    
obj_update_real(id,"match_deaths",update_flag)

if not is_bot(id)
    stat_update_real("deaths",varRead("deaths"),stat_manager.stat_flag)

varWrite("die",false)
varWrite("die_headshot",false)
varWrite("die_splosion",false)

//set respawn timer
respawn_counter = respawn_delay

if not is_bot(id)
{
    hit_indicator.draw_alpha1 = 1
    hit_indicator.draw_alpha2 = 1
}
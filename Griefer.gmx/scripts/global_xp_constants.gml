//init xp constants

var rank_xp_mult = 1.5
global.rank_xp[0] = 0
global.rank_xp[1] = 1000

var needed = 500
var total_xp = 0

printf("::: XP["+string(0)+"],"+string(global.rank_xp[0])+", XP for Level "+string(0)+" : "+string(global.rank_names[0])) 
printf("::: XP["+string(1)+"],"+string(global.rank_xp[1])+", XP for Level "+string(1)+" : "+string(global.rank_names[1])) 

for (var i=2; i<getLength(global.rank_names); i++)
{
    global.rank_xp[i] = global.rank_xp[i-1]+needed  //61*305*5/2
    total_xp = global.rank_xp[i]
    printf("::: XP["+string(i)+"],"+string(total_xp)+", XP for Level "+string(i)+" : "+string(global.rank_names[i])) 
    
    needed += 150

    if i <= 4
        needed += 100
    else if i <= 9
        needed += 800
    else if i <= 12
        needed += 100
    else if i <= 14
        needed += 200
    else if i <= 18
        needed += 1250
    else
        needed += 4000
}

global.num_ranks = getLength(global.rank_names)

unlock_indices[0] = spr_hiker_helmet
unlock_indices[1] = spr_beta_head
unlock_indices[2] = spr_spiral_helmet
unlock_indices[3] = spr_desert_helmet
unlock_indices[4] = spr_ranger_helmet
unlock_indices[5] = spr_arctic_helmet
unlock_indices[6] = spr_blue_helmet
unlock_indices[7] = spr_shield_helmet
unlock_indices[8] = spr_leather_helmet
unlock_indices[9] = spr_plague_helmet
unlock_indices[10] = spr_husky_helmet
unlock_indices[11] = spr_gold_helmet
unlock_indices[12] = spr_red_helmet
unlock_indices[13] = spr_trace_helmet
unlock_indices[14] = spr_aroach_helmet
unlock_indices[15] = spr_orange_helmet
unlock_indices[16] = spr_bee_helmet
unlock_indices[17] = spr_heavy_helmet
unlock_indices[18] = spr_med_helmet
unlock_indices[19] = spr_cursed_helmet

var unlock_indexer = 0
global.unlock_sprites[0] = spr_none
global.unlock_sprites[1] = unlock_indices[unlock_indexer] unlock_indexer++

var interval_counter = 0

//printf("ERROR: length of global.rank_names = "+string(getLength(global.rank_names)))

for (var i=2; i<global.num_ranks; i++)
{
    interval_counter++
    if interval_counter = global.rank_interval
    {
        interval_counter = 0
        unlock_indexer++
        global.unlock_sprites[i] = unlock_indices[unlock_indexer-1]
    } else
    {
        global.unlock_sprites[i] = spr_none
    }
     //printf("ERROR: global.unlock_sprites["+string(i)+"] = "+string(global.unlock_sprites[i]))
}

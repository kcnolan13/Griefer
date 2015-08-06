//init xp constants

var rank_xp_mult = 1.5
global.rank_xp[0] = 0
global.rank_xp[1] = 1000
global.rank_xp[2] = 1500
global.rank_xp[3] = 2000
global.rank_xp[4] = 2500
global.rank_xp[5] = 3000

for (var i=6; i<getLength(global.rank_names); i++)
{
    global.rank_xp[i] = 2*global.rank_xp[i-1]+300  //61*305*5/2
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

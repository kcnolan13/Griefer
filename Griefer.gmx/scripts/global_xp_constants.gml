//init xp constants

var rank_xp_mult = 1.5
global.rank_xp[0] = 0
global.rank_xp[1] = 500

for (var i=2; i<getLength(global.rank_names); i++)
{
    global.rank_xp[i] = global.rank_xp[i-1]+500  //*rank_xp_mult
}

global.num_ranks = getLength(global.rank_names)

var unlock_indexer = spr_eva_helmet
global.unlock_sprites[0] = spr_none
global.unlock_sprites[1] = unlock_indexer

var interval_counter = 0

//printf("ERROR: length of global.rank_names = "+string(getLength(global.rank_names)))

for (var i=2; i<global.num_ranks; i++)
{
    interval_counter++
    if interval_counter = global.rank_interval
    {
        interval_counter = 0
        unlock_indexer++
        global.unlock_sprites[i] = unlock_indexer
    } else
    {
        global.unlock_sprites[i] = spr_none
    }
     //printf("ERROR: global.unlock_sprites["+string(i)+"] = "+string(global.unlock_sprites[i]))
}
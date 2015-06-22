///increase_max_ranks(increase_to_rank)
var len = array_length_1d(global.rank_names)
var num = argument0-(len-1)

for (var i=0; i<num; i++)
{
    printf("::: extending max rank to:  "+string(len+i))
    global.rank_names[len+i] = global.rank_names[len+i-1]
    global.rank_colors[len+i] = global.rank_colors[len+i-1]
    global.unlock_sprites[len+i] = spr_none
    global.rank_xp[len+i] = global.rank_xp[len+i-1]*1.25
}
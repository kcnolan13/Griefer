///next_unlock_spr(current_rank)
var rank = argument0

for (var i=rank+1; i<getLength(global.rank_names); i++)
{
    var spr = get_rank_unlock_sprite(i)
    if spr != spr_none
        return spr
}
return spr_none
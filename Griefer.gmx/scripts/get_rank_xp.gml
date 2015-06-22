///get_rank_xp(rank)

var r = real(argument0)

if r < array_length_1d(global.rank_xp)
    return real(global.rank_xp[r])
else
    return real(global.rank_xp[array_length_1d(global.rank_xp)-1])
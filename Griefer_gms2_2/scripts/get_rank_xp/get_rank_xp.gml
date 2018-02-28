/// @description get_rank_xp(rank)
/// @function get_rank_xp
/// @param rank

var r = real(argument0)

if r < array_length_1d(global.rank_xp)
    return real(global.rank_xp[r])
else
    return real(global.rank_xp[array_length_1d(global.rank_xp)-1])
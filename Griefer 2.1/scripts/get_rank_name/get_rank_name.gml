/// @description get_rank_name(rank)
/// @function get_rank_name
/// @param rank

var r = real(argument0)

if r < array_length_1d(global.rank_names)
    return string(global.rank_names[r])
else
    return string(global.rank_names[array_length_1d(global.rank_names)-1])
/// @description step_rand(random_number, rank)
/// @function step_rand
/// @param random_number
/// @param  rank
var rando = argument0
var rank = argument1

var divisor = global.dice_divisor[floor((rank+1)/global.rank_interval)]

return rando/divisor
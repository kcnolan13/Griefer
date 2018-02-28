/// @description armor_set_diceroll(rank)
/// @function armor_set_diceroll
/// @param rank
var rank = argument0
var rar = random(1)
var rar_index = -1

rar = rar*random_range(rank/(global.rank_max_theoretical/2),1)

if rar < global.prob_rarity[5]
  rar_index = 5
else if rar < global.prob_rarity[4]
  rar_index = 4
else if rar < global.prob_rarity[0]
  rar_index = 0
else if rar < global.prob_rarity[3]
  rar_index = 3
else if rar < global.prob_rarity[2]
    rar_index = 2
else if rar < global.prob_rarity[1]
    rar_index = 1

return random_armor_set_with_rarity(rar_index)

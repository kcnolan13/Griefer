///random_armor_set_with_rarity(rarity)
var rarity = argument0
var armor_set = floor(random_range(0,array_length_1d(global.armor_sets)-0.1))
var loop_counter = 0

while (armor_set_rarity(armor_set) != rarity) and loop_counter < 500
{
    loop_counter ++
    armor_set = floor(random_range(0,array_length_1d(global.armor_sets)-0.1))
}

return armor_set
/// @description armor_set_rarity(armor_set_index)
/// @function armor_set_rarity
/// @param armor_set_index
var ind = argument0
return bpart_lookup(global.armor_sets[ind,0],global.BPART_RARITY)
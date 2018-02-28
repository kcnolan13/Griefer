/// @description get_bpart_color(sprite_index)
/// @function get_bpart_color
/// @param sprite_index
var spr = argument0

var r = real(bpart_lookup(spr, global.BPART_RARITY))
if r > array_length_1d(global.col_rarity)-1
    r = array_length_1d(global.col_rarity)-1

if r < 0
r = 0

return global.col_rarity[r]
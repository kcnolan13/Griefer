/// @description increment_weapon_accolade(weapon_sprite_string)
/// @function increment_weapon_accolade
/// @param weapon_sprite_string
var spr = argument0

var curr_total = acc_total(spr)
update_accolade_total(spr,curr_total+1,stat_manager.stat_flag,true)

return true
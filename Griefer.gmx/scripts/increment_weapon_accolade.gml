///increment_weapon_accolade(weapon_sprite_string)
var spr = argument0

var curr_total = acc_data(spr,COL_TOTAL)

update_accolade_total(spr,curr_total+1,TOTAL,true)

return true

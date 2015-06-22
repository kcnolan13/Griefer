///randomize_bpart_slot(list, slotNum)
var list = argument0
var num = argument1

if ds_list_empty(list)
return false

item_index = floor(random_range(0,ds_list_size(list)-0.1))
temp = list[| 0]
list[| 0] = list[| item_index]
list[| item_index] = temp

return true
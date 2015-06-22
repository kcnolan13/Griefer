///glr_lightsimple_destroy(lightsimple id)
if instance_exists(argument0)
with (argument0) instance_destroy()

return true

//
//
//OLD SHIT
//
//

ds_list_delete(global.GLR_LIGHT_LIST_SIMPLE, ds_list_find_index(global.GLR_LIGHT_LIST_SIMPLE,argument0));
ds_list_destroy(argument0); 
 
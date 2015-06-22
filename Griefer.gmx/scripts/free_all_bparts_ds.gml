///free_all_bparts_ds()
for (var i=0; i<ds_list_size(global.yo_bparts); i++)
{
    ds_list_destroy(global.yo_bparts[| i])
}

ds_list_destroy(global.yo_bparts)
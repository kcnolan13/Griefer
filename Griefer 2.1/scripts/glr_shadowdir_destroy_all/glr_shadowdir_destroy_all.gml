/// @description glr_shadowdir_destroy_all();
/// @function glr_shadowdir_destroy_all
var size = ds_list_size(global.GLR_SHADOWDIR_LIST);
for(i = 0; i < size; i++){
    var s = global.GLR_SHADOWDIR_LIST[| i];
    ds_list_destroy(s);
}
ds_list_clear(global.GLR_SHADOWDIR_LIST);
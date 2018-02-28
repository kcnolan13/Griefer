/// @description glr_shadowdepth_destroy(id)
/// @function glr_shadowdepth_destroy
/// @param id
ds_list_delete(global.GLR_DEP_DYN_LIST, ds_list_find_index(global.GLR_DEP_DYN_LIST,argument0));
ds_list_destroy(argument0);
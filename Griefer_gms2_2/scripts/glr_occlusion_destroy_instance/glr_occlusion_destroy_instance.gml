/// @description glr_occlusion_destroy_instance(instance id);
/// @function glr_occlusion_destroy_instance
/// @param instance id
ds_list_delete(global.GLR_OCCLUSION_LIST_INST, ds_list_find_index(global.GLR_OCCLUSION_LIST_INST,argument0));
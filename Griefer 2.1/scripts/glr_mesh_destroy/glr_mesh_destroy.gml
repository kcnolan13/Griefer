/// @description glr_mesh_destroy(mesh)
/// @function glr_mesh_destroy
/// @param mesh

var mesh = argument0;
ds_list_destroy(mesh[| 1]);
buf = mesh[| 2];
if(buf != -1) vertex_delete_buffer(buf); 
if(mesh[| 13]){
    ds_list_delete(global.GLR_MESH_STC_LIST, ds_list_find_index(global.GLR_MESH_STC_LIST, mesh));
}else{
    ds_list_delete(global.GLR_MESH_DYN_LIST, ds_list_find_index(global.GLR_MESH_DYN_LIST, mesh));
}
ds_list_destroy(mesh);
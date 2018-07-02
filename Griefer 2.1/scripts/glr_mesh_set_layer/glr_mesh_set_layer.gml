/// @description glr_mesh_set_layer(mesh id, layer)
/// @function glr_mesh_set_layer
/// @param mesh id
/// @param  layer
//sets the mesh layer
//if the mesh layer is greater then a light layer, this mesh will not cast shadows from that light
ds_list_replace(argument0,14,argument1);
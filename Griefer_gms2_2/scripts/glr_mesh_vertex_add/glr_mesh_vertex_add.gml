/// @description glr_mesh_vertex_add(mesh id, x, y);
/// @function glr_mesh_vertex_add
/// @param mesh id
/// @param  x
/// @param  y
var l=ds_list_find_value(argument0,1);
ds_list_add(l,argument1);
ds_list_add(l,argument2);
return ds_list_size(argument0)/2  -1;
/// @description glr_light_set_static(light, static)
/// @function glr_light_set_static
/// @param light
/// @param  static
var t_sur = argument0[| 17];
if(t_sur != -1)
{
    surface_free(t_sur);
    argument0[| 17] = -1;
}
argument0[| 14] = argument1; 
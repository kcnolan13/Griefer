/// @description glr_light_refresh(light id)
/// @function glr_light_refresh
/// @param light id
//refresh the current static light
var t_sur = argument0[| 17];
if(t_sur != -1)
{
    surface_free(t_sur);
    argument0[| 17] = -1;
}
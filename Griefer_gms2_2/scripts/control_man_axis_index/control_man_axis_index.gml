/// @description input_man_axis_index(axis_constant)
/// @function input_man_axis_index
/// @param axis_constant
var ax = argument0

for (var i=0; i<4; i++)
{
    if input_manager.axes[i] = ax
        return i
}

return 0
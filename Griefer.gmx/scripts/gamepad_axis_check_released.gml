///gamepad_axis_check_released(device, control_constant)
var device = argument0
var input_const = argument1

input_const = handle_swap_sticks(input_const)

var val = gamepad_axis_value(device,input_const)
if input_manager.released[control_man_axis_index(input_const)]
{
    return true
}

return false
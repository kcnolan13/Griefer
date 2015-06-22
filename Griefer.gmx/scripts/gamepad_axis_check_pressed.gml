///gamepad_axis_check_pressed(device, control_constant)
var device = argument0
var input_const = argument1

input_const = handle_swap_sticks(input_const)

var val = gamepad_axis_value(device,input_const)
if abs(val) > gamepad_get_axis_deadzone(device) and not input_manager.pressed[control_man_axis_index(input_const)]
{
    input_manager.set_pressed[control_man_axis_index(input_const)] = true
    return true
}

return false
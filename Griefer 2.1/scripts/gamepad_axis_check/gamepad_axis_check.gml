/// @description gamepad_axis_check(device, control_constant)
/// @function gamepad_axis_check
/// @param device
/// @param  control_constant
var device = argument0
var input_const = argument1

input_const = handle_swap_sticks(input_const)

var val = gamepad_axis_value(device,input_const)

//printf("::: gamepad axis val: "+string(val)+", deadzone: "+string(gamepad_get_axis_deadzone(device)))

if abs(val) > gamepad_get_axis_deadzone(device)
{
    return true
}

return false
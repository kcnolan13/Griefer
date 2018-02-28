/// @description gamepad_stick_val(axis_constant)
/// @function gamepad_stick_val
/// @param axis_constant
var axis = argument0

var val = 0
var ret = 0

axis = handle_swap_sticks(axis)

val = real(gamepad_axis_value(global.devno, axis))
return val
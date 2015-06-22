///set_gamepad_deadzones()
var deadzone = 0.18
if gamepad_is_connected(0) gamepad_set_axis_deadzone(0, deadzone);
if gamepad_is_connected(1) gamepad_set_axis_deadzone(1, deadzone);
if gamepad_is_connected(2) gamepad_set_axis_deadzone(2, deadzone);
if gamepad_is_connected(3) gamepad_set_axis_deadzone(3, deadzone);
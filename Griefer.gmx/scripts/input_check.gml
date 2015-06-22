///input_check(control_constant)
var input_const = argument0

if input_is_keyboard(input_const)
    return keyboard_check(input_const)

if input_is_mouse(input_const)
    return mouse_check_button(input_const)
    
if input_is_gamepad_button(input_const)
    return gamepad_button_check(global.devno, input_const)
    
if input_is_gamepad_axis(input_const)
    return gamepad_axis_check(global.devno, input_const)
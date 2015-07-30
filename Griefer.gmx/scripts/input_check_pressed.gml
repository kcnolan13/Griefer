///input_check_pressed(control_constant)
var input_const = argument0

if instance_exists(modal_controls) return false

if input_is_keyboard(input_const)
    return keyboard_check_pressed(input_const)

if input_is_mouse(input_const)
    return mouse_check_button_pressed(input_const)
    
if input_is_gamepad_button(input_const)
    return gamepad_button_check_pressed(global.devno, input_const)
    
if input_is_gamepad_axis(input_const)
    return gamepad_axis_check_pressed(global.devno, input_const)
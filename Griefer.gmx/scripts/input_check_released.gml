///input_check_released(control_constant)
var input_const = argument0

if instance_exists(modal_controls) return false

if input_is_keyboard(input_const)
    return keyboard_check_released(input_const)

if input_is_mouse(input_const)
    return mouse_check_button_released(input_const)
    
if input_is_gamepad_button(input_const)
    return gamepad_button_check_released(global.devno, input_const)
    
if input_is_gamepad_axis(input_const)
    return gamepad_axis_check_released(global.devno, input_const)
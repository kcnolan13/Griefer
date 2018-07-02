/// @description pressing_right()
/// @function pressing_right
if input_check(mapped_control(C_MOVE_RIGHT))
{
    if input_is_gamepad_axis(mapped_control(C_MOVE_RIGHT))
    {
        if gamepad_stick_val(mapped_control(C_MOVE_RIGHT)) > gamepad_get_axis_deadzone(global.devno)
            return true
        else return false
    }
    else return true
}
return false
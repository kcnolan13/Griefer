/// @description pressing_left()
/// @function pressing_left

if input_check(mapped_control(C_MOVE_LEFT))
{
    if input_is_gamepad_axis(mapped_control(C_MOVE_LEFT))
    {
        if gamepad_stick_val(mapped_control(C_MOVE_LEFT)) < gamepad_get_axis_deadzone(global.devno)
            return true
        else return false
    }
    else return true
}

return false
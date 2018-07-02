/// @description sync control scheme at start

if global.using_gamepad
{
    refresh_control_scheme(FL_GAMEPAD)
}
else refresh_control_scheme(FL_KEYBOARD)


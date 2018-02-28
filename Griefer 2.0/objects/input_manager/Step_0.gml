/// @description detect gamepads and run scheduled scripts

var gp_num = gamepad_get_device_count()
var success = false

for (var i=0; i<gp_num-1; i++)
{
    if gamepad_is_connected(i)
    {
        if not global.using_gamepad and not global.forced_control_scheme
        {
            printf("::: GAMEPAD CONNECTED")
            refresh_control_scheme(FL_GAMEPAD)
            set_gamepad_deadzones()
        }
        global.gamepad_connected = true
        global.devno = i
        success = true
        break
    }
}

if not success and global.using_gamepad
{
    global.using_gamepad = false
    global.forced_control_scheme = false
    printf("::: GAMEPAD DISCONNECTED")
    refresh_control_scheme(FL_KEYBOARD)
}

///calculate axis pressed/released

for (var i=0; i<4; i++)
{
    if pressed_counter[i]
        pressed_counter[i] --
        
    //only release for one frame
    if released[i]
        released[i] = false
        
    if pressed[i] and not pressed_counter[i] and not gamepad_axis_check(global.devno,axes[i])
    {
        pressed[i] = false
        released[i] = true
    }
}


///scheduler
if schedule_counter
{
    schedule_counter = sub_real(schedule_counter,1)
    if not schedule_counter
    {
        script_execute(schedule_script)
        schedule_script = scr_none
    }
}


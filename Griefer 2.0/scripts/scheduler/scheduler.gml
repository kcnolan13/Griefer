/// @description scheduler(script,delay)
/// @function scheduler
/// @param script
/// @param delay
var scr = argument0
var delay = argument1

if input_manager.schedule_script != scr_none
{
    printf("ERROR: tried to schedule script "+string(script_get_name(scr))+" for "+string(delay/30)+" secs from now ... but scheduler already occupied")
    return false
}

input_manager.schedule_script = scr
input_manager.schedule_counter = delay

return true

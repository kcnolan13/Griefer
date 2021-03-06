/// @description get_ready(forced_state)
/// @function get_ready
/// @param forced_state
var forced_state = argument0

if not visible or bound_avatar != myAvatar() or clicked
{
    return false
}

clicked = 2
audio(snd_click,1)

//toggle ready
if forced_state > -1
    ready = forced_state
else
    ready ^= 1
    
objVarWrite(bound_avatar,"ready",ready)
obj_update_real(bound_avatar,"ready",FL_NORMAL)

//start match if possible
start_match = true
with avatar
{
    if not varRead("ready")
        other.start_match = false
}

if start_match and not sent_ready
{
    sent_ready = true
    with bn_ready sent_ready = true
    printf("::: SENDING START MATCH NOW")
    sendMessageReal("everyone_ready",FL_NORMAL)
}

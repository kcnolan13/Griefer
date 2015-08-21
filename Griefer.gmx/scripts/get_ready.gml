///get_ready()

if not visible or bound_avatar != myAvatar() or clicked
{
    return false
}

clicked = 2
audio_play_sound(snd_click,2,false)

//toggle ready
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

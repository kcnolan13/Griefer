/// @description start not ready most of the time
event_inherited()

if not instance_exists(bound_avatar)
{
    printf("::: NO BOUND AVATAR FOR bn_ready at start of room")
    instance_destroy()
    exit
}

objVarWrite(bound_avatar,"ready",false)
ready = false
sent_ready = false


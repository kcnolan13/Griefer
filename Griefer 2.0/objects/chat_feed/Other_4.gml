/// @description force show, clear out when leave matchmaking
if in_match()
    force_show = false
    
if room = rm_menu
{
    for (var i=0; i<getLength(msgs); i++)
    {
        if instance_exists(msgs[i])
        {
            with msgs[i] instance_destroy()
            msgs[i] = NO_HANDLE
        }
    }
    //delete array basically
    msgs = 0
}


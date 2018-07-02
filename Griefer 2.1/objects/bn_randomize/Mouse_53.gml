event_inherited()

if exit_child
{
    exit_child = false
    exit
}

if visible and not net_manager.lock_armory and alpha > 0.5
{
    for (var i=0; i<8; i++)
    {
        if not net_manager.armory_disabled[i]
            randomize_bpart_slot(net_manager.armory_lists[| i],0)
    }
    with net_manager sync_my_doll()
}


event_inherited()

if exit_child
{
    exit_child = false
    exit
}

if active = false and not net_manager.lock_armory
{
    request_accolades(objVarRead(net_manager,"pName"),FL_NORMAL)
    active = true
    net_manager.menu_mode = "challenges"
}
else {
    active = false
}


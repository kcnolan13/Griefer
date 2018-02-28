event_inherited()

if exit_child
{
    exit_child = false
    exit
}

if active = false and not net_manager.lock_armory
{
    active = true
    net_manager.menu_mode = "armory"
}
else {
    active = false
}


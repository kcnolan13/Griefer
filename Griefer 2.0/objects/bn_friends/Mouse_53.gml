event_inherited()

if exit_child
{
    exit_child = false
    exit
}

if active = false
{
    active = true
    net_manager.menu_mode = "friends"
}
else {
    active = false
}


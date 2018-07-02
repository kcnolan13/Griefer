/// @description all dat ish
if not instance_exists(bound_avatar)
{
    instance_destroy()
    exit
}

if not visible or bound_avatar != myAvatar() or clicked
{
    exit
}

if not modal_highlighted(id) or net_manager.lobby_match_countdown
{
    exit_child = true
    exit
}

get_ready(-1)


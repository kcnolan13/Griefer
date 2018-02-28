event_inherited()

if exit_child
{
    exit_child = false
    exit
}

if active = false
{
    active = true
    //net_manager.menu_mode = "leaderboards"
    url_open_full("http://puddlesquid.com/games/griefer/leaderboards.html","_blank","menubar=false, status=false, titlebar=false, toolbar=false, height=768, width=1024, left=0")
}
else {
    active = false
}


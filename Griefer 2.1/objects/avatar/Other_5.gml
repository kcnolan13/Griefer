/// @description destroy if player_quit
if room = rm_lobby
{
    if varRead("player_quit") and net_manager.my_doll != id
        instance_destroy()
}


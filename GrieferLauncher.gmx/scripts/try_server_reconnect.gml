///try_server_reconnect()

with controller
{
    if not server_found
    {
        disconnect_on_game_end = false
        game_restart()
    }
}

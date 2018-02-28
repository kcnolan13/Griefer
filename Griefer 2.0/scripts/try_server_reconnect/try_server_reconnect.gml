/// @description try_server_reconnect()
/// @function try_server_reconnect

with net_manager
{
    if not server_found
    {
        disconnect_on_game_end = false
        griefer_restart()
    }
}

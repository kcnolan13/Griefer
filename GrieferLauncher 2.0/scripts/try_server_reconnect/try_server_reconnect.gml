/// @description try_server_reconnect()
/// @function try_server_reconnect

with controller
{
    if not server_found
    {
        disconnect_on_game_end = false
		
		// store the other server URL to try on the new connection
		ini_open(launcherStateIni)
			if serverURL == primaryServerURL
				storeURL = alternateServerURL
			else
				storeURL = primaryServerURL
				
			ini_write_string("Main","ServerURL",storeURL)
			printf("::: wrote next ServerURL to ini: "+storeURL)
			printf("::: successfully stored as "+ini_read_string("Main","ServerURL","null"))
		ini_close()
		
        game_restart()
    }
}

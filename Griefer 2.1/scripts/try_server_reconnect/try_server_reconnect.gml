/// @description try_server_reconnect()
/// @function try_server_reconnect

with net_manager
{
    if not server_found
    {
        disconnect_on_game_end = false
        ini_open(gameStateIni)
            if serverURL == primaryServerURL
                storeURL = alternateServerURL
            else
                storeURL = primaryServerURL
            
            ini_write_string("Main","ServerURL",storeURL)
            printf("::: wrote next ServerURL to ini: "+storeURL)
            printf("::: successfully stored as "+ini_read_string("Main","ServerURL","null"))
            
            //force restart next time just to avoid potential connection issues
            /*restarts_remaining = 0
            ini_write_real("Main","RestartsRemaining",restarts_remaining)
            printf("::: asking for "+string(restarts_remaining)+" force restarts to avoid connection issues")
            
            printf("::: invoking closeConnection()")
            closeConnection()*/
    
        ini_close()
		//launch new instance of game
        launchGame(getExecPath())
		//close old game
        game_end()
    }
}

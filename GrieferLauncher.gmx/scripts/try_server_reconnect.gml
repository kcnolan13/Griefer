///try_server_reconnect()

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
            
            //force restart next time just to avoid potential connection issues
            /*restarts_remaining = 0
            ini_write_real("Main","RestartsRemaining",restarts_remaining)
            printf("::: asking for "+string(restarts_remaining)+" force restarts to avoid connection issues")
            
            printf("::: invoking closeConnection()")
            closeConnection()*/
    
        ini_close()
        launchGame(getExecPath())
        game_end()
        //game_restart()
    }
}

//game_end()

with net_manager
{
    ini_open(grieferURL+"/Config/Config.ini")
    ini_write_real("Main","RestartsRemaining",2)
    ini_close()
    
    //maybe don't do this?
    //closeConnection()
    
    game_restart()
}
//net_manager.alarm[10] = room_speed*2
//url_open(net_manager.griefer_url);

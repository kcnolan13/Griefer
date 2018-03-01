/// @description DETECT DOWNLOAD COMPLETE
if ds_map_find_value(async_load, "id") == file
{
   var status = ds_map_find_value(async_load, "status");
   if status = 0
   {
        printf("::: DOWNLOAD COMPLETE to: "+string(downloadURL))
        
        //this patch is known to be downloaded now :)
        ini_open("Config/Config.ini")
        ini_write_string("Main","Version",official_server_hash)
        ini_close()
        
        printf("::: writing version hash to Config.ini: "+official_server_hash)
        
        launch_game()
   }
   else if status = 1
   {
        var percent = ds_map_find_value(async_load, "sizeDownloaded") / ds_map_find_value(async_load, "contentLength")
        //printf("::: PERCENT = "+string(percent))
        download_percent = percent
   }
}


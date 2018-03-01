///download_updates(file_num)
var file_num = argument0

printf("::: downloading updates to: "+string(downloadURL[file_num]))
//printf("::: "+string(getExecPath()))

/*aID = popup_okay(WVIEW/2,HVIEW/2,"New Version Available","New features and fixes are waiting for you.",download_new_game)
aID.text_okay = "Download"
aID.header_color = web_hsv(148,50,75)
aID.header_text_color = c_white*/
//ID.depth = -20000
with modal_dialogue
{
    //if is_checking
    //{
        is_downloading = true
        is_checking = false
        show_percent = true
        text_downloading = "Downloading "+other.files[file_num]+" ..."
    //}
}

printf("::: invoking http_get_file("+remoteDownloadURL[file_num]+","+"Downloads/"+files[file_num])
file = http_get_file(remoteDownloadURL[file_num],"Downloads/"+files[file_num])

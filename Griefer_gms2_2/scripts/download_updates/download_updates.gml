/// @description download_updates()
/// @function download_updates
downloadURL = "http://www.kylenolan.net/griefer/release/Griefer.exe"
printf("::: downloading updates to working_directory: "+string(downloadURL))
printf("::: "+string(getExecPath()))

/*aID = popup_okay(WVIEW/2,HVIEW/2,"New Version Available","New features and fixes are waiting for you.",download_new_game)
aID.text_okay = "Download"
aID.header_color = web_hsv(148,50,75)
aID.header_text_color = c_white*/

force_loading_popup = true
aID = popup_loading(WVIEW/2,HVIEW/2)
global.load_count --
force_loading_popup = false
aID.is_downloading = true
aID.text = "Downloading Important Updates"
aID.load_closable = false
//ID.depth = -20000

file = http_get_file("http://www.puddlesquid.com/griefer/release/Griefer.exe","Downloads/Griefer.exe")


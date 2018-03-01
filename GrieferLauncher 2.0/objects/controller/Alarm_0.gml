/// @description validate version with server

sendMessageStr("validate_hash",hash)
printf("::: sent hash "+string(hash)+" for validation")

wdir = working_directory
//wdir = string_replace_all(wdir,"\\","/")
//setWorkingDir(wdir)

force_loading_popup = true
aID = popup_loading(WVIEW/2+32,HVIEW*3/4)
global.load_count --
force_loading_popup = false
aID.is_downloading = false
aID.is_checking = true
aID.text = aID.text_checking
aID.load_closable = false
aID.draw_fade = false
aID.fade_alpha = 0
aID.draw_gradient = false
aID.draw_rect = false
aID.highlightable = false
aID.alpha_max = 1


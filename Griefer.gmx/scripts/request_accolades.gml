///request_accolades(username,flag)
var username = string(argument0)
var fl = real(argument1)

if object_index != bn_challenges
    popup_loading(WVIEW/2,HVIEW/2)
    
printf("::: sent accolades request")
clear_accolade_totals(TOTAL)
clear_accolade_totals(COL_BOT_TOTAL)

sendBigMessageStrReal("get_accolades",username,fl,FL_NORMAL)

///request_accolades(username,flag)
var username = string(argument0)
var fl = real(argument1)

printf("::: sent accolades request")
clear_accolade_totals(TOTAL)
sendBigMessageStrReal("get_accolades",username,fl,FL_NORMAL)

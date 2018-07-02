/// @description request_personal_stats(username,flag)
/// @function request_personal_stats
/// @param username
/// @param flag
var username = string(argument0)
var fl = real(argument1)

printf("::: sent personal stats request")
sendBigMessageStrReal("get_personal_stats",username,fl,FL_NORMAL)

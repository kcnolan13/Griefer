/// @description scr_create_user()
/// @function scr_create_user

field_pname = net_manager.uname
field_pword = net_manager.pword

if instance_exists(field_pname) and instance_exists(field_pword)
{
    popup_loading(WVIEW/2,HVIEW/2)
    sendBigMessageStr("user_try_create",string(field_pname.text),string(field_pword.text),"lez get it on")
}

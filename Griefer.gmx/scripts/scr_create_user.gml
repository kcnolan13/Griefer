///scr_create_user()

if instance_exists(bn_login_user) and instance_exists(bn_login_user.field_username) and instance_exists(bn_login_user.field_password)
{
    sendBigMessageStr("user_try_create",string(bn_login_user.field_username.input_string),string(bn_login_user.field_password.input_string),"lez get it on")
}

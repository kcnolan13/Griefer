exit;
if !instance_exists(processing) and instance_place(x,y,cursor)
{
    audio(snd_click,1)
    printf("MAKING AUTHENTICATION ATTEMPT: "+bn_login_user.field_username.input_string+" : "+bn_login_user.field_password.input_string)
    if !instance_exists(processing)
    {
        authenticate(bn_login_user.field_username.input_string,bn_login_user.field_password.input_string)
        objVarWrite(net_manager,"pName",bn_login_user.field_username.input_string)
        instance_create(x,y,processing)
    }
}


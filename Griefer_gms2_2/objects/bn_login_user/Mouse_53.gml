if clicked or popup_exists() exit

if instance_place(x,y,cursor) or forced_enter
{
    forced_enter = false
    clicked = 2
    printf("MAKING AUTHENTICATION ATTEMPT: "+field_username.input_string+" : "+field_password.input_string)
    if !instance_exists(processing)
    {
        authenticate(field_username.input_string,field_password.input_string)
        objVarWrite(net_manager,"pName",field_username.input_string)
        instance_create(x,y,processing)
    }
}


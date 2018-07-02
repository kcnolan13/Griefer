if not visible exit

if instance_place(x,y,cursor)
{

    if clicked exit
    clicked = 2
    audio(snd_click,1)
    printf("clicked: "+label)
    
    bn_login_user.field_username.input_string = generate_name(0.05)
    
    bn_login_user.time_since_active = 0
}


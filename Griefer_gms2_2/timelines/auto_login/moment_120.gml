if room = rm_login and instance_exists(bn_login_user)
{
    bn_login_user.field_username.input_string = "Beavis"
    cursor.x = bn_login_user.x
    cursor.y = bn_login_user.y
    with bn_login_user event_perform(ev_mouse,ev_global_left_press)
}


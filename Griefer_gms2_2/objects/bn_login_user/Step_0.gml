/// @description ysweep

if global.using_gamepad 
{
    if gamepad_button_check_pressed(global.devno,global.cvals[C_JUMP]) 
    or gamepad_button_check_pressed(global.devno,global.cvals[C_SHOOT])
    {
        event_perform(ev_mouse,ev_global_left_press)
    }
    
    if gamepad_button_check(global.devno,global.cvals[C_JUMP]) 
    or gamepad_button_check(global.devno,global.cvals[C_SHOOT])
    {
        event_perform(ev_mouse,ev_global_left_button)
    }
}

if clicked
    clicked --
    
if alert_alpha > 0
{
    alert_alpha -= alert_fade
    if alert_alpha < alert_fade
        alet_alpha =0
}
if not field_username.input_active and not field_password.input_active
{
    field_username.input_string = capwords(field_username.input_string)
    
    time_since_active ++
    if time_since_active > 30*2 and not popup_exists()
    {
        field_username.input_string = generate_name(0)
        time_since_active = 0
    }
}
else time_since_active = 0

/*
if (y-ystart < 2 and ydir = -1) or (ystart+ysweep-y < 2 and ydir = 1)
{
    ydir *= -1
}

lerp_real_amount = 0.035

if ydir = 1
{
    
    with bn_login_user 
        y = lerp_real(y,ystart+other.id.ysweep,other.id.lerp_real_amount)
    with bn_create_new 
        y = lerp_real(y,ystart+other.id.ysweep,other.id.lerp_real_amount)
    with field_username 
        y = lerp_real(y,ystart+other.id.ysweep,other.id.lerp_real_amount)
    with field_password
        y = lerp_real(y,ystart+other.id.ysweep,other.id.lerp_real_amount)
}
else
{   
    with bn_login_user
        y = lerp_real(y,ystart,other.id.lerp_real_amount)
    with bn_create_new
        y = lerp_real(y,ystart,other.id.lerp_real_amount)
    with field_username
        y = lerp_real(y,ystart,other.id.lerp_real_amount)
    with field_password
        y = lerp_real(y,ystart,other.id.lerp_real_amount)
}*/

y = bn_create_new.y

event_inherited()

/* */
/*  */

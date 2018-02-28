/// @description set lerp_real targets for all messages
event_inherited()

if nth_frame(30)
{
    alpha_scaler_max = 1//average2(global.gc[GC_CHAT_FEED_ALPHA,1],1)
    alpha_max = alpha_max_original//*global.gc[GC_CHAT_FEED_ALPHA,1]
    match_scale = average2(global.gc[GC_CHAT_FEED_ALPHA,1],1)
}

if in_match()
{

    if keyboard_check_pressed(192) and room != rm_login
    {
        force_show ^= 1
        
        if not force_show
            alpha_scaler = 0
            
        entry.input_active = force_show
        keyboard_string = ""
        entry.input_string = ""
    }

    var tval =  truthval(global.gc[GC_CHAT_FEED,1])
    if tval = 2
    {
        if not alpha_dec_delay
        {
            if alpha_scaler > 0
                alpha_scaler -= alpha_dec
            else alpha_scaler = 0
        }
        else
        {
            alpha_dec_delay --
        }
    }
    else if tval = 1
    {
        alpha_scaler = alpha_scaler_max
    }
    else if tval = 0 and not force_show
    {
        alpha_scaler = 0
    }
    else
    {
        printf("ERROR: chat_feed has unexpected GC_CHAT_FEED value: "+string(tval))
    }
    
    if force_show
        alpha_scaler = alpha_scaler_max
}
else
{
    master_scale = 0.8
    if room = rm_lobby and menmode() = "lobby"
    {
        force_show = true
        alpha_scaler = alpha_scaler_max
        if keyboard_check_pressed(192)
        {
                entry.input_active ^= 1
                entry.input_string = ""
                keyboard_string = ""
        }
    }
    else 
    {
        force_show = false
        alpha_scaler = 0
    }
}

if instance_exists(modal_controls) or rtime() < 30
    alpha_scaler = 0

/* */
///snap
if alpha < 0.1 return false

if not in_match()
{
    x = width/2-30
    y = height/2*master_scale+92
}
else
{
    master_scale = 1*match_scale//view_hview/768*match_scale
    x = width/2*master_scale
    y = HVIEW-height/2*master_scale-entry_height*master_scale
}
entry.x = x-width/2*master_scale
entry.y = y+height/2*master_scale
send.x = entry.x+sprite_get_width(entry.sprite_index)*entry.image_xscale*master_scale+send.width/2*master_scale
send.y = y+height/2*master_scale+send.height/2*master_scale
entry.master_scale = master_scale
send.master_scale = master_scale

/* */
///alphas
entry.alpha = alpha_scaler
send.alpha = alpha_scaler

/* */
/*  */

/// @description set lerp_real targets for all messages
event_inherited()

if nth_frame(30)
{
    alpha_scaler_max = 1//average2(global.gc[GC_KILL_FEED_ALPHA,1],1)
    alpha_max = alpha_max_original//*global.gc[GC_KILL_FEED_ALPHA,1]
    match_scale = average2(global.gc[GC_KILL_FEED_ALPHA,1],1)
}  

var tval =  truthval(global.gc[GC_KILL_FEED,1])
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
else if tval = 0
{
    alpha_scaler = 0
}
else
{
    printf("ERROR: kill_feed has unexpected GC_KILL_FEED value: "+string(tval))
}

//don't show up when chat feed is blocking the way
if in_match() and chat_feed.alpha_scaler > 0.1
{
    alpha_scaler = 0
}


if not in_match()
{
    master_scale = 1
    alpha_scaler = 0
        
    /*var spr = floor(random_range(spr_weapon_placeholder1,spr_weapon_placeholder2+0.99))
  
    while (spr = spr_no_hitforce or spr = spr_minor_hitforce or spr = spr_major_hitforce or spr = spr_redonk_hitforce)
    {
        spr = floor(random_range(spr_weapon_placeholder1,spr_weapon_placeholder2+0.99))
    }

    if nth_frame(30*3)
        new_kill_feed_message("kyle","kyle",spr)
        
    if nth_frame(30*5)
        new_kill_feed_message("kyle",0,"10 Kill Streak")
    */
}
else
    master_scale = 1*match_scale//view_hview/768*match_scale
    
x = width/2*master_scale
y = HVIEW-height/2*master_scale

/* */
/*  */

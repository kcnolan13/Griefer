///new_kill_feed_message(name1,name2_or_sprite,weapon_or_text)
var name1 = argument0
var weptxt = argument2
var namespr = argument1 //currently only names supported, no fancy icons 

//create the new feed message
with (kill_feed)
{
    if truthval(global.gc[GC_KILL_FEED,1]) != 0
    {
        alpha_scaler = alpha_scaler_max
        alpha_dec_delay = alpha_dec_delay_max
    }
    ID = instance_create(x,y+msg_starty,feed_message)
    ID.snap_obj = kill_feed
    ID.alpha = 0 //slower fade in than the rest
    ID.width = msg_text_width
    ID.height = msg_height
    ID.avhead_scale = msg_avhead_scale
    ID.font = fnt_hud
    ID.depth = depth-1
    ID.lerp_ytarget = msg_starty
    ID.lerp_ycurrent = ID.lerp_ytarget
    ID.text_color = c_white
    ID.draw_rect = false
    
    if is_string(weptxt)
    {
        //this is a text message. treat as such
        ID.show_text = true
        ID.text = weptxt
        ID.label = weptxt
    } else
    {
        if sprite_exists(weptxt)
        {
            ID.weapon = weptxt
        }
        else
        {
            printf("ERROR: unexpected val passed as weptxt to new_kill_feed_message: "+string(weptxt))
        }
    }
    
    if is_string(name1)
    {
        var av = find_pname_avatar(name1)
        if av != noone
        {
            ID.avhead1 = objVarRead(av,"helmet0")
            ID.avhat1 = objVarRead(av,"hat0")
            ID.avname1 = name1
        }
        else
            printf("ERROR: unable to find avatar with name: "+string(name1))
    }
    
    if is_string(namespr)
    {
        var av = find_pname_avatar(namespr)
        if av != noone
        {
            ID.avhead2 = objVarRead(av,"helmet0")
            ID.avhat2 = objVarRead(av,"hat0")
            ID.avname2 = namespr
        }
    }
    
    //shift all the other messages down
    for (var i=getLength(msgs)-1; i>=0; i--)
    {
        msgs[i].lerp_ytarget += msg_height+msg_ysep
        
        if i+1 >= msgs_max
        {
            msgs[i].fade_out = true
            msgs[i].alpha = min(1,msgs[i].alpha)
            msgs[i] = NO_HANDLE
        }
        else
        {
            msgs[i+1] = msgs[i]
        }
        
    }
    msgs[0] = ID
}

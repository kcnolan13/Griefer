/// @description sensitivity

if is_sens and modal_highlighted(id) or was_highlighted
{
    was_highlighted = 2
    //var xf = (x + 2*width*scale/2)
    if exclude_zero
        sens_percent = ceil(sens_divs*(cursor.x-xs)/(xf-xs))
    else
        sens_percent = floor((sens_divs+1)*(cursor.x-xs)/(xf-xs))
    
        var minmark = 1
        if not exclude_zero
            minmark = 0
        if sens_percent < minmark
            sens_percent = minmark
            
        if sens_percent > sens_divs
            sens_percent = sens_divs
    sens_percent = sens_percent/sens_divs
    
    sens_val = (sens_high - sens_low)*sens_percent+sens_low
    sens_update = 5
    
    if sens_val > sens_high
        sens_val = sens_high
    if sens_val < sens_low
        sens_val = sens_low
        
    if myLabel.text = global.gc[GC_AA_LEVEL,0]
    {
        var ind = gc_ind(myLabel.text)
        if ind > -1
        {
            if sens_val = 0
            {
                draw_enable_swf_aa(false)
            }
            else
            {
                draw_enable_swf_aa(true)
                draw_set_swf_aa_level(sens_val)
            }
            global.gc[ind,1] = sens_val
        }
        else
        {
            printf("ERROR: could not update sensitivity setting "+string(myLabel.text)+" -- bad ind")
        }
    }
    else if myLabel.text = global.gc[GC_KILL_FEED_ALPHA,0] or myLabel.text = global.gc[GC_CHAT_FEED_ALPHA,0]
    {
        var ind = gc_ind(myLabel.text)
        if ind > -1
        {
            global.gc[ind,1] = sens_val
        }
        else
        {
            printf("ERROR: could not update sensitivity setting "+string(myLabel.text)+" -- bad ind")
        }
    }
}


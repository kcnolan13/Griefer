///clear_postmatch_visuals
if object_index != xp_bar return false

if instance_exists(av_head)
    with av_head fade_delay = 1
    {
        fade_delay = 1
        fade_time = 5
    }   
    
if instance_exists(av_txt)
    with av_txt
    {
        fade_delay = 1
        fade_time = 5
    }
    
if instance_exists(av_namerank)
    with av_namerank 
    {
        fade_delay = 1
        fade_time = 5
    }
    
with (action_word)
{
    if init_as_promoted and fade_time > 5
    {
        fade_time = 5
        fade_delay = 1
    }
}
    
av_head = NO_HANDLE
av_txt = NO_HANDLE
av_namerank = NO_HANDLE

alarm[1] = 0
with bn_postmatch_done 
{ 
    if not cant_fade
        fade_out = true
}

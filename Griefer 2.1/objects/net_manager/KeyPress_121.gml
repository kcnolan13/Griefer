/// @description toggle full screen
do_toggle = true

with modal_dialogue
{
    if is_tutorial  
        other.do_toggle = false
}

if do_toggle
{
    global.gc[GC_FULLSCREEN,1] = toggle_truthval(global.gc[GC_FULLSCREEN,1])
    window_set_fullscreen(truthval(global.gc[GC_FULLSCREEN,1]))
    save_setting(GC_FULLSCREEN)
}
else
{
    audio(snd_denied,1)
}   


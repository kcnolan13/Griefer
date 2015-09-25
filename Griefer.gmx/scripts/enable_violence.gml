global.gc[GC_VIOLENT_CONTENT,1] = "On"
save_setting(GC_VIOLENT_CONTENT)

if net_manager.violence_2end
{
    modal_force_click(bn_play_tab)
    scheduler(tut_end,global.tut_wait)
    net_manager.violence_2end = false
}

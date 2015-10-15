global.gc[GC_CONTROL_HINTS,1] = "Off"
save_setting(GC_CONTROL_HINTS)

if net_manager.violence_2end
{
    modal_force_click(bn_play_tab)
    scheduler(tut_end,global.tut_wait)
    net_manager.violence_2end = false
}

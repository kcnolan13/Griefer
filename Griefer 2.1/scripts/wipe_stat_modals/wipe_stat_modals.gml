/// @description wipe_stat_modals()
/// @function wipe_stat_modals
with stat_manager
{
    wiped = true
    
    fade_modal(modal_table)
    fade_modal(bn_slabel)
    fade_modal(modal_stat_history)
    
    history_chart = NO_HANDLE
    pstat_title = NO_HANDLE
    leaderboards_title = NO_HANDLE
    pstat_pname = NO_HANDLE
    ts = NO_HANDLE
    
    for (var i=0; i<getLength(pstat_labels[i]); i++)
    {
        fade_modal(pstat_labels[i])
        pstat_labels[i] = NO_HANDLE
    }
    
    for (var i=0; i<getLength(pstat_vals[i]); i++)
    {
        fade_modal(pstat_vals[i])
        pstat_vals[i] = NO_HANDLE
    }
    
    for (var i=0; i<getLength(meters); i++)
    {
        fade_modal(meters[i])
        meters[i] = NO_HANDLE
    }
}

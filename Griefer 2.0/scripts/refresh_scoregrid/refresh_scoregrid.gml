//refresh_scoregrid()

with net_manager
    {
        varWrite("force_recompute_scores",true)
        obj_update_real(id,"force_recompute_scores",FL_NORMAL)
    }

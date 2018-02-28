/// @description sync histories with data from stat manager

histories[0] = objVarRead(stat_manager,"kdr_history")
histories[1] = objVarRead(stat_manager,"ppl_history")
histories[2] = objVarRead(stat_manager,"win_history")

if not history_synced
{
    history_synced = true
    history_string = histories[0]
}

switch (record_count)
{
    case 50:
        point_rad = 5
    break
    
    case 100:
        point_rad = 5
    break
    
    default:
        point_rad = 7
    break
}

//inherited modal behavior
event_inherited()



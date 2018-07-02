/// @description recompute_scores()
/// @function recompute_scores
sort_worthy = false
force_recompute_scores = false
//pull in the match kills for each avatar (which you need to sync from his player)
for (var i=0; i<instance_number(player); i++)
{
    var pID = instance_find(player,i)
    if objVarRead(pID,"player_quit")
    {
        printf("WARNING: cannot recompute scores for "+playerName(pID)+" because player has quit")
        continue
    }
    //printf("found player (object "+pID.object_index+"): "+objVarRead(pID,"pName"))
    //printf(objVarRead(pID,"pName")+"'s match_kills = "+objVarRead(pID,"match_kills"))
    var avID = find_pname_avatar(objVarRead(pID,"pName"))
    
    if not instance_exists(avID)
    {
        printf("ERROR: sort scores couldn't find an avatar matching this pName")
        return false
    }
    else
    {
        //printf("found avatar: "+objVarRead(avID, "pName"))
    }
    
    mkills = objVarRead(pID,"match_kills")
    mpoints = objVarRead(pID,"match_points")
    mdeaths = objVarRead(pID,"match_deaths")
    masses = objVarRead(pID,"match_assists")
    avRank = objVarRead(pID,"rank")
    
    //printf("read player's stats")
    objVarWrite(avID,"match_points",mpoints)
    objVarWrite(avID,"match_kills",mkills)
    objVarWrite(avID,"match_deaths",mdeaths)
    objVarWrite(avID,"match_assists",masses)
    objVarWrite(avID,"rank",avRank)
    
    //printf("set "+objVarRead(avID,"pName")+"'s match_deaths to: "+objVarRead(avID,"match_deaths")+" --> supposed to be "+mdeaths)
    //printf("set "+objVarRead(avID,"pName")+"'s match_kills to: "+objVarRead(avID,"match_kills")+" --> supposed to be "+mkills)
    
    if varRead("game_mode") = "tdm"
    {
        if get_team(pID) = 0
            dat_team_do = team0
        else dat_team_do = team1
    }
    else dat_team_do = team_all
    
    //we now know what grid this player belongs on --> find his avatar ID and update match kills + match points
    if ds_grid_value_disk_exists(dat_team_do,1,0,2*ds_grid_height(dat_team_do),avID)
    {
        //SET POINTS IN SCORE TABLE GRID
        av_gridy = ds_grid_value_disk_y(dat_team_do,1,0, 2*ds_grid_height(dat_team_do), avID)
        if not ds_grid_value_x(dat_team_do,2,av_gridy,2,av_gridy,mpoints)
        {
            ds_grid_set(dat_team_do,2,av_gridy,mpoints)
        }
        
        //SET KILLS IN SCORE TABLE GRID
        av_gridy = ds_grid_value_disk_y(dat_team_do,1,0, 2*ds_grid_height(dat_team_do), avID)
        if not ds_grid_value_x(dat_team_do,0,av_gridy,0,av_gridy,mkills)
        {
            ds_grid_set(dat_team_do,0,av_gridy,mkills)
        }
    }
    else 
    {
        printf("ERROR: TEAM GRID: unable to find avatar id "+string(avID)+" for player "+string(objVarRead(avID,"pName"))+" in the team grid")
        return false
    }
}

if not match_ending()
{
    //sort all non-empty player grids
    if ds_grid_height(team0) > 0
    {
        ds_grid_sort(team0, 2, false)
        print_ds_grid(team0)
    }
    
    if ds_grid_height(team1) > 0
    {
        ds_grid_sort(team1, 2, false)
        print_ds_grid(team1)
    }
    
    if ds_grid_height(team_all) > 0
    {
        ds_grid_sort(team_all, 0, false)
        print_ds_grid(team_all)
    }
}

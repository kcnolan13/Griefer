///match_end_accolades()

if not instance_exists(net_manager.local_player) exit

var completed = false
{
    //10 kills, 0 deaths
    if objVarRead(myPlayer(),"match_kills") >= 10 and objVarRead(myPlayer(),"match_deaths") = 0
    {
        complete_accolade("10kd")
        completed = true
    }

    //HIGHEST KDR
    var maxkdr = 0
    var maxpname = ""
    var tied = false
    for (var i=0; i<instance_number(player); i++)
    {
        plyr = instance_find(player,i)
        var cand = objVarRead(plyr,"match_kills")/objVarRead(plyr,"match_deaths")
        if cand > maxkdr
        {
            tied = false
            maxkdr = cand
            maxpname = playerName(plyr)
        }
        else if cand = maxkdr
        {
            tied = true
        }
    }
    
    if not tied and playerName(myPlayer()) = maxpname
    {
        //HIGHEST KDR, BABY!
        complete_accolade("highest_kd")
        completed = true
    }

    //MVP
    //find the person with the most points in the match
    grids[0] = 0
    if string_count("tdm",net_manager.game_mode) > 0
    {
        grids[0] = net_manager.team0
        grids[1] = net_manager.team1
    } else grids[0] = net_manager.team_all
    
    var maxpoints = 0
    maxpname = ""
    tied = false
    for (var i=0; i<getLength(grids); i++)
    {
        for (var j=0; j<ds_grid_height(grids[i]); j++)
        {
            var cand = ds_grid_get(grids[i],2,j)
            if cand > maxpoints
            {
                tied = false
                maxpoints = cand
                maxpname = ds_grid_get(grids[i],1,j)
            } else if cand = maxpoints
            {
                tied = true
            }
        }
    }
    
    if not tied and playerName(myPlayer()) = maxpname
    {
        //MVP, BABY!
        complete_accolade("mvp")
        completed = true
    }

}

return completed

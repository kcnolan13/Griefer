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
        var cand = objVarRead(plyr,"match_kills")/max(1,objVarRead(plyr,"match_deaths"))
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
    var maxpoints = 0
    var maxpname = ""
    var tied = false
    for (var i=0; i<instance_number(player); i++)
    {
        plyr = instance_find(player,i)
        var cand = objVarRead(plyr,"match_points")
        if cand > maxpoints
        {
            tied = false
            maxpoints = cand
            maxpname = playerName(plyr)
        }
        else if cand = maxpoints
        {
            tied = true
        }
    }
    
    if not tied and playerName(myPlayer()) = maxpname
    {
        //HIGHEST KDR, BABY!
        complete_accolade("mvp")
        completed = true
    }

}

return completed
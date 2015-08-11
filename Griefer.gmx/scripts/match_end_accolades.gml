///match_end_accolades()

if not instance_exists(myAvatar()) exit

var completed = false
{
    //10 kills, 0 deaths
    if objVarRead(myAvatar(),"match_kills") >= 10 and objVarRead(myAvatar(),"match_deaths") = 0
    {
        complete_accolade("10kd")
        completed = true
    }

    //HIGHEST KDR
    var maxkdr = 0
    var maxpname = ""
    var tied = false
    for (var i=0; i<instance_number(avatar); i++)
    {
        plyr = instance_find(avatar,i)
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
    
    if not tied and playerName(myAvatar()) = maxpname
    {
        //HIGHEST KDR, BABY!
        complete_accolade("highest_kd")
        completed = true
    }

    //MVP
    var maxpoints = 0
    var maxpname = ""
    var tied = false
    for (var i=0; i<instance_number(avatar); i++)
    {
        plyr = instance_find(avatar,i)
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
    
    if not tied and playerName(myAvatar()) = maxpname
    {
        //MVP, BABY!
        printf("::: trying to get MVP")
        complete_accolade("mvp")
        completed = true
    } else if tied
    {
        printf("::: mvp accolade was tied between" + string(maxpname)+" and someone else...")
    }
}

return completed

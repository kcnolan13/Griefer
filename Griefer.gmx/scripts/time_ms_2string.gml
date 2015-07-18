///time_ms_2string(time_ms, do_round)
var time = argument0
var do_round = argument1

var days = time/1000/60/60/24
if days > 0
{
    //time -= days*1000*60*60*24
    if days > 1
    {
        if do_round days = round(days)
        return string(days)+pluralize(" Day",days)
    }
}
    
var hrs = time/1000/60/60
if hrs > 0
{
    //time -= hrs*1000*60*60
    if hrs > 1
    {
        if do_round hrs = round(hrs)
        return string(hrs)+pluralize(" Hr",hrs)
    }
}
    
var mins = time/1000/60
if mins > 0
{
    //time -= mins*1000*60
    if mins > 1
    {
        if do_round mins = round(mins)
        return string(mins)+pluralize(" Min",mins)
    }
}

var secs = time/1000
{
    if do_round secs = round(secs)
     return string(secs)+pluralize(" Sec",secs)
}

var ret = string(days)+"d "+string(hrs)+"hr "+string(mins)+"min "+string(secs)+"sec"

return ret

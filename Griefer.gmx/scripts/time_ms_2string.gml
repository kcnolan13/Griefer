///time_ms_2string(time_ms)
var time = argument0

var days = truncate(time/1000/60/60/24,1)
if days > 0
{
    time -= days*1000*60*60*24
    return string(days)+" Days"
}
    
var hrs = truncate(time/1000/60/60,1)
if hrs > 0
{
    time -= hrs*1000*60*60
    return string(hrs)+" Hours"
}
    
var mins = truncate(time/1000/60,1)
if mins > 0
{
    time -= mins*1000*60
    return string(mins) +" Mins"
}

var secs = truncate(time/1000,0)
{
     return string(secs) + " Secs"
}

var ret = string(days)+"d "+string(hrs)+"hr "+string(mins)+"min "+string(secs)+"sec"

return ret

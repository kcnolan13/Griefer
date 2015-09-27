///time_30steps_2countdown(time_30steps)
var time = argument0
    
var mins = time/30/60
for (var i=1; i<mins; i++)
{
    time -= 30*60
}
mins = floor(mins)

var secs = time/30
for (var i=1; i<secs; i++)
{
    time -= secs
}
secs = floor(secs)

var ret = num2string_digits(mins,2)+" : "+num2string_digits(secs,2)

return ret

///compute_boom_delay()
var delay = 0

for (var i=0; i<instance_number(action_word); i++)
{
    aw = instance_find(action_word,i)
    if string_count("Kill",aw.txt) > 0 or string_count("Assist",aw.txt) > 0
    {
        delay = 2
    }
}

return delay
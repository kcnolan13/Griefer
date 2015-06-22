///num_new_challenges()

var num_new = 0
for (var i=0; i<instance_number(challenge_generic); i++)
{
    ID = instance_find(challenge_generic,i)
    if ID.completed and ID.new
    {
        num_new ++
    }
}

return num_new
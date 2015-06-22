///find_challenge_description(bpart_obj)
var bpart = real(argument0)

var desc = ""

if bpart.source = global.src_challenge
    desc = "Challenge Gear!"

for (var i=0; i<instance_number(challenge_generic); i++)
{
    ID = instance_find(challenge_generic,i)
    if ID.icon_complete = bpart.icon or ID.name = bpart.name
    {
        desc = ID.description
        break
    }
}

return string(desc)
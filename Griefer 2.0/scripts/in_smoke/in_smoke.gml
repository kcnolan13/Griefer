/// @description in_smoke(object)
/// @function in_smoke
/// @param object
var obj = argument0

var obscurred = false

for (var i=0; i<instance_number(splosion_smoke); i++)
{
    ID = instance_find(splosion_smoke,i)
    if ID.counter > 30*1 and abs(obj.x - ID.x) < 64*2.5 and obj.y < ID.y+64*1.5
    {
        obscurred = true
        break   
    }
}

return obscurred
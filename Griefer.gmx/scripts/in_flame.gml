///in_ink(object)
ink_obj = argument0

ink_obscurred = false

for (var i=0; i<instance_number(splosion_flame); i++)
{
    ID = instance_find(splosion_flame,i)
    with ID
    {
        if in_my_flame(other.id.ink_obj)
            other.id.ink_obscurred = true
    }
    if ink_obscurred break
}

return ink_obscurred
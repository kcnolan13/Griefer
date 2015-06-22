///in_ink(object)
ink_obj = argument0

ink_obscurred = false

for (var i=0; i<instance_number(splosion_snare); i++)
{
    ID = instance_find(splosion_snare,i)
    with ID
    {
        if in_my_snare(other.id.ink_obj)
            other.id.ink_obscurred = id
    }
    if ink_obscurred break
}

return ink_obscurred
///in_ink(object)
ink_obj = argument0

ink_obscurred = false

for (var i=0; i<instance_number(splosion_ink); i++)
{
    ID = instance_find(splosion_ink,i)
    with ID
    {
        if in_my_ink(other.id.ink_obj)
            other.id.ink_obscurred = true
    }
    if ink_obscurred break
}

return ink_obscurred
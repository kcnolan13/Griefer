/// @description is_avatar_leader(av)
/// @function is_avatar_leader
/// @param av
var av = argument0

if not instance_exists(av)
{
    printf("ERROR: is_avatar_leader passed nonexistent object: "+string(av))
    return false
}

av_who_might_be_leader = av
av_is_leader = true
with avatar
{
    if varRead("pNum") > objVarRead(other.av_who_might_be_leader,"pNum") and id != other.av_who_might_be_leader
        other.av_is_leader = false
}

if av_is_leader
    return true

    
return false

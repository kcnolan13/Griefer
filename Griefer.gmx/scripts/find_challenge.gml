///find_challenge(challenge_name)
var name = string(argument0)

var candidate = ds_map_find_value(global.ds_challenges,name)
if instance_exists(candidate) and candidate.object_index = challenge_generic
{
    //make not case sensitive
    if string_lower(candidate.name) = string_lower(name)
    {
        return candidate
    }
    else
    {
        printf("ERROR: ds_map_find_value for challenge name "+string(name)+" returned a challenge with name "+string(candidate.name))
        return NO_HANDLE
    }

}
else
{
    printf("ERROR: unable to find challenge with name: "+name+". ds_map_find_value returned "+string(candidate))
    return NO_HANDLE
}
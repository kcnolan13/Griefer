/// @description challenge_is_complete(challenge_name)
/// @function challenge_is_complete
/// @param challenge_name
var name = argument0
var cha = find_challenge(name)
if instance_exists(cha)
{
    if not cha.completed
    {
        return false
    }
    else 
    {
       // printf(name+" completed? --> "+cha.completed)
        return true
    }
}
else
{
   // printf("ERROR: unable to find challenge object: "+name)
    return true
}
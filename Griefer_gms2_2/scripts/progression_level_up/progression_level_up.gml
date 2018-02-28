/// @description progression_level_up(rank)
/// @function progression_level_up
/// @param rank
var rank = argument0

var cha = find_challenge(get_rank_name(rank))
if instance_exists(cha)
{
    if not challenge_is_complete(cha.name)
    {
        printf("::: acquiring rank unlock gear for rank "+string(rank))
        complete_challenge(cha.name)
    }
} 
else 
    return false

///progression_level_up(rank)
var rank = argument0

var cha = find_challenge(get_rank_name(rank))
if instance_exists(cha)
{
    if not challenge_is_complete(cha.name)
    {
        printf("ERROR: acquiring rank unlock gear for rank "+string(rank))
        complete_challenge(cha.name)
    }
} 
else 
    return false
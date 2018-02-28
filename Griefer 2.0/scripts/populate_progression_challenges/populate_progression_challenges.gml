/// @description populate_progression_challenges()
/// @function populate_progression_challenges
printf("POPULATING PROGRESSION CHALLENGES...")

for (var i=1; i<global.num_ranks; i++)
{
    var spr = get_rank_unlock_sprite(i)
    if spr = spr_none continue
    
    ID = instantiate_challenge(spr, get_rank_name(i), "Reach Level "+string(i))
    ID.rewards[1] = spr+1
    ID.rewards[2] = spr+2
    ID.rewards[3] = spr+3
    ID.rewards[4] = spr+4
    ID.rewards[5] = spr+5
    ID.rewards[6] = spr+6
    ID.is_progression = true
    ID.is_challenge = false
}

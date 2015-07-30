///populate_progression_challenges()
printf("POPULATING PROGRESSION CHALLENGES...")

for (var i=1; i<global.num_ranks; i++)
{
    var spr = get_rank_unlock_sprite(i)
    if spr = spr_none continue
    
    ID = instantiate_challenge(spr, get_rank_name(i), "Reach Level "+string(i))
    ID.is_progression = true
    ID.is_challenge = false
}
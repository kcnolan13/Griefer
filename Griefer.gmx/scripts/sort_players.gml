max_kills = 0
max_kills_previous = 1000000

printf("SORT_PLAYERS IS DEPRECATED")
return false

players_with_max = ds_list_create()
rank = 1

while (rank <= num_players)
{
    max_kills = 0
    
    for (i=1; i<=num_players; i++) //find max kills
    {
        kills = get_netstat_pnum(i-1,"kills")
        
        if kills = max_kills and kills < max_kills_previous
        {
            ds_list_add(players_with_max,i-1)
        }
        
        if kills > max_kills and kills < max_kills_previous
        {
            ds_list_clear(players_with_max)
            ds_list_add(players_with_max,i-1)
            max_kills = kills
        }
    }
    
    max_kills_previous = max_kills
    
    //assign rank to players with max kills
    for(j=0; j<ds_list_size(players_with_max); j++)
    {
        pnum = ds_list_find_value(players_with_max,j)
        write_stat_pnum(pnum,"match_rank",rank)
        rank++
    }
    ds_list_clear(players_with_max)
}

ds_list_destroy(players_with_max)
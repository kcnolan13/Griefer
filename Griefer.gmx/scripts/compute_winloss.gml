///compute_winloss()
if not computed_winloss and string(varRead("winning_pName")) != ""
{
    var winnah = find_player_by_pname(varRead("winning_pName"))
    
    if not instance_exists(winnah) or not instance_exists(my_doll)
    {
        printf("ERROR: BAD HANDLE TO WINNING PLAYER (or your avatar)")
        varWrite("won_previous_match",false)
        return false
    }
        
    computed_winloss = true
    printf("")
    printf("Computed Winloss")
    printf("")
        
    if net_manager.local_player = winnah or is_local_teammate(winnah)
    {
        //YOU WON!
        printf("")
        printf("YOU WON!")
        printf("")
        //go up a rank
        varWrite("match_flag",FL_WIN)
        
        //if not bot_match
        {
            mega_stat_update("wins",varRead("wins")+1)
        }
    }
    else
    {
        //YOU LOST!
        printf("")
        printf("YOU LOST!")
        printf("")
        //go down a rank
        varWrite("match_flag",FL_LOSS)
        
        rank_changed = true
        
        if instance_exists(local_player)
        {
            fewest_kills = objVarRead(local_player,"match_kills")
            if varRead("game_mode") = "ffa" or tied_bot_match
            {
                //only subtract rank if you got the fewest kills in the match
                for (var i=0; i<instance_number(player); i++)
                {
                    ID = instance_find(player,i)
                    var fewer_cand = objVarRead(ID,"match_kills")
                    if fewer_cand > -1 and fewer_cand < fewest_kills
                    {
                        rank_changed = false
                        varWrite("match_flag",FL_NEUTRAL)
                        printf("You don't Lose!! ... but really on a technicality (FFA and not fewest kills)")
                    }
                }
            }
            
            if rank_changed //and not bot_match
            {
                mega_stat_update("losses",varRead("losses")+1)
            }
        
        }
        else
        {
            printf("ERROR: match_winloss failed. no local_player.")
            return false
        }
        
        //ask for a new global rank
        obj_sendval_real(id,"compute_global_rank",true,varRead("rank"))
    }
} else if varRead("winning_pName") = "" and varRead("end_match_coming")
{
    printf("")
    printf("")
    printf("NO WINNING PNAME")
    printf("")
    printf("")
}

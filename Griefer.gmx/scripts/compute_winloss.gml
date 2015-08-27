///compute_winloss()

//make sure the score grid is updated with the latest data
force_recompute_scores = true

if net_manager.default_winner != ""
{
    printf("::: defaulting winning pName to "+string(default_winner))
    varWrite("winning_pName",default_winner)
}

//kill streak rollover
var guy = net_manager.local_player
if instance_exists(guy)
{
    with (guy)
    {
            stat_update_real("rollover_kstreak",challenge_manager.spree_kills+varRead("rollover_kstreak"),stat_manager.stat_flag)
    }
}
else
{
    printf("ERROR: COULD NOT COMPUTE_WINLOSS -- NO LOCAL PLAYER")
    return false
}

if not computed_winloss and string(varRead("winning_pName")) != ""
{
    
    var winnah = NO_HANDLE
    
    if not bot_match
    {
        winnah = find_player_by_pname(varRead("winning_pName"))
    } else
    {
        if instance_exists(winner)
        {
            winnah = find_player_by_pname(objVarRead(winner,"pName"))
            printf("::: identified bot match winner as: "+string(objVarRead(winnah,"pName")))
        }
        else
            winnah = find_player_by_pname(varRead("winning_pName"))
    }
    
    if not instance_exists(winnah) or not instance_exists(my_doll)
    {
        printf("ERROR: BAD HANDLE TO WINNING PLAYER (or your avatar)")
        varWrite("won_previous_match",false)
        return false
    }
        
    computed_winloss = true
    printf("")
    printf(":::Computing Winloss")
    printf("")
        
    if net_manager.local_player = winnah or is_local_teammate(winnah)
    {
        //YOU WON!
        
        //UPDATE WIN_STREAK POTENTIALLY
        
        if instance_exists(guy)
        {
            with guy
            {
                varAdd("wins",1)
                
                spree = 1
                spree += varRead("rollover_wstreak")
                    
                stat_update_real("rollover_wstreak",spree,stat_manager.stat_flag)
                    
                if spree > varRead("win_streak")
                    stat_update_real("win_streak",spree,stat_manager.stat_flag)
            }
        }
        
        printf(":::YOU WON!")
        //go up a rank
        varWrite("match_flag",FL_WIN)
        mega_stat_update("wins",objVarRead(guy,"wins"))
    }
    else
    {
        //UPDATE WIN_STREAK POTENTIALLY
        with guy
        {
            stat_update_real("rollover_wstreak",0,stat_manager.stat_flag)
            varAdd("losses",1)
        }

        //YOU LOST!
        printf(":::YOU LOST!  losses: "+string(objVarRead(guy,"losses")-1)+" --> "+string(objVarRead(guy,"losses")))
        varWrite("match_flag",FL_LOSS)
        mega_stat_update("losses",objVarRead(guy,"losses"))
        rank_changed = true

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
                    printf(":::You don't Lose!! ... but really on a technicality (FFA and not fewest kills)")
                }
            }
        }
        
    }
} else if varRead("winning_pName") = "" and varRead("end_match_coming")
{
    printf("")
    printf("")
    printf(":::NO WINNING PNAME")
    printf("")
    printf("")
}

//MATCH END STAT UPDATES
match_end_stat_updates()

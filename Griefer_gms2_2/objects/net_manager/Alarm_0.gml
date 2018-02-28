/// @description synchronize match and player settings

num_players = instance_number(player)

if varRead("game_mode") = "bot_tdm"
{
    varWrite("game_mode","tdm")
    bot_match = true
}

if varRead("game_mode") = "bot_ffa"
{
    varWrite("game_mode","ffa")
    bot_match = true
}

if varRead("game_mode") = "bot_versus"
{
    varWrite("game_mode","versus")
    bot_match = true
}
    

if varRead("game_mode") = "tdm"
{
    respawn_delay = 30*5
    varWrite("using_teams",true)
    kill_limit = tdm_kill_limit
    if objVarRead(local_player,"pNum") >= ceil(num_players/2)
        team = 1
    else
        team = 0
    
        //assign player image blends
        for (i=0; i<instance_number(player); i++)
        {
            ID = instance_find(player,i)
            datTeam = get_team(ID)
            /*if datTeam = 1
                objVarWrite(ID,"image_blend",c_blue)
            else if datTeam = 0
                objVarWrite(ID,"image_blend",c_red)*/
            
            draw_set_color(c_white)
        }
        
}
else if varRead("game_mode") = "ffa"
    kill_limit = ffa_kill_limit
else if varRead("game_mode") = "versus"
{
    kill_limit = versus_kill_limit
    player_limit = 2
}
    


/* */
/*  */

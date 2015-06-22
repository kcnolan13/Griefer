///get_player_limit(game_mode)
var game_mode = argument0

if string_count("ffa",game_mode)
{
    return net_manager.ffa_player_limit
} else if string_count("tdm",game_mode)
{
    return net_manager.tdm_player_limit
} else if string_count("versus",game_mode)
{
    return net_manager.versus_player_limit
}   
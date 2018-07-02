/// @description game_mode_name_long(game_mode_abbreviated)
/// @function game_mode_name_long
/// @param game_mode_abbreviated
var mode_abbrev = argument0

switch (mode_abbrev)
{
    case "tdm":
        return "Death Match"
    break
    
    case "ffa":
        return "Free-For-All"
    break
    
    case "versus":
        return "Versus"
    break
    
    case "bot_ffa":
        return "Bot-Free-For-All"
    break
    
    case "bot_tdm":
        return "Bot Death Match"
    break
    
    case "bot_versus":
        return "Bot Versus"
    break
}

return -1

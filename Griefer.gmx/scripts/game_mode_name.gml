///game_mode_name(game_mode_abbreviated)
var mode_abbrev = argument0

switch (mode_abbrev)
{
    case "tdm":
        return "TDM"
    break
    
    case "ffa":
        return "Free For All"
    break
    
    case "versus":
        return "Versus"
    break
    
    case "bot_ffa":
        return "Bot FFA"
    break
    
    case "bot_tdm":
        return "Bot TDM"
    break
    
    case "bot_versus":
        return "Bot Versus"
    break
}

return -1
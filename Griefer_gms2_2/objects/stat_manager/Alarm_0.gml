/// @description set stat flag

if in_match() and net_manager.bot_match
    stat_flag = FL_BOT
else
    stat_flag = FL_COMPETITIVE
    
if in_match()
{
    //make sure you're working with the right accolades/stats grid
    request_personal_stats(grav_name,stat_flag)
    request_accolades(grav_name,stat_flag)
}


/// @description set stat flag

if in_match() and net_manager.bot_match
	if net_manager.bot_diff_ind == 0 
    	stat_flag = FL_BOT
    else if net_manager.bot_diff_ind == 1
    	stat_flag = FL_BOT2
    else if net_manager.bot_diff_ind == 2
    	stat_flag = FL_BOT3
    else if net_manager.bot_diff_ind == 3
    	stat_flag = FL_BOT4
else
    stat_flag = FL_COMPETITIVE
    
if in_match()
{
    //make sure you're working with the right accolades/stats grid
    request_personal_stats(grav_name,stat_flag)
    if (stat_flag == FL_COMPETITIVE)
        request_accolades(grav_name,stat_flag)
    else
        request_accolades(grav_name,FL_BOT)
}


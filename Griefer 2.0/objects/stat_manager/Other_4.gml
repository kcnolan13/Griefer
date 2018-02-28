/// @description room start

//set stat_flag
stat_flag = FL_NORMAL
alarm[0] = 3

/* THIS IS DONE ON RECEIVED LOCK ARMORY NOW
if in_match()
{
    time_match_start = current_time
    if instance_exists(net_manager.stat_gravatar)
    {
        objVarWrite(net_manager.stat_gravatar,"pName",playerName(myAvatar()))
        grav_name = playerName(myAvatar())
        request_personal_stats(playerName(myAvatar()),stat_flag)
    } else printf("ERROR: stat_manager room start cannot find net_manager.stat_gravatar")
}
*?

/* */
/*  */

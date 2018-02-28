/// @description stuff

if in_match()//room = rm_menu//in_match()
{
    //sync before match vars
    alarm[0] = 15
}

if room = rm_lobby and net_manager.came_from_match
{
    regen_postmatch()
}


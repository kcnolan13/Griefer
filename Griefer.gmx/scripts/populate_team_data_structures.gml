///populate_team_data_structures()
if varRead("game_mode") = "tdm"
{
    added_t0 = 0
    added_t1 = 0
    //using two teams
    for (var i=0; i<instance_number(avatar); i++)
    {
        ID = instance_find(avatar,i)
        if get_team(ID) = 0
        {
            printf("")
            printf("")
            //printf("added "+objVarRead(ID,"pName")+"to team at y="+added_t0)
            ds_grid_set(team0,0,added_t0,0) //match_kills
            ds_grid_set(team0,1,added_t0,ID) //avatar ids
            ds_grid_set(team0,2,added_t0,0) //match_points
            added_t0++
        }
        else if get_team(ID) = 1
        {
            printf("")
            printf("")
            //printf("added "+objVarRead(ID,"pName")+"to team 1 at y="+added_t1)
            ds_grid_set(team1,0,added_t1,0)
            ds_grid_set(team1,1,added_t1,ID)
            ds_grid_set(team1,2,added_t1,0)
            added_t1++
        }
    }
}
else
{
    added = 0
    //using one team
    for (var i=0; i<instance_number(avatar); i++)
    {
        ID = instance_find(avatar,i)
        ds_grid_set(team_all,0,added,0)
        ds_grid_set(team_all,1,added,ID)
        ds_grid_set(team_all,2,added,0)
        added++
    }
}

printf("contents of team0: ")
print_ds_grid(team0)
printf("contents of team1: ")
print_ds_grid(team1)
printf("contents of team_all: ")
print_ds_grid(team_all)


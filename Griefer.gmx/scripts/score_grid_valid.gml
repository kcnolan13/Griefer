///score_grid_valid(ds_grid)
var grid = argument0

//makes sure the avatars linked to in the grid have been populated with good data

for (var i=0; i<ds_grid_height(grid); i++)
{
    av = ds_grid_get(grid,1,i)
    
    if not instance_exists(av)
    {
        //printf("ERROR: ds grid entry #"+i+" has nonexistent avatar_obj")
        //disable the score display
        net_manager.disable_scores = true
        return false
    }
    
    if objVarRead(av,"match_kills") = BAD_READ 
    or objVarRead(av,"match_deaths") = BAD_READ
    or objVarRead(av,"match_assists")= BAD_READ
    or objVarRead(av,"match_points")= BAD_READ
    or ds_grid_get(grid,0,i) = BAD_READ
    or ds_grid_get(grid,2,i) = BAD_READ
    {
        //printf("ds_grid entry for player: "+objVarRead(av,"pName")+": has BAD_READS")
        return false
    }
}

return true

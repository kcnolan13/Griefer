///score_grid_valid(ds_grid)
var grid = argument0

//makes sure the avatars linked to in the grid exist and have good variables
for (var i=0; i<ds_grid_height(grid); i++)
{
    av = ds_grid_get(grid,1,i)
    
    if not instance_exists(av)
    {
        printf(":::WARNING: ds_grid entry #"+string(i)+" has nonexistent avatar_obj ... attempting to remove this ds_grid row")
        ds_grid_clear(grid,0)

        num_non_ragers = 0
        
        with (avatar)
        {
            if not varRead("player_quit")
                other.num_non_ragers++
        }
        
        var h = num_non_ragers
        
        if grid = team1
        {
            pnum_team1 = 0
            with player
            {
                if get_team(id) = 1 and not varRead("player_quit") and instance_exists(find_pname_avatar(playerName(id)))
                    other.pnum_team1++
            }
            h = pnum_team1
        }
        else if grid = team0
        {
            pnum_team0 = 0
            with player
            {
                if get_team(id) = 0 and not varRead("player_quit") and instance_exists(find_pname_avatar(playerName(id)))
                    other.pnum_team0++
            }
            h = pnum_team0
        }
            
        printf(":::resizing grid to height: "+string(h))
            
        if (h > 0)
        {
            ds_grid_resize(grid,3,h)
            printf(":::grid resized to: "+string(ds_grid_height(grid)))
            populate_team_data_structures()
            printf(":::grid height after population: "+string(ds_grid_height(grid)))
            force_recompute_scores = true    
            
        }
        else
        {
            printf("ERROR: score_grid_valid tried to resize grid to height "+string(h))
        }
        
        return false
    }
    else
    {
        if objVarRead(av,"match_kills") = BAD_READ 
        or objVarRead(av,"match_deaths") = BAD_READ
        or objVarRead(av,"match_assists")= BAD_READ
        or objVarRead(av,"match_points")= BAD_READ
        or ds_grid_get(grid,0,i) = BAD_READ
        or ds_grid_get(grid,2,i) = BAD_READ
        {
            printf("ERROR: ds_grid entry for player: "+objVarRead(av,"pName")+" ("+string(av.id)+"): has BAD_READS")
            return false
        }
    }
}

return true

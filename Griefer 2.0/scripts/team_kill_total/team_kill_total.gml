/// @description team_kill_total(player_grid)
/// @function team_kill_total
/// @param player_grid
var grid = argument0

var kills = 0

for (var i=0; i < ds_grid_height(grid); i++)
{
    kills += ds_grid_get(grid, 0, i)
}

return kills

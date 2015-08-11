///draw_sub_table(x, y, player_grid)
var xdraw = argument0
ydraw = argument1
var pgrid = argument2

//draw the row with the lables across the top
draw_table_row(xdraw, ydraw, global.table_label_color, global.table_font_color, 1, "", 0, "Points", "Kills", "Deaths", "KDR", "Assists")
ydraw += global.row_height+global.row_vsep

for (var i=0; i<ds_grid_height(pgrid); i++)
{
    var av = ds_grid_get(pgrid,1,i)
    
    if not instance_exists(av) or av.object_index != avatar
    {
        printf("ERROR: nonexistent av in draw_sub_table (or wrong obj_index or something)")
        return false
    }
    
    var playa = find_player_by_pname(objVarRead(av,"pName"))
    if instance_exists(playa) and not objVarRead(net_manager,"end_match_coming")
    {
        var alive = objVarRead(playa,"controllable")
    }
    else var alive = true

    
    var ks = objVarRead(av,"match_kills")//ds_grid_get(pgrid,0,i)
    var ds = objVarRead(av,"match_deaths")
    
    if ds > 0
        var kdr = ks/ds
    else
        var kdr = ks
        
    var pts = objVarRead(av,"match_points")
    var ass = objVarRead(av,"match_assists")
    
    bgcolor = team_color_pname(objVarRead(av,"pName"))
    
    if objVarRead(av,"player_quit")
        bg_color = c_black

    //DRAW THE ACTUAL TABLE ROW
    draw_table_row(xdraw, ydraw, bgcolor, global.table_font_color, alive, objVarRead(av,"pName"), objVarRead(av,"rank"), pts, ks, ds, kdr, ass)
    ydraw += global.row_height+global.row_vsep
}

///draw_score_table(x, y)
var xdraw = argument0
ydraw = argument1       //this is not var'd, so subroutines will change its value as they go --> hopefully this is a good idea....

//printf("drawing score table @ "+xdraw+", "+ydraw)
//draw the match header
draw_set_font(global.table_font)
draw_table_row(xdraw, ydraw, global.table_header_color, global.table_font_color, 1, "CARNAGE REPORT               "+string(game_mode_name(objVarRead(net_manager,"game_mode")))+" on "+string(net_manager.map_previous), -99, "", "", "", "")

//draw how many kills you need and the little symbol
var scl = 0.325
var datOff = -72
draw_kill_limit(xdraw+global.table_width+datOff,ydraw+global.row_height/2,1,fa_left)
draw_set_font(global.table_font)

ydraw += global.row_height + global.table_header_vsep

//draw sub tables as needed
if objVarRead(net_manager,"game_mode") = "tdm"
{
    //figure out which team has more kills and draw it on top
    t0_kills = team_kill_total(net_manager.team0)
    t1_kills = team_kill_total(net_manager.team1)
    total0 = 0
    total1 = 0
    
    if t0_kills > t1_kills
    {
        draw_first = net_manager.team0
        draw_second = net_manager.team1
        total0 = t0_kills
        total1 = t1_kills
    }
    else
    {
        draw_first = net_manager.team1
        draw_second = net_manager.team0
        total0 = t1_kills
        total1 = t0_kills
    }
    
    var ydraw_orig = ydraw
    var xdraw_orig = xdraw
    
    if score_grid_valid(draw_first)
        draw_sub_table(xdraw, ydraw, draw_first) //hopefully this will change ydraw as it goes
            
    draw_set_valign(fa_middle)
    draw_text(xdraw_orig+10,ydraw_orig+global.row_height/2,total0)
     
    
    ydraw += 0.5*global.table_header_vsep
    
    ydraw_orig = ydraw
    xdraw_orig = xdraw
    
    if score_grid_valid(draw_second)
        draw_sub_table(xdraw, ydraw, draw_second)
        
    draw_set_valign(fa_middle)
    draw_text(xdraw_orig+10,ydraw_orig+global.row_height/2,total1)
}
else
{
    //only need to draw one talbe for FFA or Versus
    if score_grid_valid(net_manager.team_all)
        draw_sub_table(xdraw, ydraw, net_manager.team_all)
}
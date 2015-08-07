///draw_table_row(x, y, color, text_color, life_flag, player_name, player_rank, points, kills, deaths, KDR, assists)

//useing 1 for alive, 0 for dead, and -1 for no alive/dead image

var xdraw = argument0
var ydraw = argument1
var col = argument2
var txt_col = argument3
var life_flag = argument4
var pname = argument5
var prank = argument6
var points = argument7
var kills = argument8
var deaths = argument9
var kdr = argument10
var assists = argument11

var txt_alpha = 1//lerp(global.table_alpha,1,0.5)

draw_set_alpha(global.table_alpha)

if is_real(kdr) and not is_string(kdr)
{
    kdr = truncate(kdr,2)
}

draw_set_color(col)
draw_rectangle(xdraw,ydraw,xdraw+global.table_width,ydraw+global.row_height,false)

var txt_y = ydraw+global.row_height/2

draw_set_color(txt_col)
draw_set_alpha(txt_alpha)
draw_set_halign(fa_left)
draw_set_valign(fa_center)
draw_set_font(global.table_font)

//draw the player's name and rank and whatnot
if pname != "" and prank != -99
    draw_namerank(capwords(pname), prank, xdraw+5, ydraw+global.row_height/4-4, global.table_namerank_scale, c_white)

//draw the text fields passed to this row
if prank != -99
{
    txt_fields[0] = string(points)
    txt_fields[1] = string(kills)
    txt_fields[2] = string(deaths)
    txt_fields[3] = string(kdr)
    txt_fields[4] = string(assists)
    var dx = xdraw+global.txt_fields_start
    var x_incr = (global.table_width-global.txt_fields_start)/array_length_1d(txt_fields)
    for (var k=0; k<array_length_1d(txt_fields); k++)
    {
        draw_text(dx, txt_y, txt_fields[k])
        dx += x_incr
    }
}
else
{
    draw_text(xdraw+10, txt_y, pname)
}

if not life_flag
{
    //this needs to be a skull or something
    //draw_sprite(spr_head, -1, xdraw+10,txt_y)
}

draw_set_alpha(1)

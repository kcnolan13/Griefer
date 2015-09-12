///draw_modal_row(x, y, color, text_color, alpha, grid_y, dgrid)

var rxdraw = argument0
var rydraw = argument1
var col = argument2
var txt_col = argument3
var alpha = argument4
var grid_y = argument5
var dgrid = argument6

var spaces = " "

txt_fields_start = global.txt_fields_start

if not ds_exists(dgrid,ds_type_grid)
{
    printf("ERROR: draw_modal_row dgrid does not exist")
    return false
}

if not ds_grid_height(dgrid) > grid_y
{
    printf("ERROR: draw_modal_row indexing outside of dgrid")
    return false
}


var txt_alpha = 1

draw_set_alpha(alpha)

draw_set_color(col)
draw_rectangle(rxdraw,rydraw,rxdraw+width,rydraw+row_height,false)

var txt_y = rydraw+global.row_height/2+3

draw_set_color(txt_col)
draw_set_alpha(txt_alpha)
draw_set_halign(fa_left)
draw_set_valign(fa_center)
draw_set_font(global.table_font)

if grid_y > rows_used
    return false

//draw the player's name and rank and whatnot
var kst = 2

//draw the columns
var dx = rxdraw+txt_fields_start
var x_incr = (width-txt_fields_start)/(ds_grid_width(dgrid)-2-extra_stats)

helm = ds_grid_get(grid,14,row_draw_num)
if not is_real(helm)
    ds_grid_set(grid,14,row_draw_num,bpart_extract_sprite(helm))
hat = ds_grid_get(grid,15,row_draw_num)
if not is_real(hat)
    ds_grid_set(grid,15,row_draw_num,bpart_extract_sprite(hat))

if dgrid != grid_header
{
    var pname = string(ds_grid_get(dgrid,0,grid_y))
    var prank = real(ds_grid_get(dgrid,1,grid_y))
    
    if rect_highlighted(rxdraw,rydraw,rxdraw+width,rydraw+row_height)
    {
        if row_draw_num != hovrow-row_offset
        {
            hovrow_counter = 0
            show_hovrow = false
        }
        hovrow = row_draw_num+row_offset
    }
    else //moused out of area
    {
        if row_draw_num = hovrow-row_offset
        {
            hovrow_counter = 0
            show_hovrow = false
            hovrow = -1
        }
    }
    if hovrow-row_offset = row_draw_num
    {
        draw_set_color(c_ltgray)
        draw_rectangle(rxdraw,rydraw,rxdraw+width,rydraw+row_height,false)
    }
    draw_set_color(txt_col)
  
    if  pname != "" and prank != -99
    {
        //DRAW LITTLE AVATAR HEAD
        var xoff_causeav = 24
        var helm = ds_grid_get(grid,14,row_draw_num+row_offset)
        var hat = ds_grid_get(grid,15,row_draw_num+row_offset)
        
        if is_string(helm)
            helm = bpart_extract_sprite(helm)
        if is_string(hat)
            hat = bpart_extract_sprite(hat)
            
        varWrite("helmet0",helm)
        varWrite("hat0",hat)
        draw_avatar_head(rxdraw+3+24,rydraw+global.row_height/4-4+24,id,0,0.375,1,FL_NOBAR)
        draw_namerank(capwords(pname), prank, rxdraw+25+xoff_causeav, rydraw+global.row_height/4-1, global.table_namerank_scale, c_white)
    }
}
else
{
    if dgrid = grid_header
    {
        check_sort_col = false
        //column highlighting
        var col_high = sort_col_highlighted()
        if col_high > -1
        {
            draw_set_color(highlight_color)
            if col_high > 1
            {
                draw_rectangle(dx+x_incr*(col_high-2),rydraw,dx+x_incr*(col_high-1),rydraw+row_height,false)
            }
            else
            {
                //it's the player name column
                draw_rectangle(rxdraw,rydraw,dx,rydraw+row_height,false)
            }
            draw_set_color(c_white)
        }
        
        check_sort_col = true
        var col_high = sort_col_highlighted()
        if col_high > -1
        {
            draw_set_color(highlight_color)
            if col_high > 1
            {
                draw_rectangle(dx+x_incr*(col_high-2),rydraw,dx+x_incr*(col_high-1),rydraw+row_height,false)
            }
            else
            {
                //it's the player name column
                draw_rectangle(rxdraw,rydraw,dx,rydraw+row_height,false)
            }
            draw_set_color(c_white)
        }
        
    }
    draw_text(rxdraw+5, txt_y, spaces+"Player")
}

for (var k=kst; k < ds_grid_width(dgrid)-extra_stats; k++)
{
    var cell = ds_grid_get(dgrid,k,grid_y)
    
    if not is_string(cell) and k = 7
    {
        cell = time_ms_2string(cell,true)
    }
    
    //format column names (only str columns?)
    if is_string(cell)
    {
        if k < 7 and k > 2
        {
            cell = string_upper(cell)
        }
        else
        {
            if cell = "true_skill"
                cell = global.tskill
            else
                cell = capwords_super(cell)
        }
    }

    draw_text(dx, txt_y, spaces+string(cell))

    dx += x_incr
}

//draw the row number
if dgrid = grid
{
    draw_set_color(c_black)
    draw_set_halign(fa_right)
    draw_text(rxdraw-10,rydraw+row_height/2,string(grid_y+1+varRead("row_offset")))
}

draw_set_alpha(1)

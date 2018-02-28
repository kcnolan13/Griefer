/// @description draw the stuff

//if ds_exists(grid,ds_type_grid) and nth_frame(30)
  //  print_ds_grid(grid)
  
highlight_color = web_hsv(228,58,80)

if birth_delay > 0 or cols < 0 or rows < 0 or s_index_max < 1 or row_height < 1
{
    if nth_frame(60)
        printf(":::WARNING: can't draw modal_table")
    exit
}

draw_set_alpha(alpha)

modal_aligns()

//DRAW THE GRID

//always draw header
ydraw = top
draw_modal_row(left,ydraw,header_color,header_text_color,alpha,0,grid_header)

//don't draw any rows if there are none to be drawn
if rows_used < 1
{
    if nth_frame(60)
        printf(":::WARNING: can't draw modal_table")
    exit
}

ydraw += row_height*1.5

row_offset = round_nearest(s_index,row_height)/row_height

//all the rows
row_draw_num = 0
for (var i=row_offset; i<ds_grid_height(grid); i++)
{
    var col = color
    
    if string(ds_grid_get(grid,0,i)) = objVarRead(net_manager,"pName")
        col = color_highlighted
        
    draw_modal_row(left,ydraw,col,text_color,alpha,i,grid)
    ydraw += row_height+row_vsep
    row_draw_num++
    
    if ydraw - top > height
        break
}

//SCROLL AROUND
/*
if modal_highlighted(id) and cursor.y > top+row_height+8
{
    if abs(cursor.y-top) < s_thresh and s_index > 0
        s_index -= cursor_sens*2
        
    if abs(ydraw-cursor.y) < s_thresh and s_index < s_index_max
        s_index += cursor_sens*2
}*/

if cursor_depressed
{
    ydif = cursor.y - mouse_lasty
    mouse_lasty = cursor.y
    
    s_index += ydif*(s_index_max/s_height)
}

if mouse_wheel_up()
{
    s_index -= cursor_sens*3
} else if mouse_wheel_down()
{
    s_index += cursor_sens*3
}

//keep scroll area within bounds
s_index = constrict(s_index,0,s_index_max)

//draw scroll bar
s_left = left+width+10
s_width = 32
s_right = s_left+s_width
s_top = top+64
s_bottom = top+height-64+10
s_height = s_bottom - s_top
s_curs_height = lerp(height/max(1,(row_height*s_index_max)),1,0.3)*s_height
s_curs_height = constrict(s_curs_height,0,s_height)
s_curs_percent = s_index/max(1,s_index_max)
s_curs_top = s_top+s_curs_percent*(s_height-s_curs_height)
s_curs_bottom = s_curs_top+s_curs_height

//draw border
draw_set_color(c_dkgray)
draw_rectangle(s_left,s_top,s_right,s_bottom,false)

//draw cursor
if rect_highlighted(s_left,s_curs_top,s_right,s_curs_bottom) or cursor_depressed
    draw_set_color(c_ltgray)
else
    draw_set_color(c_gray)

draw_rectangle(s_left,s_curs_top,s_right,s_curs_bottom,false)

//draw popups
if hovrow > -1 and show_hovrow and not instance_exists(modal_dialogue)
{
    //show popup

    draw_player_popup_ext(cursor.x,cursor.y,ds_grid_get(grid,0,hovrow),
        ds_grid_get(grid,1,hovrow),ds_grid_get(grid,13,hovrow),ds_grid_get(grid,2,hovrow),real(ds_grid_get(grid,14,hovrow)),real(ds_grid_get(grid,15,hovrow)),1,false)
    
    if input_check_pressed(mapped_control(C_JUMP)) or mouse_check_button_pressed(mb_left)
    {
        show_player_stats(ds_grid_get(grid,0,hovrow))
    }
}

//printf("::: s_left="+string(s_left)+", s_curs_top="+string(s_curs_top)+", s_right="+string(s_right)+", s_curs_bottom="+string(s_curs_bottom))

/* */
/*  */

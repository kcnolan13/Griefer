if not modal_highlighted(id) and not rect_highlighted(s_left,s_top,s_right,s_bottom)
{
    exit_child = true
    exit
}

if clicked exit
    clicked = 2

//SORT GRID BY COLUMNS
check_sort_col = false
col_high = sort_col_highlighted()
if col_high > -1 and ds_exists(grid,ds_type_grid)
{
    //ds_grid_sort(grid,col_high,ascending[col_high])
    
    var col_high_name = string(ds_grid_get(grid_header,col_high,0))
    
    switch (col_high_name)
    {
        case "username":
            page_orderby = "stats."+"username"
            sort_col = 0
        break
        
        default:
            page_orderby = "stats."+string_lower(col_high_name)
            sort_col = col_high
        break
    }
    
    //all pages will now order by this column as well
    with (modal_button)
    {
        if is_page
        {
            page_orderby = other.page_orderby
        }
    }
    
    page_flag = FL_FINDME
    //ascending[col_high] ^= 1
    //print_ds_grid(grid)
    s_index = 0
    audio(snd_click,1)
    
    //page the leaderboards!
    scr_bn_page_leaderboards()
}

if not cursor_depressed and rect_highlighted(s_left,s_curs_top,s_right,s_curs_bottom)
{
    audio(snd_click,1)
    cursor_depressed = true
    mouse_lasty = cursor.y
}
else if not cursor_depressed and rect_highlighted(s_left,s_top,s_right,s_bottom)
{
    audio(snd_click,1)
    
    //clicks in the general scroll region
    if cursor.y > s_curs_bottom
        s_index += cursor_sens*8
    
    if cursor.y < s_curs_top
        s_index -= cursor_sens*8
}


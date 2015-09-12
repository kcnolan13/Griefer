///sort_col_highlighted()

var x_incr = (width-txt_fields_start)/(ds_grid_width(grid_header)-2-extra_stats)
var cleft = left+txt_fields_start
var cright = cleft+x_incr
var ctop = top
var cbottom = top+row_height

//player column
if rect_highlighted(left,ctop,cleft,cbottom) or (check_sort_col and sort_col < 2 and sort_col > -1)
{
    return 0
}

for (var i=2; i<cols; i++)
{
    if (rect_highlighted(cleft,ctop,cright,cbottom) and not check_sort_col) or (check_sort_col and i = sort_col)
    {
        return i
    }
    cleft += x_incr
    cright += x_incr
}

return -1

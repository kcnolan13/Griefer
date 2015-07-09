///sort_col_highlighted()

var x_incr = (width-global.txt_fields_start)/(ds_grid_width(grid_header)-2)
var cleft = left+global.txt_fields_start
var cright = cleft+x_incr
var ctop = top
var cbottom = top+row_height

for (var i=2; i<cols; i++)
{
    if rect_highlighted(cleft,ctop,cright,cbottom)
    {
        return i
    }
    cleft += x_incr
    cright += x_incr
}

return -1
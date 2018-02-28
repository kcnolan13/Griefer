/// @description row_highlighted()
/// @function row_highlighted

var yinc = row_height+row_vsep
var cleft = left+global.txt_fields_start
var ctop = ydraw
var cbottom = top+row_height

for (var i=0; i<rows; i++)
{
    //player column
    if rect_highlighted(left,ctop,left+width/*cleft*/,cbottom)
    {
        return i
    }
    ctop += yinc
    cbottom += yinc
}

return -1
/// @description adjust for aligns
if object_index != bn_postmatch_done
{
    x += width/2
    y += height/2
} 
else
{
    if halign = fa_center
        x -= width/2
    if valign = fa_center
        y -= height/2
}


///update_scrollable_accolade_grid()
if not instance_exists(accolade_generic) return false

num_accs = instance_number(accolade_generic)

//recalculate sindex_min and sindex_max
sep = acc_width

//bail when not enough accolades to scroll
if sindex_max < grid_width/2
    return false

//PERFORM SCROLLING
if point_distance(cursor.x,cursor.y,grid_left,grid_ymid) < sradius
{
    //scroll left
    with accolade_generic
    {
        x += real_speed(other.sspeed)
        left += real_speed(other.sspeed)
    }
} else if point_distance(cursor.x,cursor.y,grid_right,grid_ymid) < sradius
{
    //scroll right
    with accolade_generic
    {
        x -= real_speed(other.sspeed)
        left -= real_speed(other.sspeed)
    }
}

//loop accolades around when they exceed the bounds
with accolade_generic
{
    if x > other.grid_xmid+other.sindex_max
        x = other.grid_left-other.sep
    else if x < other.grid_left-other.sep
        x = other.grid_xmid+other.sindex_max
        
    //set alpha down sometimes
    if x < other.grid_left
    {
        var xdif = abs(other.grid_left-x)
        alpha_scroll_scaler = lerp_real(1,0,xdif/other.sep)
    } else if x > other.grid_right
    {
        var xdif = abs(x - other.grid_right)
        alpha_scroll_scaler = lerp_real(1,0,xdif/other.sep)
    } else alpha_scroll_scaler = 1
}

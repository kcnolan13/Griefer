///team_color_pname(pname)
var pname = argument0
var av = find_pname_avatar(pname)
if instance_exists(av)
{
    var col_ind = -1
    
    if net_manager.team > -1
        col_ind = get_team(av)
    else
        col_ind = objVarRead(av,"pNum")
        
    if (col_ind >= 0 and col_ind < getLength(global.team_colors))
    {
        if is_my_avatar(av)
        {
            return global.team_colors[col_ind] //was you_colors before
        } else
        {
            return global.team_colors[col_ind]
        }
    } else
    {
        printf("ERROR: team_color_pname wanted global.team_colors index: "+string(col_ind))
    }
}
else
{
    printf("ERROR: team_color_pname could not find avatar with pname: "+string(pname))  
    return c_white 
}

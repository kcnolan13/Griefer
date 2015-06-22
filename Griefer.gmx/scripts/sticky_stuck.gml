if instance_exists(stuck_player)
{
    ang = point_direction(0,0,stuck_xoff*objVarRead(ID,"animation_xscale")*stuck_xscaler,stuck_yoff)
    mag = 1/2*point_distance(0,0,stuck_xoff*objVarRead(ID,"animation_xscale")*stuck_xscaler,stuck_yoff)
    if mag > 64
        mag = 64
        
    if not varRead("local")
        mag /= 3
        
    x = stuck_player.x+trigx(mag,ang+stuck_ang+ -1*stuck_player.torso_rot)
    y = stuck_player.y+trigy(mag,ang+stuck_ang+ -1*stuck_player.torso_rot)
    varWrite("myX",x)
    varWrite("myY",y)
} else
{
    x = stuck_xoff
    y = stuck_yoff
    varWrite("myX",x)
    varWrite("myY",y)
}
stuck_player = find_player_by_pname(varRead("stuck_pname"))
stuck = true
varWrite("speed",0)
hsp = 0
vsp = 0

if instance_exists(stuck_player)
{
    ang = point_direction(0,0,varRead("stuck_xoff")*objVarRead(stuck_player,"animation_xscale")*varRead("stuck_xscaler"),varRead("stuck_yoff"))
    mag = 1/2*point_distance(0,0,varRead("stuck_xoff")*objVarRead(stuck_player,"animation_xscale")*varRead("stuck_xscaler"),varRead("stuck_yoff"))
    
    if mag > 64
        mag = 64
        
    //if not varRead("local")
    //    mag /= 3
        
    x = stuck_player.x+trigx(mag,ang+stuck_ang+ -1*stuck_player.torso_rot)
    y = stuck_player.y+trigy(mag,ang+stuck_ang+ -1*stuck_player.torso_rot)
    varWrite("myX",x)
    varWrite("myY",y)
} else
{
    printf(":::WARNING: sticky_stuck cannot find stuck_player")
    x = varRead("stuck_xoff")
    y = varRead("stuck_yoff")
    varWrite("myX",x)
    varWrite("myY",y)
}

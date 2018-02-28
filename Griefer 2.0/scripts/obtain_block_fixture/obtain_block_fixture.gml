/// @description obtain_block_fixture(block_sprite)
/// @function obtain_block_fixture
/// @param block_sprite
var spr = argument0

fix = physics_fixture_create()
physics_fixture_set_density(fix,0)

var w = 64

physics_fixture_set_polygon_shape(fix)

//just a block fixture -- simple!
if spr = spr_block or spr = spr_block2 or spr = spr_block2_top
{
    //physics_fixture_set_box_shape(fix,w/2,w/2)
    h[0]=0 v[0]=0 
    h[1]=w v[1]=0 
    h[2]=w v[2]=w
    h[3]=0 v[3]=w
}
else
{
    if spr = spr_wedge_right or spr = spr_wedge_right2
    {
        h[0]=w v[0]=0 
        h[1]=w v[1]=w 
        h[2]=0 v[2]=w
    } else if spr = spr_wedge_right_mirrored or spr = spr_wedge_right2_mirrored
    {
        h[0]=0 v[0]=0 
        h[1]=w v[1]=0 
        h[2]=w v[2]=w
    } else if spr = spr_wedge_left or spr = spr_wedge_left2
    {
        h[0]=0 v[0]=0 
        h[1]=w v[1]=w 
        h[2]=0 v[2]=w
    } else if spr = spr_wedge_left_mirrored or spr = spr_wedge_left2_mirrored
    {
        h[0]=w v[0]=0 
        h[1]=0 v[1]=w 
        h[2]=0 v[2]=0
    }
}

for (var i=0; i<getLength(h); i++)
    physics_fixture_add_point(fix,h[i],v[i])

physics_fixture_bind(fix, id)
physics_fixture_delete(fix)

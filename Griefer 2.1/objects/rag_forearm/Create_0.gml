action_inherited();
///CUSTOMIZE FIXTURE

physics_fixture_set_polygon_shape(fix)

h[0] = 12 v[0] = 12
h[1] = 20 v[1] = 10
h[2] = 42 v[2] = 14
h[3] = 39 v[3] = 19
h[4] = 16 v[4] = 18

var hoff = 0// 5//32
var voff = 0//15

for (var i=0; i<getLength(h); i++)
{
    h[i] = h[i]+hoff
    v[i] = v[i]+voff
}   

joint_xs[0] = 6 joint_ys[0] = 8
//joint_xs[1] = 44 joint_ys[1] = 36

rag_normalize_about_origin() 

if do_bind
    rag_bind_my_fix()


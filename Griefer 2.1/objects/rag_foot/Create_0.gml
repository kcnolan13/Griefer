action_inherited();
///CUSTOMIZE FIXTURE

physics_fixture_set_polygon_shape(fix)

h[0] = 24 v[0] = 28
h[1] = 31 v[1] = 26
h[2] = 36 v[2] = 29
h[3] = 39 v[3] = 34
h[4] = 31 v[4] = 37
h[5] = 23 v[5] = 34

joint_xs[0] = 31 joint_ys[0] = 27
//joint_xs[1] = 44 joint_ys[1] = 36

rag_normalize_about_origin() 

if do_bind
    rag_bind_my_fix()


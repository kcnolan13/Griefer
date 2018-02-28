action_inherited();
///CUSTOMIZE FIXTURE

physics_fixture_set_polygon_shape(fix)

h[0] = 18 v[0] = 30
h[1] = 23 v[1] = 23
h[2] = 39 v[2] = 31
h[3] = 39 v[3] = 37
h[4] = 29 v[4] = 34

joint_xs[0] = 18 joint_ys[0] = 26
joint_xs[1] = 45 joint_ys[1] = 36

rag_normalize_about_origin() 

if do_bind
    rag_bind_my_fix()


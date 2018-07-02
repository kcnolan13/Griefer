action_inherited();
///CUSTOMIZE FIXTURE

physics_fixture_set_polygon_shape(fix)

h[0] = 20 v[0] = 29
h[1] = 23 v[1] = 23
h[2] = 36 v[2] = 23
h[3] = 39 v[3] = 28
h[4] = 39 v[4] = 36
h[5] = 36 v[5] = 41
h[6] = 24 v[6] = 41
h[7] = 20 v[7] = 36

joint_xs[0] = 30 joint_ys[0] = 24
joint_xs[1] = 32 joint_ys[1] = 38

rag_normalize_about_origin() 


if do_bind
    rag_bind_my_fix()


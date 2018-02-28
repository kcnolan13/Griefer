action_inherited();
///CUSTOMIZE FIXTURE

physics_fixture_set_polygon_shape(fix)

h[0] = 24 v[0] = 28
h[1] = 36 v[1] = 28
h[2] = 44 v[2] = 32
h[3] = 44 v[3] = 40
h[4] = 32 v[4] = 40
h[5] = 20 v[5] = 36

joint_xs[0] = 28 joint_ys[0] = 32

rag_normalize_about_origin() 

if do_bind
    rag_bind_my_fix()


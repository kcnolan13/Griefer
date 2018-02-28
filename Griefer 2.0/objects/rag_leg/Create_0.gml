action_inherited();
///CUSTOMIZE FIXTURE

physics_fixture_set_polygon_shape(fix)

h[0] = 20 v[0] = 28
h[1] = 26 v[1] = 22
h[2] = 36 v[2] = 28
h[3] = 40 v[3] = 40
h[4] = 34 v[4] = 42

joint_xs[0] = 26 joint_ys[0] = 27
joint_xs[1] = 40 joint_ys[1] = 43

rag_normalize_about_origin() 

if do_bind
    rag_bind_my_fix()


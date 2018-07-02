action_inherited();
///CUSTOMIZE FIXTURE

physics_fixture_set_polygon_shape(fix)

h[0] = 28 v[0] = 22
h[1] = 35 v[1] = 22
h[2] = 36 v[2] = 28
h[3] = 31 v[3] = 40
h[4] = 26 v[4] = 36

joint_xs[0] = 33 joint_ys[0] = 18
joint_xs[1] = 27 joint_ys[1] = 40

rag_normalize_about_origin() 

if do_bind
    rag_bind_my_fix()
    
    


action_inherited();
///CUSTOMIZE FIXTURE

physics_fixture_set_polygon_shape(fix)

h[0] = 23 v[0] = 12
h[1] = 37 v[1] = 18
h[2] = 43 v[2] = 27
h[3] = 41 v[3] = 40
h[4] = 34 v[4] = 50
h[5] = 21 v[5] = 49
h[6] = 19 v[6] = 42
h[7] = 16 v[7] = 19

joint_xs[0] = 30 joint_ys[0] = 16
joint_xs[1] = 28 joint_ys[1] = 23
joint_xs[2] = 29 joint_ys[2] = 48
//third joint will never be bound -- so will always bleed
joint_xs[3] = 32 joint_ys[3] = 32

rag_normalize_about_origin() 

if do_bind
    rag_bind_my_fix()


///rag_bind_my_fix()

//clockwise
//for (var i=0; i<getLength(h); i++)
if xscale = -1
{
    for (var i=getLength(h)-1; i>=0; i--)
    {
        physics_fixture_add_point(fix,h[i],v[i])
    }
}
else
{
    for (var i=0; i<getLength(h); i++)
    {
        physics_fixture_add_point(fix,h[i],v[i])
    }
}

physics_fixture_set_density(fix,global.rag_density)
physics_fixture_set_restitution(fix,global.rag_restitution)
physics_fixture_set_collision_group(fix,global.rag_collision_group)
physics_fixture_set_linear_damping(fix,global.rag_linear_damping)
physics_fixture_set_angular_damping(fix,global.rag_angular_damping)
physics_fixture_set_friction(fix,global.rag_friction)

//BIND
physics_fixture_bind(fix,id)
physics_fixture_set_awake(fix,true)
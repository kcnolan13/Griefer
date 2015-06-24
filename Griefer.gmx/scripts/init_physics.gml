///init_physics()
physics_world_create(1/64)
physics_world_gravity(0,15)//9.81)
//physics_world_update_iterations(20)
physics_world_update_speed(room_speed*2)
flag = phy_debug_render_aabb | phy_debug_render_collision_pairs | phy_debug_render_obb
physics_world_draw_debug(flag)

/// @description init_physics()
/// @function init_physics
physics_world_create(1/64)
global.phys_world_grav = 60
physics_world_gravity(0,global.phys_world_grav)//9.81)
//physics_world_update_iterations(20)
global.phys_world_spd = 60
physics_world_update_speed(global.phys_world_spd)
flag = phy_debug_render_aabb | phy_debug_render_collision_pairs | phy_debug_render_obb
physics_world_draw_debug(flag)
net_manager.physics_going = true

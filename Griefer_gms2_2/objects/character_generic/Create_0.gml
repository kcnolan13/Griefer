/// @description basic player code
netvars = ds_map_create()

varWrite("bot",false)
varWrite("player_quit",false)

surf_splat = NO_HANDLE
create_splat_surface()

dude_lerp = 0.3
dude_instalerp_x = false
dude_instalerp_y = false

hover_counter = 0
hover_delay = 10

//dummy vars
shoulderl_xoffset_temp = 0
shoulderl_yoffset_temp = 0
shoulderr_xoffset_temp = 0
shoulderr_yoffset_temp = 0
forearml_xoffset_temp = 0
forearml_yoffset_temp = 0
forearmr_xoffset_temp = 0
forearmr_yoffset_temp = 0
shoulderl_x = 0
shoulderl_y = 0
shoulderl_rot = 0
shoulderr_x = 0
shoulderr_y = 0
shoulderr_rot = 0
forearml_rot = 0
forearml_x = 0
forearml_y = 0
forearmr_rot = 0
forearmr_x = 0
forearmr_y = 0
weapon_x = 0
weapon_y = 0
weapon_xoffset =0
weapon_yoffset = 0
weapon_rot = 0
hat_x = 0
hat_y = 0
hat_yoffset_temp = 0
hat_xoffset_temp = 0
dummy_counter = 0

//drawing vars
forearml_drawx = 0
forearml_drawy = 0
forearml_drawr = 0
forearmr_drawx = 0
forearmr_drawy = 0
forearmr_drawr = 0
shoulderl_drawx = 0
shoulderl_drawy = 0
shoulderl_drawr = 0
shoulderr_drawx = 0
shoulderr_drawy = 0
shoulderr_drawr = 0
head_drawx = 0
head_drawy = 0
head_drawr = 0
hat_drawx = 0
hat_drawy = 0
hat_drawr = 0
torso_drawx = 0
torso_drawy = 0
torso_drawr = 0
legl_drawx = 0
legl_drawy = 0
legl_drawr = 0
legr_drawx = 0
legr_drawy = 0
legr_drawr = 0
shinl_drawx = 0
shinl_drawy = 0
shinl_drawr = 0
shinr_drawx = 0
shinr_drawy = 0
shinr_drawr = 0
footl_drawx = 0
footl_drawy = 0
footl_drawr = 0
footr_drawx = 0
footr_drawy = 0
footr_drawr = 0

pose_pistol()

xaim = 0
yaim = 0

varWrite("sprite_index",spr_player)
varWrite("head0",spr_head)
varWrite("torso0",spr_torso)
varWrite("leg0",spr_leg)
varWrite("shin0",spr_shin)
varWrite("foot0",spr_foot)
varWrite("hat0",spr_hat)
varWrite("shoulder0",spr_shoulder)
varWrite("forearm0",spr_forearm)
varWrite("prop0",spr_prop)
varWrite("active_weapon_sprite",spr_rifle)
varWrite("active_weapon_prescaler",1)
varWrite("active_weapon",NO_HANDLE)
varWrite("nades",0)
varWrite("controllable",false)
varWrite("lerp_delay",0)

varWrite("dude_x",0)
varWrite("dude_y",0)

varWrite("cant_shoot",0)

varWrite("rot_true",0)

//make these networkable
varWrite("arm_pose","pose_pistol")
varWrite("animation","walk")
varWrite("animation_index",0)
varWrite("animation_length",24)
varWrite("animation_speed",1)
varWrite("animation_scale",2.5)
varWrite("animation_direction",1)
varWrite("arms_posing",true)
varWrite("animation_xscale",-1)
varWrite("arm_rot_extra",0)
varWrite("kick",0)
varWrite("arm_y_extra",0)

//arm pose animations
varWrite("arm_animation_index",0)
varWrite("arm_animation_length",1)
varWrite("arm_animation_speed",1)
varWrite("arm_animation_direction",1)


stiff_neck = 3

loop_counter = 0
offset_scale = 1

torso_x = 0
torso_y = 0
torso_rot = 0

hat_x = 0
hat_y = 0
hat_rot = 0

head_x = 0
head_y = 0
head_rot = 0

shoulderl_x = 0
shoulderl_y = 0
shoulderl_rot = 0
shoulderl_xs = 0
shoulderl_ys = 0
shoulderl_rots = 0
shoulderl_xoffset = 0
shoulderl_yoffset = 0

shoulderr_x = 0
shoulderr_y = 0
shoulderr_rot = 0
shoulderr_xs = 0
shoulderr_ys = 0
shoulderr_rots = 0
shoulderr_xoffset = 0
shoulderr_yoffset = 0

forearml_x = 0
forearmr_y = 0
forearmr_rot = 0
forearml_xs = 0
forearml_ys = 0
forearml_rots = 0
forearml_xoffset = 0
forearml_yoffset = 0

forearmr_x = 0
forearmr_y = 0
forearmr_rot = 0
forearmr_xs = 0
forearmr_ys = 0
forearmr_rots = 0
forearmr_xoffset = 0
forearmr_yoffset = 0

weapon_x = 0
weapon_y = 0
weapon_rot = 0
weapon_xoffset = 0
weapon_yoffset = 0
weapon_xoffset_temp = 0
weapon_yoffset_temp = 0

legl_x = 0
legl_y = 0
legl_rot = 0
legl_xoffset = 0
legl_yoffset = 0


legr_x = 0
legr_y = 0
legr_rot = 0
legr_xoffset = 0
legr_yoffset = 0

shinl_x = 0
shinl_y = 0
shinl_rot = 0
shinl_xoffset = 0
shinl_yoffset = 0

shinr_x = 0
shinr_y = 0
shinr_rot = 0
shinr_xoffset = 0
shinr_yoffset = 0

footl_x = 0
footl_y = 0
footl_rot = 0
footl_xoffset = 0
footl_yoffset = 0

footr_x = 0
footr_y = 0
footr_rot = 0
footr_xoffset = 0
footr_yoffset = 0

rag_init_exclusions()



//set up initial animation and arm pose
animation_walk()
pose_rifle()

initialize_physics()


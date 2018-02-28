/// @description send_frame()
/// @function send_frame

pkgCreate()

//ARM ROTATION
if nth_frame(1) or (cursor.x != cursor.xprevious or cursor.y != cursor.yprevious)
{
    obj_update_real(local_player,"rot_true",0)
}

//SPRITE INDEX
if local_player.sprite_index_transmitted != local_player.sprite_index
{
    objVarWrite(local_player,"sprite_index",local_player.sprite_index)
    obj_update_real(local_player,"sprite_index",FL_NORMAL)
    local_player.sprite_index_transmitted = local_player.sprite_index
}

//PHYSICS
if nth_frame(1) or local_player.update_physics
{
    obj_update_real(local_player,"myX",FL_NORMAL)
    obj_update_real(local_player,"myY",FL_NORMAL)
}

if nth_frame(4) or local_player.update_physics
{
    objVarWrite(local_player,"net_hsp",local_player.hsp)
    objVarWrite(local_player,"net_vsp",local_player.vsp)
    
    if local_player.was_standing or local_player.standing_2way
        objVarWrite(local_player,"net_vsp",0)
        
    obj_update_real(local_player,"net_hsp",0)
    obj_update_real(local_player,"net_vsp",0)
}

var newval = 0

newval = objVarRead(local_player,"animation")
if local_player.animation_transmitted != newval
{
    obj_update_string(local_player,"animation",FL_NORMAL)
    local_player.animation_transmitted = newval
}

newval = objVarRead(local_player,"match_points")
if local_player.match_points_transmitted != newval
{
    obj_update_real(local_player,"match_points",FL_NORMAL)
    local_player.match_points_transmitted = newval
}

newval = objVarRead(local_player,"match_deaths")
if local_player.match_deaths_transmitted != newval
{
    obj_update_real(local_player,"match_deaths",FL_NORMAL)
    local_player.match_deaths_transmitted = newval
}

newval = objVarRead(local_player,"match_kills")
if local_player.match_kills_transmitted != newval
{
    obj_update_real(local_player,"match_kills",FL_NORMAL)
    local_player.match_kills_transmitted = newval
}

newval = objVarRead(local_player,"match_assists")
if local_player.match_assists_transmitted != newval
{
    obj_update_real(local_player,"match_assists",FL_NORMAL)
    local_player.match_assists_transmitted = newval
}

newval = objVarRead(local_player,"visible")
if local_player.visible_transmitted != newval
{
    obj_update_real(local_player,"visible",FL_NORMAL)
    local_player.visible_transmitted = newval
}

newval = objVarRead(local_player,"animation_speed")
if local_player.animation_speed_transmitted != newval
{
    obj_update_real(local_player,"animation_speed",FL_NORMAL)
    local_player.animation_speed_transmitted = newval
}

newval = objVarRead(local_player,"animation_direction")
if local_player.animation_direction_transmitted != newval
{
    obj_update_real(local_player,"animation_direction",FL_NORMAL)
    local_player.animation_direction_transmitted = newval
}

newval = objVarRead(local_player,"animation_xscale")
if local_player.animation_xscale_transmitted != newval
{
    obj_update_real(local_player,"animation_xscale",FL_NORMAL)
    local_player.animation_xscale_transmitted = newval
}

newval = objVarRead(local_player,"animation_index")
if local_player.animation_index_transmitted != newval and nth_frame(15)
{
    obj_update_real(local_player,"animation_index",FL_NORMAL)
    local_player.animation_index_transmitted = newval
}

newval = objVarRead(local_player,"active_weapon_sprite")
if local_player.active_weapon_sprite_transmitted != newval
{
    obj_update_real(local_player,"active_weapon_sprite",FL_NORMAL)
    local_player.active_weapon_sprite_transmitted = newval
}

newval = objVarRead(local_player,"arms_posing")
if local_player.arms_posing_transmitted != newval
{
    obj_update_real(local_player,"arms_posing",FL_NORMAL)
    local_player.arms_posing_transmitted = newval
}

newval = objVarRead(local_player,"arm_pose")
if local_player.arm_pose_transmitted != newval
{
    obj_update_string(local_player,"arm_pose",FL_NORMAL)
    local_player.arm_pose_transmitted = newval
}

newval = objVarRead(local_player,"arm_animation_index")
if local_player.arm_animation_index_transmitted != newval
{
    obj_update_real(local_player,"arm_animation_index",FL_NORMAL)
    local_player.arm_animation_index_transmitted = newval
}

newval = objVarRead(local_player,"arm_animation_length")
if local_player.arm_animation_length_transmitted != newval
{
    obj_update_real(local_player,"arm_animation_length",FL_NORMAL)
    local_player.arm_animation_length_transmitted = newval
}

newval = objVarRead(local_player,"arm_animation_direction")
if local_player.arm_animation_direction_transmitted != newval
{
    obj_update_real(local_player,"arm_animation_direction",FL_NORMAL)
    local_player.arm_animation_direction_transmitted = newval
}

newval = objVarRead(local_player,"arm_animation_speed")
if local_player.arm_animation_speed_transmitted != newval
{
    obj_update_real(local_player,"arm_animation_speed",FL_NORMAL)
    local_player.arm_animation_speed_transmitted = newval
}

newval = objVarRead(local_player,"active_weapon_prescaler")
if local_player.active_weapon_prescaler_transmitted != newval
{
    obj_update_real(local_player,"active_weapon_prescaler",FL_NORMAL)
    local_player.active_weapon_prescaler_transmitted = newval
}

pkgSend()

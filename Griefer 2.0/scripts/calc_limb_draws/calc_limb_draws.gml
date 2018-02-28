//left arm
if not varRead("arms_posing")
{
    forearml_drawx = forearml_x+varRead("animation_scale")*varRead("animation_xscale")*forearml_xoffset_temp
    forearml_drawy = forearml_y+varRead("animation_scale")*forearml_yoffset_temp
    forearml_drawr = -1*forearml_rot
    shoulderl_drawx = shoulderl_x+varRead("animation_scale")*varRead("animation_xscale")*shoulderl_xoffset_temp
    shoulderl_drawy = shoulderl_y+varRead("animation_scale")*shoulderl_yoffset_temp
    shoulderl_drawr = -1*shoulderl_rot
}
else
{
    forearml_drawx = forearml_x+varRead("animation_scale")*forearml_xoffset_temp
    forearml_drawy = forearml_y+varRead("animation_scale")*forearml_yoffset_temp
    forearml_drawr = -1*forearml_rot
    shoulderl_drawx = shoulderl_x+varRead("animation_scale")*shoulderl_xoffset_temp
    shoulderl_drawy = shoulderl_y+varRead("animation_scale")*shoulderl_yoffset_temp
    shoulderl_drawr = -1*shoulderl_rot
}

//left leg
legl_drawx = legl_x+varRead("animation_scale")*varRead("animation_xscale")*legl_xoffset
legl_drawy = legl_y+varRead("animation_scale")*legl_yoffset
legl_drawr = -1*legl_rot
shinl_drawx = shinl_x+varRead("animation_scale")*varRead("animation_xscale")*shinl_xoffset
shinl_drawy = shinl_y+varRead("animation_scale")*shinl_yoffset
shinl_drawr = -1*shinl_rot
footl_drawx = footl_x+varRead("animation_scale")*varRead("animation_xscale")*footl_xoffset
footl_drawy = footl_y+varRead("animation_scale")*footl_yoffset
footl_drawr = -1*footl_rot

//torso
torso_drawx = torso_x+varRead("animation_scale")*varRead("animation_xscale")*torso_xoffset
torso_drawy = torso_y+varRead("animation_scale")*torso_yoffset
torso_drawr = -1*torso_rot

//right leg
legr_drawx = legr_x+varRead("animation_scale")*varRead("animation_xscale")*legr_xoffset
legr_drawy = legr_y+varRead("animation_scale")*legr_yoffset
legr_drawr = -1*legr_rot
shinr_drawx = shinr_x+varRead("animation_scale")*varRead("animation_xscale")*shinr_xoffset
shinr_drawy = shinr_y+varRead("animation_scale")*shinr_yoffset
shinr_drawr = -1*shinr_rot
footr_drawx = footr_x+varRead("animation_scale")*varRead("animation_xscale")*footr_xoffset
footr_drawy = footr_y+varRead("animation_scale")*footr_yoffset
footr_drawr = -1*footr_rot

//head
head_drawx = head_x+varRead("animation_scale")*varRead("animation_xscale")*head_xoffset
head_drawy = head_y+varRead("animation_scale")*head_yoffset
head_drawr = -1*head_rot

//hat
hat_drawx = hat_x+varRead("animation_scale")*varRead("animation_xscale")*hat_xoffset_temp
hat_drawy = hat_y+varRead("animation_scale")*hat_yoffset_temp
hat_drawr = -1*hat_rot

//right arm
if not varRead("arms_posing")
{
    forearmr_drawx = forearmr_x+varRead("animation_scale")*varRead("animation_xscale")*forearmr_xoffset_temp
    forearmr_drawy = forearmr_y+varRead("animation_scale")*forearmr_yoffset_temp
    forearmr_drawr = -1*forearmr_rot
    shoulderr_drawx = shoulderr_x+varRead("animation_scale")*varRead("animation_xscale")*shoulderr_xoffset_temp
    shoulderr_drawy = shoulderr_y+varRead("animation_scale")*shoulderr_yoffset_temp
    shoulderr_drawr = -1*shoulderr_rot
}
else
{
    forearmr_drawx = forearmr_x+varRead("animation_scale")*forearmr_xoffset_temp
    forearmr_drawy = forearmr_y+varRead("animation_scale")*forearmr_yoffset_temp
    forearmr_drawr = -1*forearmr_rot
    shoulderr_drawx = shoulderr_x+varRead("animation_scale")*shoulderr_xoffset_temp
    shoulderr_drawy = shoulderr_y+varRead("animation_scale")*shoulderr_yoffset_temp
    shoulderr_drawr = -1*shoulderr_rot
}
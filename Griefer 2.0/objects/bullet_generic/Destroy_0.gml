/// @description free net vars and create traj object if necessary

if traj_draw
{
    var ID = instance_create(x,y,flash_hitscan_simple_generic)
    objVarWrite(ID,"xscale",traj_xscale)
    objVarWrite(ID,"angle",(varRead("direction")+180) mod 360)
    ID.yscale = traj_yscale
    ID.intensity = traj_intensity
    ID.life = traj_life
    ID.color = traj_color
    ID.intensity_divisor = traj_intensity_divisor
    ID.intensity_flicker = traj_intensity_flicker
    ID.scale_divisor = traj_scale_divisor
    ID.scale_flicker = traj_scale_flicker
    ID.sprite = traj_sprite
    ID.xscale_divisor = traj_xscale_divisor
}

if ds_exists(netvars,ds_type_map)
    ds_map_destroy(netvars)


/// @description weapon_shoot()
/// @function weapon_shoot
if object_index = weapon_vulcan
{
    time_since_shot = 0
    if varRead("cant_shoot_max") > 1
        varSub("cant_shoot_max",1)
}

i_dir = point_direction(x,y,cursor.x,cursor.y)


if (object_index = weapon_boom or object_index = weapon_rocket) and aiming_at_flo(64*4,x,y,i_dir,16,16)
{
    if not is_bot(mi_jugador) and not audio_is_playing(snd_denied)
        audio(snd_denied, 1)
        
    return false
}
//handle ammo
varSub("clip",varRead("clip_decrement"))

varWrite("cant_shoot",varRead("cant_shoot_max"))


if is_bot(mi_jugador)
    i_dir = point_direction(x,y,mi_jugador.xaim,mi_jugador.yaim)

//create as many bullets as desired
for (var i=0; i<varRead("spread_count"); i++)
{
    //bullet spread spawn translation
    var xoff = 0
    var yoff = 0
    var spawn_direction
    
    //compute spawn direction and translation offsets separately for spreadshots
    if varRead("spread_count") > 2
    {
        xoff = random_range(-1*varRead("spread_spawn_translation"),varRead("spread_spawn_translation"))
        yoff = random_range(-1*varRead("spread_spawn_translation"),varRead("spread_spawn_translation"))
        spawn_direction = i_dir+random_range(-1*varRead("spread_swath"),1*varRead("spread_swath"))
    }
    else
    {
        spawn_direction = i_dir+random_range(-1*varRead("inaccuracy"),1*varRead("inaccuracy"))
    }
    
    //create each bullet
    new_bullet = instance_create_for_everyone(x+xoff+trigx(varRead("muzzle_offset"),spawn_direction),y+yoff+trigy(varRead("muzzle_offset"),spawn_direction),varRead("bullet"))
    if i=0
        objVarWrite(new_bullet,"first_in_burst",true)
        
    if object_index = weapon_torque and reached_hitscan
    {
        printf("giving hitscan")
        objVarWrite(new_bullet,"hitscan",true)
    }
    
    if varRead("is_nade")
    {
        //sync up frag image scale
        objVarWrite(new_bullet,"scale",varRead("scale")*objVarRead(new_bullet,"scale"))
        objVarWrite(new_bullet,"gravity",varRead("traj_gravity"))
        objVarWrite(new_bullet,"rigidity",varRead("traj_rigidity"))
        obj_update_real(new_bullet,"scale",FL_NORMAL)
        obj_update_real(new_bullet,"gravity",FL_NORMAL)
        obj_update_real(new_bullet,"rigidity",FL_NORMAL)
    }
    
    if DEBUG
        printf("bullet spawned at: "+new_bullet.x+","+new_bullet.y)
    
    //set bullet properties
    objVarWrite(new_bullet,"local",true)
    objVarWrite(new_bullet,"speed",varRead("bullet_speed"))
    objVarWrite(new_bullet,"direction",spawn_direction)
    objVarWrite(new_bullet,"senderId",varRead("my_player"))
    objVarWrite(new_bullet,"startX",new_bullet.x)
    objVarWrite(new_bullet,"startY",new_bullet.y)
    
    pkgCreate()
    //send bullet properties to remote players
    obj_update_real(new_bullet,"speed",FL_NORMAL)
    obj_update_real(new_bullet,"direction",FL_NORMAL)
    obj_update_string(new_bullet,"senderId",FL_NORMAL) //was varRead("uniqueId") for last param -- why??
    obj_update_real(new_bullet,"startX",FL_NORMAL)
    obj_update_real(new_bullet,"startY",FL_NORMAL)
    pkgSend()
    
    //PERFORM HIT SCANNING AND INITIAL COLLISION CHECKING WITH THE BULLET
    //if objVarRead(new_bullet,"is_bullet")
        with (new_bullet) instantiate_bullet()
}

//add inaccuracy and visual kick
varAdd("inaccuracy",varRead("recoil"))
objVarAdd(mi_jugador,"kick",varRead("kick"))

//generate muzzle flash
create_muzzle_flash(varRead("flash"),x+trigx(varRead("muzzle_offset"),i_dir),y+trigy(varRead("muzzle_offset"),i_dir),i_dir)

if mi_jugador < 0 return false

//shake the view
switch (varRead("view_shake_duration"))
{
    case "short":
        mi_jugador.view_shake_short += varRead("view_shake")
    break
    
    case "medium":
        mi_jugador.view_shake_medium += varRead("view_shake")
    break
    
    case "long":
        mi_jugador.view_shake_long += varRead("view_shake")
    break
}

//drop if empty
/*if varRead("clip") < 1 and varRead("ammo") < 1
{
    with mi_jugador 
    {
        drop_weapon(varRead("weapon_index"))
        if instance_exists(varRead("active_weapon"))
        {
            if objVarRead(varRead("active_weapon"),"is_nade")
                next_weapon()
        }
    }
}*/
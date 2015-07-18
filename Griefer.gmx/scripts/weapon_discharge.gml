///weapon_discharge

//adjust bullet speed based on charge
var normal_bullet_speed = varRead("bullet_speed")
if normal_bullet_speed > 500
{
    normal_bullet_speed = 62    
}
varWrite("bullet_speed",normal_bullet_speed*varRead("charge"))

//standard shoot code
weapon_shoot()

max_charge_counter = 0

//restore bullet speed to default
varWrite("bullet_speed",normal_bullet_speed)

//reset charging vars
varWrite("charge",0)
varWrite("charge_counter",-1)
varWrite("discharge_delay",-1)

varWrite("draw_trajectory",false)

var my_dude = find_player(varRead("my_player"))
if my_dude = net_manager.local_player
{
    objVarWrite(my_dude,"arm_animation_speed",0)
    objVarWrite(my_dude,"arm_animation_index",0)
    
    if varRead("quicktoss_backcycles")
    {
        varWrite("cant_shoot",false)
    }
    
    //auto destroy nades when empty
    if varRead("clip") < 1 and varRead("ammo") < 1 and varRead("is_nade")
    {
        with (my_dude) {drop_weapon(find_my_weapon_by_name(objVarRead(other.id,"name"))) previous_weapon()}
        x = room_width+50
        y = -50
        varWrite("myX",x)
        varWrite("myY",y)
        obj_update_real(id,"myX",FL_NORMAL)
        obj_update_real(id,"myY",FL_NORMAL)
    }
    
    //backcylce if this was a quicktoss
    var whiles = 0
    while (varRead("quicktoss_backcycles")) and whiles < 1000
    {
        whiles++
        varSub("quicktoss_backcycles",1)
        with (my_dude) previous_weapon()
    }
    
}

action_inherited();
///Weapon Constants

//bot weapon selection
varWrite("lethality",8)
varWrite("range_rating",0)
varWrite("range_trump",true)
varWrite("range_trump_distance",64*10)
varWrite("range_trump_extra_lethality",10)

//graphics
myCursor = cursor_shotgun
varWrite("sprite",spr_double)
varWrite("name",global.double)
varWrite("icon",spr_double)
varWrite("bullet_icon",icon_bullet_thick)
varWrite("pose",global.double_pose)
varWrite("muzzle_offset",100)
varWrite("scale",global.double_scale)
varWrite("flash",flash_double)

//engine
varWrite("sound_reload",snd_reload0)
varWrite("is_nade",false)
varWrite("is_secondary",false)

//specs
varWrite("clip_cap",2)
varWrite("clip",varRead("clip_cap"))
varWrite("starting_ammo",4*varRead("clip_cap"))
varWrite("max_ammo",5*varRead("clip_cap"))
varWrite("ammo",varRead("starting_ammo"))
varWrite("reload_time",1.5*30)
varWrite("reload_incremental",true)

//shooting mechanics
varWrite("view_scale",1.05)
varWrite("kick",40)
varWrite("bullet",bullet_double)
varWrite("bullet_speed",235)
varWrite("control_type","left_press")
varWrite("cant_shoot_max",2)
varWrite("spread_count",8)
varWrite("spread_swath",3)
varWrite("recoil",5)
//varWrite("handling",1.25)
varWrite("view_shake_duration","medium") //short, medium, long
varWrite("view_shake",8)






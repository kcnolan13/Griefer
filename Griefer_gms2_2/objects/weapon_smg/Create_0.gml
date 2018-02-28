action_inherited();
///Weapon Constants

//bot weapon selection
varWrite("lethality",6)
varWrite("range_rating",0)
varWrite("range_trump",true)
varWrite("range_trump_distance",64*9)
varWrite("range_trump_extra_lethality",10)

//graphics
myCursor = cursor_smg
varWrite("sprite",spr_smg)
varWrite("name",global.smg)
varWrite("icon",spr_smg)
varWrite("bullet_icon",icon_bullet_thin)
varWrite("pose",global.smg_pose)
varWrite("muzzle_offset",72)
varWrite("scale",global.smg_scale)
varWrite("flash",flash_smg)

//engine
varWrite("sound_reload",snd_reload_1_0)
varWrite("is_nade",false)
varWrite("is_secondary",true)

//specs
varWrite("clip_cap",28)
varWrite("clip",varRead("clip_cap"))
varWrite("starting_ammo",3*varRead("clip_cap"))
varWrite("max_ammo",5*varRead("clip_cap"))
varWrite("ammo",varRead("starting_ammo"))
varWrite("reload_time",1*30)

//shooting mechanics
varWrite("view_scale",1)//0.85
varWrite("kick",3)
varWrite("bullet",bullet_smg)
varWrite("bullet_speed",100)
varWrite("control_type","left_hold")
varWrite("cant_shoot_max",2)
varWrite("spread_count",1)
varWrite("spread_swath",0)
varWrite("recoil",2)
//varWrite("handling",1.25)
varWrite("view_shake_duration","short") //short, medium, long
varWrite("view_shake",4)


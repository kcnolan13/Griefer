action_inherited();
///Weapon Constants

//bot weapon selection
varWrite("lethality",3)
varWrite("range_rating",64*20)
varWrite("range_trump",true)
varWrite("range_trump_distance",64*10)

//graphics
myCursor = cursor_carbine
varWrite("sprite",spr_carbine)
varWrite("name",global.carbine)
varWrite("icon",spr_carbine)
varWrite("bullet_icon",icon_bullet)
varWrite("pose",global.carbine_pose)
varWrite("muzzle_offset",70)
varWrite("scale",global.carbine_scale)
varWrite("flash",flash_smg)

//engine
varWrite("sound_reload",snd_reload_1_0)
varWrite("is_nade",false)
varWrite("is_secondary",false)

//specs
varWrite("clip_cap",18)
varWrite("clip",varRead("clip_cap"))
varWrite("starting_ammo",2*varRead("clip_cap"))
varWrite("max_ammo",5*varRead("clip_cap"))
varWrite("ammo",varRead("starting_ammo"))
varWrite("reload_time",1*30)

//shooting mechanics
varWrite("view_scale",1.2)
varWrite("kick",10)
varWrite("bullet",bullet_carbine)
varWrite("bullet_speed",280)
varWrite("control_type","left_press")
varWrite("cant_shoot_max",6)
varWrite("spread_count",1)
varWrite("spread_swath",0)
varWrite("recoil",8)
//varWrite("handling",1.25)
varWrite("view_shake_duration","short") //short, medium, long
varWrite("view_shake",5)






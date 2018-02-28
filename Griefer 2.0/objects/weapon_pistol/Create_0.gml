action_inherited();
///Weapon Constants

//bot weapon selection
varWrite("lethality",1)
varWrite("range_rating",64*12)
varWrite("range_trump",false)
varWrite("range_trump_distance",64*8)

//graphics
myCursor = cursor_pistol
varWrite("sprite",spr_pistol)
varWrite("name",global.pistol)
varWrite("icon",spr_pistol)
varWrite("bullet_icon",icon_bullet)
varWrite("pose",global.pistol_pose)
varWrite("muzzle_offset",70)
varWrite("scale",global.pistol_scale)
varWrite("flash",flash_pistol)

//engine
varWrite("sound_reload",snd_reload0)
varWrite("is_nade",false)
varWrite("is_secondary",true)

//specs
varWrite("clip_cap",12)
varWrite("clip",varRead("clip_cap"))
varWrite("starting_ammo",2*varRead("clip_cap"))
varWrite("max_ammo",5*varRead("clip_cap"))
varWrite("ammo",varRead("starting_ammo"))
varWrite("reload_time",0.6*30)

//shooting mechanics
varWrite("view_scale",1.15)
varWrite("kick",10)
varWrite("bullet",bullet_pistol)
varWrite("bullet_speed",275)
varWrite("control_type","left_press")
varWrite("cant_shoot_max",3)
varWrite("spread_count",1)
varWrite("spread_swath",0)
varWrite("recoil",2)
//varWrite("handling",1.25)
varWrite("view_shake_duration","short") //short, medium, long
varWrite("view_shake",5)






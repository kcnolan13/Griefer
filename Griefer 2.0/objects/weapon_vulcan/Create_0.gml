action_inherited();
///Weapon Constants

//bot weapon selection
varWrite("lethality",6)
varWrite("range_rating",64*8)
varWrite("range_trump",false)
varWrite("range_trump_distance",64*4)
varWrite("range_trump_extra_lethality",0)

//graphics
myCursor = cursor_vulcan
varWrite("sprite",spr_vulcan)
varWrite("name",global.vulcan)
varWrite("icon",spr_vulcan)
varWrite("bullet_icon",icon_bullet_thin)
varWrite("pose",global.vulcan_pose)
varWrite("muzzle_offset",132)
varWrite("scale",global.vulcan_scale)
varWrite("flash",flash_vulcan)

//engine
varWrite("sound_reload",snd_reload_1_0)
varWrite("is_nade",false)
varWrite("is_secondary",false)

//specs
varWrite("clip_cap",36)
varWrite("clip",varRead("clip_cap"))
varWrite("starting_ammo",3*varRead("clip_cap"))
varWrite("max_ammo",5*varRead("clip_cap"))
varWrite("ammo",varRead("starting_ammo"))
varWrite("reload_time",floor(1.25*30))

//shooting mechanics
varWrite("view_scale",1.15)
varWrite("kick",3)
varWrite("bullet",bullet_vulcan)
varWrite("bullet_speed",100)
varWrite("control_type","left_hold")
varWrite("cant_shoot_max",5)
varWrite("cant_shoot_max_original",varRead("cant_shoot_max"))
varWrite("spread_count",1)
varWrite("spread_swath",0)
varWrite("recoil",0.5)
//varWrite("handling",1.25)
varWrite("view_shake_duration","short") //short, medium, long
varWrite("view_shake",2)


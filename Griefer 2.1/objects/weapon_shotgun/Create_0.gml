action_inherited();
///Weapon Constants

//bot weapon selection
varWrite("lethality",0)
varWrite("range_rating",0)
varWrite("range_trump",true)
varWrite("range_trump_distance",64*6)
varWrite("range_trump_extra_lethality",10)

//graphics
myCursor = cursor_shotgun
varWrite("sprite",spr_shotgun)
varWrite("name",global.shotgun)
varWrite("icon",spr_shotgun)
varWrite("bullet_icon",icon_bullet_thick)
varWrite("pose",global.shotgun_pose)
varWrite("muzzle_offset",100)
varWrite("scale",global.shotgun_scale)
varWrite("flash",flash_shotgun)

//engine
varWrite("sound_reload",snd_reload0)
varWrite("is_nade",false)
varWrite("is_secondary",false)

//specs
varWrite("clip_cap",8)
varWrite("clip",varRead("clip_cap"))
varWrite("starting_ammo",1*varRead("clip_cap"))
varWrite("max_ammo",5*varRead("clip_cap"))
varWrite("ammo",varRead("starting_ammo"))
varWrite("reload_time",1.5*30)
varWrite("reload_incremental",true)

//shooting mechanics
varWrite("view_scale",0.925)
varWrite("kick",25)
varWrite("bullet",bullet_shotgun)
varWrite("bullet_speed",185)
varWrite("control_type","left_press")
varWrite("cant_shoot_max",16)
varWrite("spread_count",5)
varWrite("spread_swath",12)
varWrite("recoil",5)
//varWrite("handling",1.25)
varWrite("view_shake_duration","short") //short, medium, long
varWrite("view_shake",5)






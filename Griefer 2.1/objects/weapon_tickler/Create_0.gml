action_inherited();
///Weapon Constants

//bot weapon selection
varWrite("lethality",2)
varWrite("range_rating",0)
varWrite("range_trump",false)
varWrite("range_trump_distance",64*8)
varWrite("range_trump_extra_lethality",20)

//graphics
myCursor = cursor_tickler
varWrite("sprite",spr_tickler)
varWrite("name",global.tickler)
varWrite("icon",spr_tickler)
varWrite("bullet_icon",icon_bullet_thin)
varWrite("pose",global.tickler_pose)
varWrite("muzzle_offset",72)
varWrite("scale",global.tickler_scale)
varWrite("flash",flash_tickler)

//engine
varWrite("sound_reload",snd_reload_1_0)
varWrite("is_nade",false)
varWrite("is_secondary",true)

//specs
varWrite("clip_cap",36)
varWrite("clip",varRead("clip_cap"))
varWrite("starting_ammo",3*varRead("clip_cap"))
varWrite("max_ammo",5*varRead("clip_cap"))
varWrite("ammo",varRead("starting_ammo"))
varWrite("reload_time",1*30)

//shooting mechanics
varWrite("view_scale",0.85)//0.85
varWrite("kick",3)
varWrite("bullet",bullet_tickler)
varWrite("bullet_speed",50)
varWrite("control_type","left_hold")
varWrite("cant_shoot_max",1)
varWrite("spread_count",1)
varWrite("spread_swath",0)
varWrite("recoil",0.5)
//varWrite("handling",1.25)
varWrite("view_shake_duration","short") //short, medium, long
varWrite("view_shake",4)


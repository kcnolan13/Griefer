action_inherited();
///Weapon Constants

//bot weapon selection
varWrite("lethality",2)
varWrite("range_rating",64*10)
varWrite("range_trump",false)
varWrite("range_trump_distance",64*4)
varWrite("range_trump_extra_lethality",10)

//graphics
myCursor = cursor_rifle
varWrite("sprite",spr_rifle)
varWrite("name",global.rifle)
varWrite("icon",spr_rifle)
varWrite("bullet_icon",icon_bullet_thin2)
varWrite("pose",global.rifle_pose)
varWrite("muzzle_offset",85)
varWrite("scale",global.rifle_scale)
varWrite("flash",flash_rifle)

//engine
varWrite("sound_reload",snd_reload_1_0)
varWrite("is_nade",false)
varWrite("is_secondary",false)

//specs
varWrite("clip_cap",54)
varWrite("clip",varRead("clip_cap"))
varWrite("starting_ammo",2*varRead("clip_cap"))
varWrite("max_ammo",5*varRead("clip_cap"))
varWrite("ammo",varRead("starting_ammo"))
varWrite("reload_time",1*30)

//shooting mechanics
varWrite("kick",3)
varWrite("bullet",bullet_rifle)
varWrite("bullet_speed",180)
varWrite("control_type","left_hold")
varWrite("cant_shoot_max",3)
varWrite("spread_count",1)
varWrite("spread_swath",0)
varWrite("recoil",2)
//varWrite("handling",1.25)
varWrite("view_shake_duration","short") //short, medium, long
varWrite("view_shake",5)


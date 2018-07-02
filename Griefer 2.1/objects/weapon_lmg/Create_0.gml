action_inherited();
///Weapon Constants

//bot weapon selection
varWrite("lethality",8)
varWrite("range_rating",64*20)
varWrite("range_trump",false)
varWrite("range_trump_distance",64*10)
varWrite("range_trump_extra_lethality",10)

//graphics
myCursor = cursor_lmg
varWrite("sprite",spr_lmg)
varWrite("name",global.lmg)
varWrite("icon",spr_lmg)
varWrite("bullet_icon",icon_bullet_thin2)
varWrite("pose",global.lmg_pose)
varWrite("muzzle_offset",85)
varWrite("scale",global.lmg_scale)
varWrite("flash",flash_lmg)

//engine
varWrite("sound_reload",snd_reload_2_0)
varWrite("is_nade",false)
varWrite("is_secondary",false)

//specs
varWrite("clip_cap",48)
varWrite("clip",varRead("clip_cap"))
varWrite("starting_ammo",0.5*varRead("clip_cap"))
varWrite("max_ammo",5*varRead("clip_cap"))
varWrite("ammo",varRead("starting_ammo"))
varWrite("reload_time",2*30)

//shooting mechanics
varWrite("view_scale",1.15)
varWrite("kick",3)
varWrite("bullet",bullet_lmg)
varWrite("bullet_speed",200)
varWrite("control_type","left_hold")
varWrite("cant_shoot_max",3)
varWrite("spread_count",1)
varWrite("spread_swath",0)
varWrite("recoil",4)
//varWrite("handling",1.25)
varWrite("view_shake_duration","short") //short, medium, long
varWrite("view_shake",15)


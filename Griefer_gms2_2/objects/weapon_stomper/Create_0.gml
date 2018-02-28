action_inherited();
///Weapon Constants

//bot weapon selection
varWrite("lethality",20)
varWrite("range_rating",64*15)
varWrite("range_trump",true)
varWrite("range_trump_distance",64*10)
varWrite("range_trump_extra_lethality",5)

//graphics
myCursor = cursor_stomper
varWrite("sprite",spr_stomper)
varWrite("name",global.stomper)
varWrite("icon",spr_stomper)
varWrite("bullet_icon",icon_bullet_long)
varWrite("pose",global.stomper_pose)
varWrite("muzzle_offset",142)
varWrite("scale",global.stomper_scale)
varWrite("flash",flash_shotgun)

//engined
varWrite("sound_reload",snd_reload_stomper)
varWrite("is_nade",false)
varWrite("is_secondary",false)

//specs
varWrite("clip_cap",2)
varWrite("clip",varRead("clip_cap"))
varWrite("starting_ammo",4*varRead("clip_cap"))
varWrite("max_ammo",26*varRead("clip_cap"))
varWrite("ammo",varRead("starting_ammo"))
varWrite("reload_time",ceil(2.5*30))

//shooting mechanics
varWrite("view_scale",1.3)
varWrite("kick",20)
varWrite("bullet",bullet_stomper)
varWrite("bullet_speed",90)
varWrite("control_type","left_press")
varWrite("cant_shoot_max",10)
varWrite("spread_count",1)
varWrite("spread_swath",0)
varWrite("recoil",4)
//varWrite("handling",1.25)
varWrite("view_shake_duration","short") //short, medium, long
varWrite("view_shake",8)


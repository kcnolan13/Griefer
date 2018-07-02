action_inherited();
///Weapon Constants

//bot weapon selection
varWrite("lethality",6)
varWrite("range_rating",64*1)
varWrite("range_trump",true)
varWrite("range_trump_distance",64*4)

//graphics
myCursor = cursor_boltok
varWrite("sprite",spr_thumper)
varWrite("name",global.thumper)
varWrite("icon",spr_thumper)
varWrite("bullet_icon",icon_bullet_long)
varWrite("pose",global.thumper_pose)
varWrite("muzzle_offset",70)
varWrite("scale",global.thumper_scale)
varWrite("flash",flash_shotgun)

//engine
varWrite("sound_reload",snd_reload_1_5)
varWrite("is_nade",false)
varWrite("is_secondary",true)

//specs
varWrite("clip_cap",1)
varWrite("clip",varRead("clip_cap"))
varWrite("starting_ammo",8*varRead("clip_cap"))
varWrite("max_ammo",5*varRead("clip_cap"))
varWrite("ammo",varRead("starting_ammo"))
varWrite("reload_time",1.5*30)

//shooting mechanics
varWrite("view_scale",1.15)
varWrite("kick",10)
varWrite("bullet",bullet_thumper)
varWrite("bullet_speed",40)
varWrite("control_type","left_press")
varWrite("cant_shoot_max",11)
varWrite("spread_count",1)
varWrite("spread_swath",0)
varWrite("recoil",8)
//varWrite("handling",1.25)
varWrite("view_shake_duration","medium") //short, medium, long
varWrite("view_shake",10)






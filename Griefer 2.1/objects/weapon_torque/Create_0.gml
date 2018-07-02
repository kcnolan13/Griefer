action_inherited();
///Weapon Constants

//bot weapon selection
varWrite("lethality",-1)
varWrite("range_rating",64*8)
varWrite("range_trump",false)
varWrite("range_trump_distance",64*8)

//graphics
myCursor = cursor_torque
varWrite("sprite",spr_torque)
varWrite("name",global.torque)
varWrite("icon",spr_torque)
varWrite("bullet_icon",icon_bullet_long)
varWrite("pose",global.torque_pose)
varWrite("muzzle_offset",132)
varWrite("scale",global.torque_scale)
varWrite("flash",flash_torque_launch)

varWrite("sound_on",false)

varWrite("traj_gravity",2)
varWrite("traj_rigidity",3)
col_on = global.torque_col
col_off = c_white
varWrite("traj_color",col_off)   //trajectory main color
varWrite("traj_width",3)          //width of main segments
varWrite("traj_resolution",1)    //frames per segment
varWrite("traj_length",64*14)      //trajectory length
varWrite("traj_alpha1",1)         //starting alpha
varWrite("traj_alpha2",1)         //alpha in middle
varWrite("traj_alpha3",0)         //alpha at end
varWrite("traj_highlight",spr_none) //trajectory highlight sprite
//varWrite("traj_highlight_color",c_white)
varWrite("traj_highlight_interval",64*1) //distance between highlights
varWrite("traj_flag",FL_DISAPPEAR)

//engined
varWrite("sound_reload",snd_reload_longshot)
varWrite("is_nade",false)
varWrite("is_secondary",false)

//specs
varWrite("clip_cap",1)
varWrite("clip",varRead("clip_cap"))
varWrite("starting_ammo",4*varRead("clip_cap"))
varWrite("max_ammo",26*varRead("clip_cap"))
varWrite("ammo",varRead("starting_ammo"))
varWrite("reload_time",ceil(0.75*30))

varWrite("charge_delay",30*2.5)
varWrite("charge_weight",2)
varWrite("discharge_delay_max",2)


//shooting mechanics
varWrite("view_scale",1.4)
varWrite("kick",20)
varWrite("bullet",bullet_torque)
varWrite("bullet_speed",62)
varWrite("control_type","left_charge")
varWrite("max_charge_time",30*3.5)
varWrite("cant_shoot_max",3)
varWrite("spread_count",1)
varWrite("spread_swath",0)
varWrite("recoil",15)
//varWrite("handling",1.25)
varWrite("view_shake_duration","short") //short, medium, long
varWrite("view_shake",8)


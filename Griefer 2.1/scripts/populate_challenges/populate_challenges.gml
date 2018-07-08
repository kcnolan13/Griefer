/// @description populate_challenges()
/// @function populate_challenges
printf("POPULATING CHALLENGES...")

//fill with bogus challenges for now
/*for (var p=0; p<14; p++)
{
    blah = instantiate_challenge(floor(random_range(spr_armor_placeholder1+1, spr_armor_placeholder2-0.1)), "Super Duper Challenge", "Do Something Hella Insane While Snorkling...",floor(random_range(0,5)))
    if random(1) > 0.5
    blah.completed = true
}*/

wep_chal_scaler = 100
chal_scaler = 0.25

netvars = ds_map_create()


//COMPETITIVE EXLUSIVE 

blah = instantiate_challenge(spr_longshot, global.longshot, "Get "+string(acc_chal_needed("spr_longshot")) + " Kills with the "+string(global.longshot))
blah.progress_varname = "spr_longshot" blah.is_competitive = true blah.is_challenge = false
blah.xp = wep_chal_scaler*acc_chal_needed("spr_longshot")
blah = instantiate_challenge(spr_shotgun, global.shotgun, "Get "+string(acc_chal_needed("spr_shotgun")) + " Kills with the "+string(global.shotgun))
blah.progress_varname = "spr_shotgun"
blah.xp = wep_chal_scaler*acc_chal_needed("spr_shotgun")
blah = instantiate_challenge(spr_pistol, global.pistol, "Get "+string(acc_chal_needed("spr_pistol")) + " Kills with the "+string(global.pistol))
blah.progress_varname = "spr_pistol"
blah.xp = wep_chal_scaler*acc_chal_needed("spr_pistol")
blah = instantiate_challenge(spr_frag, global.frag, "Get "+string(acc_chal_needed("spr_frag")) + " Kills with the "+string(global.frag))
blah.progress_varname = "spr_frag" blah.is_competitive = true blah.is_challenge = false
blah.xp = wep_chal_scaler*acc_chal_needed("spr_frag")
blah = instantiate_challenge(spr_rifle, global.rifle, "Get "+string(acc_chal_needed("spr_rifle")) + " Kills with the "+string(global.rifle))
blah.progress_varname = "spr_rifle"
blah.xp = wep_chal_scaler*acc_chal_needed("spr_rifle")
blah = instantiate_challenge(spr_flashbang, global.flashbang, "Get "+string(acc_chal_needed("spr_flashbang")) + " Stuns with the "+string(global.flashbang))
blah.progress_varname = "spr_flashbang"
blah.xp = wep_chal_scaler*acc_chal_needed("spr_flashbang")
blah = instantiate_challenge(spr_boom, global.boom, "Get "+string(acc_chal_needed("spr_boom")) + " Kills with the "+string(global.boom))
blah.progress_varname = "spr_boom" blah.is_competitive = true blah.is_challenge = false
blah.xp = wep_chal_scaler*acc_chal_needed("spr_boom")
blah = instantiate_challenge(spr_boltok, global.boltok, "Get "+string(acc_chal_needed("spr_boltok")) + " Kills with the "+string(global.boltok))
blah.progress_varname = "spr_boltok" blah.is_competitive = true blah.is_challenge = false
blah.xp = wep_chal_scaler*acc_chal_needed("spr_boltok")
blah = instantiate_challenge(spr_smoke, global.smoke, "Pop Smoke "+string(acc_chal_needed("spr_smoke")) + " Times")
blah.progress_varname = "spr_smoke" blah.is_competitive = true blah.is_challenge = false
blah.xp = wep_chal_scaler*acc_chal_needed("spr_smoke")
blah = instantiate_challenge(spr_vulcan, global.vulcan, "Get "+string(acc_chal_needed("spr_vulcan")) + " Kills with the "+string(global.vulcan))
blah.progress_varname = "spr_vulcan" blah.is_competitive = true blah.is_challenge = false
blah.xp = wep_chal_scaler*acc_chal_needed("spr_vulcan")
blah = instantiate_challenge(spr_lmg, global.lmg, "Get "+string(acc_chal_needed("spr_lmg")) + " Kills with the "+string(global.lmg))
blah.progress_varname = "spr_lmg" blah.is_competitive = true blah.is_challenge = false
blah.xp = wep_chal_scaler*acc_chal_needed("spr_lmg")
blah = instantiate_challenge(spr_smg, global.smg,"Get "+string(acc_chal_needed("spr_smg")) + " Kills with the "+string(global.smg))
blah.progress_varname = "spr_smg" blah.is_competitive = true blah.is_challenge = false
blah.xp = wep_chal_scaler*acc_chal_needed("spr_smg")
blah = instantiate_challenge(spr_carbine, global.carbine, "Get "+string(acc_chal_needed("spr_carbine")) + " Kills with the "+string(global.carbine))
blah.progress_varname = "spr_carbine" blah.is_competitive = true blah.is_challenge = false
blah.xp = wep_chal_scaler*acc_chal_needed("spr_carbine")
blah = instantiate_challenge(spr_thumper, global.thumper, "Get "+string(acc_chal_needed("spr_thumper")) + " Kills with the "+string(global.thumper))
blah.progress_varname = "spr_thumper" blah.is_competitive = true blah.is_challenge = false
blah.xp = wep_chal_scaler*acc_chal_needed("spr_thumper")
blah = instantiate_challenge(spr_tickler, global.tickler, "Get "+string(acc_chal_needed("spr_tickler")) + " Kills with the "+string(global.tickler))
blah.progress_varname = "spr_tickler" blah.is_competitive = true blah.is_challenge = false
blah.xp = wep_chal_scaler*acc_chal_needed("spr_tickler")
blah = instantiate_challenge(spr_ink, global.ink, "Get "+string(acc_chal_needed("spr_ink")) + " Kills with the "+string(global.ink))
blah.progress_varname = "spr_ink" blah.is_competitive = true blah.is_challenge = false
blah.xp = wep_chal_scaler*acc_chal_needed("spr_ink")
blah = instantiate_challenge(spr_flame, global.flame, "Get "+string(acc_chal_needed("spr_flame")) + " Kills with the "+string(global.flame))
blah.progress_varname = "spr_flame" blah.is_competitive = true blah.is_challenge = false
blah.xp = wep_chal_scaler*acc_chal_needed("spr_flame")
blah = instantiate_challenge(spr_snare, global.snare, "Trap "+string(acc_chal_needed("spr_snare")) + " Players with the "+string(global.snare))
blah.progress_varname = "spr_snare" blah.is_competitive = true blah.is_challenge = false
blah.xp = wep_chal_scaler*acc_chal_needed("spr_snare")
blah = instantiate_challenge(spr_sticky, global.sticky, "Get "+string(acc_chal_needed("spr_sticky")) + " Kills with the "+string(global.sticky))
blah.progress_varname = "spr_sticky" blah.is_competitive = true blah.is_challenge = false
blah.xp = wep_chal_scaler*acc_chal_needed("spr_sticky")
blah = instantiate_challenge(spr_torque, global.torque, "Get "+string(acc_chal_needed("spr_torque")) + " Kills with the "+string(global.torque))
blah.progress_varname = "spr_torque" blah.is_competitive = true blah.is_challenge = false
blah.xp = wep_chal_scaler*acc_chal_needed("spr_torque")
blah = instantiate_challenge(spr_rocket, global.rocket,"Get "+string(acc_chal_needed("spr_rocket")) + " Kills with the "+string(global.rocket))
blah.progress_varname = "spr_rocket" blah.is_competitive = true blah.is_challenge = false
blah.xp = wep_chal_scaler*acc_chal_needed("spr_rocket")
blah = instantiate_challenge(spr_double, global.double, "Get "+string(acc_chal_needed("spr_double")) + " Kills with the "+string(global.double))
blah.progress_varname = "spr_double" blah.is_competitive = true blah.is_challenge = false
blah.xp = wep_chal_scaler*acc_chal_needed("spr_double")
blah = instantiate_challenge(spr_stomper, global.stomper, "Get "+string(acc_chal_needed("spr_stomper")) + " Kills with the "+string(global.stomper))
blah.progress_varname = "spr_stomper" blah.is_competitive = true blah.is_challenge = false
blah.xp = wep_chal_scaler*acc_chal_needed("spr_stomper")

needed = 2
blah = instantiate_challenge(spr_dred_helmet, global.dred_name, "Earn "+string(needed)+" \""+acc_name("6gibs")+"\" "+global.accolade_name)
blah.is_competitive = true blah.is_challenge = false
blah.progress_varname = "6gibs"
blah.xp = 7500*chal_scaler
blah.acc_needed = needed

needed = 30
blah = instantiate_challenge(spr_tadpole_helmet, global.tadpole_name, "Earn "+string(needed)+" \""+acc_name("stick_kill")+"\" "+global.accolade_name+"s")
blah.is_competitive = true blah.is_challenge = false
blah.progress_varname = "stick_kill"
blah.xp = 7500*chal_scaler
blah.acc_needed = needed

needed = 10
blah = instantiate_challenge(spr_rvisor2_helmet, global.fanatic_name, "Earn "+string(needed)+" \""+acc_name("cant_touch_dis")+"\" "+global.accolade_name+"s")
blah.is_competitive = true blah.is_challenge = false
blah.progress_varname = "cant_touch_dis"
blah.xp = 7500*chal_scaler
blah.acc_needed = needed

needed = 3
blah = instantiate_challenge(spr_pyramid_helmet, "Pyramid Head", "Earn "+string(needed)+" \""+acc_name("10ks")+"\" "+global.accolade_name)
blah.is_competitive = true blah.is_challenge = false
blah.progress_varname = "10ks"
blah.xp = 10000*chal_scaler
blah.acc_needed = needed

needed = 10
blah = instantiate_challenge(spr_pimp_hat, "Pimp Hat", "Earn "+string(needed)+" \""+acc_name("mvp")+"\" "+global.accolade_name+"s")
blah.is_competitive = true blah.is_challenge = false
blah.progress_varname = "mvp"
blah.xp = 10000*chal_scaler
blah.acc_needed = needed


//BOT MODE CHALLENGES

needed = 1
blah = instantiate_challenge(spr_longhorn_hat, global.longhorn_name, "Earn "+string(needed)+" \""+acc_name("3ks")+"\" "+global.accolade_name+"s")
blah.progress_varname = "3ks"
blah.xp = 1500*chal_scaler
blah.acc_needed = needed
blah.is_challenge = false
blah.is_bot_mode = true
blah.bot_diff_ind = 3

needed = 1
blah = instantiate_challenge(spr_pvisor2_helmet, global.pvisor2_name, "Earn "+string(needed)+" \""+acc_name("9heads")+"\" "+global.accolade_name+"s")
blah.progress_varname = "9heads"
blah.xp = 4500*chal_scaler
blah.acc_needed = needed
blah.is_challenge = false
blah.is_bot_mode = true
blah.bot_diff_ind = 1

needed = 5
blah = instantiate_challenge(spr_pvisor_helmet, global.pvisor_name, "Earn "+string(needed)+" \""+acc_name("3heads")+"\" "+global.accolade_name+"s")
blah.progress_varname = "3heads"
blah.xp = 7500*chal_scaler
blah.acc_needed = needed
blah.is_challenge = false
blah.is_bot_mode = true
blah.bot_diff_ind = 2

needed = 5
blah = instantiate_challenge(spr_gashog_helmet, global.gashog_name, "Earn "+string(needed)+" \""+acc_name("3gibs")+"\" "+global.accolade_name+"s")
blah.progress_varname = "3gibs"
blah.xp = 5000*chal_scaler
blah.acc_needed = needed
blah.is_bot_mode = true
blah.bot_diff_ind = 2

samurai = instantiate_challenge(spr_samurai_helmet, global.samurai_name, "Earn "+string(1)+" \""+acc_name("15ks")+"\" "+global.accolade_name)
samurai.rewards[1] = spr_samurai_torso
samurai.rewards[2] = spr_samurai_leg
samurai.rewards[3] = spr_samurai_shin
samurai.rewards[4] = spr_samurai_foot
samurai.rewards[5] = spr_samurai_shoulder
samurai.rewards[6] = spr_samurai_forearm
samurai.progress_varname = "15ks"
samurai.xp = 10000*chal_scaler
samurai.acc_needed = 1
samurai.is_challenge = false
samurai.is_bot_mode = true
samurai.bot_diff_ind = 2

needed = 5
blah = instantiate_challenge(spr_ahunch_helmet, "War Mongrel", "Earn "+string(needed)+" \""+acc_name("5ks")+"\" "+global.accolade_name+"s")
blah.progress_varname = "5ks"
blah.xp = 10000*chal_scaler
blah.acc_needed = needed
blah.is_challenge = false
blah.is_bot_mode = true
blah.bot_diff_ind = 2

needed = 5
blah = instantiate_challenge(spr_bhunch_helmet, "Hell Hound", "Earn "+string(needed)+" \""+acc_name("5ks")+"\" "+global.accolade_name+"s")
blah.progress_varname = "5ks"
blah.xp = 10000*chal_scaler
blah.acc_needed = needed
blah.is_challenge = false
blah.is_bot_mode = true
blah.bot_diff_ind = 3


//GENERAL CHALLENGES (COMP OR BOT)

und = instantiate_challenge(spr_underwear_helmet, global.underwear_name, "Die "+string(underwear_deaths)+" Times In A Row")
und.rewards[1] = spr_underwear_torso
und.rewards[2] = spr_underwear_leg
und.rewards[3] = spr_underwear_shin
und.rewards[4] = spr_underwear_foot
und.rewards[5] = spr_underwear_shoulder
und.rewards[6] = spr_underwear_forearm
und.xp = 10
und.acc_needed = underwear_deaths

needed = halo_assists
blah = instantiate_challenge(spr_halo_hat, "Halo", "Earn "+string(needed)+" \""+acc_name("3ass")+"\" "+global.accolade_name)
blah.progress_varname = "3ass"
blah.xp = 5000*chal_scaler
blah.acc_needed = needed

needed = santa_assists
blah = instantiate_challenge(spr_santa_hat, "Santa Hat", "Earn "+string(needed)+" \""+acc_name("3ass")+"\" "+global.accolade_name+"s")
blah.progress_varname = "3ass"
blah.xp = 4000*chal_scaler
blah.acc_needed = needed

blah = instantiate_challenge(spr_bandicoot_helmet, global.bandicoot_name, "Earn "+string(10)+" \""+acc_name("flash_bandicoot")+"\" "+global.accolade_name+"s")
blah.progress_varname = "flash_bandicoot"
blah.xp = 5000*chal_scaler
blah.acc_needed = 10

ass = instantiate_challenge(spr_assassin_helmet, global.ass_name, "Earn "+string(assassin_spree_needed)+" \""+acc_name("3ks")+"\" "+global.accolade_name+"s")
ass.rewards[1] = spr_assassin_torso
ass.rewards[2] = spr_assassin_leg
ass.rewards[3] = spr_assassin_shin
ass.rewards[4] = spr_assassin_foot
ass.rewards[5] = spr_assassin_shoulder
ass.rewards[6] = spr_assassin_forearm
ass.progress_varname = "3ks"
ass.xp = 3000*chal_scaler
ass.acc_needed = assassin_spree_needed

needed = 5
iron = instantiate_challenge(spr_iron_helmet, "Iron", "Earn "+string(needed)+" \""+acc_name("3gibs")+"\" "+global.accolade_name+"s")
iron.rewards[1] = spr_iron_torso
iron.rewards[2] = spr_iron_leg
iron.rewards[3] = spr_iron_shin
iron.rewards[4] = spr_ironboot_foot
iron.rewards[5] = spr_iron_shoulder
iron.rewards[6] = spr_iron_forearm
iron.progress_varname = "3gibs"
iron.xp = 5000*chal_scaler
iron.acc_needed = needed

muscle = instantiate_challenge(spr_muscle_helmet, global.muscle_name, "Earn "+string(near_deaths_needed)+" \""+acc_name("survivor")+"\" "+global.accolade_name+"s")
muscle.rewards[1] = spr_muscle_torso
muscle.rewards[2] = spr_muscle_leg
muscle.rewards[3] = spr_muscle_shin
muscle.rewards[4] = spr_muscle_foot
muscle.rewards[5] = spr_muscle_shoulder
muscle.rewards[6] = spr_muscle_forearm
muscle.progress_varname = "survivor"
muscle.xp = 5000*chal_scaler
muscle.acc_needed = near_deaths_needed

ninja = instantiate_challenge(spr_ninja_helmet, global.ninja_name, "Earn "+string(ninjas_needed)+" \""+acc_name("ninja")+"\" "+global.accolade_name+"s")
ninja.rewards[1] = spr_ninja_torso
ninja.rewards[2] = spr_ninja_leg
ninja.rewards[3] = spr_ninja_shin
ninja.rewards[4] = spr_ninja_foot
ninja.rewards[5] = spr_ninja_shoulder
ninja.rewards[6] = spr_ninja_forearm
ninja.progress_varname = "ninja"
ninja.xp = 2500*chal_scaler
ninja.acc_needed = ninjas_needed

needed = 20
blah = instantiate_challenge(spr_roman_helmet, global.roman_name, "Earn "+string(needed)+" \""+acc_name("3ks")+"\" "+global.accolade_name)
blah.progress_varname = "3ks"
blah.xp = 5000*chal_scaler
blah.acc_needed = needed

needed = 5
blah = instantiate_challenge(spr_hound_helmet, "Hound Helmet", "Earn "+string(needed)+" \""+acc_name("dub_kill")+"\" "+global.accolade_name+"s")
blah.progress_varname = "dub_kill"
blah.xp = 7500*chal_scaler
blah.acc_needed = needed

needed = 10
blah = instantiate_challenge(spr_hound2_helmet, global.hound2_name, "Earn "+string(needed)+" \""+acc_name("dub_kill")+"\" "+global.accolade_name+"s")
blah.acc_needed = needed
blah.progress_varname = "dub_kill"
blah.xp = 10000*chal_scaler

needed = 10
blah = instantiate_challenge(spr_mantel_helmet, global.mantel_name, "Earn "+string(needed)+" \""+acc_name("highest_kd")+"\" "+global.accolade_name+"s")
blah.progress_varname = "highest_kd"
blah.xp = 5000*chal_scaler
blah.acc_needed = needed

needed = 3
blah = instantiate_challenge(spr_mantel2_helmet, global.mantel2_name, "Earn "+string(needed)+" \""+acc_name("15ks")+"\" "+global.accolade_name)
blah.progress_varname = "15ks"
blah.xp = 5000*chal_scaler
blah.acc_needed = needed

needed = 10
helm = instantiate_challenge(spr_glow_helmet, global.glow_name, "Earn "+string(needed)+" \""+acc_name("5ks")+"\" "+global.accolade_name+"s")
helm.rewards[1] = spr_glow_torso
helm.rewards[2] = spr_glow_leg
helm.rewards[3] = spr_glow_foot
helm.rewards[4] = spr_glow_shoulder
helm.rewards[5] = spr_glow_forearm
helm.progress_varname = "5ks"
helm.xp = 10000*chal_scaler
helm.acc_needed = needed


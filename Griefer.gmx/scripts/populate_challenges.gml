///populate_challenges()
printf("POPULATING CHALLENGES...")

//fill with bogus challenges for now
/*for (var p=0; p<14; p++)
{
    blah = instantiate_challenge(floor(random_range(spr_armor_placeholder1+1, spr_armor_placeholder2-0.1)), "Super Duper Challenge", "Do Something Hella Insane While Snorkling...",floor(random_range(0,5)))
    if random(1) > 0.5
    blah.completed = true
}*/

blah = instantiate_challenge(spr_longshot, global.longshot, "Get "+string(acc_chal_needed("spr_longshot")) + " Kills with the "+string(global.longshot))
blah.progress_varname = "spr_longshot"
blah = instantiate_challenge(spr_shotgun, global.shotgun, "Get "+string(acc_chal_needed("spr_shotgun")) + " Kills with the "+string(global.shotgun))
blah.progress_varname = "spr_shotgun"
blah = instantiate_challenge(spr_pistol, global.pistol, "Get "+string(acc_chal_needed("spr_pistol")) + " Kills with the "+string(global.pistol))
blah.progress_varname = "spr_pistol"
blah = instantiate_challenge(spr_frag, global.frag, "Get "+string(acc_chal_needed("spr_frag")) + " Kills with the "+string(global.frag))
blah.progress_varname = "spr_frag"
blah = instantiate_challenge(spr_rifle, global.rifle, "Get "+string(acc_chal_needed("spr_rifle")) + " Kills with the "+string(global.rifle))
blah.progress_varname = "spr_rifle"
blah = instantiate_challenge(spr_flashbang, global.flashbang, "Get "+string(acc_chal_needed("spr_flashbang")) + " Stuns with the "+string(global.flashbang))
blah.progress_varname = "spr_flashbang"
blah = instantiate_challenge(spr_boom, global.boom, "Get "+string(acc_chal_needed("spr_boom")) + " Kills with the "+string(global.boom))
blah.progress_varname = "spr_boom"
blah = instantiate_challenge(spr_boltok, global.boltok, "Get "+string(acc_chal_needed("spr_boltok")) + " Kills with the "+string(global.boltok))
blah.progress_varname = "spr_boltok"
blah = instantiate_challenge(spr_smoke, global.smoke, "Throw "+string(acc_chal_needed("spr_smoke")) + " "+string(global.smoke)+"s")
blah.progress_varname = "spr_smoke"
blah = instantiate_challenge(spr_vulcan, global.vulcan, "Get "+string(acc_chal_needed("spr_vulcan")) + " Kills with the "+string(global.vulcan))
blah.progress_varname = "spr_vulcan"
blah = instantiate_challenge(spr_lmg, global.lmg, "Get "+string(acc_chal_needed("spr_lmg")) + " Kills with the "+string(global.lmg))
blah.progress_varname = "spr_lmg"
blah = instantiate_challenge(spr_smg, global.smg,"Get "+string(acc_chal_needed("spr_smg")) + " Kills with the "+string(global.smg))
blah.progress_varname = "spr_smg"
blah = instantiate_challenge(spr_carbine, global.carbine, "Get "+string(acc_chal_needed("spr_carbine")) + " Kills with the "+string(global.carbine))
blah.progress_varname = "spr_carbine"
blah = instantiate_challenge(spr_thumper, global.thumper, "Get "+string(acc_chal_needed("spr_thumper")) + " Kills with the "+string(global.thumper))
blah.progress_varname = "spr_thumper"
blah = instantiate_challenge(spr_tickler, global.tickler, "Get "+string(acc_chal_needed("spr_tickler")) + " Kills with the "+string(global.tickler))
blah.progress_varname = "spr_tickler"
blah = instantiate_challenge(spr_ink, global.ink, "Get "+string(acc_chal_needed("spr_ink")) + " Kills with the "+string(global.ink))
blah.progress_varname = "spr_ink"
blah = instantiate_challenge(spr_flame, global.flame, "Get "+string(acc_chal_needed("spr_flame")) + " Kills with the "+string(global.flame))
blah.progress_varname = "spr_flame"
blah = instantiate_challenge(spr_snare, global.snare, "Get "+string(acc_chal_needed("spr_snare")) + " Kills with the "+string(global.snare))
blah.progress_varname = "spr_snare"
blah = instantiate_challenge(spr_sticky, global.sticky, "Get "+string(acc_chal_needed("spr_sticky")) + " Kills with the "+string(global.sticky))
blah.progress_varname = "spr_sticky"
blah = instantiate_challenge(spr_torque, global.torque, "Get "+string(acc_chal_needed("spr_torque")) + " Kills with the "+string(global.torque))
blah.progress_varname = "spr_torque"
blah = instantiate_challenge(spr_rocket, global.rocket,"Get "+string(acc_chal_needed("spr_rocket")) + " Kills with the "+string(global.rocket))
blah.progress_varname = "spr_rocket"
blah = instantiate_challenge(spr_double, global.double, "Get "+string(acc_chal_needed("spr_double")) + " Kills with the "+string(global.double))
blah.progress_varname = "spr_double"
blah = instantiate_challenge(spr_stomper, global.stomper, "Get "+string(acc_chal_needed("spr_stomper")) + " Kills with the "+string(global.stomper))
blah.progress_varname = "spr_stomper"

muscle = instantiate_challenge(spr_muscle_helmet, global.muscle_name, "Earn "+string(near_deaths_needed)+" "+acc_name("survivor")+" Medals")
muscle.rewards[1] = spr_muscle_torso
muscle.rewards[2] = spr_muscle_leg
muscle.rewards[3] = spr_muscle_shin
muscle.rewards[4] = spr_muscle_foot
muscle.rewards[5] = spr_muscle_shoulder
muscle.rewards[6] = spr_muscle_forearm
muscle.progress_varname = "survivor"
update_acc_chal_needed("survivor",near_deaths_needed)


ninja = instantiate_challenge(spr_ninja_helmet, global.ninja_name, "Earn "+string(ninjas_needed)+" "+acc_name("ninja")+" Medals")
ninja.rewards[1] = spr_ninja_torso
ninja.rewards[2] = spr_ninja_leg
ninja.rewards[3] = spr_ninja_shin
ninja.rewards[4] = spr_ninja_foot
ninja.rewards[5] = spr_ninja_shoulder
ninja.rewards[6] = spr_ninja_forearm
ninja.progress_varname = "ninja"

ass = instantiate_challenge(spr_assassin_helmet, global.ass_name, "Earn "+string(assassin_spree_needed)+" "+acc_name("3ks")+" Medals")
ass.rewards[1] = spr_assassin_torso
ass.rewards[2] = spr_assassin_leg
ass.rewards[3] = spr_assassin_shin
ass.rewards[4] = spr_assassin_foot
ass.rewards[5] = spr_assassin_shoulder
ass.rewards[6] = spr_assassin_forearm
ass.progress_varname = "3ks"
update_acc_chal_needed("3ks",assassin_spree_needed)

helm = instantiate_challenge(spr_smallvisor2_helmet, global.smallvisor2_name, "Earn "+string(smallvisor2_kills)+" "+acc_name("5ks")+" Medals")
helm.progress_varname = "5ks"
update_acc_chal_needed("5ks",smallvisor2_kills)

samurai = instantiate_challenge(spr_samurai_helmet, global.samurai_name, "Earn "+string(samurai_kills)+" "+acc_name("10ks")+" Medals")
samurai.rewards[1] = spr_samurai_torso
samurai.rewards[2] = spr_samurai_leg
samurai.rewards[3] = spr_samurai_shin
samurai.rewards[4] = spr_samurai_foot
samurai.rewards[5] = spr_samurai_shoulder
samurai.rewards[6] = spr_samurai_forearm
samurai.progress_varname = "10ks"
update_acc_chal_needed("10ks",samurai_kills)

blah = instantiate_challenge(spr_bhunch_helmet, "Hell Hound", "Earn "+string(bhunch_kills)+" "+acc_name("6heads")+" Medals")
blah.progress_varname = "6heads"
update_acc_chal_needed("6heads",bhunch_kills)

blah = instantiate_challenge(spr_ahunch_helmet, "War Mongrel", "Earn "+string(ahunch_kills)+" "+acc_name("6gibs")+" Medals")
blah.progress_varname = "6gibs"
update_acc_chal_needed("6gibs",ahunch_kills)

und = instantiate_challenge(spr_underwear_helmet, global.underwear_name, "Die "+string(underwear_deaths)+" Times In One Match")
und.rewards[1] = spr_underwear_torso
und.rewards[2] = spr_underwear_leg
und.rewards[3] = spr_underwear_shin
und.rewards[4] = spr_underwear_foot
und.rewards[5] = spr_underwear_shoulder
und.rewards[6] = spr_underwear_forearm

iron = instantiate_challenge(spr_iron_helmet, "Iron", "Earn "+string(iron_assists)+" "+acc_name("3gibs")+" Medals")
iron.rewards[1] = spr_iron_torso
iron.rewards[2] = spr_iron_leg
iron.rewards[3] = spr_iron_shin
iron.rewards[4] = spr_ironboot_foot
iron.rewards[5] = spr_iron_shoulder
iron.rewards[6] = spr_iron_forearm
iron.progress_varname = "3gibs"
update_acc_chal_needed("3gibs",iron_assists)

blah = instantiate_challenge(spr_santa_hat, "Santa Hat", "Earn "+string(santa_assists)+" "+acc_name("3ass")+" Medals")
blah.progress_varname = "3ass"
update_acc_chal_needed("3ass",santa_assists)

blah = instantiate_challenge(spr_hound_helmet, "Hound Helmet", "Earn "+string(hound_kills_needed)+" "+acc_name("dub_kill")+" Medals")
blah.progress_varname = "dub_kill"
update_acc_chal_needed("dub_kill",hound_kills_needed)

blah = instantiate_challenge(spr_rvisor2_helmet, "Fanatic Helmet", "Earn "+string(fanatic_kills_needed)+" "+acc_name("trip_kill")+" Medals")
blah.progress_varname = "trip_kill"
update_acc_chal_needed("trip_kill",fanatic_kills_needed)

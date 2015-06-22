///populate_challenges()
printf("POPULATING CHALLENGES...")

//fill with bogus challenges for now
/*for (var p=0; p<14; p++)
{
    blah = instantiate_challenge(floor(random_range(spr_armor_placeholder1+1, spr_armor_placeholder2-0.1)), "Super Duper Challenge", "Do Something Hella Insane While Snorkling...",floor(random_range(0,5)))
    if random(1) > 0.5
    blah.completed = true
}*/

instantiate_challenge(spr_longshot, global.longshot, "Get a Hat Trick with the "+string(global.longshot))
instantiate_challenge(spr_shotgun, global.shotgun, string(shotgun_spree_needed)+" Gib Kills with the "+string(global.shotgun)+" in 2 Seconds")
instantiate_challenge(spr_pistol, global.pistol, string(pistol_headshots_needed)+" Headshots with the "+string(global.pistol)+" in One Match")
instantiate_challenge(spr_frag, global.frag, "Frag Grenade Double Kill")
instantiate_challenge(spr_rifle, global.rifle, string(rifle_kills_needed)+" Kills with the "+string(global.rifle)+" in One Match")
instantiate_challenge(spr_flashbang, global.flashbang, string(flashes_needed) +" Stuns with the "+string(global.flashbang)+" in One Match")
instantiate_challenge(spr_boom, global.boom, string(boom_kills_needed)+" Explosive Kills with the "+string(global.boom)+" in One Match")
instantiate_challenge(spr_boltok, global.boltok, string(boltok_kills_needed)+" Headshots with the "+string(global.boltok)+" in One Match")
instantiate_challenge(spr_smoke, global.smoke, string(smokes_needed)+" smoke clouds with the "+string(global.smoke)+" in One Match")
instantiate_challenge(spr_vulcan, global.vulcan, string(vulcan_kills_needed)+" Kills with the "+string(global.vulcan)+" in One Match")
instantiate_challenge(spr_lmg, global.lmg, string(lmg_kills_needed)+" Kills with the "+string(global.lmg)+" in One Match")
instantiate_challenge(spr_smg, global.smg, string(smg_kills_needed)+" Kills with the "+string(global.smg)+" in One Match")
instantiate_challenge(spr_carbine, global.carbine, string(carbine_kills_needed)+" Kills with the "+string(global.carbine)+" in One Match")
instantiate_challenge(spr_thumper, global.thumper, string(thumper_kills_needed)+" Kills with the "+string(global.thumper)+" in One Match")
instantiate_challenge(spr_tickler, global.tickler, string(tickler_kills_needed)+" Kills with the "+string(global.tickler)+" in One Match")

instantiate_challenge(spr_ink, global.ink, string(ink_kills_needed)+" Kills with the "+string(global.ink)+" in One Match")
instantiate_challenge(spr_flame, global.flame, string(flame_kills_needed)+" Contact Kills with the "+string(global.flame)+" in One Match")
instantiate_challenge(spr_snare, global.snare, string(snare_kills_needed)+" Enemies Trapped with the "+string(global.snare)+" in One Match")
instantiate_challenge(spr_sticky, global.sticky, string(sticky_kills_needed)+" Sticks with the "+string(global.sticky)+" in One Match")
instantiate_challenge(spr_torque, global.torque, string(torque_kills_needed)+" Ricochet Sticks with the "+string(global.torque)+" in One Match")
instantiate_challenge(spr_rocket, global.rocket, string(rocket_kills_needed)+" Explosive Kills with the "+string(global.rocket)+" in One Match")
instantiate_challenge(spr_double, global.double, string(double_spree_needed)+" Gib Kills with the "+string(global.double)+" in 2 Seconds")
instantiate_challenge(spr_stomper, global.stomper, "Get a Hat Trick with the "+string(global.stomper))

muscle = instantiate_challenge(spr_muscle_helmet, global.muscle_name, "Survive a Near-Death-Experience "+string(near_deaths_needed)+" Times In A Single Life")
muscle.rewards[1] = spr_muscle_torso
muscle.rewards[2] = spr_muscle_leg
muscle.rewards[3] = spr_muscle_shin
muscle.rewards[4] = spr_muscle_foot
muscle.rewards[5] = spr_muscle_shoulder
muscle.rewards[6] = spr_muscle_forearm

ninja = instantiate_challenge(spr_ninja_helmet, global.ninja_name, "Take No Damage For "+string(ninja_time_needed/room_speed)+" Sec.")
ninja.rewards[1] = spr_ninja_torso
ninja.rewards[2] = spr_ninja_leg
ninja.rewards[3] = spr_ninja_shin
ninja.rewards[4] = spr_ninja_foot
ninja.rewards[5] = spr_ninja_shoulder
ninja.rewards[6] = spr_ninja_forearm

ass = instantiate_challenge(spr_assassin_helmet, global.ass_name, "Get "+string(assassin_spree_needed)+" Kills Without Dying")
ass.rewards[1] = spr_assassin_torso
ass.rewards[2] = spr_assassin_leg
ass.rewards[3] = spr_assassin_shin
ass.rewards[4] = spr_assassin_foot
ass.rewards[5] = spr_assassin_shoulder
ass.rewards[6] = spr_assassin_forearm

instantiate_challenge(spr_smallvisor2_helmet, global.smallvisor2_name, "Get "+string(smallvisor2_kills)+" Kills Without Dying")

samurai = instantiate_challenge(spr_samurai_helmet, global.samurai_name, "Get "+string(samurai_kills)+" Kills Without Dying")
samurai.rewards[1] = spr_samurai_torso
samurai.rewards[2] = spr_samurai_leg
samurai.rewards[3] = spr_samurai_shin
samurai.rewards[4] = spr_samurai_foot
samurai.rewards[5] = spr_samurai_shoulder
samurai.rewards[6] = spr_samurai_forearm

instantiate_challenge(spr_bhunch_helmet, "Hell Hound", "Get "+string(bhunch_kills)+" Kills Without Dying")
instantiate_challenge(spr_ahunch_helmet, "War Mongrel", "Get "+string(ahunch_kills)+" Kills In One Match")

und = instantiate_challenge(spr_underwear_helmet, global.underwear_name, "Die "+string(underwear_deaths)+" Times In One Match")
und.rewards[1] = spr_underwear_torso
und.rewards[2] = spr_underwear_leg
und.rewards[3] = spr_underwear_shin
und.rewards[4] = spr_underwear_foot
und.rewards[5] = spr_underwear_shoulder
und.rewards[6] = spr_underwear_forearm

iron = instantiate_challenge(spr_iron_helmet, "Iron", "Get "+string(iron_assists)+" Assists In One Match")
iron.rewards[1] = spr_iron_torso
iron.rewards[2] = spr_iron_leg
iron.rewards[3] = spr_iron_shin
iron.rewards[4] = spr_ironboot_foot
iron.rewards[5] = spr_iron_shoulder
iron.rewards[6] = spr_iron_forearm

instantiate_challenge(spr_santa_hat, "Santa Hat", "Get "+string(santa_assists)+" Assists In One Match")

instantiate_challenge(spr_hound_helmet, "Hound Helmet", "Get A Double Kill")

instantiate_challenge(spr_rvisor2_helmet, "Fanatic Helmet", "Get A Triple Kill")

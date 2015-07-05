///find_instrument_of_death(bullet_or_splosion_object_index)
var obj = argument0

//this routine returns the corresponding SPRITE!

var spr = spr_none

if obj = bullet_shotgun               spr = spr_shotgun
else if obj = bullet_double           spr = spr_double
else if obj = bullet_pistol           spr = spr_pistol
else if obj = bullet_long             spr = spr_longshot
else if obj = bullet_stomper          spr = spr_stomper
else if obj = bullet_rifle            spr = spr_rifle
else if obj = bullet_smg              spr = spr_smg
else if obj = bullet_tickler          spr = spr_tickler
else if obj = bullet_lmg              spr = spr_lmg
else if obj = bullet_boltok           spr = spr_boltok
else if obj = bullet_carbine          spr = spr_carbine
else if obj = bullet_vulcan           spr = spr_vulcan
else if obj = bullet_boom             spr = spr_boom
else if obj = splosion_frag           spr = spr_frag
else if obj = splosion_thumper        spr = spr_thumper
else if obj = splosion_flame_instant  spr = spr_flame
else if obj = splosion_flame          spr = spr_flame
else if obj = splosion_sticky         spr = spr_sticky
else if obj = splosion_torque         spr = spr_torque
else if obj = splosion_boom           spr = spr_boom
else if obj = splosion_rocket         spr = spr_rocket
else if obj = splosion_ink            spr = spr_ink

return spr

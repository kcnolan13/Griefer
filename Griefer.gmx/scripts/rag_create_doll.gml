///rag_create_doll(fracture_strength,force,force_direction)
//fracture strength 0 to 1
//force is initial impulse strength
//force_direction is initial impulse direction

var frac_prob = argument0
var force = argument1
var fdir = argument2

var sever_force = force/30

animation_die()
varWrite("animation_index",0)
framely_limb_computations()
calc_limb_draws()

/*if not varRead("arms_posing")
{
    shoulderl_drawx *= varRead("animation_xscale")
    shoulderr_drawx *= varRead("animation_xscale")
    forearml_drawx *= varRead("animation_xscale")
    forearmr_drawx *= varRead("animation_xscale")
}*/

xs[0] = head_drawx           ys[0] = head_drawy             rots[0] = head_drawr               limb_names[0] = global.bpart_limb_types[0]  depths[0] = depth-4
xs[1] = torso_drawx          ys[1] = torso_drawy            rots[1] = torso_drawr              limb_names[1] = global.bpart_limb_types[1]  depths[1] = depth
xs[2] = legl_drawx           ys[2] = legl_drawy             rots[2] = legl_drawr               limb_names[2] = global.bpart_limb_types[2]  depths[2] = depth+5
xs[3] = legr_drawx           ys[3] = legr_drawy             rots[3] = legr_drawr               limb_names[3] = global.bpart_limb_types[2]  depths[3] = depth-1
xs[4] = shinl_drawx          ys[4] = shinl_drawy            rots[4] = shinl_drawr              limb_names[4] = global.bpart_limb_types[3]  depths[4] = depth+4
xs[5] = shinr_drawx          ys[5] = shinr_drawy            rots[5] = shinr_drawr              limb_names[5] = global.bpart_limb_types[3]  depths[5] = depth-2
xs[6] = hat_drawx            ys[6] = hat_drawy              rots[6] = hat_drawr                limb_names[6] = global.bpart_limb_types[4]  depths[6] = depth-5
xs[11] = footl_drawx         ys[11] = footl_drawy           rots[11] = footl_drawr             limb_names[11] = global.bpart_limb_types[7] depths[11] = depth+3
xs[12] = footr_drawx         ys[12] = footr_drawy           rots[12] = footr_drawr             limb_names[12] = global.bpart_limb_types[7] depths[12] = depth-3

//do the arms at xscale 1 always cause there ain't no explanation for why they don't line up with -1
varWrite("animation_xscale",1)
framely_limb_computations()
calc_limb_draws()

xs[7] = shoulderl_drawx      ys[7] = shoulderl_drawy        rots[7] = shoulderl_drawr          limb_names[7] = global.bpart_limb_types[5]  depths[7] = depth+6
xs[8] = shoulderr_drawx      ys[8] = shoulderr_drawy        rots[8] = shoulderr_drawr          limb_names[8] = global.bpart_limb_types[5]  depths[8] = depth-6
xs[9] = forearml_drawx       ys[9] = forearml_drawy         rots[9] = forearml_drawr           limb_names[9] = global.bpart_limb_types[6]  depths[9] = depth+7
xs[10] = forearmr_drawx      ys[10] = forearmr_drawy        rots[10] = forearmr_drawr          limb_names[10] = global.bpart_limb_types[6] depths[10] = depth-6

/*if not varRead("arms_posing")
{
    shoulderl_drawx /= varRead("animation_xscale")
    shoulderr_drawx /= varRead("animation_xscale")
    forearml_drawx /= varRead("animation_xscale")
    forearmr_drawx /= varRead("animation_xscale")
}*/

scale = varRead("animation_scale")

//initialize array of ragdoll pieces to no handle
for (var i=RAG_HEAD; i<= RAG_FOOTR; i++)
{
    rags[i] = NO_HANDLE
}

if is_hatless(varRead(limb_names[0]+"0"))
{
    rag_exclusions[6] = true
    printf("::: adding hat to ragdoll exclusions in rag_create_doll")
}


//create each rag limb
for (var i=0; i<getLength(limb_names); i++)
{
    
    //skip pieces that have been intentionally excluded
    if rag_exclusions[i] continue

    rags[i] = instance_create(x+xs[i],y+ys[i],rag_of_limb_type(limb_names[i]))
    rags[i].depth = depths[i]
    
    printf("::: created rag type: "+string(object_get_name(rags[i].object_index)))
    
    limb_names[i] += "0"
    
    limb_2draw = varRead(limb_names[i])
    limb_2draw = convert_spr_none_to_drawable(limb_2draw,limb_names[i])
    
    rags[i].sprite_index = limb_2draw
    rags[i].scale = scale
    
    if object_index = die_generic
        rags[i].blood_color = varRead("blood_color")
    
    var xsc = varRead("animation_xscale")
    var r = rots[i]
    
    with rags[i] rag_pretransform_fix(xsc,1,r)
    with rags[i] rag_bind_my_fix()
}

//BIND FIXTURES

//bind hat to head
if random(1) > frac_prob*1.5
    rag_bind_limbs(rags[RAG_HEAD],rags[RAG_HAT])
else rag_apply_sever_impulse(rags[6],sever_force,fdir)

//bind head to torso
if random(1) > frac_prob*0.75
    rag_bind_limbs(rags[RAG_TORSO],rags[RAG_HEAD])
else rag_apply_sever_impulse(rags[0],sever_force,fdir)

//bind shoulders to torso
for (var i=0; i<2; i++)
{
    if random(1) > frac_prob*2.5
        rag_bind_limbs(rags[1],rags[7+i])
    else rag_apply_sever_impulse(rags[7+i],sever_force,fdir)
}
    
//bind forearms to shoulders
for (var i=0; i<2; i++)
{
    if random(1) > frac_prob*0.3
        rag_bind_limbs(rags[7+i],rags[9+i])
    else rag_apply_sever_impulse(rags[9+i],sever_force,fdir)
}

//bind legs to torso
for (var i=0; i<2; i++)
{
    if random(1) > frac_prob*2
        rag_bind_limbs(rags[1],rags[2+i])
    else rag_apply_sever_impulse(rags[2+i],sever_force,fdir)
}

//bind shins to legs
for (var i=0; i<2; i++)
{
    if random(1) > frac_prob*0.3
        rag_bind_limbs(rags[2+i],rags[4+i])
    else rag_apply_sever_impulse(rags[4+i],sever_force,fdir)
}

//bind feet to shins
for (var i=0; i<2; i++)
{
    if random(1) > frac_prob*0.3
        rag_bind_limbs(rags[4+i],rags[11+i])
    else rag_apply_sever_impulse(rags[11+i],sever_force,fdir)
}


//apply the hurt force to the torso
rag_apply_death_impulse(rags[RAG_TORSO],force,fdir)

//tell net_manager to focus on the torso rag
if varRead("pName") = objVarRead(net_manager.my_doll,"pName")
{
    net_manager.rag_target = rags[RAG_TORSO]
    net_manager.view_overscaler = view_hview/768
    net_manager.view_overscaler_target = net_manager.view_overscaler_dead
    printf("::: set rag_target to: "+string(varRead("pName")+"'s torso"))
}

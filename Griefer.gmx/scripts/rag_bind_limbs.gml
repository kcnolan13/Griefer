///rag_bind_limbs(base limb, limb that can rotate)
var trunk = argument0
var branch = argument1

if not instance_exists(trunk) or not instance_exists(branch)
    return false

var tobj = trunk.object_index
var bobj = branch.object_index

var tx = 0
var ty = 0
var bx = 0
var by = 0
//actual joint coords -- average of trunk and branch joint coords?
var jx = 0
var jy = 0

var tjoint = 0
var bjoint = 0

var rot_freedom = 45

switch (tobj)
{
    case rag_head:
        rot_freedom = 0
        tjoint = 0
        bjoint = 0
    break
    
    case rag_torso:
        if bobj = rag_head
        {
            rot_freedom = 60
            tjoint = 0
            bjoint = 1
        } else if bobj = rag_leg
        {
            tjoint = 2
            bjoint = 0
        } else if bobj = rag_shoulder
        {
            tjoint = 1
            bjoint = 0
            rot_freedom = 180
        }
    break
    
    case rag_shoulder:
        tjoint = 1
        bjoint = 0
    break
    
    case rag_leg:
        tjoint = 1
        bjoint = 0
    break
    
    case rag_shin:
        tjoint = 1
        bjoint = 0
    break
}

//inform rag objects of bindings (for blood probably)
trunk.is_bound[tjoint] = true
branch.is_bound[bjoint] = true

tx = trunk.x+trigx(point_distance(0,0,trunk.joint_xs[tjoint],trunk.joint_ys[tjoint]),trunk.joint_dirs[tjoint]+trunk.image_angle)//+trunk.image_angoff)//trunk.x+trunk.joint_xs[tjoint]
ty = trunk.y+trigy(point_distance(0,0,trunk.joint_xs[tjoint],trunk.joint_ys[tjoint]),trunk.joint_dirs[tjoint]+trunk.image_angle)//+trunk.image_angoff)//trunk.y+trunk.joint_ys[tjoint]

bx = branch.x+trigx(point_distance(0,0,branch.joint_xs[bjoint],branch.joint_ys[bjoint]),branch.joint_dirs[bjoint]+branch.image_angle)//+trunk.image_angoff)//trunk.x+trunk.joint_xs[tjoint]
by = branch.y+trigy(point_distance(0,0,branch.joint_xs[bjoint],branch.joint_ys[bjoint]),branch.joint_dirs[bjoint]+branch.image_angle)//+trunk.image_angoff)//trunk.y+trunk.joint_ys[tjoint]

jx = average2(tx,bx)
jy = average2(ty,by)

physics_joint_revolute_create(trunk,branch,jx,jy,-1*rot_freedom,rot_freedom,true,0,0,0,false)
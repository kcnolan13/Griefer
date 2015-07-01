///rag_pretransform_fix(xscale,yscale,angle)
xscale = argument0
yscale = argument1
var ang = argument2

scale = scale/2

if object_index != rag_forearm and object_index != rag_shoulder
{
    if xscale = -1
        ang = (-1*ang) mod 360
}
else
{
    if xscale = -1
    {
        ang = (180 - ang) mod 360
        yscale = 1//-1
    }
} 

//transform fixture
for (var i=0; i<getLength(h); i++)
{
    if xscale = -1
      h[i] = -1*h[i]
      
    if yscale = -1
      v[i] = -1*v[i]
    
    //rotate all points about origin by angle
    hor = h[i]
    vor = v[i]
    
    h[i] = trigx(point_distance(0,0,hor,vor),ang+point_direction(0,0,hor,vor))
    v[i] = trigy(point_distance(0,0,hor,vor),ang+point_direction(0,0,hor,vor))
    
    //scale up
    h[i] = scale*h[i]
    v[i] = scale*v[i]
}

//transform joint locations
for (var i=0; i<getLength(joint_xs); i++)
{
    if xscale = -1
        joint_xs[i] = -1*joint_xs[i]
        
    if yscale = -1
      joint_ys[i] = -1*joint_ys[i]
        
    hor = joint_xs[i]
    vor = joint_ys[i]
    
    //rotate all points about origin by angle
    joint_xs[i] = trigx(point_distance(0,0,hor,vor),ang+point_direction(0,0,hor,vor))
    joint_ys[i] = trigy(point_distance(0,0,hor,vor),ang+point_direction(0,0,hor,vor))
    
    joint_xs[i] = scale*joint_xs[i]
    joint_ys[i] = scale*joint_ys[i]
    
    joint_dirs[i] = point_direction(0,0,joint_xs[i],joint_ys[i])
    
}

scale = scale*2

rag_sort_clockwise()
image_angoff = ang

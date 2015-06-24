///rag_apply_sever_impulse(rag_obj,force,force_direction)

var rag = argument0
var f = argument1
var fdir = argument2

var sever_dir = average2(random(360),fdir) mod 360

if not instance_exists(rag) return false

rag.f = f
rag.sever_dir = sever_dir

with rag
{
    physics_apply_impulse(x,y,trigx(f,sever_dir),trigy(f,sever_dir))
    physics_apply_angular_impulse(random_range(-1*f,f))
}

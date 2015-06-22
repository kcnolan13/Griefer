///rag_apply_death_impulse(rag_obj,force,force_direction)
var rag = argument0
var force = argument1
var fdir = argument2

if not instance_exists(rag) return false

rag.force = force
rag.fdir = fdir

with rag
{
    physics_apply_impulse(x,y,trigx(force,fdir),trigy(force,fdir))
}
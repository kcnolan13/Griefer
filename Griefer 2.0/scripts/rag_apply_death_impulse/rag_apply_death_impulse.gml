/// @description rag_apply_death_impulse(rag_obj,force,force_direction)
/// @function rag_apply_death_impulse
/// @param rag_obj
/// @param force
/// @param force_direction
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
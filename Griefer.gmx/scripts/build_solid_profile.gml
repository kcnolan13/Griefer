///build_solid_profile(surface)
var surface_name = argument0
if !surface_exists(surface_name)
{
    printf("failed to build solid profile")
    return false
}

surface_set_target(surface_name);
draw_set_blend_mode(bm_normal)

draw_set_color(c_white)
draw_set_alpha(1)

for (var i=0;i<instance_number(block);i++)
{
    printf("adding block to solid profile")
    ID = instance_find(block,i)
    if ID != noone
    draw_sprite(ID.sprite_index,1,ID.x,ID.y)
}

for (var i=0;i<instance_number(block2);i++)
{
    printf("adding block2 to solid profile")
    ID = instance_find(block2,i)
    if ID != noone
    draw_sprite(ID.sprite_index,1,ID.x,ID.y)
}

draw_set_blend_mode(bm_normal);
surface_reset_target();

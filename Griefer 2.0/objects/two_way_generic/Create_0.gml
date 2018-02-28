/// @description decide state
id_destruct = 0
if !collision_rectangle(x+32-10,y+32-10-64,x+32+10,y+32+10-64,two_way_generic,true,true)
{
    state = "top"
    ID = instance_create(x,y,block2_top)
    ID.sprite_index = sprite_index
    ID.direction = direction
    exit
}

if !collision_rectangle(x+32-10,y+32-10+64,x+32+10,y+32+10+64,two_way_generic,true,true)
{
    state = "bottom"
    exit
}

state = "middle"


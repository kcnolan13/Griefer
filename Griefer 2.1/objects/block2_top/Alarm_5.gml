if collision_rectangle(bbox_left,bbox_top-10,bbox_right,bbox_top-5,block2_top,true,true)
state = "middle"
else
{
    ID = instance_create(x,y,block2_top_true)
    if id_destruct = 1
    ID.id_destruct = 1
    ID.sprite_index = sprite_index
    ID.image_index = image_index
    ID.image_speed = image_speed
    ID.direction = direction
    obtain_block_fixture(sprite_index)
    //instance_destroy()
}


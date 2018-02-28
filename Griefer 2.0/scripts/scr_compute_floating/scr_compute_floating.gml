for (i=0;i<64;i+=8)
{
    ID = collision_rectangle(bbox_left,bbox_bottom-5,bbox_right,bbox_bottom+i,block2,true,false)
    if ID > 1
    {
        if ID.state = "top"
        floating_2way = true
        break
    }
}
///boot_loitering_avatars()
//boot any loitering avatars
if instance_number(avatar) > 1
{
    for (var i=0; i<instance_number(avatar); i++)
    {
        ID = instance_find(avatar,i)
        if not is_my_avatar(ID)
            with ID instance_destroy()
        else
        {
            ID.x = room_width*4/5
            ID.y = 0
        }
    }
}
xpos = argument0
ypos = argument1
obj = argument2

if instance_place(xpos,ypos,block2_top)
{
    for (i=0;i<64;i+=8)
    {
        ID = instance_place(xpos+trigx(i,direction+180),ypos+trigy(i,direction+180),block2_top)
        if ID > 1
        {
            if ID.state = "top"
            return true
        }
    }
}

return false
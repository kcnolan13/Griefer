/// @description set x,y to a reasonable number
if x > room_width*2
{
    printf("::: alarm[3] setting x,y to reasonable numbers")
    varWrite("myX",room_width*1/2)
    varWrite("myY",room_height-5*room_height)
    x = varRead("myX")
    y = varRead("myY")
}


/// @description rag_rain_limbs(number)
/// @function rag_rain_limbs
/// @param number

repeat(argument0)
{
    ID = instance_create(random_range(__view_get( e__VW.XView, 0 )+128,__view_get( e__VW.XView, 0 )+__view_get( e__VW.WView, 0 )-128),random_range(__view_get( e__VW.YView, 0 )+64,__view_get( e__VW.YView, 0 )+328),floor(random_range(rag_head,rag_foot+0.99)))
    ID.sprite_index = random_bpart_limbtype(ID.limb_type)

    ID.scale = random_range(3,6)
    sc = 1
    if random(1) < 0.7
        sc = -1
    with (ID) rag_pretransform_fix(other.sc,1,random(365))
    with (ID) rag_bind_my_fix()
}
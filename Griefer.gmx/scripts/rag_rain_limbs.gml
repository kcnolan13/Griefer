///rag_rain_limbs(number)

repeat(argument0)
{
    ID = instance_create(random_range(view_xview+128,view_xview+view_wview-128),random_range(view_yview+64,view_yview+328),floor(random_range(rag_head,rag_foot+0.99)))
    ID.sprite_index = random_bpart_limbtype(ID.limb_type)

    ID.scale = random_range(3,6)
    sc = 1
    if random(1) < 0.7
        sc = -1
    with (ID) rag_pretransform_fix(other.sc,1,random(365))
    with (ID) rag_bind_my_fix()
}
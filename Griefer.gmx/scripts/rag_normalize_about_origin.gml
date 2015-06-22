///rag_normalize_about_origin

for (var i=0; i<getLength(h); i++)
{
    //normalize about sprite origin
    h[i] -= sprite_xoffset
    v[i] -= sprite_yoffset
}

for (var i=0; i<getLength(joint_xs); i++)
{
    joint_xs[i] -= sprite_xoffset
    joint_ys[i] -= sprite_yoffset
}
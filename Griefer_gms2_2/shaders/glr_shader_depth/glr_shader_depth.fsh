varying vec2 v_vTexcoord;


void main()
{
    if(texture2D(gm_BaseTexture, v_vTexcoord ).a < 1.0)
        discard;
    else
    gl_FragColor = vec4(1.0, 1.0, 1.0, 1.0);
}


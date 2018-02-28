varying vec2 v_vTexcoord;
const float ray = 3.0;
const float ray2 = ray*ray*3.5;
void main()
{
    float dep = texture2D( gm_BaseTexture, v_vTexcoord ).r;
    float ao = 0.0;
    for(float i=-ray; i<=ray; i++){
        for(float j=-ray; j<=ray; j++){
            float dep2 = texture2D(gm_BaseTexture, v_vTexcoord + vec2(i*0.003, j*0.003)).r;
            ao += max(dep2 - dep, 0.0)/ray2;
        }
    }
    gl_FragColor = vec4(0, 0, 0, min(ao, 0.8)); 
}


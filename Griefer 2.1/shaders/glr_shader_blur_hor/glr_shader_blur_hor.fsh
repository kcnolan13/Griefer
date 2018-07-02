varying vec2 v_vTexcoord;

varying vec2 v_blurTexCoords[6];

void main()
{
    
    vec4 col = texture2D(gm_BaseTexture, v_vTexcoord);
    vec4 result_color = vec4(0.0, 0.0, 0.0, col.a);
    result_color += texture2D(gm_BaseTexture, vec2( v_blurTexCoords[ 0].x, max(v_blurTexCoords[ 0].y, 0.0) )) * 0.07;
    result_color += texture2D(gm_BaseTexture, vec2( v_blurTexCoords[ 1].x, max(v_blurTexCoords[ 1].y, 0.0) )) * 0.15;
    result_color += texture2D(gm_BaseTexture, vec2( v_blurTexCoords[ 2].x, max(v_blurTexCoords[ 2].y, 0.0) )) * 0.18;
    result_color += col * 0.2;
    result_color += texture2D(gm_BaseTexture, vec2( v_blurTexCoords[ 3].x, min(v_blurTexCoords[ 3].y, 0.999) )) * 0.18;
    result_color += texture2D(gm_BaseTexture, vec2( v_blurTexCoords[ 4].x, min(v_blurTexCoords[ 4].y, 0.999) )) * 0.15;
    result_color += texture2D(gm_BaseTexture, vec2( v_blurTexCoords[ 5].x, min(v_blurTexCoords[ 5].y, 0.999) )) * 0.07;
    gl_FragColor =  max(col, result_color);  
} 

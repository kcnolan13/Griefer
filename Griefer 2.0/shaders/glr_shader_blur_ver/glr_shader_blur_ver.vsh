attribute vec3 in_Position;                  // (x,y,z)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord; 
varying vec2 v_blurTexCoords[6];

void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
    v_vTexcoord = in_TextureCoord;
 
    v_blurTexCoords[ 0] = v_vTexcoord + vec2( 0.0, -0.012);
    v_blurTexCoords[ 1] = v_vTexcoord + vec2( 0.0, -0.008);
    v_blurTexCoords[ 2] = v_vTexcoord + vec2( 0.0, -0.004);
    v_blurTexCoords[ 3] = v_vTexcoord + vec2( 0.0, 0.004);
    v_blurTexCoords[ 4] = v_vTexcoord + vec2( 0.0, 0.008);
    v_blurTexCoords[ 5] = v_vTexcoord + vec2( 0.0, 0.012);
}
 

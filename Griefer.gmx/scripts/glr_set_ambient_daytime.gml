///glr_set_ambient_daytime(time)
var a = argument0;
var r,g,b, ratio;
if(a <= 0.2){
    //midnight
    ratio = a/0.2;
    r = lerp_real(global.GLR_M_R, global.GLR_S_R, ratio);
    g = lerp_real(global.GLR_M_G, global.GLR_S_G, ratio);
    b = lerp_real(global.GLR_M_B, global.GLR_S_B, ratio);
    global.GLR_DIRECTIONAL_STRENGTH = 0;
}else if(a <= 0.4){
    //sunrise
    ratio = (a-0.2)/0.2;
    r = lerp_real(global.GLR_S_R, global.GLR_N_R, ratio);
    g = lerp_real(global.GLR_S_G, global.GLR_N_G, ratio);
    b = lerp_real(global.GLR_S_B, global.GLR_N_B, ratio);
    global.GLR_DIRECTIONAL_STRENGTH =  lerp_real(0,0.30, ratio);
    global.GLR_DIRECTIONAL_LENGTH = lerp_real(1,0.6, ratio);
}else if(a <= 0.6){
    //noon
    ratio = (a-0.4)/0.2;
    r = lerp_real(global.GLR_N_R, global.GLR_A_R, ratio);
    g = lerp_real(global.GLR_N_G, global.GLR_A_G, ratio);
    b = lerp_real(global.GLR_N_B, global.GLR_A_B, ratio);
    global.GLR_DIRECTIONAL_STRENGTH = lerp_real(0.30,0.60, ratio);
    global.GLR_DIRECTIONAL_LENGTH = lerp_real(0.6,0.25, ratio);
}else if(a <= 0.8){
    //afternoon
    ratio = (a-0.6)/0.2;
    r = lerp_real(global.GLR_A_R, global.GLR_E_R, ratio);
    g = lerp_real(global.GLR_A_G, global.GLR_E_G, ratio);
    b = lerp_real(global.GLR_A_B, global.GLR_E_B, ratio);
    global.GLR_DIRECTIONAL_STRENGTH = lerp_real(0.60,0.75, ratio);
    global.GLR_DIRECTIONAL_LENGTH = lerp_real(0.25,0.4, ratio);
}else{
    //evening
    ratio = (a-0.8)/0.2;
    r = lerp_real(global.GLR_E_R, global.GLR_M_R, ratio);
    g = lerp_real(global.GLR_E_G, global.GLR_M_G, ratio);
    b = lerp_real(global.GLR_E_B, global.GLR_M_B, ratio);
    global.GLR_DIRECTIONAL_STRENGTH  =  lerp_real(0.75, 0, ratio);
    global.GLR_DIRECTIONAL_LENGTH = lerp_real(0.4,1, ratio);
}
global.GLR_DIRECTIONAL_ANGLE = 100+a*275;
global.GLR_AMBIENT_COLOR = make_color_rgb(r, g, b);
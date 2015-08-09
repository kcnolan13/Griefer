//glrtest_get_illumination()


//retrive information about illumination (use only once per frame)
glr_get_illumination_update();

//Player coordinates in screen space
var px = 0//obj_player.x - view_xview;
var py = 0//obj_player.y - view_yview;

var illum = 0;

//Get illumination around the player (5 points)
illum += glr_get_illumination(px, px);
illum += glr_get_illumination(px-16, py-16);
illum += glr_get_illumination(px+16, py-16);
illum += glr_get_illumination(px+16, py+16);
illum += glr_get_illumination(px-16, py+16);

illum /= 5; //mean value

return illum;

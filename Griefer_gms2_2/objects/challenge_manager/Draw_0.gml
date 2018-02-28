/// @description draw challenges text
if (room != rm_menu and room != rm_lobby) or net_manager.menu_mode != "challenges"
    return false
    
draw_set_font(fnt_hud_big)
draw_set_halign(fa_center)
draw_set_valign(fa_bottom)
draw_set_color(c_white)
draw_set_alpha(1)
draw_text(global.challenge_grid_xstart+global.challenge_grid_width*(global.challenge_grid_sep+global.challenge_slot_width)/2, global.challenge_grid_ystart-10, string_hash_to_newline("Progression"))
draw_text(global.challenge_grid_xstart+global.challenge_grid_width*(global.challenge_grid_sep+global.challenge_slot_width)/2, global.challenge_grid_ystart-10+comp_yoff, string_hash_to_newline(global.cmode+" Challenges"))
//draw_text(global.challenge_grid_xstart+global.challenge_grid_width*(global.challenge_grid_sep+global.challenge_slot_width)/2, global.challenge_grid_ystart-10+bot_yoff, global.bmode+" Challenges")
draw_set_color(c_black)
draw_text(global.challenge_grid_xstart+global.challenge_grid_width*(global.challenge_grid_sep+global.challenge_slot_width)/2, global.challenge_grid_ystart-10+chal_yoff, string_hash_to_newline("General Challenges"))


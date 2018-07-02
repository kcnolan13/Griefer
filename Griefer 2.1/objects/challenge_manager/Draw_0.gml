/// @description draw challenges text
if (room != rm_menu and room != rm_lobby) or net_manager.menu_mode != "challenges"
    return false
    
draw_set_font(fnt_hud_big)
draw_set_halign(fa_center)
draw_set_valign(fa_bottom)
draw_set_color(c_white)
draw_set_alpha(1)
var xoff = 0
for (var i=0; i<array_length_1d(global.challenge_grid_names); i++) {
	draw_text(global.challenge_grid_xstart+xoff+global.challenge_grid_widths[i]*(global.challenge_grid_sep+global.challenge_slot_width)/2, global.challenge_grid_ystart-10, string_hash_to_newline(global.challenge_grid_names[i]))
	xoff += global.challenge_grid_widths[i]*(global.challenge_grid_sep+global.challenge_slot_width)+global.challenge_grids_xsep
}

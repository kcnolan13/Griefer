/// @description draw my ish
draw_set_font(fnt)
draw_set_color(col)
if instance_exists(net_manager.local_player)
{
    if objVarRead(net_manager.local_player,"flash_hp") < 50
        draw_set_color(c_black)
}
draw_set_halign(halign)
draw_set_valign(valign)
draw_set_alpha(alpha)

/*if init_as_promoted
{
    printf("::: draw_x = "+string(draw_x)+", draw_y = "+string(draw_y))
}*/

if is_string(txt)
{
    if txt != "" and not drawing_namerank
    {
        if not stuck_yet
            draw_text_ext_transformed(WVIEW/2,HVIEW/2+draw_y,string_hash_to_newline(txt),0,400,scale,scale,0)
        else
            draw_text_ext_transformed(draw_x,draw_y,string_hash_to_newline(txt),0,800,scale,scale,0)
    }
    
}

if image != spr_none
{
    if image.object_index != avatar
    {
        if not stuck_yet
            draw_sprite_ext(image,-1,0+WVIEW/2+draw_x,0+HVIEW/2+draw_y,scale,scale,0,col,alpha)
        else
            draw_sprite_ext(image,-1,draw_x,draw_y,scale,scale,0,col,alpha)
    } else
    {
        if not stuck_yet
            draw_avatar_head(0+WVIEW/2+draw_x,0+HVIEW/2+draw_y,image,0,scale,1,FL_NOBAR)
        else
            draw_avatar_head(draw_x,draw_y,image,0,scale,1,FL_NOBAR)
    }
}

if drawing_namerank and is_real(txt)
{
    var namerank_xoff = 0
    var namerank_name = get_rank_name(txt)
    if halign = fa_center
    {
        namerank_xoff -= get_namerank_width(namerank_name,scale)/2
    }
        if not stuck_yet
            draw_namerank(namerank_name,txt,namerank_xoff+0+WVIEW/2+draw_x,0+HVIEW/2+draw_y,scale,col)
        else
            draw_namerank(namerank_name,txt,namerank_xoff+draw_x,draw_y,scale,col)
}

if drawing_slot
{
    icon = get_rank_unlock_sprite(rank_2unlock)
    disabled = false
    color = get_bpart_color(icon)
    
    if not stuck_yet
        draw_bpart_slot_complete_ext2(id,0+WVIEW/2+draw_x,0+HVIEW/2+draw_y,scale,alpha)
    else
        draw_bpart_slot_complete_ext2(id,draw_x,draw_y,scale,alpha)
}
    
draw_set_alpha(1)

/* */
/*  */

///compute_auto_crop
if auto_crop
{
    var header_width = 0
    var text_width = 0
    var bail = true
    
    if string_length(header_text) > 0 and header_height > 0
    {
        draw_set_font(header_font)
        header_width = string_width(header_text)+2*crop_pad
        bail = false
    }
    
    if string_length(text) > 0
    {
        draw_set_font(font)
        text_width = string_width(text)+2*crop_pad
        bail = false
    }
    
    if not bail
    {
        var temp_width = max(text_width,header_width)
        if temp_width < width
        {
            width = temp_width
            return temp_width
        }
        return -1
    }
}

return -1
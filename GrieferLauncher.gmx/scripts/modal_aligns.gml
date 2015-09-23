///modal_aligns()

left = x
top = y
performed_aligns = true

if halign = fa_center
    left -= width*scale/2
if halign = fa_right
    left -= width*scale/2
    
if valign = fa_center
    top -= height*scale/2
if valign = fa_bottom
    top -= height*scale/2
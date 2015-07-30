///save_setting(gc_ind)
var ind = argument0

var msg = "save_setting"
var setting_name = global.gc[ind,0]
var val_str = global.gc[ind,1]
var val_real = global.gc[ind,1]
var is_sens = global.gc[ind,2]

if is_sens
    val_str = ""
else
    val_real = -69
    
sendBigMessageStrReal2(msg,setting_name,val_str,val_real)
/// @description save_cache()
/// @function save_cache

//save what's in your cache to the server
if room != rm_login and server_found
{
  var len = ds_list_size(global.cache)
  
  var statement = "UPDATE users SET cache='"
  var cache_str = ""
  
  for (var i=0; i<len; i++)
  {
    var item = global.cache[| i]
    if instance_exists(item) and item.object_index = bpart_generic
    {
        cache_str += string(num2string_digits(item.icon,4))+"_"+string(item.source)
        if i < len-1
            cache_str += ","
    }
    else
    {
        printf("ERROR: unknown object found in global.cache")
    }
  }
  statement += cache_str+"'"
  statement += " WHERE username='"+string(objVarRead(net_manager,"pName"))+"';"
  printf(":::"+statement)
  stat_update_string(statement,0,FL_SQL)
  printf("::: SAVED CACHE TO REMOTE SERVER")
}

///hash_string_gml(string)
var str = argument0
var result = 0

result = hash_string_gpp(str)
if net_manager.show_cout
    printf("::: hashed string "+string(str)+" ---> "+string(result))
return result

/*var max_length = 15
//printf("hashing string "+str)
for (i=0; i<string_length(str); i++)
{
    result += power(27,max_length - i - 1)*(1+ord(string_copy(str,i,1))-ord('a'))
}*/
/*
if (string_length(str) = 0) return hash

for (var i=0; i < string_length(str); i++)
{
    var char = ord(string_copy(str,i+1,1))
    result = ((result<<5)-result)+char
    printf(":::intermediary hash: "+string(result))
    result = result & result
    printf(":::after anding: "+string(result))
}

if SPBUG
    printf("HASHED "+str+" ---> "+string(result))
    
if result < 0
    result = result*2
    
printf("::: HASHED "+string(str)+" ---> "+string(abs(result)))
    */

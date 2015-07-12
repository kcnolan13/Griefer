///hash_string(string)
var str = argument0
var result = 5381

/*var max_length = 15
//printf("hashing string "+str)
for (i=0; i<string_length(str); i++)
{
    result += power(27,max_length - i - 1)*(1+ord(string_copy(str,i,1))-ord('a'))
}*/

if (string_length(str) = 0) return hash

for (var i=0; i < string_length(str); i++)
{
    var char = ord(string_copy(str,i+1,1))
    result = ((result<<5)-result)+char
    result = result & result
}

if SPBUG
    printf("HASHED "+str+" ---> "+string(result))
    
if result < 0
    result = result*2
    
return abs(result)

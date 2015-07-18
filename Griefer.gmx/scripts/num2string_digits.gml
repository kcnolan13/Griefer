///num2string_digits(num, num_digits)
var num = argument0
var num_digits = argument1
var result = ""

if num = 0
{
    var temp_ind = 0
    var whiles = 0
    while (temp_ind < num_digits) and whiles < 1000
    {
        whiles++
        result += "0"
        temp_ind ++
    }
    
    if SUPER_DEBUG
        printf(""+num+" ---> "+result)
    
    return result
}

var testNum = power(10,num_digits)

var whiles = 0
while (testNum > 1) and whiles < 1000
{
    whiles++
    testNum /= 10
    if testNum > num
    result += "0"
}

result += string(num)

if SUPER_DEBUG
    printf(""+num+" ---> "+result)
    
return result

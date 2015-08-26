myX = argument0
myY = argument1
obj = argument2

temp = instance_create(myX, myY, obj)
objVarWrite(temp,"uniqueId",random_string(9))

return temp
myX = argument0
myY = argument1
obj = argument2

temp = instance_create(myX, myY, obj)
objVarWrite(temp,"uniqueId",temp.id)

return temp
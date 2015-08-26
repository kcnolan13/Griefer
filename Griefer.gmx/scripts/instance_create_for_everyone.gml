///instance_create_for_everyone(myX,myY,obj)
myX = argument0
myY = argument1
obj = argument2

someVal = random_string(9)

temp = instance_create(myX, myY, obj)
objVarWrite(temp,"uniqueId",string(someVal)) //was temp.id

if net_manager.bot_match
{
    return temp.id
}

//send signal to create this object for all players
objCreate(temp.object_index,objVarRead(temp,"uniqueId"),myX,myY)

//printf("created object with uniqueId = "+objVarRead(temp,"uniqueId"))

//return a handle to the local instance of the object
return temp.id

exit
///create ragdoll

if random(1) > 0.7
	animation_roll()
else if random(1) > 0.5
	animation_walk()
else 
	animation_wall()

//rag_create_doll(0.1,random_range(5,10),random(360))


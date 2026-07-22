Hello and welcome to making rooms with Hellojed. i'll be your host

What is a room? well a room is a long hallway right now that can contain anything, but right now it needs the following things:
	Tilemaps for background, foreground, stairs, ground, etc
	A door at the end
		This transitions the player to the end of the room and into the next one
	A camera path
		This is what the camera follows and frankly the system is really complicated and sucks and I might get rid of it but each room needs one, right now.
	
The best thing to do right now is to just copy Hall_Easy02 

How do I get rooms in the game?
	that's a great question and the best answer is to open up 1_test_hall (the current test level). Click on the LevelGen object and in the inspector notice the "Level Rooms" array
	 drag the room into the "Level Rooms" array and it'll appear in the order 

ENEMIES
	Each room has Easy, Medium, and Hard spawns for enemies. Each floor has an Easy/Medium/Hard enemy array.
	
	Right now levels will generate Easy layouts in early rooms, then Medium, then Hard spawns as the level progresses.
	
	LAYOUTS
		To make layouts, create a node called "EnemySpawnLayouts" and create 3 child nodes called "EasySpawn", "MediumSpawn", and "HardSpawn"
		Under each spawn node, create a marker2D node and place it whereever you want in the level, you can add as many as you want to each layout
		These node2Ds are where the enemies will spawn when the level is generated
	ENEMIES
		on the floor's "LevelGen" node there are now arrays for Easy Enemies, Medium Enemies, and Hard Enemies.
		In Scenes/Entities/Enemies are where the enemies are, you can assign multiple enemies per array
		When an Easy layout is picked by the game, a random enemy from the Easy array is chosen. 
	
	
TODOS:
	Bossfight
	Temp Store
	Transition to next floor
	add giant skull to UI
	The rest of the game T_T

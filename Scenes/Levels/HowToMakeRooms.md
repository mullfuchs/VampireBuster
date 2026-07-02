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
	
TODOS:
	Have different start/mid/end rooms per floor so they can be properly randomized
	The rest of the game T_T

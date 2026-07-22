extends Node
### when the level starts, pick from a selection of levels
### for now levels are stored in arrays 
### place the levels, then the doors and camera things

@export var LevelRooms: Array[PackedScene]

@export var StartingRooms: Array[PackedScene]
@export var EndingRooms: Array[PackedScene]

@export var EasyEnemies: Array[PackedScene]
@export var MediumEnemies: Array[PackedScene]
@export var HardEnemies: Array[PackedScene]

var NextRoomLoc: Vector2
var CameraManager: Node

var doorIndex: int = 0

var EasySpawns: Node
var MediumSpawns: Node
var HardSpawns: Node

enum roomLayout{EASY, MEDIUM, HARD}

# Called when the node enters the scene tree for the first time.
func _ready():
	CameraManager = get_tree().root.get_node("Main/Managers/CameraManager")
	SignalBus.on_level_generated.connect(_generateRoom)
	_generateRoom()
	pass


func _generateRoom() -> void:
	CameraManager.clear_paths()
	## spawn a random starter room
	_spawnRoom(NextRoomLoc, StartingRooms.pick_random())
	
	var NextRoom
	for room in LevelRooms:
		NextRoom = _spawnRoom(NextRoomLoc, room)
		NextRoomLoc = NextRoom.get_node("NextRoom").global_position
	CameraManager.set_start_camera()
	
	### spawn a random ending room
	_spawnRoom(NextRoomLoc, EndingRooms.pick_random())
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _spawnRoom(location: Vector2, room: PackedScene):

	print("Next Room Location" + str(NextRoomLoc))
	var currentRoom = room.instantiate()
	currentRoom.global_position = location
	add_child(currentRoom)
	NextRoomLoc = Vector2(location.x + 1300, location.y)
	var cameraPath = currentRoom.get_node("CameraPath")
	CameraManager.add_path(cameraPath)
	print("Spawned room at " + str(currentRoom.global_position))
	### Connect previous room to current room's door? or just increment the door index
	doorIndex += 1
	var currentDoor = currentRoom.get_node("Door/Door")
	currentDoor.target_camera_path_index = doorIndex
	
	if(currentRoom.get_node("EnemySpawnLayouts") != null):
		_spawnEnemies(currentRoom, doorIndex)
		
	return currentRoom
	
func _spawnEnemies(room: Node, roomIndex: int):
	### need a way to get all the points from a layout
	### how do we determine if a level is spawned with an easy, normal, or hard spawn?
	## right now it escalates from easy to hard as the level progresses but this should be more sophisticated
	var spawns: Node
	var enemy: PackedScene
	
	if (roomIndex >= 3):
		spawns = room.get_node("EnemySpawnLayouts/HardSpawn")
	elif (roomIndex >= 2):
		spawns = room.get_node("EnemySpawnLayouts/MediumSpawn")
	else:
		spawns = room.get_node("EnemySpawnLayouts/EasySpawn")
	
	for spawn: Node in spawns.get_children():
		if (roomIndex >= 3):
			enemy = HardEnemies.pick_random()
		elif (roomIndex >= 2):
			enemy = MediumEnemies.pick_random()
		else:
			enemy = EasyEnemies.pick_random()
		var spawnedEnemy = enemy.instantiate()
		spawnedEnemy.global_position = spawn.global_position
		add_child(spawnedEnemy)
	
	pass
### to add enemies we'll need a few things
### there is gonna be a list of enemy spawn layouts? Each layout has point 2Ds in it. 
### for enemies we'll have easy/medium/and hard. these guys are stored in an array in levelgen. after a layout is picked 

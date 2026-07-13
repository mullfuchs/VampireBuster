extends Node
### when the level starts, pick from a selection of levels
### for now levels are stored in arrays 
### place the levels, then the doors and camera things

@export var LevelRooms: Array[PackedScene]

@export var StartingRooms: Array[PackedScene]
@export var EndingRooms: Array[PackedScene]

var NextRoomLoc: Vector2
var CameraManager: Node

var doorIndex: int = 0

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
	return currentRoom
	### gonna have to put some logic in here for paths
	## get the path, then rename it, then call the "build paths" function somehow
	

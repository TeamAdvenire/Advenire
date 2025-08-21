extends Node2D

@export var spawnPosition: Transform2D
@onready var door: Node2D = $Door

@onready var spawn_pos: Sprite2D = $SpawnPos


func _init() -> void:
	spawnPosition.origin.x = 0
	spawnPosition.origin.y = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawnPosition.origin.x = spawn_pos.position.x
	spawnPosition.origin.y = spawn_pos.position.y
	spawn_pos.queue_free()
	SignalBus.setPlayerPosition.emit(spawnPosition)
	pass # Replace with function body.

func readyThroughDoor():
	print("through door")
	spawnPosition.origin.x = 95
	spawnPosition.origin.y = 15
	
	await ready
	door.closeDoorAnimation()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

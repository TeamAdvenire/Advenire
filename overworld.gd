extends Node2D

@export var spawnPosition: Transform2D
@onready var door: Node2D = $Door

@onready var spawn_pos: Sprite2D = $SpawnPos
@onready var data_layer: TileMapLayer = $"OverworldLayer5 (dataLayer)"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawnPosition.origin.x = spawn_pos.position.x
	spawnPosition.origin.y = spawn_pos.position.y
	spawn_pos.queue_free()
	SignalBus.setPlayerPosition.emit(spawnPosition)
	
	data_layer.self_modulate.a = 0.0
	
	if !SignalBus.is_connected("playerPositionUpdated", playerPositionUpdated):
		SignalBus.playerPositionUpdated.connect(playerPositionUpdated)
	pass # Replace with function body.

func readyThroughDoor():
	print("through door")
	spawnPosition.origin.x = -1160
	spawnPosition.origin.y = -1075
	
	await ready
	door.closeDoorAnimation()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func playerPositionUpdated(newPos: Vector2):

	var tile_coord = data_layer.local_to_map(data_layer.to_local(newPos))
	var tile_data = data_layer.get_cell_tile_data(tile_coord)
	if tile_data:
		var custom_data = tile_data.get_custom_data("FALLING")
		var tile_id = data_layer.get_cell_source_id(tile_coord)
		var polygons = tile_data.get_collision_polygon_points(0, 0)
		
		var is_inside_polygon = false
		
		var local_player_pos = data_layer.to_local(newPos)
		var tile_origin = data_layer.map_to_local(tile_coord)
		var player_pos_in_tile = local_player_pos - tile_origin
		

		if Geometry2D.is_point_in_polygon(player_pos_in_tile, polygons):
			is_inside_polygon = true
			
		
		if is_inside_polygon:
			SignalBus.tileDataStandingOn.emit(SignalBus.tileType.FALLING, custom_data)
	else: 
		SignalBus.tileDataStandingOn.emit(SignalBus.tileType.NONE, 0)

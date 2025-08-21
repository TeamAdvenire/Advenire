extends Area2D

var isDissapearing = false
@export var howFast = 7
@export var offset = Vector2()
@export_range(1,4) var texture = 1
var textures = [Vector2(0,0),Vector2(0,16),Vector2(16,16),Vector2(16,0)]
@onready var grass: Sprite2D = $Grass
func isGrass() -> bool:
	return true# ;)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	offset = Vector2(randf_range(0,12),randf_range(0,12))
	var random = textures.pick_random()
	grass.region_rect = Rect2(random.x,random.y, 16, 16)
	#print(grass.region_rect)
	grass.position = offset
	grass.material = grass.material.duplicate()
	grass.material.set_shader_parameter("offset", randf_range(1,3))
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if isDissapearing: 
		if modulate.a > 0:
			modulate.a -= delta * howFast;
		else:
			self.queue_free()

func doDamage(value) -> int:
	if value > 0:
		isDissapearing = true
		var item = Item.new("Grass", "is grass", "the plains", grass.texture)
		GlobalInventory.addItem(item)
		return 1 
	return 0

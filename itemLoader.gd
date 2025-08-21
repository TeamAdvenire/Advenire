@tool
extends Area2D
class_name ItemController

@onready var sprite_2d: Sprite2D = $Sprite2D

@export var itemReference: GDScript:
	set(value):
		itemReference = value
		if value:
			item = value.new()
			_ready()
		else:
			queue_free()
		

var item: Item

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !item:
		queue_free()
		return
	sprite_2d.texture = item.icon
	name = item.title
		


func _on_body_entered(body: Node2D) -> void:
	if(body.has_method("playerDeath")):
		GlobalInventory.addItem(item)
	queue_free()
	

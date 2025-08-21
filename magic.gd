extends Node
class_name Magic 


enum magic_type {ELEMENTAL, COALESCENCE, CHAOS}

var title: String
var description: String
var type = magic_type.ELEMENTAL
var mp: float 

func _init(title, desc, type, mp) -> void:
	self.title = title
	self.description = desc
	self.type = type
	self.mp = mp

func is_hovering():
	pass;

# function called when cast
func use(direction: Vector2 = Vector2.ZERO):
	pass;


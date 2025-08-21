extends Node
class_name Item

var title: String
var description: String
var origin: String
var icon: Texture

func _init(title, desc, origin, icon) -> void:
	self.title = title
	self.description = desc
	self.origin = origin
	self.icon = icon
	
func use():
	pass
	
func onAdd():
	pass
	
func onRemove():
	pass

func isEquel(item: Item) -> bool:
	return item.title == title # && item.description == description

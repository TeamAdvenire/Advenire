extends Magic
class_name ExampleMagic

func _init() -> void:
	self.title = "Example Chaos"
	self.description = "this is a description"
	self.type = magic_type.CHAOS
	self.mp = 10

func use(direction: Vector2 = Vector2.ZERO):
	print("using magic because it works fine :)")
	SignalBus.pause.emit(false)

func is_hovering():
	pass

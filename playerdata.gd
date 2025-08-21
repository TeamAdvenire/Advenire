@tool
extends Resource
class_name PlayerData

@export var health:float = 100
@export var mana:float = 100

@export var items: Array[GDScript] = []

@export var position:Vector2 = Vector2.ZERO
@export var world:SceneManager.DeScenes = SceneManager.DeScenes.OVERWORLD

# var dir = OS.get_data_dir() # If you ever want to delete your data, uve gotta go to this directory and delete your related files. 
#	print(dir)

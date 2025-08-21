extends Node


const DUNEGON = preload("res://scenes/Dungeon.tscn")
const OVERWORLD = preload("res://scenes/Overworld.tscn")

var current_scene: DeScenes

func sceneOf(scene: DeScenes) -> PackedScene:
	if scene == DeScenes.DUNEGON:
		return DUNEGON
	if scene == DeScenes.OVERWORLD:
		return OVERWORLD
	return null
	
	
enum DeScenes {
	DUNEGON, OVERWORLD
}

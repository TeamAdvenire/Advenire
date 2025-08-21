extends CanvasLayer

@onready var settings_view: Control = $"Settings View"
@onready var credits_view: Control = $"Credits View"
@onready var main_menu_view: Control = $"Main Menu View"
@onready var main: Node2D = $".."

@export var firstSceneLoader := SceneManager.DeScenes.DUNEGON
@export var playerLoader := preload("res://assets/sprites/Player/Player.tscn")
@export var hudLoader := preload("res://assets/UI/hud.tscn")

var menuLoaded = true

var currentScene: Node2D = null
var currentSceneType: SceneManager.DeScenes
var currentPlayer: Node2D = null
var currentHud: CanvasLayer = null

func _ready() -> void:
	if !SignalBus.is_connected("changeScene", onSceneChanged):
		SignalBus.changeScene.connect(onSceneChanged) 
	self.layer = 1000
	print("this is something new")


func _input(event: InputEvent) -> void:
	if event.is_action("Exit") && menuLoaded:
		_on_back_pressed()

func _on_play_pressed() -> void:
	
	var data:PlayerData = load("user://player_data.tres")
	if data:
		firstSceneLoader = data.world

	currentPlayer = playerLoader.instantiate()
	currentHud = hudLoader.instantiate()
	SignalBus.changeScene.emit(firstSceneLoader, closeMenu)

func closeMenu(scene: Node2D):
	menuLoaded = false 
	main_menu_view.visible = false
	main.add_child(currentPlayer)
	main.add_child(currentHud)

func _on_settings_pressed() -> void:
	main_menu_view.visible = false
	settings_view.visible = true


func _on_credits_pressed() -> void:
	main_menu_view.visible = false
	credits_view.visible = true


func _on_back_pressed() -> void:
	main_menu_view.visible = true
	settings_view.visible = false
	credits_view.visible = false

var sceneToGo: PackedScene = null
var callBack: Callable

func onSceneChanged(sceneToGo: SceneManager.DeScenes, midCallBack: Callable) -> void:
	self.callBack = midCallBack
	self.sceneToGo = SceneManager.sceneOf(sceneToGo)
	self.currentSceneType = sceneToGo
	var blackGround = ColorRect.new()
	blackGround.color = Color(0,0,0,0)
	blackGround.set_anchors_preset(Control.PRESET_FULL_RECT)
	add_child(blackGround)
	var tween = get_tree().create_tween()
	tween.tween_property(blackGround, "color", Color.BLACK, 1)
	SignalBus.pause.emit(true)
	tween.tween_callback(halfwayTransition)
	tween.tween_property(blackGround, "color", Color(0,0,0,0), 1)
	tween.tween_callback(blackGround.queue_free)

func halfwayTransition():
	var newScene = sceneToGo.instantiate()
	#if !callBack.is_null():
	callBack.call(newScene)
	if(currentScene != null):
		currentScene.queue_free.call_deferred()
	currentScene = newScene
	main.add_child(currentScene)
	SignalBus.pause.emit(false)
	SceneManager.current_scene = currentSceneType

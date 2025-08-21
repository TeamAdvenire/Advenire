extends Node

signal saveGame() # called to tell everyone to save the game

signal healthChanged(newValue: float) # called when health is changed.
signal playerDied # called when player dies
signal playerRespawn # called when player respawns 
signal setPlayerPosition(position: Transform2D)
signal playerPositionUpdated(position: Vector2)
signal tileDataStandingOn(tileType: tileType, data)

signal manaChanged(newValue: float)
 
signal pause(truefalse: bool) # called when someone wants to pause the game (true = pause, false = unpause)
signal openInventory # called when you want to open the inventory
signal openEquipment # called when you want to open the equipment menu
signal openMagic(truefalse) # called when you want to open the magic menu

signal startGame # called when the "Start Game" button is pressed
signal changeScene(newScene: SceneManager.DeScenes, midCallBack: Callable) #called to tell the scenemanager to load a new scene

signal showDialogue(textToShow: String, name: String) # called to present a diologe option on screen

signal startRadialMenu(magic: Magic) # called to start the "magic menu" with the pointer direction

signal spawnSceneOnPlayer(scene: PackedScene, callback: Callable) # called to spawn a node from the player class

var paused := false

enum tileType {NONE, FALLING}

func _ready():
	if !is_connected("pause", onPaused):
		pause.connect(onPaused) 

var _currentMana: float = 100 :
	set(newValue):
		if(newValue < 0):
			newValue = 0
		if(newValue >= 100):
			newValue = 100
			if _manaTimer:
				_manaTimer.stop()
				_manaTimer.queue_free()
				_manaTimer = null
		elif _manaTimer == null:
			_startManaTimer()
		_currentMana = newValue
		manaChanged.emit(_currentMana)
		
var _manaPerSecond: float = 1
var _manaTimer: Timer

func checkUseMana(ammount) -> bool:
	if(ammount < _currentMana):
		_currentMana -= ammount
		return true
	else: 
		return false

func _startManaTimer() -> void:
	_manaTimer = Timer.new()
	_manaTimer.wait_time = 1.0 # Combo reset Time
	
	add_child(_manaTimer)
	
	_manaTimer.timeout.connect(_onManaTimer);
	_manaTimer.start()

func _onManaTimer() -> void:
	if (!paused):
		_currentMana += _manaPerSecond

func waitForTime(time: float) -> void:
	await get_tree().create_timer(time).timeout
	

func onPaused(trueFalse: bool):
	paused = trueFalse

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		saveGame.emit()
		get_tree().quit() # default behavior

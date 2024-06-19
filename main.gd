extends Node2D

@export var enemy: PackedScene

var memoSpawnRateDecreaseTimer : int = 6000
var srDecrease : int = 0

var memoSpawnRate : int = 10
var sRate : int = 0

var sVariant : int = 0
var sVariantPos = Vector2(0,0)

var screen = Rect2()

func _ready():
	sRate = memoSpawnRate
	screen = get_viewport_rect()
	srDecrease = memoSpawnRateDecreaseTimer
	Weapons.add_weapon(Weapons.arsenal['rocket'])
	$Player/Camera2D/kettle_button.z_index = 100
	$Player/Camera2D/Control.z_index = 100

func _physics_process(delta):
	sRate -= 1
	if sRate <= 0:
		for n in 2:
			var e = enemy.instantiate()
			get_tree().root.add_child(e) 
			_determineSpawnPos()
			e.onSpawn(sVariantPos, n % 2 == 0)
			sRate = memoSpawnRate
			sVariant = (sVariant+1) % 4
			g.enemyCount += 1
	
	srDecrease -= 1
	if srDecrease <= 0:
		srDecrease = memoSpawnRateDecreaseTimer
		if memoSpawnRate > 20:
			memoSpawnRate -= 10

func _determineSpawnPos():
	match sVariant:
		1: sVariantPos = Vector2(screen.size.x-screen.size.x,screen.size.y)
		2: sVariantPos = Vector2(screen.size.x,screen.size.y-screen.size.y)
		3: sVariantPos = Vector2(screen.size.x,screen.size.y)
		_: sVariantPos = Vector2(screen.size.x-screen.size.x,screen.size.y-screen.size.y)

func pause():
	get_tree().paused = true
	$Player/Camera2D/Control.show()

func unpause():
	$Player/Camera2D/Control.hide()
	get_tree().paused = false

func _on_kettle_button_pressed():
	pause()


func _on_to_main_button_pressed():
	unpause()

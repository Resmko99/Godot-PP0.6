extends Node

var weapon = Weapons.arsenal['pistol']
var timer = 0

func init(weapon_new):
	weapon = weapon_new

func _physics_process(delta):
	# shuut.
	if Input.is_action_pressed("left_mouse") && timer == 0:
		var b = weapon.projectile.instantiate()
		get_tree().root.add_child(b) 
		b.init(g.playerPos, weapon.speedMult, weapon.lifetime, weapon.damage, weapon.ohHitEffect)
		timer = weapon.memoReloadTime
		
	# handle reloads
	timer = max(0, timer-1)

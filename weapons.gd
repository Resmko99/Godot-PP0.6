extends Node

class Weapon:
	var speedMult : float = 4
	var lifetime : int = 140
	var damage : float = 3
	#var behavior : GDScript 
	var memoReloadTime = 50
	var projectile : PackedScene = preload("res://player_bullet.tscn")
	var ohHitEffect : String
	
	func _init(
		 speed_new : float = 4,
		 lifetime_new : int = 140,
		 damage_new : float = 3,
		 #behavior_new : GDScript,
		 memoReloadTime_new = 50,
		 projectile_new : PackedScene = preload("res://player_bullet.tscn"),
		 ohHitEffect_new = '',
	):
		speedMult = speed_new
		lifetime = lifetime_new
		damage = damage_new
		#behavior = behavior_new
		memoReloadTime = memoReloadTime_new
		projectile = projectile_new
		ohHitEffect = ohHitEffect_new
		

var arsenal = {
	'pistol' : Weapon.new(),
	'rifle' : Weapon.new(7, 60, 2, 8),
	'rocket' : Weapon.new(5, 200, 5, 60, preload("res://player_bullet.tscn"), 'explosion'),
}

func add_weapon(type):
	var w = preload("res://weapon_pistol.tscn").instantiate()
	get_tree().get_first_node_in_group("players").add_child(w)
	w.init(type)

func hitHandler(attacker, area):
	if area.has_method("onHit"):
		area.onHit(attacker)
		
func applyEffects(effect, pos):
	if effect == 'explosion':
		createExplosion(pos)

func createExplosion(pos):
		var xplo = preload("res://explosion.tscn").instantiate()
		get_tree().root.add_child(xplo)
		xplo.init(pos)
		

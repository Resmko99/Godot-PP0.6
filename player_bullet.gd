extends Area2D

var speedMult : float = 4
var lifetime : int = 140
var damage : float = 3
var behavior : GDScript 
var ohHitEffect : String

func init(pos, spd, l, dmg, effect):
	position = pos
	speedMult = spd
	damage = dmg
	lifetime = l
	ohHitEffect = effect
	look_at(get_global_mouse_position())

func _physics_process(delta):
	position += Vector2(1,0).rotated(rotation) * speedMult
	lifetime -= 1
	if lifetime <= 0:
		_ohHit(null)

func _ohHit(area):
	if ohHitEffect != '':
		Weapons.applyEffects(ohHitEffect, position)
	if area != null:
		Weapons.hitHandler(self, area)
	queue_free()

func _on_area_entered(area):
	if area.is_in_group('enemies'):
		_ohHit(area)

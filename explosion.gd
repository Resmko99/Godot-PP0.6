extends Area2D

var initScale
var damage = 5

func init(pos, s = 0.5):
	initScale = s
	scale *= initScale
	position = pos

func _physics_process(delta):
	scale += Vector2(0.05, 0.05)
	if scale.x >= initScale * 3:
		queue_free()


func _on_area_entered(area):
	Weapons.hitHandler(self, area)

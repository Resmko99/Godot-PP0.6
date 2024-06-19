extends Area2D

var speedmult = 1
var rng = RandomNumberGenerator.new()
var lifetime = 16

func init(pos):
	position = pos

func _ready():
	rotation = rng.randf_range(0.0, 360.0)
	speedmult = rng.randf_range(2.0, 5.0)
	scale = scale * rng.randf_range(5.0, 7.5)

func _physics_process(delta):
	position += Vector2(1,0).rotated(rotation) * speedmult
	lifetime -= 1
	scale *= 0.9
	if lifetime <= 0:
		queue_free()
	


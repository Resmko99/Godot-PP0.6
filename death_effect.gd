extends Area2D
var lifetime = 25
const addScale = 0.07
@export var blood: PackedScene

func init(pos):
	position = pos
	_createBlood()

func _physics_process(delta):
	lifetime -= 1
	scale += Vector2(addScale,addScale)
	rotation += 0.0523599 # 3 degress in radians
	modulate.a -= 0.03
	if (lifetime <= 0):
		queue_free()
	
func _createBlood():
	for n in 5:
		var splash = blood.instantiate()
		get_tree().root.call_deferred("add_child", splash) 
		splash.init(position)

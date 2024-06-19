extends CharacterBody2D
@export var bullet: PackedScene

const speedMult = 1.0

# Godot's _physics_proccess runs 60 times per second, 
# meaning if reload is 30, bullet can be shot twice per second
func _physics_process(delta):
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	position += input_dir * speedMult
	
	# let other entities know player's position 
	# using this global value for lighter calls
	g.playerPos = position
	
	# These here are for testing! 
	# example of siphon ability
	if Input.is_action_just_pressed("ui_accept"): # spacebar
		g.applyReward(g.DropReward.siphon)
		#Weapons.add_weapon(Weapons.arsenal['rocket'])
	# example of creating a pistol weapon

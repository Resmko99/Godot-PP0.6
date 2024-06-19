extends Area2D
@export var speedMult = 0.375

@export var weaknessList = {
	'fire':1,    # burns flesh pretty well. pretty much useless against anything else. applies debuff
	'shock':1,   # shock. kills ethereals and metal pretty well 
	'bullet':1,  # most of the bullets. metal and ethereal are pretty much immune
	'slice':1.5, # whip uses this type of damage. Cuts through flesh and ethereals
	'blunt':1.5, # aka melee. good against armor and metal
}

@export var skinType = {
	'flesh':1,      # flesh monsters 
	'metal':0.5,    # robots. slow, deal a lot of damage
	'armor':0.75,   # dudes in armor. skeletons have this type of armor
	'ethereal':2,   # ghosts. have increased vulnerabilty, because movement is fast and unpredictable
	'godlike':0.10, # bosses. taking all damage equally, but very resistant. debuffs do not apply
}
# Dictionary<g.DropReward, int> Godot devs make it happen god damn it
@export var killReward : Dictionary = {'gSmall': 1}

@export var deathEffect: PackedScene
var hp = 5
var calcPriority = 0
var ticker = 0
var lookingAt : float = 0

func onSpawn(pos, priority : int = 0):
	position = pos
	calcPriority = priority

func _physics_process(delta):
	ticker = (ticker + 1) % 100
	position += Vector2(1,0).rotated(lookingAt) * speedMult 
	# calc priority will determine when to look at player
	if (calcPriority == 0 && ticker%19==0):
		#look_at(g.playerPos)
		# this is a reverse formula - enemies will run away from you~!
		#lookingAt = atan2(position.y - g.playerPos.y, position.x - g.playerPos.x)
		lookingAt = atan2(g.playerPos.y - position.y, g.playerPos.x - position.x)
	elif ticker%13==0:
			#look_at(g.playerPos)
			lookingAt = atan2(g.playerPos.y - position.y, g.playerPos.x - position.x)
	

# When got shot at
func onHit(bullet):
	if (hp > 0):
		hp -= bullet.damage
		if (hp <= 0):
			onDeath()
	
func onDeath(effect : String = ''):
	#if !effect.is_empty():
		#effect
	for entry in killReward:
		#print (str(killReward[entry]))
		for n in killReward[entry]:
			_create(g.rewardItemCreate(g.stringToReward(entry)))
	_create(deathEffect)
	g.enemyCount -= 1
	queue_free()
	
func _create(creation : PackedScene):
	var rng = RandomNumberGenerator.new()

	var obj = creation.instantiate()
	get_tree().root.add_child(obj) 
	obj.init(position + Vector2(rng.randf_range(-4.0, 4.0),rng.randf_range(-4.0, 4.0)))

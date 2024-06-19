extends Area2D

var animProgress = 0
var pullSpeed = -0.1
const _acceleration = 0.007
const _maxSpeed = 0.075
var pickedUp = false
var ogPos = Vector2(0,0)
var pickupOffsetTimer = 1
@export var rewardType : g.DropReward = g.DropReward.gSmall
var itemPriority = 0

func init(pos):
	position = pos

func initPickUp():
	if pickedUp:
		return
	pickupOffsetTimer = RandomNumberGenerator.new().randi_range(1,15)
	ogPos = position
	pickedUp = true
	get_node("CollisionShape2D").set_deferred("disabled",true)

func _physics_process(delta):
	if pickupOffsetTimer>0 && pickedUp:
		pickupOffsetTimer -= 1
	if pickedUp && animProgress < 1 && pickupOffsetTimer <= 0:
		_getToPlayer()
	if animProgress >= 1:
		_onCollected()

# calculate pos to player
func _getToPlayer():
	animProgress = min(animProgress + pullSpeed, 1)
	position = ogPos + (g.playerPos - ogPos) * animProgress
	pullSpeed = min(pullSpeed + _acceleration, _maxSpeed)
	
func _onCollected():
		g.applyReward(rewardType)
		queue_free()

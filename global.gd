extends Node
# number of enemies on screen:

# 850 - prior to changes 17.04.24
# 950 - with 2 enemy priorities
# 1030 - using atan2 to look at the player, instead of using look_at func provided by Godot

var playerPos = Vector2(0,0)
var playerGems = 0
var playerHP = 100
var playerHPMAX = 100
var enemyCount = 0
var maxEnemyBullets = 5
var enemyBulletsOnScreen = 0
var itemPriority = 0
var ingredients = []


enum DropReward {gSmall, gMid, gBig, hp, siphon}

func stringToReward(string : String):
	match string:
		'gMid': return DropReward.gSmall
		'gBig': return DropReward.gSmall
		'hp': return DropReward.gSmall
		'siphon': return DropReward.gSmall
		_: return DropReward.gSmall

func rewardItemCreate(type : DropReward):	
	match type:
		#DropReward.gMid: return preload("res://gem01.tscn")
		#DropReward.gBig: return preload("res://gem02.tscn")
		#DropReward.hp: return preload("res://item_hp.tscn")
		#DropReward.siphon: return preload("res://item_siphon.tscn")
		_: return preload("res://gem00.tscn")
		
func applyReward(type : DropReward):
	match type:
		DropReward.gMid: playerGems += 5
		DropReward.gBig: playerGems += 20
		DropReward.hp: playerHP = min(playerHP + 20, playerHPMAX) 
		DropReward.siphon: callSiphon()
		_: playerGems += 1
		
func callSiphon():
	var entities = get_tree().get_nodes_in_group("drop_reward")
	#var array = entities.find(itemPriority == 0)  
	#print (entities[0].itemPriority)
	#print (array)
	for n in entities:
		n.initPickUp()
	#.initPickUp()

func add_ingredient(ingredient_id):
	ingredients.append(ingredient_id)
	print("Добавлен новый ингридиент с ID: ", ingredient_id)

func get_ingredients():
	return ingredients

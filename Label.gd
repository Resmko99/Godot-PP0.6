extends Label

func _physics_process(delta):
	text = "Gems: " + str(g.playerGems) + "Enemies: " + str(g.enemyCount) 

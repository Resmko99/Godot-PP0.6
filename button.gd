extends TextureButton
class_name CustomSkillNode

@onready var label = $MarginContainer/Label

func update_perk(perk_data, id):
	if perk_data.has("Name"):
		if label != null:
			label.text = perk_data["Name"]["eng"]
		else:
			print("Ошибка: Label не найден для перка ", name)

func _on_pressed():
	var ingridient_in_kettle = get_node("/root/main/Player/Camera2D/Control/ingridient_in_kettle")
	if ingridient_in_kettle != null:
		var new_text = label.text
		if ingridient_in_kettle.text != "":
			ingridient_in_kettle.text += "\n" + new_text
		else:
			ingridient_in_kettle.text = new_text
		
		g.add_ingredient(label.text)
		print(g.ingredients)
	else:
		print("Ошибка: Node 'ingridient_in_kettle' не найден")

func _on_margin_container_mouse_entered():
	pass

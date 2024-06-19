extends Control

var perk_template_scene = preload("res://button.tscn")

func _ready():
	print("Создание кнопок")
	var load_perks = get_node("/root/LoadJson")
	if load_perks == null:
		print("Ошибка: не найден singleton LoadJson!")
		return

	var IngredientsData = load_perks.IngredientsData
	var ActionientsData = load_perks.ActionientsData
	print("Все json подгружены")
	if IngredientsData == null:
		print("Ошибка: IngredientsData не найден в LoadJson!")
		return
	elif ActionientsData == null:
		print("Ошибка: ActionientsData не найден в LoadJson!")
		return
	else:
		print("Все необходимые данные загружены")

	call_deferred("create_perk_buttons", IngredientsData, ActionientsData)

func create_perk_buttons(IngredientsData, ActionientsData):
	var created_perks = {}
	print("Создание кнопок перков")

	for perk_id in IngredientsData.keys():
		create_perk_button(IngredientsData[perk_id], perk_id, created_perks)

	for perk_id in ActionientsData.keys():
		create_perk_button(ActionientsData[perk_id], perk_id, created_perks)

	print("Завершено создание кнопок перков")

func create_perk_button(perk_info, perk_id, created_perks):
	print("Создание кнопки для перка ", perk_id)
	if created_perks.has(perk_id):
		return created_perks[perk_id]

	if not perk_info.has("position_x") or not perk_info.has("position_y"):
		print("Ошибка: Перку '", perk_id, "' не хватает координат позиции!")
		return null

	var new_button = perk_template_scene.instantiate()
	new_button.name = "Button_" + perk_info["Name"]["eng"]
	new_button.set_position(Vector2(perk_info["position_x"], perk_info["position_y"]))

	var label = new_button.get_node("MarginContainer/Label")
	if label == null:
		print("Ошибка: Label не найден для перка ", new_button.name)
	else:
		if "Name" in perk_info and "eng" in perk_info["Name"]:
			label.text = perk_info["Name"]["eng"]
		else:
			label.text = "Perk " + str(perk_id)

	if perk_info.has("icon") and "eng" in perk_info["icon"] and typeof(perk_info["icon"]["eng"]) == TYPE_STRING:
		var icon_path = perk_info["icon"]["eng"]
		var texture = load(icon_path)
		if texture:
			new_button.texture_normal = texture
		else:
			print("Ошибка: Иконка не загружена по пути ", icon_path)
	else:
		print("Ошибка: Иконка не найдена или неверного типа для перка ", new_button.name)

	created_perks[perk_id] = new_button
	add_child(new_button)
	print("Завершено создание кнопки ", perk_id)
	return new_button

extends Node

var IngredientsData = {}
var ActionientsData = {}

var ingredients_file_path = "res://ingrid.json"
var action_file_path = "res://action.json"

func _ready():
	IngredientsData = load_json_file(ingredients_file_path)
	ActionientsData = load_json_file(action_file_path)

func load_json_file(file_path: String) -> Dictionary:
	if FileAccess.file_exists(file_path):
		var data_file = FileAccess.open(file_path, FileAccess.READ)
		if data_file:
			var file_text = data_file.get_as_text()
			data_file.close()

			var json = JSON.new()
			var error_code = json.parse(file_text)

			if error_code == OK:
				return json.get_data()
			else:
				print("Ошибка парсинга файла: %s" % file_path)
		else:
			print("Ошибка открытия файла: %s" % file_path)
	else:
		print("Файл не существует: %s" % file_path)
		
	return {}

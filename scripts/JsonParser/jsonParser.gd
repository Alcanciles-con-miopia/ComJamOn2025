extends Node

class_name JsonParser

# Variables para coger del json.
var json_data = {}
var mapas = []

func _ready():
	_load_maps("res://assets/jsons/maps.json")

func _load_maps(root: String) -> void:
	load_json_data(root)

# Cargar los datos del Json
func load_json_data(file_path: String) -> void:
	var file = FileAccess.open(file_path, FileAccess.READ)
	if  file != null:
		var file_content = file.get_as_text()
		file.close()
		json_data = parse_json(file_content)
		mapas = json_data["Mapas"]
	print("No existe el archivo.")

# Funcion para parsear el JSON
func parse_json(json_string: String) -> Dictionary:
	var json = JSON.new()
	var result = json.parse(json_string)
	if result == OK:
		var data = json.data
		if not typeof(data) == null:
			print("Bien parseado.") # Prints array
			return data
		else:
			print("Me da que no ha sido parseado.")
	return {}

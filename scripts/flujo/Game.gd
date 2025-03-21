extends Scene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	
	pass

func on_enable():
	Global.bgm1.play()
	Global.bgm2.play()
	Global.bgm3.play()
	Global.bgm4.play()
	Global.bgm5.play()
	
	#await get_tree().create_timer(1).timeout
	getJson() # Coger los datos del json.
	get_node("ScenaNieves2/Creador de Celdas").initialize() # Llamar al creador de celdas para que se cree la grid inicial.
	
	# inicializa la pantalla de carga
	get_node("ScenaNieves2/Pantalla de carga").empezar_carga()

func on_disable():
	for i in 5:
		Global.bgm[i].stop()
	pass

# Coger la info del json para las celdas iniciales y las expansiones de la grid.
func getJson() -> void:
	var random: int = Global.random.randf_range(0, 4) # Random entre [0, 4).
	print_debug("Random: ", random)
	for i in JsonParser.json_data["Mapas"][random]["Init"]:
		Global.initialCells.append(Vector2(i["x"], i["y"]))
	for i in JsonParser.json_data["Mapas"][random]["Expansion1"]:
		Global.expansion1.append(Vector2(i["x"], i["y"]))
	for i in JsonParser.json_data["Mapas"][random]["Expansion2"]:
		Global.expansion2.append(Vector2(i["x"], i["y"]))
	for i in JsonParser.json_data["Mapas"][random]["Expansion3"]:
		Global.expansion3.append(Vector2(i["x"], i["y"]))
	for i in JsonParser.json_data["Mapas"][random]["Expansion4"]:
		Global.expansion4.append(Vector2(i["x"], i["y"]))
	Global.expansions = [Global.initialCells, Global.expansion1, Global.expansion2, Global.expansion3, Global.expansion4]

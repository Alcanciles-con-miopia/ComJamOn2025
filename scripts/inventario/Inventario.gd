extends Node

var item = preload("res://scenes/Inventario/PiezaInventario.tscn")

func _ready() -> void:
	Global.evolve.connect(instantiate_inventario)
	Global.evolve.connect(add_piezas)
	instantiate_inventario()

func instantiate_inventario() -> void:
	Global.windowX = DisplayServer.window_get_size().x
	Global.windowY = DisplayServer.window_get_size().y
	
	if get_children():
		for n in get_children():
			remove_child(n)
			n.queue_free()
	
	for i in range(Global.PiezasDesbl):
		instantiate_item(Global.windowX*2/3 - Global.PiezasDesbl * 38 / 2 + 38 * i, i)

func instantiate_item(x_pos, i) -> void:
	var actualPos = Vector2(0,Global.windowY-50)
	actualPos.x = x_pos
	var pieza = item.instantiate()
	pieza.tipo = i
	pieza.rama_conocimiento = Global.FeedbackText[i]
	pieza.global_position = actualPos
	add_child(pieza)

func add_piezas() -> void:
	for i in range(Global.PiezasDesbl-1):
		Global.Inventario[i] += 1

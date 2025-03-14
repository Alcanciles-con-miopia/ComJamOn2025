extends Node

var item = preload("res://scenes/Inventario/PiezaInventario.tscn")

func _ready() -> void:
	Global.evolve.connect(instantiate_inventario)
	Global.evolve.connect(add_piezas)
	instantiate_inventario()

func instantiate_inventario() -> void:
	if get_children():
		for n in get_children():
			remove_child(n)
			n.queue_free()
	
	for i in range(Global.PiezasDesbl):
		Global.windowX = get_window().size.x
		instantiate_item(1152*2/3 - Global.PiezasDesbl * 38 / 2 + 45 * i, i)

func instantiate_item(x_pos, i) -> void:
	var actualPos = Vector2(0,598.0)
	actualPos.x = x_pos
	var pieza = item.instantiate()
	pieza.tipo = i
	pieza.rama_conocimiento = Global.FeedbackText[i]
	pieza.color = Global.FeedbackColor[i]
	pieza.global_position = actualPos
	pieza.icon = Global.casillaTex[i]
	pieza.scale = Vector2(0.03,0.03)
	print(pieza.global_position)
	add_child(pieza)

func add_piezas() -> void:
	for i in range(Global.PiezasDesbl-1):
		Global.Inventario[i] += 1

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
		instantiate_item(Global.windowX*2/3 - Global.PiezasDesbl * 38 / 2 + 45 * i, i)

func instantiate_item(x_pos, i) -> void:
	var actualPos = Vector2(0,Global.windowY)
	actualPos.x = x_pos
	var pieza = item.instantiate()
	pieza.tipo = i
	pieza.rama_conocimiento = Global.FeedbackText[i]
	pieza.color = Global.FeedbackColor[i]
	pieza.global_position = actualPos
	pieza.icon = Global.casillaTex[i]
	pieza.scale = Vector2(0.03,0.03)
	add_child(pieza)

func add_piezas() -> void:
	for i in range(Global.PiezasDesbl-1):
		Global.Inventario[i] += 1


func devolver_Inventario_enter(area: Area2D) -> void:
	if area.get_parent().get_parent().get_script() == preload("res://scripts/Piezas/Pieza.gd"):
		# Anyadir pieza a cantidad del inventario NIEVES AQUI
		area.get_parent().get_parent().preparar_para_eliminar()


func _on_area_devolver_al_inventario_area_exited(area: Area2D) -> void:
	if area.get_parent().get_parent().get_script() == preload("res://scripts/Piezas/Pieza.gd"):
		# quitar pieza a cantidad del inventario NIEVES AQUI
		area.get_parent().get_parent().despreparar_para_eliminar()

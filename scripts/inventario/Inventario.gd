extends Node

var item = preload("res://scenes/Inventario/PiezaInventario.tscn")

func _ready() -> void:
	Global.windowX = DisplayServer.window_get_size().x
	Global.windowY = DisplayServer.window_get_size().y
	
	print(Global.windowX)
	for i in range(Global.PiezasDesbl):
		#instantiate_item((((Global.windowX))/(Global.PiezasDesbl))+(Global.windowX/3) + 40*i, i)
		instantiate_item(Global.windowX*2/3 - Global.PiezasDesbl * 38 / 2 + 38 * i, i)

func instantiate_item(x_pos, i) -> void:
	var actualPos = Vector2(0,Global.windowY-50)
	actualPos.x = x_pos
	var pieza = item.instantiate()
	pieza.tipo = i
	pieza.global_position = actualPos
	add_child(pieza)

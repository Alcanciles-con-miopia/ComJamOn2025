extends Node

var item = preload("res://scenes/Inventario/PiezaInventario.tscn")

func _ready() -> void:
	for i in range(Global.PiezasDesbl):
		instantiate_item((1152/(Global.PiezasDesbl))-50 + 150*i, i)
		
func instantiate_item(x_pos, i) -> void:
	var actualPos = Vector2(0,0)
	actualPos.x = x_pos
	var pieza = item.instantiate()
	pieza.tipo = i
	pieza.global_position = actualPos
	add_child(pieza)

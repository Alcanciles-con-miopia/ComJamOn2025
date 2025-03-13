extends Button
class_name ItemInventario

@export var tipo:Global.TipoPieza

func _ready() -> void:
	pass

var pieza = preload("res://scenes/Piezas/Pieza.tscn")

func _pressed() -> void:
	if Global.Inventario[tipo] > 0:
		# Actualizamos la cantidad
		print(Global.Inventario[tipo])
		Global.Inventario[tipo] = Global.Inventario[tipo]-1

		# Instanciamos la pieza
		var piezaObj = pieza.instantiate()
		get_parent().add_child(piezaObj)
		piezaObj.instantiate_forma(tipo) #con el metodo nuevo podemos ahorrarnos el match creo
	
	else:
		print("no quedan piezas")
	

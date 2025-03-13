extends Button
class_name ItemInventario

@export var tipo:Global.TipoPieza

func _ready() -> void:
	pass

@onready var pieza = $"../../Pieza"

func _pressed() -> void:
	if Global.Inventario[tipo] > 0:
		print(Global.Inventario[tipo])
		match tipo:
			Global.TipoPieza.MEDIO:
				pieza.instantiate_medio()
			Global.TipoPieza.LENGUA:
				pieza.instantiate_lengua()
			Global.TipoPieza.CREATIVO:
				pieza.instantiate_creativo()
			Global.TipoPieza.LOGICA:
				pieza.instantiate_logica()
			Global.TipoPieza.HISTORIA:
				pieza.instantiate_historia()
			Global.TipoPieza.FILOSOFIA:
				pieza.instantiate_filosofia()
				
		Global.Inventario[tipo] = Global.Inventario[tipo]-1
	
	else:
		print("no quedan piezas")

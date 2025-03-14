extends Button
class_name ItemInventario

# para hover:
@export_multiline var rama_conocimiento: String
@onready var label = $PanelContainer/MarginContainer/Label
@onready var panel_container = $PanelContainer

@export var tipo: Global.TipoPieza

@export var color: Color

func _ready() -> void:
	var styleBox: StyleBoxFlat = panel_container.get_theme_stylebox("panel").duplicate()
	panel_container.add_theme_stylebox_override("panel", styleBox)
	styleBox.set("bg_color", color)
	panel_container.visible = false

	label.text = rama_conocimiento

var pieza = preload("res://scenes/Piezas/Pieza.tscn")

func _pressed() -> void:
	if Global.Inventario[tipo] > 0:
		# Actualizamos la cantidad
		print(Global.Inventario[tipo])
		Global.Inventario[tipo] = Global.Inventario[tipo]-1

		# Instanciamos la pieza
		var piezaObj = pieza.instantiate()
		get_node("../../Piezas").add_child(piezaObj)
		piezaObj.instantiate_forma(tipo) #con el metodo nuevo podemos ahorrarnos el match creo
	
	else:
		print("no quedan piezas")
	
func _on_mouse_entered():
	panel_container.visible = true

func _on_mouse_exited():
	panel_container.visible = false

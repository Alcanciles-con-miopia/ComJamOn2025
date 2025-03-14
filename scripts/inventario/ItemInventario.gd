extends Button
class_name ItemInventario

# para hover:
@export_multiline var rama_conocimiento: String
@onready var label = $PanelContainer/MarginContainer/Label
@onready var panel_container = $PanelContainer
@export var color: Color

@export var tipo: Global.TipoPieza

func _ready() -> void:
	var styleBox: StyleBoxFlat = panel_container.get_theme_stylebox("panel").duplicate()
	panel_container.add_theme_stylebox_override("panel", styleBox)
	styleBox.set("bg_color", color)
	panel_container.visible = false
	
	panel_container.pivot_offset = Vector2(0, 150)

	label.text = rama_conocimiento

var pieza = preload("res://scenes/Piezas/Pieza.tscn")

func _pressed() -> void:
	var tween = create_tween()
	
	if Global.Inventario[tipo] > 0:
		tween.tween_property(self, "scale", Vector2(0.08,0.08), 0.08)
		
		var tween2 = create_tween()
		tween2.tween_property(panel_container, "rotation_degrees", -2, 0.08)
		
		# Actualizamos la cantidad
		Global.Inventario[tipo] = Global.Inventario[tipo]-1

		# Instanciamos la pieza
		var piezaObj = pieza.instantiate()
		get_node("../../Piezas").add_child(piezaObj)
		piezaObj.instantiate_forma(tipo) #con el metodo nuevo podemos ahorrarnos el match creo
	
	else:	
		tween.tween_property(self, "scale", Vector2(0.03,0.03), 0.08)
		var tween2 = create_tween()
		tween2.tween_property(panel_container, "rotation_degrees", -2, 0.08)
		print("no quedan piezas")
	
func _on_button_up():
	var tween = create_tween()
	if Global.Inventario[tipo] > 0:
		var tween2 = create_tween()
		tween.tween_property(self, "scale", Vector2(0.08,0.08), 0.1)
		tween2.tween_property(panel_container, "rotation_degrees", -2, 0.08)
	else:
		var tween2 = create_tween()
		tween.tween_property(self, "scale", Vector2(0.03,0.03), 0.1)
		tween2.tween_property(panel_container, "rotation_degrees", -2, 0.08)

func _on_mouse_entered():
	panel_container.visible = true
	var tween = create_tween()
	var tween2 = create_tween()
	
	if Global.Inventario[tipo] > 0:
		tween2.tween_property(panel_container, "rotation_degrees", -5, 0.1)
		tween2.tween_property(panel_container, "scale", Vector2(5,5), 0.1)
		tween.tween_property(self, "scale", Vector2(0.032,0.032), 0.1)
		tween.tween_property(self, "rotation_degrees", 2, 0.1)
		tween2.tween_property(panel_container, "rotation_degrees", -2, 0.2)
	else:
		tween2.tween_property(panel_container, "rotation_degrees", 0, 0.1)
		tween.tween_property(self, "scale", Vector2(0.03,0.03), 0.1)
		tween.tween_property(self, "rotation_degrees", 0, 0.1)
		
func _on_mouse_exited():
	var tween = create_tween()
	var tween2 = create_tween()
	tween2.tween_property(panel_container, "rotation_degrees", 0, 0.1)
	tween.tween_property(self, "scale", Vector2(0.03,0.03), 0.1)
	tween.tween_property(self, "rotation_degrees", 0, 0.1)
	panel_container.visible = false

extends Button
class_name ItemInventario

# para hover:
@export_multiline var rama_conocimiento: String
@onready var label = $PanelContainer/MarginContainer/Label
@onready var panel_container = $PanelContainer
@export var color: Color
@onready var numero = $Numero

@export var tipo: Global.TipoPieza

func _process(delta: float) -> void:
	print_debug(numero.global_position)
	
	# Bonito print eh, como DaniZ.
	#print_debug("Inventario: ",
	#" MEDIO: ", Global.Inventario[Global.TipoPieza.MEDIO],
	#" LENGUA: ", Global.Inventario[Global.TipoPieza.LENGUA],
	#" CREATIVO: ", Global.Inventario[Global.TipoPieza.CREATIVO],
	#" LOGICA: ", Global.Inventario[Global.TipoPieza.LOGICA],
	#" HISTORIA: ", Global.Inventario[Global.TipoPieza.HISTORIA],
	#" FILOSOFIA: ", Global.Inventario[Global.TipoPieza.FILOSOFIA])
	# Para que se ponga transparente si no hay piezas.
	if Global.Inventario[tipo] <= 0:
		modulate = Color(1.0, 1.0, 1.0, 0.5)
	else: # Para que deje de ser transparente.
		modulate = Color(1.0, 1.0, 1.0, 1)
	# Para que aparezcan los numeros de las piezas que quedan con su maximo.
	if numero!= null:
		numero.text = str(Global.Inventario[tipo]) + "/" + str(Global.maxPiezas)

func _ready() -> void:
	var styleBox: StyleBoxFlat = panel_container.get_theme_stylebox("panel").duplicate()
	panel_container.add_theme_stylebox_override("panel", styleBox)
	styleBox.set("bg_color", color)
	panel_container.visible = false

	panel_container.pivot_offset = Vector2(0, 200)

	label.text = rama_conocimiento

var pieza = preload("res://scenes/Piezas/Pieza.tscn")

func _pressed() -> void:
	var tween = create_tween()
	
	if Global.Inventario[tipo] > 0:
		tween.tween_property(self, "scale", Vector2(0.08,0.08), 0.08)
		var tween2 = create_tween()
		tween2.tween_property(panel_container, "rotation_degrees", -2, 0.08)
		
		Global.sfx2.stream = load("res://assets/sounds/recortar/inventory2.wav")
		Global.sfx2.play()
		
		# Instanciamos la pieza
		var piezaObj = pieza.instantiate()
		get_node("../../Piezas").add_child(piezaObj)
		# Si ya hay una pieza la eliminamos.
		if Global.piezaEnInventario != null:
			Global.piezaEnInventario.queue_free() # La elimina.
			# Si hay una pieza de un tipo y la que queremos es de otro tipo le sumamos al inventario de la original.mp3 (temazo)
			if Global.piezaEnInventario.tipo != tipo:
				Global.sumaInventarioPieza(Global.piezaEnInventario.tipo)
				Global.restaInventarioPieza(tipo)
		# Si esta vacio simplemente quitamos.
		else:
			Global.restaInventarioPieza(tipo)

		Global.piezaEnInventario = piezaObj # La pieza del inventario es la nueva.
		piezaObj.instantiate_forma(tipo) #con el metodo nuevo podemos ahorrarnos el match creo
	else:
		tween.tween_property(self, "scale", Vector2(0.03,0.03), 0.08)
		var tween2 = create_tween()
		tween2.tween_property(panel_container, "rotation_degrees", -2, 0.08)
		print_debug("No quedan piezas.")

func _on_button_up():
	var tween = create_tween()
	if Global.Inventario[tipo] > 0:
		var tween2 = create_tween()
		tween.tween_property(self, "scale", Vector2(0.03,0.03), 0.1)
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

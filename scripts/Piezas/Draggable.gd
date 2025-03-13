extends Button
class_name Draggable

var mousePos: Vector2
var posToCenter: Vector2
var enPosicion: bool = false

func _ready() -> void:
	posToCenter = get_parent().global_position - global_position
	scale = (Global.cellSize * Vector2(1,1)) / icon.get_size()

func _on_button_down() -> void:
	if not Global.clicked:
		get_parent().coge()
		Global.clicked = true
	print(name)


func _on_button_up() -> void:
	get_parent().suelta()
	if Global.clicked:
		Global.clicked = false


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent().name == "Celda":
		#print("Ha entrado en celdas vacias")
		if area.get_parent().get_state():
			#print("Puede quedarse")
			enPosicion = true;
	else:
		#print("Ha entrado en algo que no es una celda", area.name)
		pass

extends Button
class_name Draggable

var mousePos: Vector2
var offset: Vector2
var startPos: Vector2
var isThisClicked: bool = false

func _ready() -> void:
	startPos = get_parent().global_position

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		offset = get_global_mouse_position() - get_parent().global_position
	if isThisClicked and event is InputEventMouseMotion:
		get_parent().global_position = (event.position - offset)

func _on_button_down() -> void:
	if not Global.clicked:
		isThisClicked = true
		Global.clicked = true
	print(name)


func _on_button_up() -> void:
	isThisClicked = false
	#get_parent().global_position = startPos
	if Global.clicked:
		Global.clicked = false


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent().name == "Celda":
		print("Ha entrado en celdas vacias")
		if area.get_parent().get_state():
			print("Puede quedarse")
	else:
		print("Ha entrado en algo que no es una celda", area.name)

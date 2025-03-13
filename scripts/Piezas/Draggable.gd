extends Button
class_name Draggable

var mousePos: Vector2
var offset: Vector2
var clicked: bool = false


func _process(delta: float) -> void:	
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		offset = get_global_mouse_position() - get_parent().global_position
	if clicked and event is InputEventMouseMotion:
		get_parent().global_position = (event.position - offset)

func _on_button_down() -> void:
	clicked = not clicked
	print(clicked)

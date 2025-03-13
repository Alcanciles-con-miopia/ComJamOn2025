extends Line2D

#TODO: dividir por secciones (export?), puntos


@export var hide: = true;
var connected_points: Array;
var current_point = 0;

func _ready() -> void:
	print("Size: ", points.size())
	connected_points = points
	if hide: clear_points()
	show_animation()
	
func show_animation() -> void:
	current_point = clamp(current_point, 0, connected_points.size() - 1)
	hide = true;
	#for point in connectedPoints:
	add_point(connected_points[current_point])
	current_point += 1
	#	await get_tree().create_timer(0.1).timeout

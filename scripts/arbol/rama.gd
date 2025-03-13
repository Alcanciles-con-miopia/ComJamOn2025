extends Line2D

#@export var hide: = true;
var full_line: Array;
var next_point = 0;
#@onready var tween = get_tree().create_tween()
var current_point
var next_position

func _ready() -> void:
	print("Line size: ", points.size())
	full_line = points
	clear_points() # points = 0
	
	add_point(full_line[next_point])
	current_point = points[next_point]
	next_point += 1
	
	next_position = full_line[next_point - 1]
	
	
func create_point() -> void:
	next_point = clamp(next_point, 0, full_line.size() - 1)
	add_point(full_line[next_point - 1]) # crea un duplicado del último punto en la línea dibujada
	current_point = points[next_point - 1]
	next_position = full_line[next_point]
	next_point += 1

#func _physics_process(delta: float) -> void:
func _physics_process(delta: float) -> void:
	points[next_point - 1] = points[next_point - 1].lerp(next_position, 0.1)

extends Line2D

# TODO: feedback, puntos por puntuación, animar al iniciar

@export var debug = false;
var full_line: Array;
var next_point = 0;
var next_position

func _ready() -> void:
	#print("Line size: ", points.size())
	full_line = points
	clear_points() # points = 0
	#
	#add_point(full_line[next_point])
	#next_point += 1
	#
	#add_point(full_line[next_point])
	#next_point += 1
	#
	add_point(full_line[next_point])
	next_point += 1
	
	next_position = full_line[next_point - 1]
	#print(full_line)
	
func create_point() -> void:
	add_point(full_line[next_point - 1]) # crea un duplicado del último punto en la línea dibujada

	next_point = clamp(next_point, 0, full_line.size() - 1)
	next_position = full_line[next_point]
	next_point += 1

func delete_point() -> void:
	print("me ejecuto")
	if next_point >= 2:
		next_point -= 1
		remove_point(points.size() - 1)
		next_position = full_line[next_point - 1]
		next_point = clamp(next_point, 1, full_line.size() - 1)
	pass
	

#func _physics_process(delta: float) -> void:
func _physics_process(delta: float) -> void:
	points[next_point - 1] = points[next_point - 1].lerp(next_position, 0.1)

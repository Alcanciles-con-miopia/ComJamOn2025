extends Line2D

#@export var hide: = true;
var full_line: Array;
var next_point = 0;
#@onready var tween = get_tree().create_tween()
var current_point
var next_position
var t = 0.0

func _ready() -> void:
	print("Size: ", points.size())
	full_line = points
	#if hide: 
	clear_points() # points = 0
	
	add_point(full_line[next_point])
	current_point = points[next_point]
	next_point += 1
	
	#add_point(full_line[next_point])
	#current_point = points[next_point]
	#next_point += 1
	
	#add_point(full_line[next_point])
	#current_point = points[next_point]
	#next_point += 1
	
	next_position = full_line[next_point - 1]
	
	
func create_point() -> void:
	next_point = clamp(next_point, 0, full_line.size() - 1)
	add_point(full_line[next_point - 1]) # crea un duplicado del último punto en la línea dibujada
	current_point = points[next_point - 1]
	next_position = full_line[next_point]
	next_point += 1

#func _physics_process(delta: float) -> void:
func _physics_process(delta: float) -> void:
	t += delta * 0.1
	#points[next_point - 1].lerp(next_position, t)
	points[next_point - 1] = points[next_point - 1].lerp(next_position, 0.1)
	#points[next_point - 1] = full_line[next_point - 1].lerp(next_position, delta)
	#self.set_point_position(next_point - 1, next_position * t)
	#pass
	#print("a")
	#t += delta * 0.4
	#tween.interpolate_value(points[current_point].x, 20, t, 10,Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	#points[current_point].lerp(Vector2(2,2) * Vector2(200,200), t)

#func update_last_point(new_pos):
	#self.set_point_position(next_point, new_pos)

extends Line2D

#@export var hide: = true;
var full_line: Array;
var current_point = 0;
@onready var tween = get_tree().create_tween()

func _ready() -> void:
	print("Size: ", points.size())
	full_line = points
	#if hide: 
	clear_points() # points = 0
	add_point(full_line[current_point])
	current_point += 1
	
func show_animation() -> void:
	current_point = clamp(current_point, 0, full_line.size() - 1)
	add_point(full_line[current_point - 1])
	var last_point = points[current_point]
	#print(points)
	#tween.tween_property(self.points, "position", full_line[current_point].position, 0.5)
	tween.tween_property(self, "points[current_point]", full_line[current_point], 0.5)
	#tween.interpolate_value(points[])
	#tween.interpolate_method()
	#hide = true;
	#for point in connectedPoints:
	#add_point(full_line[current_point])
	current_point += 1
	#	await get_tree().create_timer(0.1).timeout

func update_last_point(new_pos):
	self.set_point_position(current_point, new_pos)

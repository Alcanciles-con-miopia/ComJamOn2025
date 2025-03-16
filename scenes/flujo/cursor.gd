extends AnimatedSprite2D

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	frame = 0
	pass

func _process(delta: float) -> void:
	global_position = get_global_mouse_position()
	if (Input.is_action_pressed("mb_left")):
		frame = 1
		
	if (Input.is_action_just_released("mb_left")):
		frame = 0
	pass

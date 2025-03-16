extends Scene


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func on_enable():
	Global.bgm0.stream = load("res://assets/music/mainmenu.mp3")
	Global.bgm0.play()
	pass

func on_disable():
	Global.bgm0.stop()
	pass

func _on_button_button_down() -> void:
	Global.change_scene(Global.Scenes.INTRO)
	pass # Replace with function body.

func _on_button_2_button_down() -> void:
	get_tree().quit()

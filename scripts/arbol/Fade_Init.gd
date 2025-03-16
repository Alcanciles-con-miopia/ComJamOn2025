extends Control

var tween;

func _ready() -> void:
	#modulate = Color.TRANSPARENT
	#tween = get_tree().create_tween()
	#tween.tween_property(self, "modulate", Color.WHITE, 1).set_delay(1)
	pass

func activate():
	modulate = Color.TRANSPARENT
	tween = get_tree().create_tween()
	tween.tween_property(self, "modulate", Color.WHITE, 1).set_delay(1)
	pass

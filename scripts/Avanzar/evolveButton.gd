extends Button
class_name EvolveButton

func _ready() -> void:
		print(Global.CurrentEdad)
		Global.evolve.connect(_pressed)

func _pressed() -> void:
	if Global.CurrentEdad < 5:
		Global.CurrentEdad += 1
		print(Global.CurrentEdad)

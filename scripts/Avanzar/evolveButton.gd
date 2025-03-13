extends Button
class_name EvolveButton

func _ready() -> void:
		print(Global.CurrentEdad)

func _pressed() -> void:
	if Global.CurrentEdad < 4:
		Global.CurrentEdad += 1
		Global.evolve.emit()
	else:
		print("FINAL")

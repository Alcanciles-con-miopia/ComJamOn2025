extends Button
class_name EvolveButton

func _ready() -> void:
	print(Global.CurrentEdad)

func _pressed() -> void:
	$"../Arbol".animate_tree()
	
	_manage_pressed()
	disabled = true
	await get_tree().create_timer(1.5).timeout
	disabled = false

func _manage_pressed() -> void:
	Global.sfx.stream = load("res://assets/sounds/CintaMontaje.ogg")
	Global.sfx.play()
	
	var tween = create_tween()
	tween.tween_property(self, "position", Vector2(394.0, 0.0), 0.2)
	tween.tween_property(self, "position", Vector2(394.0, -120.0), 0.1)
	
	if Global.CurrentEdad < 4:
		Global.CurrentEdad += 1 
		
		# Lo quito para que solo se sumen 1 cada era.
		if Global.CurrentEdad == 1:   # de nino a joven -> +2 ramas
			Global.PiezasDesbl += 2
		
		elif Global.CurrentEdad == 2: # de joven a adulto -> +1 rama
			Global.PiezasDesbl += 1
		
		Global.evolve.emit()
		$"../Creador de Celdas".actualizeMatrix(Global.CurrentEdad) # Para que aparezcan las siguientes.
	else:
		await get_tree().create_timer(2).timeout
		Global.change_scene(Global.Scenes.RESOLUCION)
		print("FINAL")

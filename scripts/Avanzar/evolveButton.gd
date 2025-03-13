extends Button
class_name EvolveButton

func _ready() -> void:
		print(Global.CurrentEdad)

func _pressed() -> void:
	if Global.CurrentEdad < 4:
		Global.CurrentEdad += 1 
		
		if Global.CurrentEdad == 1:   # de nino a joven -> +2 ramas
			Global.PiezasDesbl += 2
			
		elif Global.CurrentEdad == 2: # de joven a adulto -> +1 rama
			Global.PiezasDesbl += 1
		
		Global.evolve.emit()
		$"../Creador de Celdas".actualizeMatrix(Global.CurrentEdad) # Para que aparezcan las siguientes.
	else:
		print("FINAL")

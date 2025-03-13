extends Node

class_name Cell

var state: Global.cellState # Estado en el que esta la celda (vacia, ocupada o no disponible)
var id: Vector2 # Id de la celda.
var visible: bool # Si esta visible o no. // Alomejor se peina // o alomejor no //

# Start de la celda.
func _ready() -> void:
	$CuerpoCelda/ColliderCelda.shape.size.x = Global.cellSize/4
	$CuerpoCelda/ColliderCelda.shape.size.y = Global.cellSize/4
	pass

# Devuelve es estado de la celda.
func get_state() -> bool:
	return state == Global.cellState.EMPTY_STATE

# Cambia el estado de la celda.
func setState(newState: Global.cellState) -> void:
	state = newState

# Permite cambiar la visibilidad de la celda.
func setVisible(newVis: bool) -> void:
	visible = newVis
	var newA: float = 1
	if visible == false:
		newA = 0.3
	#$ImagenCelda.visible = newVis
	$ImagenCelda.modulate.a = newA
	$CuerpoCelda/ColliderCelda.set_deferred("disabled", newVis) # Para que no haga colision.

# Cambia la visibilidad de las celdas. 
# 0-> inisibles, 1->trasnparentes, 2->completamentes visibles
func setVisibilityState(state: int) -> void:
	if state == 0:
		visible = false
		$ImagenCelda.modulate.a = 0
		$CuerpoCelda/ColliderCelda.set_deferred("disabled", true) # Para que no haga colision.
	else: if state == 1:
		visible = false
		$ImagenCelda.modulate.a = 0.3
		$CuerpoCelda/ColliderCelda.set_deferred("disabled", true) # Para que no haga colision.
	else: if state == 2:
		visible = true
		$ImagenCelda.modulate.a = 1
		$CuerpoCelda/ColliderCelda.set_deferred("disabled", false) # Para que haga colision.

# Devuelve el ID de la celda.
func getId() -> Vector2:
	return id

# Settea el ID de la celda.
func setId(newId: Vector2) -> void:
	id = newId

extends Node

class_name Cell

var state: Global.cellState
var id: Vector2
var visible: bool

func _ready() -> void:
	$CuerpoCelda/ColliderCelda.shape.size.x = Global.cellSize
	$CuerpoCelda/ColliderCelda.shape.size.y = Global.cellSize
	pass

func get_state() -> bool:
	return state == Global.cellState.EMPTY_STATE

# Cambia el estado de la celda.
func setState(newState: Global.cellState) -> void:
	state = newState

# Permite cambiar la visibilidad de la celda.
func setVisible(newVis: bool) -> void:
	visible = newVis
	$ImagenCelda.visible = newVis

func getId() -> Vector2:
	return id

func setId(newId: Vector2) -> void:
	id = newId

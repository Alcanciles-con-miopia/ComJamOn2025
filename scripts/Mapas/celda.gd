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

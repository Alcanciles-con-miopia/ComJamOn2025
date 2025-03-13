extends Node

class_name Cell

var state: Global.cellState
var id: Vector2
var visible: bool

func _ready() -> void:
	pass

func get_state() -> bool:
	return state == Global.cellState.EMPTY_STATE

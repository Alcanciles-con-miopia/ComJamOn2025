extends Node2D

class_name CellCreator

var matrix: Array[Array]
var cell = preload("res://scenes/Matrix/celda.tscn")

func _ready():
	_createMatrix()
	pass

# Devuelve la matriz.
func getMatrix()->Array[Array]:
	return matrix
	pass;

# Crea la matriz de juego.
func _createMatrix() -> void:
	for i in range(0, Global.matrixSize.x):
		matrix.append([])
		for j in range(0, Global.matrixSize.y):
			var cellObj = cell.instantiate()
			cellObj.position.x = Global.cellInitPos.x + i * Global.cellSize + Global.cellOfset
			cellObj.position.y = Global.cellInitPos.y + j * Global.cellSize + Global.cellOfset
			$".".add_child(cellObj)
			print("hola", " ", i, " ", j)
	print($".".get_child_count())

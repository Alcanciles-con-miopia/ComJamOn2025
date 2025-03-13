extends Node2D

class_name CellCreator

var matrix: Array # matrix va [col][fil]
var cell = preload("res://scenes/Matrix/celda.tscn")

func _ready():
	_createMatrix()
	matrix[0][1].position.y += 50
	matrix[5][0].position.y += 50
	pass

# Devuelve la matriz.
func getMatrix()->Array:
	return matrix
	pass

func  _process(delta: float) -> void:
	
	pass

# Crea la matriz de juego.
func _createMatrix() -> void:
	for i in range(0, Global.matrixSize.x):
		matrix.append([])
		for j in range(0, Global.matrixSize.y):
			matrix.append([])
			var cellObj = cell.instantiate()
			cellObj.position.x = Global.cellInitPos.x + i * Global.cellSize + Global.cellOfset
			cellObj.position.y = Global.cellInitPos.y + j * Global.cellSize + Global.cellOfset
			matrix[i].append(cellObj) 
			$".".add_child(cellObj)
			print("hola", " ", i, " ", j)
	print($".".get_child_count())

extends Node2D

class_name CellCreator

var matrix: Array[Array]
var matrix_x = 2 # En numero que sea
var matrix_y = 2 # El numero que sea
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
	for i in range(0, matrix_x):
		matrix.append([])
		for j in range(0, matrix_y):
			var cellObj = cell.instantiate()
			cellObj.position.x=20+i*300
			cellObj.position.y=20+j*300
			$".".add_child(cellObj)
			print("hola", " ", i, " ", j)
	print($".".get_child_count())

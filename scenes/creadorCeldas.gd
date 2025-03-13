extends Node2D

class_name CellCreator

var matrix: Array # Matrix va [col][fil]
var cell = preload("res://scenes/Matrix/celda.tscn")

func _ready():
	_createMatrix()
	# Probando metodos de celda.gd
	matrix[0][1].position.y += 50
	matrix[5][0].position.x += 50
	matrix[4][2].setVisible(false)
	print(" Prueba id celda",matrix[2][3].getId())
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
			cellObj.setId(Vector2(i, j))
			matrix[i].append(cellObj) 
			$".".add_child(cellObj)
			print("Celda: ", " ", i, " ", j)
	print("Num celdas: ", $".".get_child_count())

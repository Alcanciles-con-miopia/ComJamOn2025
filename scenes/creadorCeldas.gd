extends Node2D

class_name CellCreator

var matrix: Array # Matrix va [col][fil]
var cell = preload("res://scenes/Matrix/celda.tscn")

# Start del creador de celdas.
func _ready():
	pass
	
func initialize() -> void:
	_createMatrix()
	print(matrix[0][0].getId())
	actualizeMatrix(0)

# Devuelve la matriz.
func getMatrix()->Array:
	return matrix
	pass

# Update de la celda.
func  _process(delta: float) -> void:
	
	pass

# Crea la matriz de juego.
func _createMatrix() -> void:
	for i in range(0, Global.matrixSize.x):
		matrix.append([])
		for j in range(0, Global.matrixSize.y):
			matrix.append([])
			var cellObj = cell.instantiate()
			cellObj.position.x = Global.cellInitPos.x + i * Global.cellSize + Global.cellOfset # Pos x.
			cellObj.position.y = Global.cellInitPos.y + j * Global.cellSize + Global.cellOfset # Pos y.
			
			cellObj.setId(Vector2(i, j)) # El id de la celda.
			
			if Global.debugUnlockAllCells: # // DEBUG //
				cellObj.setVisibilityState(0) # Celdas invisibles.
			
			cellObj.setState(Global.cellState.NOT_VALID_STATE) # Pone el estado inicial.
			
			matrix[i].append(cellObj)
			$".".add_child(cellObj)
			#print("Celda: ", " ", i, " ", j)
	#print("Num celdas: ", $".".get_child_count())

# Actualiza las casillas de la matriz dado el indice en el array de expansiones. Si no es la ultima expansion, muestra la siguientes celdas trasnparentes.
func actualizeMatrix(index: int) -> void:
	var newExpansion = Global.expansions[index]
	# Recorre las celdas de la matriz que estan en el array de expansion.
	for i in range(0, newExpansion.size()):
		matrix[newExpansion[i].x][newExpansion[i].y].setVisibilityState(2)
		matrix[newExpansion[i].x][newExpansion[i].y].setState(Global.cellState.EMPTY_STATE)
		#########################
		#  sonido animar
		#########################
		await get_tree().create_timer(0.05).timeout
	# Tanda siguiente de celdas si no es la ultima expansion.
	if index < 4:
		var nextExpansion = Global.expansions[index + 1]
		for i in range(0, nextExpansion.size()):
			matrix[nextExpansion[i].x][nextExpansion[i].y].setVisibilityState(1)
			await get_tree().create_timer(0.02).timeout

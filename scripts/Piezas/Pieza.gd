extends Control

@export var tipo:Global.TipoPieza
var modulo = preload("res://scenes/Piezas/modulo_pieza.tscn")

var offset: Vector2
var isThisClicked: bool = false
var clikcDer: bool = false

func _ready() -> void:
	Global.evolve.connect(bloquear_pieza)

func _input(event: InputEvent) -> void:
	# Click derecho rota la pieza
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.is_pressed() and clikcDer:
		rotation += PI/2;
	
	if event is InputEventMouseButton:
		offset = get_global_mouse_position() - global_position
	if isThisClicked and event is InputEventMouseMotion:
		global_position = (event.position - offset)

func instantiate_forma(tipoPieza: Global.TipoPieza) -> void:
	tipo = tipoPieza
	match tipo:
		Global.TipoPieza.MEDIO:
			instantiate_medio()
		Global.TipoPieza.LENGUA:
			instantiate_lengua()
		Global.TipoPieza.CREATIVO:
			instantiate_creativo()
		Global.TipoPieza.LOGICA:
			instantiate_logica()
		Global.TipoPieza.HISTORIA:
			instantiate_historia()
		Global.TipoPieza.FILOSOFIA:
			instantiate_filosofia()

func instantiate_medio() -> void:
	var actualPos = Vector2(0,0)
	# arriba derecha
	actualPos.x = actualPos.x - Global.cellSize
	var mod = modulo.instantiate()
	mod.global_position = actualPos
	add_child(mod)
	# arriba izquierda
	actualPos.x += Global.cellSize
	mod = modulo.instantiate()
	mod.global_position = actualPos
	add_child(mod)	
	# abajo derecha
	actualPos.y -= Global.cellSize
	mod = modulo.instantiate()
	mod.global_position = actualPos
	add_child(mod)
	# abajo izquierda
	actualPos.x -= Global.cellSize
	mod = modulo.instantiate()
	mod.global_position = actualPos
	add_child(mod)
func instantiate_lengua() -> void:
	# De arriba a abajo
	# 1
	var actualPos = Vector2(0,0)
	actualPos.x = actualPos.x - (Global.cellSize / 2)
	actualPos.y = actualPos.y + Global.cellSize
	var mod = modulo.instantiate()
	mod.global_position = actualPos
	add_child(mod)
	# 2
	actualPos.y -= Global.cellSize
	mod = modulo.instantiate()
	mod.global_position = actualPos
	add_child(mod)
	# 3
	actualPos.y -= Global.cellSize
	mod = modulo.instantiate()
	mod.global_position = actualPos
	add_child(mod)
	# 4
	actualPos.y -= Global.cellSize
	mod = modulo.instantiate()
	mod.global_position = actualPos
	add_child(mod)
func instantiate_creativo() -> void:
	# De arriba a abajo
	# 1
	var actualPos = Vector2(0,0)
	actualPos.x = actualPos.x - Global.cellSize
	actualPos.y = actualPos.y + (Global.cellSize / 2)
	var mod = modulo.instantiate()
	mod.global_position = actualPos
	add_child(mod)
	# 2
	actualPos.y -= Global.cellSize
	mod = modulo.instantiate()
	mod.global_position = actualPos
	add_child(mod)
	# 3
	actualPos.y -= Global.cellSize
	mod = modulo.instantiate()
	mod.global_position = actualPos
	add_child(mod)
	# a la derecha
	actualPos.x += Global.cellSize
	mod = modulo.instantiate()
	mod.global_position = actualPos
	add_child(mod)
func instantiate_logica() -> void:
	# izquierda abajo
	var actualPos = Vector2(0,0)
	actualPos.x = actualPos.x - Global.cellSize
	actualPos.y = actualPos.y + (Global.cellSize / 2)
	var mod = modulo.instantiate()
	mod.global_position = actualPos
	add_child(mod)
	# izquierda centro
	actualPos.y -= Global.cellSize
	mod = modulo.instantiate()
	mod.global_position = actualPos
	add_child(mod)
	# derecha centro
	actualPos.x += Global.cellSize
	mod = modulo.instantiate()
	mod.global_position = actualPos
	add_child(mod)
	# derecha arriba
	actualPos.y -= Global.cellSize
	mod = modulo.instantiate()
	mod.global_position = actualPos
	add_child(mod)
func instantiate_historia() -> void:
	var actualPos = Vector2(0,0)
	actualPos.x = actualPos.x - (Global.cellSize/2)
	actualPos.y = actualPos.y + (Global.cellSize)
	# centro abajo
	var mod = modulo.instantiate()
	mod.global_position = actualPos
	add_child(mod)
	# centro 
	actualPos.y -= Global.cellSize
	mod = modulo.instantiate()
	mod.global_position = actualPos
	add_child(mod)
	# derecha 
	actualPos.x += Global.cellSize
	mod = modulo.instantiate()
	mod.global_position = actualPos
	add_child(mod)
	# izquierda
	actualPos.x -= Global.cellSize * 2
	mod = modulo.instantiate()
	mod.global_position = actualPos
	add_child(mod)
func instantiate_filosofia() -> void:
	var actualPos = Vector2(0,0)
	actualPos.x = actualPos.x - (Global.cellSize/2)
	actualPos.y = actualPos.y + (Global.cellSize/2)
	# centro abajo
	var mod = modulo.instantiate()
	mod.global_position = actualPos
	add_child(mod)
	# centro 
	actualPos.y -= Global.cellSize
	mod = modulo.instantiate()
	mod.global_position = actualPos
	add_child(mod)
	# derecha 
	actualPos.x += Global.cellSize
	mod = modulo.instantiate()
	mod.global_position = actualPos
	add_child(mod)
	# izquierda
	actualPos.x -= Global.cellSize * 2
	mod = modulo.instantiate()
	mod.global_position = actualPos
	add_child(mod)
	# centro arriba
	actualPos.x += Global.cellSize
	actualPos.y -= Global.cellSize
	mod = modulo.instantiate()
	mod.global_position = actualPos
	add_child(mod)

func enter_Pieza() -> void:
	clikcDer = true;
func exit_Pieza() -> void:
	clikcDer = false;

func coge() -> void:
	#print(global_position)
	isThisClicked = true
	for c in get_children():
		c.desocupar_celda()
	Global.on_piece_exit.emit(tipo)

func suelta() -> bool:
	isThisClicked = false
	var modulosEnPosicion = 0
	var suma_pos = Vector2.ZERO
	var nMods = get_child_count()
	
	for c in get_children():
		if c.check_celda():
			modulosEnPosicion += 1
			suma_pos += c.celda_donde_colocar()
		
	if modulosEnPosicion >= nMods:
		var nueva_pos = suma_pos / nMods  # media de posiciones de los modulos
		global_position = nueva_pos
		
		# Ocupamos lac celdas
		for c in get_children():
			c.ocupar_celda()
		
		Global.on_piece_enter.emit(tipo)
		
		return true
	return false

func bloquear_pieza() -> void:
	#print("Bloquear pieza")
	for c in get_children():
		c.ocupar_celda()

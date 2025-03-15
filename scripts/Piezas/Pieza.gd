extends Control

@export var tipo:Global.TipoPieza
var modulo = preload("res://scenes/Piezas/modulo_pieza.tscn")

var offset: Vector2
var stopPosition: Vector2
var isThisClicked: bool = false
var puesta: bool = false
var clikcDer: bool = false
var piezaBloqueada: bool = false

func _ready() -> void:
	Global.evolve.connect(bloquear_pieza)

func _input(event: InputEvent) -> void:
	# Click derecho rota la pieza
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.is_pressed() and not puesta and clikcDer:
		rotation += PI/2;
	# Captura la posicion inicial del raton al hacer clic
	if event is InputEventMouseButton:
		offset = get_global_mouse_position() - global_position
	# Si la pieza esta seleccionada y se mueve el raton, actualiza su posicion
	if isThisClicked and event is InputEventMouseMotion:
		global_position = (event.position - offset)

# Funcion que instancia la forma de la pieza segun su tipo
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
	
	stopPosition = global_position

func instantiate_medio() -> void:
	var actualPos = Vector2(0,0)
	# arriba derecha
	actualPos.x = actualPos.x - Global.cellSize
	var mod = modulo.instantiate()
	mod.global_position = actualPos
	mod.icon = Global.textureCVERDE
	add_child(mod)
	# arriba izquierda
	actualPos.x += Global.cellSize
	mod = modulo.instantiate()
	mod.global_position = actualPos
	mod.icon = Global.textureCVERDE
	add_child(mod)	
	# abajo derecha
	actualPos.y -= Global.cellSize
	mod = modulo.instantiate()
	mod.global_position = actualPos
	mod.icon = Global.textureCVERDE
	add_child(mod)
	# abajo izquierda
	actualPos.x -= Global.cellSize
	mod = modulo.instantiate()
	mod.global_position = actualPos
	mod.icon = Global.textureCVERDE
	add_child(mod)
func instantiate_lengua() -> void:
	# De arriba a abajo
	# 1
	var actualPos = Vector2(0,0)
	actualPos.x = actualPos.x - (Global.cellSize / 2)
	actualPos.y = actualPos.y + Global.cellSize
	var mod = modulo.instantiate()
	mod.global_position = actualPos
	mod.icon = Global.textureCNARANJA
	add_child(mod)
	# 2
	actualPos.y -= Global.cellSize
	mod = modulo.instantiate()
	mod.global_position = actualPos
	mod.icon = Global.textureCNARANJA
	add_child(mod)
	# 3
	actualPos.y -= Global.cellSize
	mod = modulo.instantiate()
	mod.global_position = actualPos
	mod.icon = Global.textureCNARANJA
	add_child(mod)
	# 4
	actualPos.y -= Global.cellSize
	mod = modulo.instantiate()
	mod.global_position = actualPos
	mod.icon = Global.textureCNARANJA
	add_child(mod)
func instantiate_creativo() -> void:
	# De arriba a abajo
	# 1
	var actualPos = Vector2(0,0)
	actualPos.x = actualPos.x - (Global.cellSize * 0.8)
	actualPos.y = actualPos.y + (Global.cellSize / 1.4)
	var mod = modulo.instantiate()
	mod.global_position = actualPos
	mod.icon = Global.textureCMORADA
	add_child(mod)
	# 2
	actualPos.y -= Global.cellSize
	mod = modulo.instantiate()
	mod.global_position = actualPos
	mod.icon = Global.textureCMORADA
	add_child(mod)
	# 3
	actualPos.y -= Global.cellSize
	mod = modulo.instantiate()
	mod.global_position = actualPos
	mod.icon = Global.textureCMORADA
	add_child(mod)
	# a la derecha
	actualPos.x += Global.cellSize
	mod = modulo.instantiate()
	mod.global_position = actualPos
	mod.icon = Global.textureCMORADA
	add_child(mod)
func instantiate_logica() -> void:
	# izquierda abajo
	var actualPos = Vector2(0,0)
	actualPos.x = actualPos.x - Global.cellSize
	actualPos.y = actualPos.y + (Global.cellSize / 2)
	var mod = modulo.instantiate()
	mod.global_position = actualPos
	mod.icon = Global.textureCAZUL
	add_child(mod)
	# izquierda centro
	actualPos.y -= Global.cellSize
	mod = modulo.instantiate()
	mod.global_position = actualPos
	mod.icon = Global.textureCAZUL
	add_child(mod)
	# derecha centro
	actualPos.x += Global.cellSize
	mod = modulo.instantiate()
	mod.global_position = actualPos
	mod.icon = Global.textureCAZUL
	add_child(mod)
	# derecha arriba
	actualPos.y -= Global.cellSize
	mod = modulo.instantiate()
	mod.global_position = actualPos
	mod.icon = Global.textureCAZUL
	add_child(mod)
func instantiate_historia() -> void:
	var actualPos = Vector2(0,0)
	actualPos.x = actualPos.x - (Global.cellSize/2)
	actualPos.y = actualPos.y + (Global.cellSize/3.7)
	# centro abajo
	var mod = modulo.instantiate()
	mod.global_position = actualPos
	mod.icon = Global.textureCAMARILLA
	add_child(mod)
	# centro 
	actualPos.y -= Global.cellSize
	mod = modulo.instantiate()
	mod.global_position = actualPos
	mod.icon = Global.textureCAMARILLA
	add_child(mod)
	# derecha 
	actualPos.x += Global.cellSize
	mod = modulo.instantiate()
	mod.global_position = actualPos
	mod.icon = Global.textureCAMARILLA
	add_child(mod)
	# izquierda
	actualPos.x -= Global.cellSize * 2
	mod = modulo.instantiate()
	mod.global_position = actualPos
	mod.icon = Global.textureCAMARILLA
	add_child(mod)
func instantiate_filosofia() -> void:
	var actualPos = Vector2(0,0)
	actualPos.x = actualPos.x - (Global.cellSize/2)
	actualPos.y = actualPos.y + (Global.cellSize/2)
	# centro abajo
	var mod = modulo.instantiate()
	mod.global_position = actualPos
	mod.icon = Global.textureCROJA
	add_child(mod)
	# centro 
	actualPos.y -= Global.cellSize
	mod = modulo.instantiate()
	mod.global_position = actualPos
	mod.icon = Global.textureCROJA
	add_child(mod)
	# derecha 
	actualPos.x += Global.cellSize
	mod = modulo.instantiate()
	mod.global_position = actualPos
	mod.icon = Global.textureCROJA
	add_child(mod)
	# izquierda
	actualPos.x -= Global.cellSize * 2
	mod = modulo.instantiate()
	mod.global_position = actualPos
	mod.icon = Global.textureCROJA
	add_child(mod)
	# centro arriba
	actualPos.x += Global.cellSize
	actualPos.y -= Global.cellSize
	mod = modulo.instantiate()
	mod.global_position = actualPos
	mod.icon = Global.textureCROJA
	add_child(mod)

# Funciones que indican cuando el cursor esta sobre la pieza para poderla rotar
func enter_Pieza() -> void:
	if not piezaBloqueada:
		var tween = create_tween()
		tween.tween_property(self, "rotation_degrees", -0.5, 0.1)
		tween.tween_property(self, "rotation_degrees", 0, 0.1)
	clikcDer = true;
func exit_Pieza() -> void:
	if not piezaBloqueada:
		var tween = create_tween()
		tween.tween_property(self, "rotation_degrees", -0.5, 0.1)
		tween.tween_property(self, "rotation_degrees", 0, 0.1)
	clikcDer = false;

# Funciones que se usan cuando el jugador coge o suelta una pieza
func coge() -> void:
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(0.9,0.9), 0.1)
	tween.tween_property(self, "scale", Vector2(1,1), 0.1)
	#print(global_position)
	isThisClicked = true
	for c in get_children():
		c.desocupar_celda()
	if puesta:
		Global.on_piece_exit.emit(tipo)

func suelta() -> bool:
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1.1,1.1), 0.05)
	tween.tween_property(self, "scale", Vector2(1,1), 0.1)
	
	isThisClicked = false
	var modulosEnPosicion = 0 # cantidad de modulos colocados en celdas validas
	var suma_pos = Vector2.ZERO # suma posiciones para sacar el punto medio
	var nMods = get_child_count() # cantidad de modulos de la pieza
	
	for c in get_children():
		if c.check_celda(): # si la celda esta disponible
			modulosEnPosicion += 1
			suma_pos += c.celda_donde_colocar()
		
	if modulosEnPosicion >= nMods:
		var nueva_pos = suma_pos / nMods  # media de posiciones de los modulos
		global_position = nueva_pos
		
		# Ocupamos lac celdas
		for c in get_children():
			c.ocupar_celda()
		
		Global.on_piece_enter.emit(tipo)
		# Desregistra la pieza creada y guardada en el inventario
		# porque ya ha sido puesta en la grid.
		if Global.piezaEnInventario == self:
			Global.piezaEnInventario = null
		
		stopPosition = nueva_pos
		puesta = true
		return true
	elif puesta: # si esta puesta pero el jugador la ha sacado de las celdas
		global_position = stopPosition # lo devuelve a la posicion de las celdas anteriores
		for c in get_children():
			c.ocupar_celda()
		return true
	else:
		global_position = stopPosition # lo devuelve a la posicion de las celdas anteriores
		return false

func bloquear_pieza() -> void:
	#print("Bloquear pieza")
	# si esta pieza no es la que esta para usar en el inventario la bloquea
	if Global.piezaEnInventario != self:
		piezaBloqueada = true
		for c in get_children():
			c.bloquear_modulo()

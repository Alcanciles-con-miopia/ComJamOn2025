extends Node
# SEÑALES
signal on_transition_begin
signal on_transition_end
signal on_enable(scene)
signal on_disable(scene)
signal on_game_end()

# árbol
signal grow_branch(branch, points) #para cuando confirmas y la rama crece
signal feedback_branch(branch, points) #solo para el feedback al poner una pieza
signal feedback_unbranch(branch, points) #solo para el feedback al poner una pieza
signal resultado_grown(branch)

# crecer
signal evolve() # para cuando crezca el automata

enum Scenes { SPLASH, MAIN_MENU, INTRO, GAME, RESOLUCION, CREDITS, NULL}

var gms 
var sfx
var sfx2
var sfx3
var sfxs = [ sfx, sfx2, sfx3 ]
var bgm0
var bgm1
var bgm2
var bgm3
var bgm4
var bgm5
var bgm = [bgm1, bgm2, bgm3, bgm4, bgm5]
var current_scene = Scenes.SPLASH 
var next_scene = Scenes.SPLASH
var stage = 0

var coolDown = 0.5
var startCoolDown = false

func _ready() -> void:
	on_piece_enter.connect(pieceEnter)
	on_piece_exit.connect(pieceExit)
	# change_scene(Scenes.SPLASH)
	pass

func  _process(delta: float) -> void:
	pass
	if startCoolDown:
		if coolDown <= 0:
			startCoolDown = false
			coolDown = 0.5
		else:
			coolDown-= delta

func next_stage():
	Global.stage += 1
	Global.stage = clamp(Global.stage, 0, 6)
	get_node("Creador de Celdas").actualizeMatrix(expansions[Global.stage])

func change_scene(next: Global.Scenes, force = true):
	Global.next_scene = next
	print(">> Changing from ", Global.current_scene, " to ", Global.next_scene)
	if ((current_scene != next || force)and not startCoolDown):
		startCoolDown = true
		Global.on_transition_begin.emit()
#
func pieceEnter(tipo: TipoPieza) -> void:
	Global.arbol[tipo] += Global.puntos_por_rama[tipo]
	match tipo:
		TipoPieza.MEDIO:
			ramaMedio.punt += 1
			#print("Suma MEDIO")
		TipoPieza.LENGUA:
			ramaLengua.punt += 1
			#print("Suma LENGUA")
		TipoPieza.CREATIVO:
			ramaCreativo.punt += 1
			#print("Suma CREATIVO")
		TipoPieza.LOGICA:
			ramaLogica.punt += 1
			#print("Suma LOGICA")
		TipoPieza.HISTORIA:
			ramaHistoria.punt += 1
			#print("Suma HISOTORIA")
		TipoPieza.FILOSOFIA:
			ramaFilo.punt += 1
			#print("Suma FILO")
	#print_debug(Global.arbol)

#
func pieceExit(tipo: TipoPieza) -> void:
	Global.arbol[tipo] -= Global.puntos_por_rama[tipo]
	match tipo:
		TipoPieza.MEDIO:
			ramaMedio.punt -= 1
			#print("Resta MEDIO")
		TipoPieza.LENGUA:
			ramaLengua.punt -= 1
			#print("Resta LENGUA")
		TipoPieza.CREATIVO:
			ramaCreativo.punt -= 1
			#print("Resta CREATIVO")
		TipoPieza.LOGICA:
			ramaLogica.punt -= 1
			#print("Resta LOGICA")
		TipoPieza.HISTORIA:
			ramaHistoria.punt -= 1
			#print("Resta HISOTORIA")
		TipoPieza.FILOSOFIA:
			ramaFilo.punt -= 1
			#print("Resta FILO")
	#print_debug(Global.arbol)

# ---- GAME ----
# --- Funcionalidad y logica
var windowX = 1152.0
var windowY = 598.0

# - Draggables
var clicked: bool = false
signal CheckPieza

# --- Estado juego
# - Edad
enum Edad {BEBE, NINO, JOVEN, ADULTO, VIEJO}
var CurrentEdad = Edad.BEBE
var textureBEBE = load("res://assets/images/Arbolcabeza/Cabeza1.png")
var textureNINO = load("res://assets/images/Arbolcabeza/Cabeza2.png")
var textureJOVEN = load("res://assets/images/Arbolcabeza/Cabeza3.png")
var textureADULTO = load("res://assets/images/Arbolcabeza/Cabeza4.png")
var textureVIEJO = load("res://assets/images/Arbolcabeza/Cabeza5.png")
var edadTex = [textureBEBE, textureNINO, textureJOVEN, textureADULTO, textureVIEJO]	

const ARBOL_1 = preload("res://assets/images/Arbolcabeza/Arbol1.png")
const ARBOL_2 = preload("res://assets/images/Arbolcabeza/Arbol2.png")
const ARBOL_3 = preload("res://assets/images/Arbolcabeza/Arbol3.png")
var arbol_text = [ARBOL_1,ARBOL_2,ARBOL_3]

# - Inventario
enum TipoPieza { MEDIO, LENGUA, CREATIVO, LOGICA, HISTORIA, FILOSOFIA }
var textureCVERDE = load("res://assets/images/casillaVerde.jpg")
var textureCROJA = load("res://assets/images/casillaRoja.jpg")
var textureCNARANJA = load("res://assets/images/casillaNaranja.jpg")
var textureCMORADA = load("res://assets/images/casillaMorada.jpg")
var textureCAZUL = load("res://assets/images/casillaAzul.jpg")
var textureCAMARILLA = load("res://assets/images/casillaAmarilla.jpg")
var casillaTex = [textureCVERDE, textureCNARANJA, textureCMORADA, textureCAZUL, textureCAMARILLA, textureCROJA]	

# - Inventario:
var PiezasDesbl: int = 3 # Tipos de pieza que se van desbloqueando cada nivel. (+2) y (+1).
var maxPiezas: int = 4 # Maximo total de piezas.
var Inventario = [1,1,1,0,0,0] # Inventario.
var piezaEnInventario = null # Pieza que se muestra en el inventario cuando le das a un boton.
var inventarioOffset: float = 80
# Mete una pieza al inventario (numericamente)
func sumaInventarioPieza(tipo: TipoPieza)-> void:
	# No puedes tener mas de x piezas.
	if Inventario[tipo] < maxPiezas:
		Inventario[tipo] += 1
# Lo contrario que el anterior.
func restaInventarioPieza(tipo: TipoPieza) -> void:
	Inventario[tipo] -= 1

# - Hover
var FeedbackText = ["Entorno", "Lenguas", "Artes", "Lógica", "Historia", "Filosofía"]
var FeedbackColor = [
	Color(0.427, 0.851, 0.49), 
	Color(0.878, 0.522, 0.286), 
	Color(0.733, 0.408, 0.851), 
	Color(0.325, 0.655, 0.871), 
	Color(0.98, 0.847, 0.259),
	Color(0.929, 0.376, 0.408)]

# - Matriz de juego y celdas:
var cellSize: float = 50 # Tamanyo de cada celda en x e y.
var cellOfset: float = 0 # Offset entre las celdas.
var cellInitPos: Vector2 = Vector2(640, 50) # Posicion inicial de la primera celda.
var matrixSize: Vector2 = Vector2(10, 10) # Entiendo que esto luego sera leido del json pero de momento aqui esta.
enum cellState { EMPTY_STATE, POTENTIAL_OCCUPED_STATE, OCCUPIED_STATE, NOT_VALID_STATE } # Enum de los estados que puede tener una celda.
# - Expansion del tablero. Sease [col, fil]
var debugUnlockAllCells: bool = true # // DEBUG //
var initialCells: Array #= [Vector2(4,4),Vector2(5,4),Vector2(5,5),Vector2(4,5),Vector2(3,5),Vector2(3,4),Vector2(3,3),Vector2(4,3),Vector2(5,3),Vector2(6,3),Vector2(6,4),Vector2(6,5),Vector2(6,6),Vector2(5,6),Vector2(4,6),Vector2(3,6)] # Celdas iniciales
var expansion1: Array #= [Vector2(3,7),Vector2(4,7),Vector2(2,5),Vector2(5,7),Vector2(2,4),Vector2(7,4),Vector2(5,2),Vector2(7,3),Vector2(6,2),Vector2(7,2),Vector2(6,1)] # Celdas de expansion del bebe a nini.
var expansion2: Array #= [Vector2(8,4),Vector2(8,3),Vector2(9,3),Vector2(9,2),Vector2(8,2),Vector2(8,1),Vector2(7,1),Vector2(7,0),Vector2(6,0),Vector2(5,0),Vector2(5,1),Vector2(4,1),Vector2(4,2),Vector2(3,2),Vector2(2,2),Vector2(2,3),Vector2(1,3),Vector2(1,4)] # Celdas de expansion del nino al joven.
var expansion3: Array #= [Vector2(0,4),Vector2(0,5),Vector2(1,5),Vector2(1,6),Vector2(2,6),Vector2(2,7),Vector2(2,8),Vector2(3,8),Vector2(4,8),Vector2(5,8),Vector2(6,8),Vector2(6,7),Vector2(7,7),Vector2(7,6),Vector2(7,5),Vector2(8,6),Vector2(8,5)] # Celdas de expansion del joven al adulto.
var expansion4: Array #=[Vector2(9,0),Vector2(8,0),Vector2(9,1),Vector2(9,4),Vector2(4,0),Vector2(9,5),Vector2(3,0),Vector2(9,6),Vector2(3,1),Vector2(9,7),Vector2(2,1),Vector2(8,7),Vector2(1,1),Vector2(8,8),Vector2(1,2),Vector2(7,8),Vector2(0,2),Vector2(7,9),Vector2(0,3),Vector2(6,9),Vector2(5,9),Vector2(4,9),Vector2(0,6),Vector2(1,7),Vector2(3,9),Vector2(0,7),Vector2(1,8),Vector2(2,9),Vector2(0,8),Vector2(1,9)] # Celdas de expansion del adulto al viejo.
var expansions: Array #= [initialCells, expansion1, expansion2, expansion3, expansion4] # Aqui estan todos para ir iterando al pasar de fase vital.
# - Arbol
var piezaVal: int = 1 		# Puntuacion que aporta cada pieza a una rama

# ramas: MEDIO, LENGUA, CREATIVO, LOGICA, HISTORIA, FILOSOFIA
# { nombre , puntuacion (inicialmente 0) }
var ramaMedio = 	{ nombre = "Medio",	 	punt = 0 }
var ramaLengua = 	{ nombre = "Lengua", 	punt = 0 }
var ramaCreativo = 	{ nombre = "Creativo", 	punt = 0 }
var ramaLogica = 	{ nombre = "Logica", 	punt = 0 }
var ramaHistoria = 	{ nombre = "Historia", 	punt = 0 }
var ramaFilo = 		{ nombre = "Filosofia",	punt = 0 }

# puntuacion acumulada por rama
var arbol = [ramaMedio.punt, ramaLengua.punt, ramaCreativo.punt, ramaLogica.punt, ramaHistoria.punt, ramaFilo.punt]	
# puntuacion max de una rama
const ramaMax: int = 10
var puntos_por_rama = [3,3,3,5,5,6] #hola soy cynthia
#var piezas_este_turno = [] #deprecated, lo dejo por si acaso
var arbol_act = [0,0,0,0,0,0]
var puntos_maximos_por_rama = [0, 0, 0, 0, 0, 0] #esto va a ser rellenado en el ready del arbol
#hola dejo de ser cynthia

# - Signales de las piezas:
signal on_piece_enter(tipo: TipoPieza) # Cuando la pieza se coloca.
signal on_piece_exit(tipo: TipoPieza) # Cuando la pieza se quita.

# - Random:
var random = RandomNumberGenerator.new()

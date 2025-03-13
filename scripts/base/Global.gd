extends Node
# SEÑALES
signal on_transition_begin
signal on_transition_end
signal on_enable(scene)
signal on_disable(scene)
signal on_game_end()

# árbol
signal grow_branch(branch) #para cuando confirmas y la rama crece
signal feedback_branch(branch) #solo para el feedback al poner una pieza

# crecer
signal evolve() # para cuando crezca el automata

enum Scenes { SPLASH, MAIN_MENU, INTRO, GAME, CREDITS, NULL}

var gms 
var sfx
var current_scene = Scenes.SPLASH 
var next_scene = Scenes.SPLASH
var stage = 0

var coolDown = 0.5
var startCoolDown = false

func _ready() -> void:
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

func change_scene(next: Global.Scenes, force = true):
	Global.next_scene = next
	print(">> Changing from ", Global.current_scene, " to ", Global.next_scene)
	if ((current_scene != next || force)and not startCoolDown):
		startCoolDown = true
		Global.on_transition_begin.emit()

# ---- GAME ----
# --- Funcionalidad y logica
var clicked: bool = false
var windowX
var windowY

# --- Estado juego
# - Edad
enum Edad {BEBE, NINO, JOVEN, ADULTO, VIEJO}
var CurrentEdad = Edad.BEBE
var textureBEBE = load("res://assets/images/automataBEBE.png")
var textureNINO = load("res://assets/images/automataNINO.png")
var textureJOVEN = load("res://assets/images/automataJOVEN.png")
var textureADULTO = load("res://assets/images/automataADULTO.png")
var textureVIEJO = load("res://assets/images/automataVIEJO.png")
var edadTex = [textureBEBE, textureNINO, textureJOVEN, textureADULTO, textureVIEJO]	

# - Inventario
enum TipoPieza { MEDIO, LENGUA, CREATIVO, LOGICA, HISTORIA, FILOSOFIA }
var PiezasDesbl: int = 6
var Inventario = [4,4,4,4,4,4]

# - Matriz de juego y celdas:
var cellSize: float = 50 # Tamanyo de cada celda en x e y.
var cellOfset: float = 0 # Offset entre las celdas.
var cellInitPos: Vector2 = Vector2(600, 150) # Posicion inicial de la primera celda.
var matrixSize: Vector2 = Vector2(10, 10) # Entiendo que esto luego sera leido del json pero de momento aqui esta.
enum cellState { EMPTY_STATE, OCCUPIED_STATE, NOT_VALID_STATE } # Enum de los estados que puede tener una celda.
# - Expansion del tablero. Sease [col, fil]
var debugUnlockAllCells: bool = true
var initialCells: Array = [Vector2(3,3),Vector2(4,3),Vector2(5,3),Vector2(3,4),Vector2(4,4),Vector2(5,4),Vector2(3,5),Vector2(4,5),Vector2(5,5)] # Celdas iniciales
var expansion1: Array = [Vector2(2,1),Vector2(3,1),Vector2(2,2),Vector2(3,2),Vector2(4,2),Vector2(5,2),Vector2(6,2),Vector2(7,2),Vector2(2,3),Vector2(6,3),Vector2(7,3),Vector2(2,4),Vector2(6,4),Vector2(1,5),Vector2(2,5),Vector2(6,5),Vector2(1,6),Vector2(2,6),Vector2(3,6),Vector2(4,6),Vector2(5,6),Vector2(6,6),Vector2(5,7),Vector2(6,7)] # Celdas de expansion del bebe a nini.
var expansion2: Array = [Vector2(1,1),Vector2(4,1),Vector2(5,1),Vector2(6,1),Vector2(7,1),Vector2(1,2),Vector2(1,3),Vector2(1,4),Vector2(7,4),Vector2(7,5),Vector2(1,7),Vector2(2,7),Vector2(3,7),Vector2(4,7),Vector2(7,6),Vector2(7,7)] # Celdas de expansion del nin0 al joven.
var expansion3: Array = [Vector2(8,1),Vector2(8,2),Vector2(8,3),Vector2(8,4),Vector2(8,5),Vector2(8,6),Vector2(8,7),Vector2(8,8),Vector2(1,8),Vector2(2,8),Vector2(3,8),Vector2(4,8),Vector2(5,8),Vector2(6,8),Vector2(7,8)] # Celdas de expansion del joven al adulto.
var expansion4: Array = [Vector2(0,0),Vector2(0,1),Vector2(0,2),Vector2(0,3),Vector2(0,4),Vector2(0,5),Vector2(0,6),Vector2(0,7),Vector2(0,8),Vector2(0,9),Vector2(1,0),Vector2(2,0),Vector2(3,0),Vector2(4,0),Vector2(5,0),Vector2(6,0),Vector2(7,0),Vector2(8,0),Vector2(9,0),Vector2(9,1),Vector2(9,2),Vector2(9,3),Vector2(9,4),Vector2(9,5),Vector2(9,6),Vector2(9,7),Vector2(9,8),Vector2(9,9),Vector2(1,9),Vector2(2,9),Vector2(3,9),Vector2(4,9),Vector2(5,9),Vector2(6,9),Vector2(7,9),Vector2(8,9)] # Celdas de expansion del adulto al viejo.
var expansions: Array = [initialCells, expansion1, expansion2, expansion3, expansion4] # Aqui estan todos para ir iterando al pasar de fase vital.
# - Arbol
var piezaVal: int = 1 		# puntuacion que aporta cada pieza a una rama

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

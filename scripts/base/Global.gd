extends Node
# SEÑALES
signal on_transition_begin
signal on_transition_end
signal on_enable(scene)
signal on_disable(scene)
signal on_game_end()

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

func change_scene(next : Global.Scenes, force = true):
	Global.next_scene = next
	print(">> Changing from ", Global.current_scene, " to ", Global.next_scene)
	if ((current_scene != next || force)and not startCoolDown):
		startCoolDown = true
		Global.on_transition_begin.emit()

# ---- GAME ----
# --- Funcionalidad y logica
var clicked: bool = false
# --- Estado juego
# - Edad
enum Edad {BEBE, NINO, JOVEN, ADULTO, VIEJO}
var CurrentEdad = Edad.BEBE

# - Inventario
enum TipoPieza { MEDIO, LENGUA, CREATIVO, LOGICA, HISTORIA, FILOSOFIA }
var PiezasDesbl: int = 5
var Inventario = [4,4,4,4,4,4]

# - Matriz de juego
var cellSize: float = 128
enum cellState { EMPTY_STATE, OCCUPIED_STATE, NOT_VALID_STATE }
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

extends Node2D
enum Ramas { MEDIO, LENGUA, CREATIVO, LOGICA, HISTORIA, FILOSOFIA }
var current_branch = Ramas.MEDIO #solo para debugging

@onready var ramas : Array = [$Lineas/Medio, $Lineas/Lengua, $Lineas/Creativo]
#, $Lineas/Logica, $Lineas/Historia, $Lineas/Filo]

func _ready() -> void:
	#print(puntos[Ramas.MEDIO][1])
	Global.grow_branch.connect(on_branch_grow)
	Global.feedback_branch.connect(on_branch_feed)
	pass

func _input(event):
	if event.is_action_pressed("branch grow"):
		Global.grow_branch.emit(current_branch)
	if event.is_action_pressed("branch feed"):
		Global.feedback_branch.emit(current_branch)
	if event.is_action_pressed("cambiar rama derecha"):
		current_branch += 1;
		current_branch = clamp(current_branch, Ramas.MEDIO, Ramas.CREATIVO)
		print("Current branch: ", current_branch)
	if event.is_action_pressed("cambiar rama izquierda"):
		current_branch -= 1;
		current_branch = clamp(current_branch, Ramas.MEDIO, Ramas.CREATIVO)
		print("Current branch: ", current_branch)
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()

func on_branch_grow(rama) -> void:
	#print("Branch grow: ", rama)
	Global.arbol[rama] += 1;
	print("Nivel de la rama ", rama, ": ", Global.arbol[rama])
	ramas[rama].show_animation()
	pass
	
func on_branch_feed() -> void:
	print("Branch feed")
	pass

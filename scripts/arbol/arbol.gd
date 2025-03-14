extends Node2D
enum Ramas { MEDIO, LENGUA, CREATIVO, LOGICA, HISTORIA, FILOSOFIA }
var current_branch = Ramas.MEDIO #solo para debugging

@onready var ramas : Array = [$Lineas/Medio, $Lineas/Lengua, $Lineas/Creativo, $Lineas/Logica, $Lineas/Historia, $Lineas/Filo]
@onready var feedback_ramas : Array = [$Feedback/Medio, $Feedback/Lengua, $Feedback/Feedback, $Feedback/Logica, $Feedback/Historia, $Feedback/Filo]

func _ready() -> void:
	#print(puntos[Ramas.MEDIO][1])
	Global.grow_branch.connect(on_branch_grow)
	Global.feedback_branch.connect(on_branch_feed)
	Global.feedback_unbranch.connect(on_branch_receed)
	pass

func _input(event):
	if event.is_action_pressed("branch grow"):
		Global.grow_branch.emit(current_branch)
	if event.is_action_pressed("branch feed"):
		Global.feedback_branch.emit(current_branch)
	if event.is_action_pressed("branch unfeed"):
		Global.feedback_unbranch.emit(current_branch)
	if event.is_action_pressed("cambiar rama derecha"):
		current_branch += 1;
		current_branch = clamp(current_branch, Ramas.MEDIO, Ramas.FILOSOFIA)
		print("Current branch: ", current_branch)
	if event.is_action_pressed("cambiar rama izquierda"):
		current_branch -= 1;
		current_branch = clamp(current_branch, Ramas.MEDIO, Ramas.FILOSOFIA)
		print("Current branch: ", current_branch)
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()

func on_branch_grow(rama, puntos) -> void:
	#print("Branch grow: ", rama)
	Global.arbol[rama] += 1;
	print("Nivel de la rama ", rama, ": ", Global.arbol[rama])
	ramas[rama].create_point()
	pass
	
func on_branch_feed(rama, puntos) -> void:
	print("Branch feed")
	for i in puntos:
		feedback_ramas[rama].create_point()
		await get_tree().create_timer(0.5).timeout
	pass
	
func on_branch_receed(rama, puntos) -> void:
	Global.arbol[rama] -= 1
	print("Branch receed")
	feedback_ramas[rama].delete_point()
	pass

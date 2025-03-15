extends Node2D
enum Ramas { MEDIO, LENGUA, CREATIVO, LOGICA, HISTORIA, FILOSOFIA }
var current_branch = Ramas.MEDIO #solo para debugging

@export var es_resolucion = false;
@onready var ramas : Array = [$Lineas/Medio, $Lineas/Lengua, $Lineas/Creativo, $Lineas/Logica, $Lineas/Historia, $Lineas/Filo]
@onready var feedback_ramas : Array = [$Feedback/Medio, $Feedback/Lengua, $Feedback/Creativo, $Feedback/Logica, $Feedback/Historia, $Feedback/Filo]
var anim_dur = 0.3

func _ready() -> void:
	#print(puntos[Ramas.MEDIO][1])
	Global.grow_branch.connect(on_branch_grow)
	Global.feedback_branch.connect(on_branch_feed)
	Global.feedback_unbranch.connect(on_branch_receed)
	
	for i in 6:
		Global.puntos_maximos_por_rama[i] = ramas[i].get_full_line_points()
	
	pass

func _input(event):
	if event.is_action_pressed("branch grow"):
		Global.grow_branch.emit(current_branch, 1)
	if event.is_action_pressed("branch feed"):
		Global.feedback_branch.emit(current_branch, 1)
	if event.is_action_pressed("branch unfeed"):
		Global.feedback_unbranch.emit(current_branch, 1)
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
	Global.arbol[rama] += puntos;
	for i in puntos:
		ramas[rama].create_point()
		await get_tree().create_timer(anim_dur).timeout
	pass
	
func on_branch_feed(rama, puntos) -> void:
	grow_branch(rama, puntos, true)
	pass
	
func on_branch_receed(rama, puntos) -> void:
	for i in puntos:
		feedback_ramas[rama].delete_point()
		await get_tree().create_timer(anim_dur).timeout
	pass

func grow_branch(rama, puntos, feedback):
	for i in puntos:
		if feedback:
			feedback_ramas[rama].create_point()
		else:
			ramas[rama].create_point()
		await get_tree().create_timer(anim_dur).timeout
	Global.resultado_grown.emit(rama)
	#print("he acabado de crecer inicialmente")

func animate_tree():
	current_branch = 0
	for i in 6:
		if es_resolucion:
			grow_branch(current_branch, 100, true)
			await get_tree().create_timer(0.1).timeout
			grow_branch(current_branch, Global.arbol[current_branch], false)
			current_branch += 1;
			current_branch = clamp(current_branch, Ramas.MEDIO, Ramas.FILOSOFIA)
		else:
			grow_branch(current_branch, Global.arbol[current_branch] - Global.arbol_act[current_branch], false)
			Global.arbol_act[current_branch] += Global.arbol[current_branch] - Global.arbol_act[current_branch]
			current_branch += 1;
			current_branch = clamp(current_branch, Ramas.MEDIO, Ramas.FILOSOFIA)
	print_debug(Global.arbol_act)

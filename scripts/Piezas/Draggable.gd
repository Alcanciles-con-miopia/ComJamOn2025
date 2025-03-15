extends Button
class_name Draggable

var bloqueada: bool = false
var celda = null

func _ready() -> void:
	scale = (Global.cellSize * Vector2(1,1)) / icon.get_size()

func _on_button_down() -> void:
	if bloqueada:
		return
	
	if not Global.clicked:
		#print(global_position)
		get_parent().coge()
		Global.clicked = true
	#print(name)

func _on_button_up() -> void:
	if bloqueada:
		return
	
	get_parent().suelta()
	
	if Global.clicked:
		Global.clicked = false

func check_celda() -> bool:
	return celda != null and celda.get_is_empty()

func ocupar_celda() -> void :
	if celda != null:
		celda.setState(Global.cellState.OCCUPIED_STATE)

func desocupar_celda() ->void:
	if celda != null:
		celda.setState(Global.cellState.POTENTIAL_OCCUPED_STATE)

func bloquear_modulo() -> void:
	var tween = create_tween()
	var modulate =  Color.WHITE
	var modulate_color: Color
	modulate_color.r = 1
	modulate_color.g = 1
	modulate_color.b = 1
	modulate_color.a = 0.7
	tween.tween_property(self, 'modulate', modulate_color, 0.1)
	bloqueada = true

func celda_donde_colocar() -> Vector2:
	if celda != null:
		return celda.global_position
	return Vector2(-1,-1)

func _on_area_2d_area_entered(area: Area2D) -> void:
	#print(area.get_parent().name)
	if area.get_parent().get_script() == preload("res://scripts/Mapas/celda.gd"):
		#print("Entra en celda")
		if area.get_parent().get_is_empty():
			#print("Puede quedarse ", area.get_parent().get_state())
			area.get_parent().setState(Global.cellState.POTENTIAL_OCCUPED_STATE)
			celda = area.get_parent()

func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.get_parent().get_script() == preload("res://scripts/Mapas/celda.gd") and area.get_parent().get_state()!= Global.cellState.OCCUPIED_STATE:
		area.get_parent().setState(Global.cellState.EMPTY_STATE)
		#print("Se ha salido")
		celda = null

func _on_mouse_entered() -> void:
	get_parent().enter_Pieza()

func _on_mouse_exited() -> void:
	get_parent().exit_Pieza()

extends Button
class_name Draggable

var enPosicion: bool = false
var celdaPos: Vector2

func _ready() -> void:
	scale = (Global.cellSize * Vector2(1,1)) / icon.get_size()

func _on_button_down() -> void:
	if not Global.clicked:
		print(global_position)
		get_parent().coge()
		Global.clicked = true
	print(name)

func _on_button_up() -> void:
	get_parent().suelta()
	if Global.clicked:
		Global.clicked = false

func celdaDondeColocar() -> Vector2:
	return celdaPos

func _on_area_2d_area_entered(area: Area2D) -> void:
	print(area.get_parent().name)
	if area.get_parent().get_script() == preload("res://scripts/Mapas/celda.gd"):# and area.get_parent().get_is_epty():
			print("Puede quedarse")
			enPosicion = true
			celdaPos = area.get_parent().global_position

func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.get_parent().get_script() == preload("res://scripts/Mapas/celda.gd"):
		enPosicion = false
		print("Se ha salido")

func getINPOS() -> bool:
	return enPosicion

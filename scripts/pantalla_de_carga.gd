extends Node2D
@onready var progress_bar: ProgressBar = $ProgressBar
@onready var fondo: ColorRect = $Fondo
@onready var engranaje: Sprite2D = $Engranaje
@onready var coger: AnimatedSprite2D = $coger
@onready var rotar: AnimatedSprite2D = $rotar
@onready var evolucionar: AnimatedSprite2D = $evolucionar

var cargar: bool = false
var tiempocarga: float = 0

func _process(delta: float) -> void:
	if cargar:
		if tiempocarga < 100:
			progress_bar.value = tiempocarga
			tiempocarga += (13 * delta)
		else:
			cargar = false
			ha_cargado()
		

func empezar_carga() -> void:
	cargar = true
	tiempocarga = 0
	recargar_tween()

func ha_cargado() -> void:
	progress_bar.visible = false
	cargar = false
	var tween = create_tween()
	var newColor = Color(1,1,1,0) #ocultar
	tween.tween_property(fondo, "modulate", newColor, 1)
	var tween2 = create_tween()
	tween2.tween_property(engranaje, "modulate", newColor, 1)
	var tween3 = create_tween()
	tween3.tween_property(coger, "modulate", newColor, 1)
	var tween4 = create_tween()
	tween4.tween_property(rotar, "modulate", newColor, 1)
	var tween5 = create_tween()
	tween5.tween_property(evolucionar, "modulate", newColor, 1)
	tween.connect("finished", eliminar_pantalla)

func eliminar_pantalla() -> void:
	self.queue_free()

func recargar_tween() -> void:
	var tween = create_tween()
	tween.tween_property(engranaje, "rotation_degrees", 360 * 10, 10 )
	

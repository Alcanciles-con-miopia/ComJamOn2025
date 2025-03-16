extends Scene

var elapsedTime: float = 0
var maxTime: float = 3
var aumentado: bool = false
@onready var control: Control = $Control
@onready var alcancil_1: TextureRect = $Control/Alcancil1
@onready var alcancil_2: TextureRect = $Control/Alcancil2
@onready var color_rect: ColorRect = $ColorRect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var tween = create_tween()
	var tween2 = create_tween()
	var tween3 = create_tween()
	var newColor = Color(1,1,1,0) #ocultar
	var newColor2 = Color(1,1,1,1) #mostrar
	tween.tween_property(alcancil_2, "position", alcancil_2.position, 1)
	tween2.tween_property(alcancil_1, "position", alcancil_1.position, 1)
	tween3.tween_property(color_rect, "position", color_rect.position, 1)
	
	tween.tween_property(alcancil_2, "modulate", newColor, 1)
	tween2.tween_property(alcancil_1, "modulate", newColor2, 1)
	tween3.tween_property(color_rect, "modulate", newColor2, 1)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if elapsedTime<= maxTime:
		# control.scale =  Vector2((1+elapsedTime)/10,(1+elapsedTime)/10)
		elapsedTime += delta
	elif not aumentado:
		#print("FUERA SPLASH")
		Global.change_scene(Global.Scenes.MAIN_MENU)
		aumentado = true	


func on_enable():
	#print("hHOOOOLA")
	pass

func on_disable():
	aumentado = false;
	elapsedTime = 0;
	maxTime = 3;
	pass

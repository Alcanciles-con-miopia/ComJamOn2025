extends Scene

@onready var porcentajes : Array = [ $Porcentajes/Cono,$Porcentajes/Lengua, $Porcentajes/Creativo, $Porcentajes/Logica, $Porcentajes/Historia, $Porcentajes/Filo, ]
var tween
@onready var label = $Label
@onready var boton = $Button

func _ready() -> void:
	Global.resultado_grown.connect(on_branch_grown)
	#tween.tween_property(porcentajes[0], "modulate", Color.WHITE, 1)
	#tween.tween_property(porcentajes[1], "modulate", Color.WHITE, 1)
	pass
	
func _process(delta: float) -> void:
	pass
	
func on_branch_grown(rama):
	#print("hola")
	await get_tree().create_timer(1.5).timeout
	tween = get_tree().create_tween()
	tween.tween_property(porcentajes[rama], "modulate", Color.WHITE, 1).set_delay(3)
	#porcentajes[rama].
	pass


func _on_button_button_down() -> void:
	Global.sfx.stream = load("res://assets/sounds/metal_click.ogg")
	Global.sfx.play()
	Global.change_scene(Global.Scenes.CREDITS)
	pass # Replace with function body.

func on_enable():
	$Arbol.animate_tree()
	label.activate()
	boton.activate()
	
	for i in 6:
		if Global.arbol[i] >= 0.95:
			Global.arbol[i] == 1
	
	# poner % en los labels
	for i in 6:
		var percent = Global.arbol[i] * 100 / Global.puntos_maximos_por_rama[i]
		porcentajes[i].text = str(percent, "%")
		
		
func on_disable():
	for i in 5:
		Global.bgm[i].stop()
	pass

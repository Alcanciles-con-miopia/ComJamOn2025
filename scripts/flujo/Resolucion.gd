extends Scene

@onready var porcentajes : Array = [ $Porcentajes/Cono, $Porcentajes/Logica, $Porcentajes/Lengua, $Porcentajes/Historia, $Porcentajes/Filo, $Porcentajes/Creativo]
var tween

func _ready() -> void:
	Global.resultado_grown.connect(on_branch_grown)
	#tween.tween_property(porcentajes[0], "modulate", Color.WHITE, 1)
	#tween.tween_property(porcentajes[1], "modulate", Color.WHITE, 1)
	pass
	
func _process(delta: float) -> void:
	pass
	
func on_branch_grown(rama):
	#print("hola")
	tween = get_tree().create_tween()
	tween.tween_property(porcentajes[rama], "modulate", Color.WHITE, 1).set_delay(1)
	#porcentajes[rama].
	pass

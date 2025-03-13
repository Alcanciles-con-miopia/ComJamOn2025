extends Sprite2D
class_name FondoAutomata

func _ready() -> void:
	Global.evolve.connect(change_fondo)
	Global.windowX = DisplayServer.window_get_size().x
	texture = Global.edadTex[Global.CurrentEdad]
	scale = Vector2(0.5, 0.5)
	position.x = texture.get_size().x/2
	position.y = texture.get_size().y/2

func change_fondo() -> void:
	print(Global.CurrentEdad)
	if Global.CurrentEdad < 5:
		texture = Global.edadTex[Global.CurrentEdad]

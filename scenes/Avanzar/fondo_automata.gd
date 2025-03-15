extends Sprite2D
class_name FondoAutomata

@onready var initX = 0
@onready var initY = 0
@onready var fondo_puzle_2: Sprite2D = $"../FondoPuzle2"

func _ready() -> void:
	initX = self.global_position.x
	initY = self.global_position.y
	Global.evolve.connect(change_fondo)
	texture = Global.edadTex[Global.CurrentEdad]

func change_fondo() -> void:
	if Global.CurrentEdad < 5:
		var tween = create_tween()
		tween.tween_property(fondo_puzle_2, "position", Vector2(205.0, 375), 0.5)
		tween.tween_property(self, "scale",Vector2(0.4, 0.4), 0.25)
		tween.tween_property(self, "position", Vector2(191.437, -400.0), 0.5)
		var tween2 = create_tween()
		tween2.tween_property(self, "position", Vector2(initX, initY+50), 0.1)
		tween2.tween_property(self, "rotation_degrees", -10, 0.2)
		tween2.tween_property(self, "rotation_degrees", 10, 0.2)
		tween2.tween_property(self, "rotation_degrees", 0, 0.1)
		tween.connect("finished", cambiar_fondo)

func cambiar_fondo() -> void:
	texture = Global.edadTex[Global.CurrentEdad]
	#var x = self.global_position.x
	#var y = self.global_position.y 
	#global_position = Vector2(x, y-Global.windowY)
	var tween = create_tween()
	var tween2 = create_tween()
	print(initX)
	tween.tween_property(self, "position", Vector2(initX, initY+50), 0.3)
	tween2.tween_property(self, "rotation_degrees", -10, 0.2)
	tween2.tween_property(self, "rotation_degrees", 10, 0.2)
	tween2.tween_property(self, "rotation_degrees", 0, 0.1)
	tween2.tween_property(self, "position", Vector2(initX, initY), 0.1)
	tween.tween_property(self, "scale",Vector2(0.6, 0.6), 0.25)

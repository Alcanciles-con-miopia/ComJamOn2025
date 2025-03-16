extends Sprite2D
class_name FondoAutomata

@onready var initX = 0
@onready var initY = 0
@onready var fondo_puzle_2: Sprite2D = $"../FondoPuzle2"
@onready var sprite_2d: Sprite2D = $Sprite2Dç
@onready var arbol: Sprite2D = $Sprite2D

func _ready() -> void:
	fondo_puzle_2.global_position = Vector2(493.0, 52)
	Global.evolve.connect(change_fondo)
	texture = Global.edadTex[Global.CurrentEdad]

func change_fondo() -> void:
	if Global.CurrentEdad < 5:
		var tween = create_tween()
		var tween2 = create_tween() 
		tween.tween_property(fondo_puzle_2, "position", Vector2(217.0, 52), 0.5)
		tween.tween_property(fondo_puzle_2, "position", Vector2(217.0, 82), 0.2)
		tween2.tween_property(self, "position", Vector2(205, 375), 0.5)
		tween2.tween_property(self, "scale",Vector2(0.6, 0.6), 0.2)
		
		tween.tween_property(fondo_puzle_2, "position", Vector2(217.0, 52), 0.5)
		tween2.tween_property(self, "position", Vector2(205.0, 355), 0.5)
		
		tween.tween_property(fondo_puzle_2, "position", Vector2(-100, 52), 0.5)
		tween2.tween_property(self, "position", Vector2(-100.0, 355), 0.5)
		
		tween.connect("finished", cambiar_fondo)

func cambiar_fondo() -> void:
	texture = Global.edadTex[Global.CurrentEdad]
	if Global.CurrentEdad <= Global.Edad.JOVEN:
		arbol.texture = Global.arbol_text[Global.CurrentEdad]
	#var x = self.global_position.x
	#var y = self.global_position.y 
	#global_position = Vector2(x, y-Global.windowY)
	var tween = create_tween()
	var tween2 = create_tween()
	print(initX)
	
	tween.tween_property(fondo_puzle_2, "position", Vector2(217.0, 82), 0.5)
	tween2.tween_property(self, "position", Vector2(205, 375), 0.5)
	
	
	tween.tween_property(fondo_puzle_2, "position", Vector2(217.0, 52), 0.2)
	
	tween.tween_property(fondo_puzle_2, "position", Vector2(217.0, 52), 0.5)
	tween.tween_property(fondo_puzle_2, "position", Vector2(493.0, 52), 0.5)
	tween2.tween_property(self, "scale",Vector2(0.6, 0.6), 0.25)

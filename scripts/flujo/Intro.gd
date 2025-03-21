extends Scene

#@onready var label: Label = $Label
var timer = 0
var frames_per_letter = 4
var elapsedTime: float = 0
var maxTime: float = 8
var textDisplay: float = 0
var aumentado: bool = false
var text_ended = false
var clicked = false
var clicks = 0;
var stop = false
var transitioned = false
var mostrar_aviso = false
@onready var aviso = $Aviso
var counter = 0;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if mostrar_aviso:
		counter += 1
		if counter >= 400:
			mostrar_aviso = false
			counter = 0
			var tween = create_tween()
			tween.tween_property(aviso, "modulate", Color.TRANSPARENT, 0.5)
	#if stop:
		#label.visible_ratio =  1
		#text_ended = true
	#elif elapsedTime <= maxTime:
		#if textDisplay < 1:
			#if timer >= frames_per_letter:
				#timer = 0
				#label.visible_ratio = textDisplay
				#textDisplay += delta
			#else:
				#timer += 1
		#else:
			#label.visible_ratio =  1
		#elapsedTime += delta
	pass

func _input(event):
	if (event is InputEventKey && event.pressed) || event.is_action_pressed("any"):
		if (!mostrar_aviso):
			mostrar_aviso = true
			var tween = create_tween()
			tween.tween_property(aviso, "modulate", Color.WHITE, 0.5)
		else:
			Global.change_scene(Global.Scenes.GAME)
			pass
	pass
	#if event.is_action_pressed("click"):
		#if label.visible_ratio == 1:
			#text_ended = true
		#if transitioned:
			#print(transitioned)
			#Global.change_scene(Global.Scenes.MAIN_MENU)
		#if !text_ended:
			#label.visible_ratio = 1
			#stop = true;
			#text_ended = true;
		#else:
			#if !clicked:
				#$AnimationPlayer.play("fadeout")
				#clicked = true
			#

func on_enable():
	Global.bgm0.stream = load("res://assets/music/Intro.mp3")
	Global.bgm0.play()
	pass

func on_disable():
	Global.bgm0.stop()
	_reset()
	pass

func _on_animation_player_animation_finished(anim_name:StringName) -> void:
	transitioned = true

func _reset():
	timer = 0
	frames_per_letter = 4
	elapsedTime = 0
	maxTime = 8
	textDisplay = 0
	aumentado = false
	text_ended = false
	clicked = false
	clicks = 0;
	stop = false
	transitioned = false


func _on_video_stream_player_finished() -> void:
	Global.change_scene(Global.Scenes.GAME)

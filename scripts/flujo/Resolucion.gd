extends Scene

@onready var porcentajes : Array = [ $Porcentajes/Cono, $Porcentajes/Logica, $Porcentajes/Lengua, $Porcentajes/Historia, $Porcentajes/Filo, $Porcentajes/Creativo]


func _ready() -> void:
	Global.grow_branch.connect(on_branch_grown)
	pass
	
func _process(delta: float) -> void:
	pass
	
func on_branch_grown(rama):
	#porcentajes[rama].
	pass

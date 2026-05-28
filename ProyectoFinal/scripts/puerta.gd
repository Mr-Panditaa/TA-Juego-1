extends Area3D

@export var siguiente_nivel: String = "res://ProyectoFinal/escenas/nivel2.tscn"

var cambiando_nivel: bool = false

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body) -> void:
	if cambiando_nivel:
		return

	if body.is_in_group("player"):
		
		if body.tiene_llave:
			cambiando_nivel = true
			
			body.MostrarMensaje("Entrando al siguiente nivel...")
			
			await get_tree().create_timer(1.0).timeout
			
			get_tree().change_scene_to_file(siguiente_nivel)
		
		else:
			body.MostrarMensaje("Necesitas una llave")
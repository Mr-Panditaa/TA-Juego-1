extends Area3D

@export var fuerza_salto: float = 12.0
@export var solo_si_cae: bool = false

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body) -> void:
	if body.is_in_group("player"):
		
		if solo_si_cae and body.velocity.y > 0:
			return
		
		body.velocity.y = fuerza_salto
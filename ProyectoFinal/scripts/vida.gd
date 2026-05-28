extends Area3D

@export var velocidad_rotacion: float = 0.015
@export var altura_flotacion: float = 0.2

var posicion_inicial: Vector3
var tiempo: float = 0.0

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	posicion_inicial = global_position
	add_to_group("items")

func _process(delta: float) -> void:
	rotation.y += velocidad_rotacion
	tiempo += delta
	global_position.y = posicion_inicial.y + sin(tiempo * 2.0) * altura_flotacion

func _on_body_entered(body) -> void:
	if body.is_in_group("player"):
		var se_curo: bool = body.AgregarVida()
		
		if se_curo:
			queue_free()
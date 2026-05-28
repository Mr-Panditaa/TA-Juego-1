extends Area3D

@export var velocidad_empuje: float = 6.0

# Dirección del movimiento
@export var direccion: Vector3 = Vector3.FORWARD

var player_dentro = null

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	
	direccion = direccion.normalized()

func _physics_process(delta: float) -> void:
	if player_dentro:
		player_dentro.global_position += direccion * velocidad_empuje * delta

func _on_body_entered(body) -> void:
	if body.is_in_group("player"):
		player_dentro = body

func _on_body_exited(body) -> void:
	if body == player_dentro:
		player_dentro = null
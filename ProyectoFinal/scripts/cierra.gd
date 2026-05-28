extends Area3D

@export var velocidad_movimiento: float = 2.0
@export var altura_movimiento: float = 2.0
@export var velocidad_rotacion: float = 8.0

var posicion_inicial: Vector3
var tiempo: float = 0.0

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	posicion_inicial = global_position

func _process(delta: float) -> void:
	tiempo += delta
	
	# Movimiento arriba y abajo
	global_position.y = posicion_inicial.y + sin(tiempo * velocidad_movimiento) * altura_movimiento
	
	# Rotación tipo sierra
	rotation.z += velocidad_rotacion * delta

func _on_body_entered(body) -> void:
	if body.is_in_group("player"):
		body.Die()
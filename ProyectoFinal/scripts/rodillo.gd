extends Area3D

@export var velocidad_avance: float = 3.0
@export var distancia_avance: float = 5.0
@export var velocidad_rotacion: float = 8.0
@export var tiempo_espera: float = 0.0

@export var direccion: Vector3 = Vector3.LEFT

var posicion_inicial: Vector3
var avanzando: bool = true
var tiempo: float = 0.0

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	posicion_inicial = global_position
	
	direccion = direccion.normalized()

func _process(delta: float) -> void:

	# MOVIMIENTO
	if avanzando:
		global_position += direccion * velocidad_avance * delta
		
		global_position.y = posicion_inicial.y

		# ROTACIÓN COMO TRONCO REAL
		if direccion == Vector3.LEFT:
			$SpikeBlockWide.rotation.y += velocidad_rotacion * delta
		
		elif direccion == Vector3.RIGHT:
			$SpikeBlockWide.rotation.y -= velocidad_rotacion * delta
		
		elif direccion == Vector3.FORWARD:
			$SpikeBlockWide.rotation.x += velocidad_rotacion * delta
		
		elif direccion == Vector3.BACK:
			$SpikeBlockWide.rotation.x -= velocidad_rotacion * delta

		# DISTANCIA
		if global_position.distance_to(posicion_inicial) >= distancia_avance:
			avanzando = false
			tiempo = 0.0

	else:
		tiempo += delta

		if tiempo >= tiempo_espera:
			global_position = posicion_inicial
			avanzando = true

func _on_body_entered(body) -> void:
	if body.is_in_group("player"):
		body.Die()

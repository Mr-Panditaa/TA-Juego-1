extends Area3D

@export var velocidad_avance: float = 5.0
@export var distancia_avance: float = 8.0
@export var velocidad_rotacion: float = 8.0
@export var tiempo_reaparicion: float = 1.0

@export var direccion: Vector3 = Vector3.BACK

var posicion_inicial: Vector3
var tiempo: float = 0.0
var activa: bool = true

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	posicion_inicial = global_position
	direccion = direccion.normalized()

func _process(delta: float) -> void:
	if activa:
		global_position += direccion * velocidad_avance * delta
		global_position.y = posicion_inicial.y
		
		$SpikeBlock.rotation.x += velocidad_rotacion * delta
		
		if global_position.distance_to(posicion_inicial) >= distancia_avance:
			DesactivarPincho()
	else:
		tiempo += delta
		
		if tiempo >= tiempo_reaparicion:
			ReactivarPincho()

func DesactivarPincho():
	activa = false
	visible = false
	tiempo = 0.0
	
	# Desactiva la colisión del Area3D
	$CollisionShape3D.disabled = true
	
	# Desactiva la colisión física del modelo si existe
	$SpikeBlock/StaticBody3D/CollisionShape3D.disabled = true

func ReactivarPincho():
	global_position = posicion_inicial
	visible = true
	activa = true
	
	$CollisionShape3D.disabled = false
	$SpikeBlock/StaticBody3D/CollisionShape3D.disabled = false

func _on_body_entered(body) -> void:
	if activa and body.is_in_group("player"):
		body.Die()
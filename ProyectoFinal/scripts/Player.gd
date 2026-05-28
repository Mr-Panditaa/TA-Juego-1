class_name Player
extends CharacterBody3D

var coins: int = 0
var vidas: int = 3
var max_vidas: int = 3
var tiene_llave: bool = false
var comodines: int = 0

const SPEED = 5.0
const JUMP_VELOCITY = 5.2
const GRAVITY_MULTIPLIER = 2.2
const FALL_MULTIPLIER = 2.8

@export var sens: float = 0.001

var ultimo_checkpoint: Vector3 = Vector3.ZERO

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	add_to_group("player")
	ultimo_checkpoint = global_position
	ActualizarUI()

func _input(event):
	if Input.is_action_just_pressed("salir"):
		get_tree().quit()
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * sens)

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		var g = ProjectSettings.get_setting("physics/3d/default_gravity")
		if velocity.y > 0:
			velocity.y -= g * GRAVITY_MULTIPLIER * delta
		else:
			velocity.y -= g * FALL_MULTIPLIER * delta
		ComprobarAltura()
	
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	var input_dir := Input.get_vector("izquierda", "derecha", "adelante", "atras")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED * 4 * delta)
		velocity.z = move_toward(velocity.z, 0, SPEED * 4 * delta)
	
	move_and_slide()

func ComprobarAltura():
	if global_position.y <= -15.0:
		Die()

func Die():
	vidas -= 1
	
	if vidas <= 0:
		if comodines > 0:
			comodines -= 1
			vidas = 1
			ActualizarUI()
			MostrarMensaje("Comodín usado")
			RespawnEnCheckpoint()
		else:
			get_tree().reload_current_scene()
	else:
		ActualizarUI()
		RespawnEnCheckpoint()

func RespawnEnCheckpoint():
	global_position = ultimo_checkpoint
	velocity = Vector3.ZERO

func AgregarMoneda():
	coins += 1
	
	if coins % 10 == 0:
		if vidas < max_vidas:
			vidas += 1
			MostrarMensaje("Ganaste +1 vida")
		else:
			comodines += 1
			MostrarMensaje("Ganaste 1 comodín")
	
	ActualizarUI()

func AgregarVida():
	if vidas < max_vidas:
		vidas += 1
		ActualizarUI()
		return true
	
	return false

func EstablecerCheckpoint(nueva_posicion: Vector3):
	ultimo_checkpoint = nueva_posicion
	print("✓ Checkpoint establecido en: ", nueva_posicion)

func ActualizarUI():
	var texto_llave := "No"
	
	if tiene_llave:
		texto_llave = "Sí"

	$CanvasLayer/Control/Label.text = \
	"Coins: " + str(coins) + \
	" | Vidas: " + str(vidas) + "/" + str(max_vidas) + \
	" | Comodín: " + str(comodines) + \
	" | Llave: " + texto_llave
func RecogerLlave():
	tiene_llave = true
	ActualizarUI()
	MostrarMensaje("Llave recogida")

func MostrarMensaje(texto: String):
	$CanvasLayer/Control/MensajeLabel.text = texto
	$CanvasLayer/Control/MensajeLabel.visible = true
	
	await get_tree().create_timer(2.0).timeout
	
	$CanvasLayer/Control/MensajeLabel.visible = false

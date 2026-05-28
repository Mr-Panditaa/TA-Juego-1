extends Area3D

@export var velocidad_subida: float = 4.0

var player_dentro = null

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _process(_delta: float) -> void:
	if player_dentro:
		if Input.is_action_pressed("ui_accept"):
			player_dentro.velocity.y = velocidad_subida
		elif Input.is_action_pressed("atras"):
			player_dentro.velocity.y = -velocidad_subida
		else:
			player_dentro.velocity.y = 0

func _on_body_entered(body) -> void:
	if body.is_in_group("player"):
		player_dentro = body

func _on_body_exited(body) -> void:
	if body == player_dentro:
		player_dentro = null
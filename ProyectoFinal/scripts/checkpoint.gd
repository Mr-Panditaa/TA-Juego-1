extends Area3D

@export var es_checkpoint_inicio: bool = false
@export var efecto_visual: bool = true

var ya_activado: bool = false

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	add_to_group("checkpoints")

func _on_body_entered(body) -> void:
	if body.is_in_group("player") and not ya_activado:
		ActivarCheckpoint(body)

func ActivarCheckpoint(player):
	ya_activado = true
	
	if player:
		player.EstablecerCheckpoint(player.global_position)
		player.MostrarMensaje("Checkpoint activado")

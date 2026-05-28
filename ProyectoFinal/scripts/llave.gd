extends Area3D

@export var velocidad_rotacion: float = 1.5

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	add_to_group("items")

func _process(delta: float) -> void:
	$Key.rotation.y += velocidad_rotacion * delta

func _on_body_entered(body) -> void:
	if body.is_in_group("player"):
		body.RecogerLlave()
		queue_free()
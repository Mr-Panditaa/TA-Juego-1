extends Area3D

@export var velocidad_rotacion: float = 0.01

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	add_to_group("items")

func _process(_delta: float) -> void:
	rotation.y += velocidad_rotacion

func _on_body_entered(body) -> void:
	if body.is_in_group("player"):
		body.AgregarMoneda()
		queue_free()

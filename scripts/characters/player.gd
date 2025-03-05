extends CharacterBody2D
class_name Player

@export var speed: int = 250


func _process(_delta: float) -> void:
	"""Обрабатывает движение игрока и поворот к позиции мыши."""
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	look_at(get_global_mouse_position())
	move_and_slide()

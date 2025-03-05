extends StaticBody2D

signal player_entered


func _go_inside_area_entered(body: Node2D) -> void:
	"""Отправляет сигнал, если игрок входит в область."""
	if body.is_in_group("player"):
		player_entered.emit()

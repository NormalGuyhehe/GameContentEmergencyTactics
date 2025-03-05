extends Area2D

signal npc_entered(body: NPC)


func _save_zone_entered(body: Node2D) -> void:
	"""Вызывает сигнал, когда NPC входит в безопасную зону."""
	if body.is_in_group("npcs"):
		npc_entered.emit(body)

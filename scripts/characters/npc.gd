# ДОРАБОТАТЬ - NPC ДОЛЖЕН ТАРГИТЬСЯ ОДИН РАЗ, НЕ БОЛЕЕ 
extends CharacterBody2D 
class_name NPC

@export var speed: int = 150
@export var follow_distance: int = 80

var npc_id: String
var player: Player = null
var flag_target = 0
""" ^В А Ж Н О ^"""

func _physics_process(delta: float) -> void:
	"""Следует за игроком, если он вне предела follow_distance."""
	if player:
		print("Состояние игрок", player)
		var distance_to_player = global_position.distance_to(player.global_position)
		if distance_to_player > follow_distance:
			var direction = (player.global_position - global_position).normalized()
			velocity = direction * speed
			move_and_slide()
		else: velocity = Vector2.ZERO
		"""если не достаточно расстояние до того, чтобы *дернуть* NPC, то
		их вектор будет ZERO (проще - будет равен 0) """
func _on_player_detected(body: Node2D) -> void:
	"""Начинает следить за игроком при обнаружении."""
	if body.is_in_group("player"):
		player = body
		print(player)
		NPCManager.npc_data[npc_id] = NPCManager.NPC_State.FOLLOWING
		print("Игрок в зоне видимости, %s теперь следует за игроком" % npc_id)

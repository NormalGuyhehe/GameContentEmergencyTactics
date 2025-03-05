extends Level1Base


func _ready() -> void:
	"""Инициализирует NPC в доме, если их нет, и спавнит их."""
	super._ready()
	if NPCManager.get_npcs_by_state(NPCManager.NPC_State.IN_HOUSE).is_empty():
		var npc_count = npc_spawn_coords.size()
		NPCManager.set_npc_count(NPCManager.NPC_State.IN_HOUSE, npc_count)
	spawn_npcs_for_state(NPCManager.NPC_State.IN_HOUSE, $NPCSpawnPoints)

func _go_outside_area_entered(body: Node2D) -> void:
	"""Переключает сцену на уровень улицы при входе в область."""
	get_tree().change_scene_to_file("res://scenes/levels/level1/level1_street.tscn")

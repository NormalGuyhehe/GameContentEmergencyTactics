extends Node2D
class_name Level1Base

var npc_scene: PackedScene = preload("res://scenes/characters/npc.tscn")
var fire_scene: PackedScene = preload("res://scenes/objects/fire.tscn")
"""импортируем необходимые сцены - npc.tsn, fire.tsn"""

var level1_task_data: Dictionary = { 
	"extinguish_fires": {
		"description": "Потушить очаги огня", 
		"current": 0, "target": 3
	},
	"escort_to_safe_zone": {
		"description": "Спасти людей и отвести в безопасную зону", 
		"current": 0, "target": 3
	},
}
"""^используется в TaskManager.set_new_data($object)^"""

@onready var npc_spawn_coords: Array[Node] = $NPCSpawnPoints.get_children()
@onready var fire_spawn_coords: Array[Node] = $FireSpawnPoints.get_children()
#^      ^ - берет потомков при инициализации уровня

func _ready() -> void:
	"""Инициализирует задачи и создает элементы Taskbar."""
	TaskManager.set_new_data(level1_task_data)
	$Taskbar.create_taskbar_items()

func spawn_npcs_for_state(state: int, container: Node) -> void:
	""""Создает NPC по заданному состоянию и добавляет их в контейнер."""
	var npc_ids = NPCManager.get_npcs_by_state(state)
	for i in range(npc_ids.size()):
		var npc = npc_scene.instantiate()
		npc.npc_id = npc_ids[i]
		npc.global_position = npc_spawn_coords[i].global_position
		container.call_deferred("add_child", npc)

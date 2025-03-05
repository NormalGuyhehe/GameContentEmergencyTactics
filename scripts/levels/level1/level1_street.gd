extends Level1Base

@onready var extinguish_rate: float = $Player/FireExtinguisher.extinguish_rate


func _ready() -> void:
	"""Инициализирует уровень, спавнит огонь и NPC."""
	super._ready()
	spawn_fire()
	spawn_npcs_for_state(NPCManager.NPC_State.FOLLOWING, $NPCSpawnPoints)

func spawn_fire() -> void:
	"""Создает огонь на точках спавна, если задача не выполнена."""
	if TaskManager.tasks["extinguish_fires"].current >= TaskManager.tasks["extinguish_fires"].target: 
		return
	for point in fire_spawn_coords:
		var fire: Fire = fire_scene.instantiate()
		fire.global_position = point.global_position
		$FireSpawnPoints.add_child(fire)

func _on_fire_affected(fire: Fire, is_extinguishing: bool) -> void:
	"""Наносит урон огню и обновляет задачу, если огонь потушен."""
	if is_extinguishing:
		fire.take_damage(extinguish_rate * get_physics_process_delta_time())
		if fire.health <= 0:
			var current_task = TaskManager.tasks["extinguish_fires"].current
			TaskManager.update_task("extinguish_fires", current_task+1)

func _on_house_player_entered() -> void:
	""""Переключает сцену на дом, если все пожары потушены."""
	if TaskManager.tasks["extinguish_fires"].current < 3:
		print("Потушите огонь, иначе вход внутрь запрещён!")
		return
	get_tree().change_scene_to_file("res://scenes/levels/level1/level1_in_home.tscn")

func _save_zone_npc_entered(body: NPC) -> void:
	"""Обновляет состояние NPC и задачу при входе в безопасную зону."""
	NPCManager.npc_data[body.npc_id] = NPCManager.NPC_State.IN_SAVE_ZONE
	var current_task = TaskManager.tasks["escort_to_safe_zone"].current
	TaskManager.update_task("escort_to_safe_zone", current_task+1)
	body.queue_free()

extends Node

enum NPC_State {
	IN_HOUSE,
	FOLLOWING,
	IN_SAVE_ZONE
}

var npc_data: Dictionary = {}
var npc_counter: int = 0

func set_npc_count(state: int, desired_count: int) -> void:
	"""Устанавливает заданное количество NPC в указанном состоянии."""
	var current_ids = []
	print(current_ids)
	for id in npc_data.keys():
		if npc_data[id] == state:
			current_ids.append(id)
	var current_count = current_ids.size()
	if current_count < desired_count:
		for i in range(desired_count - current_count):
			add_npc(state)
	elif current_count > desired_count:
		for i in range(current_count - desired_count):
			remove_npc(current_ids.pop_back())

func add_npc(state: int) -> String:
	"""Добавляет NPC с указанным состоянием и возвращает его ID."""
	var id = generate_npc_id()
	"""дает ID-шки неписям, ^ благодаря этому методу"""
	npc_data[id] = state
	print()
	return id

func remove_npc(npc_id: String) -> void:
	"""Удаляет NPC по его ID."""
	npc_data.erase(npc_id)

func generate_npc_id() -> String:
	"""Генерирует уникальный ID для NPC."""
	npc_counter += 1
	return "npc_" + str(npc_counter)

func get_npcs_by_state(state: int) -> Array:
	"""Возвращает массив ID всех NPC в указанным состоянием."""
	var ids = []
	print("массив ID NPC", ids)
	for id in npc_data.keys():
		if npc_data[id] == state:
			print("состояние NPC по ID", ids)
			ids.append(id)
	#возвращаем массив ID неписей
	print(ids)
	return ids
	

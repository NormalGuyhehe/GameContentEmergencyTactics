# ДОБАВИТЬ - МЕТОД is_task_complete ДЛЯ ПРОВЕРКИ СТАТУСВ ЗАДАЧИ
extends Node

signal task_updated(task_name: String, current: int, target: int)

var tasks: Dictionary = {}

func update_task(task_id: String, new_value: int) -> void:
	"""Обновляет текущее значение задачи и вызывает сигнал обновления."""
	if tasks.has(task_id):
		var task = tasks[task_id]
		task.current = clamp(new_value, 0, task.target)
		task_updated.emit(task_id, task.current, task.target)
	else: push_warning("TaskManager: задание '%s' не найдено" % task_id)

func get_task_text(task_id: String) -> String:
	"""Возвращает текст задачи в формате 'описание: текущее из целевого'."""
	if tasks.has(task_id):
		var task = tasks[task_id]
		return "%s: %d из %d" % [task.description, task.current, task.target]
	return ""

func remove_task(task_id: String) -> void:
	"""Удаляет задачу по её ID."""
	if tasks.has(task_id):
		tasks.erase(task_id)
	else: push_warning("TaskManager: задание '%s' не найдено" % task_id)
	
func set_new_data(new_task: Dictionary) -> void:
	"""Обновляет данные задач, если структура изменилась."""
	if new_task.keys() == tasks.keys():
		return
	tasks = new_task.duplicate()

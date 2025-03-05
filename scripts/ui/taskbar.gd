extends CanvasLayer

var task_labels: Dictionary = {}


func _ready() -> void:
	"""Подключает _on_task_updated к сигналу TaskManager."""
	TaskManager.task_updated.connect(_on_task_updated)

func _on_task_updated(task_name: String, current: int, target: int) -> void:
	"""Обновляет текст задачи на панели при её изменении."""
	if TaskManager.tasks.has(task_name) and task_labels.has(task_name):
		task_labels[task_name].text = TaskManager.get_task_text(task_name)

func create_taskbar_items() -> void:
	"""Создаёт элементы задач на панели и отображает их."""
	var container = $TaskbarContent/VBoxContainer
	
	for task_id in TaskManager.tasks.keys():
		var task = TaskManager.tasks[task_id]
		var label = Label.new()
		
		label.name = task_id
		label.text = "%s: %d из %d" % [task.description, task.current, task.target]
		task_labels[task_id] = label
		
		container.add_child(label)

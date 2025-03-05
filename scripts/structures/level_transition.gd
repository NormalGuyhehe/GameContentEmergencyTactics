extends Area2D

@export var level_scene: PackedScene
@export var description: String

var is_player_in_area: bool = false
#в области или нет

func _process(_delta: float) -> void:
	"""^стандартный метод физического движка, представляющий 
	из себя обычный игровой цикл^"""
	
	"""Переключает сцену на level_scene при нажатии E, если игрок в области."""
	if Input.is_action_just_pressed("accept") and is_player_in_area:
		"""^Отслеживает нажатие произошедшее^+ ^и игрок в зоне сигнала^"""
		"""V берет дерево Узлов, V изменяет сцену на определенную в переменной
		level_scene"""
		get_tree().change_scene_to_packed(level_scene)

func _on_body_entered(body: Node2D) -> void:
	"""Обрабатывает вход игрока в область, выводя сообщение."""
	"""Наследуется от _on_body_entered()"""
	if body.is_in_group("player"):
		"""^body - это игрок, либо тело^"""
		""" V выводит название уровня, \n является переносом на новую строку"""
		print("%s\nНажмите на E чтобы начать" % description)
		is_player_in_area = true
		

func _on_body_exited(body: Node2D) -> void:
	"""^наследуется или переопределяется^ от > _on_body_exited() <"""
	"""Обрабатывает выход игрока из области."""
	is_player_in_area = false

extends Area2D

signal fire_affected(fire: Fire, is_extinguishing: bool)

@export var extinguish_rate: float

@onready var particles: GPUParticles2D = $GPUParticles2D


func _process(_delta: float) -> void:
	"""Активирует частицы по нажатию 'fire' и отправляет сигнал при взаимодействии с огнем."""
	var is_active = Input.is_action_pressed("fire")
	particles.emitting = is_active

	if is_active:
		for area in get_overlapping_areas():
			"""^ проверяет, есть ли здесь область^"""
			if area.is_in_group("fires"):
				#^если область из группы огонь^
				#V срабатывает V сигнал на тушение
				fire_affected.emit(area, true)

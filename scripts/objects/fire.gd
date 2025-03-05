extends Area2D
class_name Fire

@export var health: float = 100.0


func take_damage(amount: float) -> void:
	"""Уменьшает здоровье огня и обновляет прозрачность."""
	health -= amount
	#health - здоровье огня
	#amount - аналог damage
	modulate.a = health / 100
	print(modulate.a)
	#modulate.a - изменяет альфа канал ( по простому - прозрачность) огня
	if health <= 0: 
		#если меньше нуля или равно 0 - вызов метода
		extinguish()

func extinguish() -> void:
	"""Уничтожает объект огня."""
	print("Огонь потушен")
	queue_free()
	#удаляет объект

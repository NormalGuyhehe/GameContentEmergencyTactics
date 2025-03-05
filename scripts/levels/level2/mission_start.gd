extends CanvasLayer

signal spawn_player(button_index: int)

func _ready() -> void:
	var buttons = $VBoxContainer/Buttons.get_children()
	for i in buttons.size():
		buttons[i].connect("pressed", Callable(self, "_on_button_pressed").bind(i))

func _on_button_pressed(button_index: int) -> void:
	spawn_player.emit(button_index)
	queue_free()

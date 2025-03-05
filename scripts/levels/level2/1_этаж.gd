extends Node2D

var second_floor_scene: PackedScene = preload("res://scenes/levels/level_2/2_этаж.tscn")
var player_scene: PackedScene = preload("res://scenes/characters/player.tscn")
@onready var start_points: Array[Node] = $"StartPoints".get_children()


func _go_second_floor_area_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("Переход на второй этаж")
		get_tree().change_scene_to_file(second_floor_scene.resource_path)

func _on_mission_start_gui_spawn_player(button_index: int) -> void:
	var player = player_scene.instantiate()
	player.global_position = start_points[button_index].position
	add_child(player)

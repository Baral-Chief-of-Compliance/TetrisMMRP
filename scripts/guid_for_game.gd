extends Control

@export
## Сцена с игрой
var game_packed_scene : PackedScene = preload('res://scenes/Main.tscn')


func _on_play_button_button_down():
	get_tree().change_scene_to_packed(game_packed_scene)

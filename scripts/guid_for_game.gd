extends Control

@export
## Сцена с игрой
var game_packed_scene : PackedScene = preload('res://scenes/Main.tscn')

@export
## Музыка в обучении
var music_audio_stream : AudioStreamPlayer2D = null

func _on_play_button_button_down():
	if (music_audio_stream):
		music_audio_stream.stop()
	get_tree().change_scene_to_packed(game_packed_scene)

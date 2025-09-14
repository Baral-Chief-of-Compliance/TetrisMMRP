extends Control


@export
## Сцена меню игры
var main_menu_scene_packed : PackedScene = preload("res://scenes/MainMenu.tscn")

## Функция перехода на глвное меню
func go_main_menu_scene():
	get_tree().change_scene_to_packed(main_menu_scene_packed)

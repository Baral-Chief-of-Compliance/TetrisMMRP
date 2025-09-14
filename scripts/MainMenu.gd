extends CanvasLayer

@export 
## Главное меню 
var main_menu : VBoxContainer 

@export
## Меню с настройками
var settings_menu : VBoxContainer

@export
## Сцена с игрой
var game_menu_packed_scene : PackedScene = preload('res://scenes/Main.tscn')


@export
## ссылка на сайт ММРП
var site_mmrp : String = 'https://mmrp.ru/'

@onready var os_name : String = OS.get_name()

## Выход из игры
func _on_exit_btn_button_down():
	if os_name == 'Android':
		get_tree().quit(true)
	else:
		get_tree().quit()


## Переход на сайте ММРП
func _on_mmrp_btn_button_down():
	var error = OS.shell_open(site_mmrp)
	
	if error != OK:
		push_error("Не удалось открыть ссылку: " + site_mmrp)
		print("Ошибка при открытии URL: ", error)

## Переход назад в меню
func _on_back_to_menu_btn_button_down():
	settings_menu.hide()
	main_menu.show()

## Переход в меню настроек
func _on_settings_btn_button_down():
	main_menu.hide()
	settings_menu.show()

## Переход на с цену игры
func _on_play_btn_button_down():
	get_tree().change_scene_to_packed(game_menu_packed_scene)

extends CanvasLayer

@export 
## Главное меню 
var main_menu : VBoxContainer 

@export var DOMAIN_NAME : String = 'localhost'
@export var HTTPS : bool = false


@export
## Сцена с игрой
var game_guid_packed_scene : PackedScene = preload('res://scenes/guid_for_game.tscn')


@export
## Сцена с таблицей лидеров
var leaderboard_scene : PackedScene = preload('res://scenes/LeaderBoardsWindow.tscn')



@export
## ссылка на сайт ММРП
var site_mmrp : String = 'https://mmrp.ru/'

@onready var os_name : String = OS.get_name()

## Выход из игры
func _on_exit_btn_button_down():
	if os_name == 'Android':
		get_tree().quit(true)
	elif os_name == 'Web':
		var http_protocol = "http"
		if HTTPS:
			http_protocol = "https"
			
		JavaScriptBridge.eval("window.location.href='{http}://{domain}/'".format(
			{"http": http_protocol, "domain": DOMAIN_NAME}
		))
	else:
		get_tree().quit()


## Переход на сайте ММРП
func _on_mmrp_btn_button_down():
	var error = OS.shell_open(site_mmrp)
	
	if error != OK:
		push_error("Не удалось открыть ссылку: " + site_mmrp)
		print("Ошибка при открытии URL: ", error)

## Переход на с цену игры
func _on_play_btn_button_down():
	get_tree().change_scene_to_packed(game_guid_packed_scene)

#при нажатии на кнопку списков лидеров игры
func _on_leader_board_btn_button_down():
	get_tree().change_scene_to_packed(leaderboard_scene)

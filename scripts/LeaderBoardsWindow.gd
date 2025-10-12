extends Control

@export
## Сцена с главным меню
var main_game_menu : PackedScene = preload('res://scenes/MainMenu.tscn')

@export
##Сцена полоски пользователя
var user_info_packed_scene : PackedScene = preload("res://scenes/user_info_in_leader_board.tscn")

@onready var http_request = HTTPRequest.new()

@export
#Блок в котором будут отображаться пользователи
var users_block : VBoxContainer = null

@export
#уведолмение о том, что нет пользователй в таблице лидеров за все время
var no_user_all_leaderboard : Label = null


@export
#уведомление о том, что нет пользователей в таблице лидеров за сегодня
var no_user_today_leaderboard : Label = null


var all_leaderboard : bool = true
var today_leaderboard : bool = true


var users : Array = [
#	{"name": "Алексей", "score": 85},
#	{"name": "Мария", "score": 92},
#	{"name": "Иван", "score": 78},
#	{"name": "Елена", "score": 95},
#	{"name": "Дмитрий", "score": 67},
#	{"name": "Ольга", "score": 88},
#	{"name": "Сергей", "score": 73},
#	{"name": "Анна", "score": 91},
#	{"name": "Павел", "score": 82},
#	{"name": "Наталья", "score": 79},
#	{"name": "Андрей", "score": 86},
#	{"name": "Татьяна", "score": 94},
#	{"name": "Михаил", "score": 70},
#	{"name": "Юлия", "score": 89},
#	{"name": "Владимир", "score": 77},
#	{"name": "Светлана", "score": 83},
#	{"name": "Артем", "score": 90},
#	{"name": "Екатерина", "score": 87},
#	{"name": "Константин", "score": 74},
#	{"name": "Людмила", "score": 81},
#	{"name": "Алексей", "score": 85},
#	{"name": "Мария", "score": 92},
#	{"name": "Иван", "score": 78},
#	{"name": "Елена", "score": 95},
#	{"name": "Дмитрий", "score": 67},
#	{"name": "Ольга", "score": 88},
#	{"name": "Сергей", "score": 73},
#	{"name": "Анна", "score": 91},
#	{"name": "Павел", "score": 82},
#	{"name": "Наталья", "score": 79},
#	{"name": "Андрей", "score": 86},
#	{"name": "Татьяна", "score": 94},
#	{"name": "Михаил", "score": 70},
#	{"name": "Юлия", "score": 89},
#	{"name": "Владимир", "score": 77},
#	{"name": "Светлана", "score": 83},
#	{"name": "Артем", "score": 90},
#	{"name": "Екатерина", "score": 87},
#	{"name": "Константин", "score": 74},
#	{"name": "Людмила", "score": 81},
#	{"name": "Алексей", "score": 85},
#	{"name": "Мария", "score": 92},
#	{"name": "Иван", "score": 78},
#	{"name": "Елена", "score": 95},
#	{"name": "Дмитрий", "score": 67},
#	{"name": "Ольга", "score": 88},
#	{"name": "Сергей", "score": 73},
#	{"name": "Анна", "score": 91},
#	{"name": "Павел", "score": 82},
#	{"name": "Наталья", "score": 79},
#	{"name": "Андрей", "score": 86},
#	{"name": "Татьяна", "score": 94},
#	{"name": "Михаил", "score": 70},
#	{"name": "Юлия", "score": 89},
#	{"name": "Владимир", "score": 77},
#	{"name": "Светлана", "score": 83},
#	{"name": "Артем", "score": 90},
#	{"name": "Екатерина", "score": 87},
#	{"name": "Константин", "score": 74},
#	{"name": "Людмила", "score": 81},
#	{"name": "Алексей", "score": 85},
#	{"name": "Мария", "score": 92},
#	{"name": "Иван", "score": 78},
#	{"name": "Елена", "score": 95},
#	{"name": "Дмитрий", "score": 67},
#	{"name": "Ольга", "score": 88},
#	{"name": "Сергей", "score": 73},
#	{"name": "Анна", "score": 91},
#	{"name": "Павел", "score": 82},
#	{"name": "Наталья", "score": 79},
#	{"name": "Андрей", "score": 86},
#	{"name": "Татьяна", "score": 94},
#	{"name": "Михаил", "score": 70},
#	{"name": "Юлия", "score": 89},
#	{"name": "Владимир", "score": 77},
#	{"name": "Светлана", "score": 83},
#	{"name": "Артем", "score": 90},
#	{"name": "Екатерина", "score": 87},
#	{"name": "Константин", "score": 74},
#	{"name": "Людмила", "score": 81}
]


func get_leaderboards():
#	Получить таблицу лидеров
	today_leaderboard = false
	all_leaderboard = true
	
	var url = Globals.api_path + "leaderboard/"
	var error = http_request.request(url)
	if error != OK:
		print("Ошибка при создании запроса: ", error)
		
func get_leaderboards_today():
#	Получить таблицу лидеров за сегодня
	today_leaderboard = true
	all_leaderboard = false
	
	var url = Globals.api_path + "leaderboard/today"
	var error = http_request.request(url)
	if error != OK:
		print("Ошибка при создании запроса: ", error)

# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(http_request)
	http_request.request_completed.connect(_on_request_completed)
	
	get_leaderboards_today()
	

	for user in users:
		var user_scene = user_info_packed_scene.instantiate()
		user_scene.username = user.name
		user_scene.user_score = user.score
		users_block.add_child(user_scene)
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func show_notif():
	no_user_all_leaderboard.hide()
	no_user_today_leaderboard.hide()
	if len(users) == 0:
		if all_leaderboard:
			no_user_all_leaderboard.show()
		elif today_leaderboard:
			no_user_today_leaderboard.show()

#При нажати домой
func _on_texture_button_button_down():
		get_tree().change_scene_to_packed(main_game_menu)
		
		

func _on_request_completed(
	result: int, 
	response_code: int, 
	headers: PackedStringArray,
	body: PackedByteArray):
	if result == HTTPRequest.RESULT_SUCCESS:
		if response_code == 200:
			var response = body.get_string_from_utf8()
			print("Успешный ответ: ", response)
			
			var json = JSON.new()
			var parser_result = json.parse(response)
			if parser_result == OK:
				var data = json.get_data()
				users = data.get("users")
				show_notif()
		else:
			print("Ошибка HTTP: ", response_code)
	else:
		print("Ошибка запроса: ", result)
		

func _on_all_button_down():
#	получить таблицу лидеров за все время
	get_leaderboards()


func _on_today_button_down():
#	получить таблицу лидеров за сегодня
	get_leaderboards_today()

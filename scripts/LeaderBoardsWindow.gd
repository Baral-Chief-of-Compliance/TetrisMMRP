extends Control

@export
## Сцена с главным меню
var main_game_menu : PackedScene = preload('res://scenes/MainMenu.tscn')

@export
##Сцена полоски пользователя
var user_info_packed_scene : PackedScene = preload("res://scenes/user_info_in_leader_board.tscn")

@export
#Блок в котором будут отображаться пользователи
var users_block : VBoxContainer = null

var users : Array = [
	{"name": "Алексей", "score": 85},
	{"name": "Мария", "score": 92},
	{"name": "Иван", "score": 78},
	{"name": "Елена", "score": 95},
	{"name": "Дмитрий", "score": 67},
	{"name": "Ольга", "score": 88},
	{"name": "Сергей", "score": 73},
	{"name": "Анна", "score": 91},
	{"name": "Павел", "score": 82},
	{"name": "Наталья", "score": 79},
	{"name": "Андрей", "score": 86},
	{"name": "Татьяна", "score": 94},
	{"name": "Михаил", "score": 70},
	{"name": "Юлия", "score": 89},
	{"name": "Владимир", "score": 77},
	{"name": "Светлана", "score": 83},
	{"name": "Артем", "score": 90},
	{"name": "Екатерина", "score": 87},
	{"name": "Константин", "score": 74},
	{"name": "Людмила", "score": 81},
	{"name": "Алексей", "score": 85},
	{"name": "Мария", "score": 92},
	{"name": "Иван", "score": 78},
	{"name": "Елена", "score": 95},
	{"name": "Дмитрий", "score": 67},
	{"name": "Ольга", "score": 88},
	{"name": "Сергей", "score": 73},
	{"name": "Анна", "score": 91},
	{"name": "Павел", "score": 82},
	{"name": "Наталья", "score": 79},
	{"name": "Андрей", "score": 86},
	{"name": "Татьяна", "score": 94},
	{"name": "Михаил", "score": 70},
	{"name": "Юлия", "score": 89},
	{"name": "Владимир", "score": 77},
	{"name": "Светлана", "score": 83},
	{"name": "Артем", "score": 90},
	{"name": "Екатерина", "score": 87},
	{"name": "Константин", "score": 74},
	{"name": "Людмила", "score": 81},
	{"name": "Алексей", "score": 85},
	{"name": "Мария", "score": 92},
	{"name": "Иван", "score": 78},
	{"name": "Елена", "score": 95},
	{"name": "Дмитрий", "score": 67},
	{"name": "Ольга", "score": 88},
	{"name": "Сергей", "score": 73},
	{"name": "Анна", "score": 91},
	{"name": "Павел", "score": 82},
	{"name": "Наталья", "score": 79},
	{"name": "Андрей", "score": 86},
	{"name": "Татьяна", "score": 94},
	{"name": "Михаил", "score": 70},
	{"name": "Юлия", "score": 89},
	{"name": "Владимир", "score": 77},
	{"name": "Светлана", "score": 83},
	{"name": "Артем", "score": 90},
	{"name": "Екатерина", "score": 87},
	{"name": "Константин", "score": 74},
	{"name": "Людмила", "score": 81},
	{"name": "Алексей", "score": 85},
	{"name": "Мария", "score": 92},
	{"name": "Иван", "score": 78},
	{"name": "Елена", "score": 95},
	{"name": "Дмитрий", "score": 67},
	{"name": "Ольга", "score": 88},
	{"name": "Сергей", "score": 73},
	{"name": "Анна", "score": 91},
	{"name": "Павел", "score": 82},
	{"name": "Наталья", "score": 79},
	{"name": "Андрей", "score": 86},
	{"name": "Татьяна", "score": 94},
	{"name": "Михаил", "score": 70},
	{"name": "Юлия", "score": 89},
	{"name": "Владимир", "score": 77},
	{"name": "Светлана", "score": 83},
	{"name": "Артем", "score": 90},
	{"name": "Екатерина", "score": 87},
	{"name": "Константин", "score": 74},
	{"name": "Людмила", "score": 81}
]


# Called when the node enters the scene tree for the first time.
func _ready():
	for user in users:
		var user_scene = user_info_packed_scene.instantiate()
		user_scene.username = user.name
		user_scene.user_score = user.score
		users_block.add_child(user_scene)
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#При нажати домой
func _on_texture_button_button_down():
		get_tree().change_scene_to_packed(main_game_menu)

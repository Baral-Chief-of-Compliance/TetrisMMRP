extends Node

var api_path : String = "https://mmrp-games.ru/api/v1/tetris/"


var user_data: Dictionary = {
	"user_id": 0,
	"username": "",
	"email": "",
	"score": 0
}

func save_data():
#	Сохранить данные в хранилище пользователя
	"""Сохранить данные пользователя"""
	var file = FileAccess.open("user://user_data.json", FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(user_data))
		file.close()		

func chek_need_save() -> bool:
#	проверка нужно ли сохранять
	if user_data["user_id"] != 0:
		return true
	else:
		return false
		
func check_need_send_score(score: int) -> bool:
#	Проверка нужно ли сохранять и отправлять данные
	if user_data["score"] < score:
		return true
	else:
		return false
	

func _ready():
	if FileAccess.file_exists("user://user_data.json"):
		var file = FileAccess.open("user://user_data.json", FileAccess.READ)
		if file:
			var content = file.get_as_text()
			file.close()
			
			var json = JSON.new()
			var error = json.parse(content)
			if error == OK:
				user_data["user_id"] = json.get("user_id")
				user_data["username"] = json.get("username")
				user_data["email"] = json.get("email")
				user_data["score"] = json.get("score")
	else:
		var file = FileAccess.open("user://user_data.json", FileAccess.WRITE)
		if file:
			file.store_string(JSON.stringify(user_data))
			file.close()		

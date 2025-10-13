extends Control

#http клиент для получения имени пользователя
@onready var http_request_for_get_username = HTTPRequest.new()

#http клиент для отправки данных
@onready var http_request_to_send_data = HTTPRequest.new()

@export
#кнопка для отправки данных
var btn_create_user : TextureButton = null


@export
#input никнейма
var login_input : TextEdit = null

@export
#input email
var email_input : TextEdit = null


@export
#checkinput для согласия обработки данных
var check_box : CheckBox = null

var user_agree_with_email_send : bool = false

@export
#блок отображающий ошибку
var lableError : Label = null

@export
#сцена меню
var main_menu_scene : PackedScene = preload('res://scenes/MainMenu.tscn')


# Called when the node enters the scene tree for the first time.
func _ready():
	btn_create_user.disabled = true
	
	add_child(http_request_for_get_username)
	http_request_for_get_username.request_completed.connect(_on_request_completed_get_username)
	var get_username_url : String = Globals.api_path + 'get_random_username'
	var error = http_request_for_get_username.request(get_username_url)
	if error != OK:
		print("Ошибка при создании запроса: ", error)
		
	add_child(http_request_to_send_data)
	http_request_to_send_data.request_completed.connect(_on_request_completed_send_data)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_check_box_button_down():
	user_agree_with_email_send = not user_agree_with_email_send
	
	if user_agree_with_email_send:
		btn_create_user.disabled = false
	else:
		btn_create_user.disabled = true


func _on_request_completed_get_username(
	result: int, 
	response_code: int,
	headers: PackedStringArray,
	body: PackedByteArray):
		if result == HTTPRequest.RESULT_SUCCESS and response_code == 200:
			var json = JSON.new()
			if json.parse(body.get_string_from_utf8()) == OK:
				var res = json.data
				login_input.text = res.get('username')
				
				
func _on_request_completed_send_data(
	result: int,
	response_code: int,
	headers: PackedStringArray,
	body: PackedByteArray
):
	var response_body = body.get_string_from_utf8()
	if result == HTTPRequest.RESULT_SUCCESS and response_code == 200:
		var json = JSON.new()
		json.parse(body.get_string_from_utf8())
		var response = json.get_data()
		
		Globals.user_data['user_id'] = response.get('id')
		Globals.user_data['username'] = response.get('name') 
		Globals.user_data['email'] = response.get('email')
		Globals.user_data['score'] = response.get('score')
		
		Globals.save_data()
		get_tree().change_scene_to_packed(main_menu_scene)
		
	else:
		var json = JSON.new()
		json.parse(response_body)
		var response = json.get_data()
		
		lableError.show()
		lableError.text = response.get("detail")

func _on_texture_button_button_down():
#	Отправка данных
	var url = Globals.api_path + "users/"
	var headers = ["Content-Type: application/json"]
	var score = Globals.user_data["score"]
	if not score:
		score = 0
	var body = JSON.stringify({
		"name": login_input.text,
		"email": email_input.text,
		"score": score
	})
		
	var error = http_request_to_send_data.request(
		url,
		headers,
		HTTPClient.METHOD_POST,
		body
	)
	
	if error != OK:
		print(error)

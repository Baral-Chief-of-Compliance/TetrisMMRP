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
	if result == HTTPRequest.RESULT_SUCCESS and response_code == 200:
		var json = JSON.new()
		if json.parse(body.get_string_from_utf8()) == OK:
			var res = json.data
		
		else:
			print("Ошибка HTTP:")
	else:
		print("Ошибка")


func _on_texture_button_button_down():
#	Отправка данных
	pass # Replace with function body.

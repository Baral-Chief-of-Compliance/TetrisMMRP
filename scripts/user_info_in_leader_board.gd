extends MarginContainer

@export
#имя игрока
var username : String = 'Имя игрока'


@export
#кол-во очков пользователя
var user_score : int = 5000

@export
#Узел, который отвечает за имя пользоваетля
var username_label : Label = null


@export
#Узел, который отвечает за очки пользователя
var user_score_label : Label = null

@export
#Золотая иконка
var gold_icon : TextureRect = null

@export
#серебренная иконка
var silver_icon : TextureRect = null


@export
#бронзованя иконка
var bronze_icon : TextureRect = null


@export
#Иконка игрока
var person_iocn : TextureRect = null

var place : int = 100
var user_owner : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	username_label.text = username
	user_score_label.text = str(user_score)
	
	if place == 0:
		gold_icon.show()
	elif place == 1:
		silver_icon.show()
	elif place == 2:
		bronze_icon.show()
		
	if user_owner:
		person_iocn.show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

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

# Called when the node enters the scene tree for the first time.
func _ready():
	username_label.text = username
	user_score_label.text = str(user_score)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

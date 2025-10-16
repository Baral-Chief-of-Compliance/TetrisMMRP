extends Sprite2D


# Предзагруженные текстуры
var textures = [
	preload("res://assets/stickers/phrase_1.png"),
	preload("res://assets/stickers/phrase_2.png"),
	preload("res://assets/stickers/phrase_3.png"),
	preload("res://assets/stickers/phrase_4.png"),
	preload("res://assets/stickers/phrase_5.png"),
	preload("res://assets/stickers/phrase_6.png"),
	preload("res://assets/stickers/phrase_7.png"),
	preload("res://assets/stickers/phrase_8.png")
]

# Called when the node enters the scene tree for the first time.
func _ready():
	change_texture_random()

func change_texture_random():
	if textures.size() > 0:
		var random_index = randi() % textures.size()
		texture = textures[random_index]
	else:
		push_error("Нет загруженных текстур!")
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

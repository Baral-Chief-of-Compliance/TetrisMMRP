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

# Параметры движения
@export var move_duration: float = 20.0        # Длительность движения
@export var amplitude: float = 6.0           # Амплитуда синусоиды
@export var frequency: float = 10            # Частота колебаний
@export var target_y: float = -100.0          # Конечная позиция по Y

func _ready():
	# Меняем текстуру
	change_texture_random()
	
	# Запускаем движение
	start_sine_movement_tween()

func change_texture_random():
	if textures.size() > 0:
		var random_index = randi() % textures.size()
		texture = textures[random_index]
	else:
		push_error("Нет загруженных текстур!")

func start_sine_movement_tween():
	var tween = create_tween()
	var start_pos = global_position
	var end_pos = Vector2(start_pos.x, start_pos.y + target_y)
	
	# Используем пользовательский метод для синусоидального движения
	tween.tween_method(_update_sine_position, 0.0, 1.0, move_duration)
	tween.tween_callback(_on_movement_finished)

func _update_sine_position(progress: float):
	var start_pos = global_position
	var current_y = start_pos.y + (target_y * progress)
	var sine_offset = sin(progress * frequency * PI * 2) * amplitude
	
	global_position = Vector2(
		start_pos.x + sine_offset,
		current_y
	)

func _on_movement_finished():
	print("Движение завершено")
	queue_free()	
	# Можно добавить дополнительные действия здесь

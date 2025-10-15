extends Node2D

# Константы
const GRID_WIDTH = 10
const GRID_HEIGHT = 20
const CELL_SIZE = 72
const BASE_DROP_SPEED = 1.0
const MAX_SPEED_CUP = 0.4


@export
#кнопка для отправки результата на сервер
var share_btn : TextureButton = null

@export
#сцена для отправки результата
var share_scene : PackedScene = preload("res://scenes/share_result_window.tscn")

@export
#HTTP client для обновления данных
var http_request : HTTPRequest = null

# Сцены фигур
const PIECE_SCENES = {
	"I": [],
	"O":  [],
	"T":  [],
	"L":  [],
	"J":  [],
	"S":  [],
	"LINE": []
}


## Для взрыва блоков
@onready var expose_stream_player : AudioStreamPlayer2D = $SucessExplose

## Для падения блока
@onready var fall_stream_player : AudioStreamPlayer2D = $FallVolumes

## Для поворота блока
@onready var tap_stream_player : AudioStreamPlayer2D = $TapVolumes


@export_group("Текстуры фигур")

## Для фигуры I
@onready var I_1 : Texture2D = load("res://assets/pieces/I/I_1.png")
@onready var I_2 : Texture2D = load("res://assets/pieces/I/I_2.png")
@onready var I_3 : Texture2D = load("res://assets/pieces/I/I_3.png")
@onready var I_4 : Texture2D = load("res://assets/pieces/I/I_4.png")

## Для фигуры I на 90 градусов
@onready var I_1_90 : Texture2D = load("res://assets/pieces/I/90/I_1_90.png")
@onready var I_2_90 : Texture2D = load("res://assets/pieces/I/90/I_2_90.png")
@onready var I_3_90 : Texture2D = load("res://assets/pieces/I/90/I_3_90.png")
@onready var I_4_90 : Texture2D = load("res://assets/pieces/I/90/I_4_90.png")

## Для фигуры I на 180 градусов
@onready var I_1_180 : Texture2D = load("res://assets/pieces/I/180/I_1_180.png")
@onready var I_2_180 : Texture2D = load("res://assets/pieces/I/180/I_2_180.png")
@onready var I_3_180 : Texture2D = load("res://assets/pieces/I/180/I_3_180.png")
@onready var I_4_180 : Texture2D = load("res://assets/pieces/I/180/I_4_180.png")

## Для фигуры I на 270 градусов
@onready var I_1_270 : Texture2D = load("res://assets/pieces/I/270/I_1_270.png")
@onready var I_2_270 : Texture2D = load("res://assets/pieces/I/270/I_2_270.png")
@onready var I_3_270 : Texture2D = load("res://assets/pieces/I/270/I_3_270.png")
@onready var I_4_270 : Texture2D = load("res://assets/pieces/I/270/I_4_270.png")

## Для фигуры O
@onready var O_1 : Texture2D = load("res://assets/pieces/O/o_1.png")
@onready var O_2 : Texture2D = load("res://assets/pieces/O/o_2.png")
@onready var O_3 : Texture2D = load("res://assets/pieces/O/o_3.png")
@onready var O_4 : Texture2D = load("res://assets/pieces/O/o_4.png")

## Для фигуры T
@onready var T_1 : Texture2D = load("res://assets/pieces/T/T_1.png")
@onready var T_2 : Texture2D = load("res://assets/pieces/T/T_2.png")
@onready var T_3 : Texture2D = load("res://assets/pieces/T/T_3.png")
@onready var T_4 : Texture2D = load("res://assets/pieces/T/T_4.png")

## Для фигуры T на 90
@onready var T_1_90 : Texture2D = load("res://assets/pieces/T/90/T_1_90.png")
@onready var T_2_90 : Texture2D = load("res://assets/pieces/T/90/T_2_90.png")
@onready var T_3_90 : Texture2D = load("res://assets/pieces/T/90/T_3_90.png")
@onready var T_4_90 : Texture2D = load("res://assets/pieces/T/90/T_4_90.png")

## Для фигуры T на 180
@onready var T_1_180 : Texture2D = load("res://assets/pieces/T/180/T_1_180.png")
@onready var T_2_180 : Texture2D = load("res://assets/pieces/T/180/T_2_180.png")
@onready var T_3_180 : Texture2D = load("res://assets/pieces/T/180/T_3_180.png")
@onready var T_4_180 : Texture2D = load("res://assets/pieces/T/180/T_4_180.png")

## Для фигуры T на 270
@onready var T_1_270 : Texture2D = load("res://assets/pieces/T/270/T_1_270.png")
@onready var T_2_270 : Texture2D = load("res://assets/pieces/T/270/T_2_270.png")
@onready var T_3_270 : Texture2D = load("res://assets/pieces/T/270/T_3_270.png")
@onready var T_4_270 : Texture2D = load("res://assets/pieces/T/270/T_4_270.png")

## Для фигуры L
@onready var L_1 : Texture2D = load("res://assets/pieces/L/L_1.png")
@onready var L_2 : Texture2D = load("res://assets/pieces/L/L_2.png")
@onready var L_3 : Texture2D = load("res://assets/pieces/L/L_3.png")
@onready var L_4 : Texture2D = load("res://assets/pieces/L/L_4.png")

## Для фигуры L на 90
@onready var L_1_90 : Texture2D = load("res://assets/pieces/L/90/L_1_90.png")
@onready var L_2_90 : Texture2D = load("res://assets/pieces/L/90/L_2_90.png")
@onready var L_3_90 : Texture2D = load("res://assets/pieces/L/90/L_3_90.png")
@onready var L_4_90 : Texture2D = load("res://assets/pieces/L/90/L_4_90.png")

## Для фигуры L на 180
@onready var L_1_180 : Texture2D = load("res://assets/pieces/L/180/L_1_180.png")
@onready var L_2_180 : Texture2D = load("res://assets/pieces/L/180/L_2_180.png")
@onready var L_3_180 : Texture2D = load("res://assets/pieces/L/180/L_3_180.png")
@onready var L_4_180 : Texture2D = load("res://assets/pieces/L/180/L_4_180.png")

## Для фигуры L на 270
@onready var L_1_270 : Texture2D = load("res://assets/pieces/L/270/L_1_270.png")
@onready var L_2_270 : Texture2D = load("res://assets/pieces/L/270/L_2_270.png")
@onready var L_3_270 : Texture2D = load("res://assets/pieces/L/270/L_3_270.png")
@onready var L_4_270 : Texture2D = load("res://assets/pieces/L/270/L_4_270.png")

## Для фигуры J
@onready var J_1 : Texture2D = load("res://assets/pieces/J/J_1.png")
@onready var J_2 : Texture2D = load("res://assets/pieces/J/J_2.png")
@onready var J_3 : Texture2D = load("res://assets/pieces/J/J_3.png")
@onready var J_4 : Texture2D = load("res://assets/pieces/J/J_4.png")

## Для фигуры J на 90
@onready var J_1_90 : Texture2D = load("res://assets/pieces/J/90/J_1_90.png")
@onready var J_2_90 : Texture2D = load("res://assets/pieces/J/90/J_2_90.png")
@onready var J_3_90 : Texture2D = load("res://assets/pieces/J/90/J_3_90.png")
@onready var J_4_90 : Texture2D = load("res://assets/pieces/J/90/J_4_90.png")

## Для фигуры J на 180
@onready var J_1_180 : Texture2D = load("res://assets/pieces/J/180/J_1_180.png")
@onready var J_2_180 : Texture2D = load("res://assets/pieces/J/180/J_2_180.png")
@onready var J_3_180 : Texture2D = load("res://assets/pieces/J/180/J_3_180.png")
@onready var J_4_180 : Texture2D = load("res://assets/pieces/J/180/J_4_180.png")

## Для фигуры J на 270
@onready var J_1_270 : Texture2D = load("res://assets/pieces/J/270/J_1_270.png")
@onready var J_2_270 : Texture2D = load("res://assets/pieces/J/270/J_2_270.png")
@onready var J_3_270 : Texture2D = load("res://assets/pieces/J/270/J_3_270.png")
@onready var J_4_270 : Texture2D = load("res://assets/pieces/J/270/J_4_270.png")

## Для фигуры S
@onready var S_1 : Texture2D = load("res://assets/pieces/S/S_1.png")
@onready var S_2 : Texture2D = load("res://assets/pieces/S/S_2.png")
@onready var S_3 : Texture2D = load("res://assets/pieces/S/S_3.png")
@onready var S_4 : Texture2D = load("res://assets/pieces/S/S_4.png")

## Для фигуры S на 90
@onready var S_1_90 : Texture2D = load("res://assets/pieces/S/90/S_1_90.png")
@onready var S_2_90 : Texture2D = load("res://assets/pieces/S/90/S_2_90.png")
@onready var S_3_90 : Texture2D = load("res://assets/pieces/S/90/S_3_90.png")
@onready var S_4_90 : Texture2D = load("res://assets/pieces/S/90/S_4_90.png")

## Для фигуры S на 180
@onready var S_1_180 : Texture2D = load("res://assets/pieces/S/180/S_1_180.png")
@onready var S_2_180 : Texture2D = load("res://assets/pieces/S/180/S_2_180.png")
@onready var S_3_180 : Texture2D = load("res://assets/pieces/S/180/S_3_180.png")
@onready var S_4_180 : Texture2D = load("res://assets/pieces/S/180/S_4_180.png")

## Для фигуры S на 270
@onready var S_1_270 : Texture2D = load("res://assets/pieces/S/270/S_1_270.png")
@onready var S_2_270 : Texture2D = load("res://assets/pieces/S/270/S_2_270.png")
@onready var S_3_270 : Texture2D = load("res://assets/pieces/S/270/S_3_270.png")
@onready var S_4_270 : Texture2D = load("res://assets/pieces/S/270/S_4_270.png")

## Для фигуры LINE
@onready var line_1 : Texture2D = load("res://assets/pieces/line/line_1.png")
@onready var line_2 : Texture2D = load("res://assets/pieces/line/line_2.png")

## Для фигуры LINE на 90
@onready var line_1_90 : Texture2D = load("res://assets/pieces/line/90/line_1_90.png")
@onready var line_2_90 : Texture2D = load("res://assets/pieces/line/90/line_2_90.png")

## Для фигуры LINE на 180
@onready var line_1_180 : Texture2D = load("res://assets/pieces/line/180/line_1_180.png")
@onready var line_2_180 : Texture2D = load("res://assets/pieces/line/180/line_2_180.png")

## Для фигуры LINE на 270
@onready var line_1_270 : Texture2D = load("res://assets/pieces/line/270/line_1_270.png")
@onready var line_2_270 : Texture2D = load("res://assets/pieces/line/270/line_2_270.png")


@onready var PIECE_TEXTURE = {
	"I":[I_1, I_2, I_3, I_4],
	"O":[O_1, O_2, O_3, O_4],
	"T":[T_2, T_1, T_3, T_4],
	"L":[L_1, L_2, L_3, L_4],
	"J":[J_4, J_2, J_3, J_1],
	"S":[S_2, S_1, S_3, S_4],
	"LINE":[line_1, line_2]
}

@onready var PIECE_TEXTURE_90 = {
	"I":[I_1_90, I_2_90, I_3_90, I_4_90],
	"O":[O_1, O_2, O_3, O_4],
	"T":[T_2_90, T_1_90, T_3_90, T_4_90],
	"L":[L_1_90, L_2_90, L_3_90, L_4_90],
	"J":[J_4_90, J_2_90, J_3_90, J_1_90],
	"S":[S_2_90, S_1_90, S_3_90, S_4_90],
	"LINE":[line_1_90, line_2_90]
}

@onready var PIECE_TEXTURE_180 = {
	"I":[I_1_180, I_2_180, I_3_180, I_4_180],
	"O":[O_1, O_2, O_3, O_4],
	"T":[T_2_180, T_1_180, T_3_180, T_4_180],
	"L":[L_1_180, L_2_180, L_3_180, L_4_180],
	"J":[J_4_180, J_2_180, J_3_180, J_1_180],
	"S":[S_2_180, S_1_180, S_3_180, S_4_180],
	"LINE":[line_1_180, line_2_180]
}

@onready var PIECE_TEXTURE_270 = {
	"I":[I_1_270, I_2_270, I_3_270, I_4_270],
	"O":[O_1, O_2, O_3, O_4],
	"T":[T_2_270, T_1_270, T_3_270, T_4_270],
	"L":[L_1_270, L_2_270, L_3_270, L_4_270],
	"J":[J_4_270, J_2_270, J_3_270, J_1_270],
	"S":[S_2_270, S_1_270, S_3_270, S_4_270],
	"LINE":[line_1_270, line_2_270]
}

# Смещения для каждой фигуры относительно центра (0,0)
const PIECE_OFFSETS = {
	"I": [
		Vector2i(-1, 0), Vector2i(0, 0), Vector2i(1, 0), Vector2i(2, 0)  # Центр между 2 и 3 блоком
	],
	"O": [
		Vector2i(0, 0), Vector2i(1, 0), Vector2i(0, 1), Vector2i(1, 1)
	],
	"T": [
		Vector2i(0, 0), Vector2i(-1, 0), Vector2i(1, 0), Vector2i(0, -1)
	],
	"L": [
		Vector2i(0, 0), Vector2i(-1, 0), Vector2i(1, 0), Vector2i(1, -1)
	],
	"J": [
		Vector2i(0, 0), Vector2i(-1, 0), Vector2i(1, 0), Vector2i(-1, -1)
	],
	"S": [
		Vector2i(0, 0), Vector2i(1, 0), Vector2i(0, -1), Vector2i(-1, -1)
	],
	"LINE": [
		Vector2i(0, 0), Vector2i(1, 0)
	]
}

# Переменные игры
var grid = []
var current_piece = null
var current_position = Vector2i()
var current_rotation = 0
var next_piece = null
var score = 0
var level = 1
var lines_cleared = 0
var game_over = false
var drop_timer = 0.0
var current_drop_speed = BASE_DROP_SPEED
var explosion_particles_scene = preload("res://scenes/ExplosionParticles.tscn")
var ghost_position = Vector2i()

# Мобильные элементы управления
var fast_fall = false
var touch_start_pos = Vector2()
var touch_start_time = 0
var is_tap = false
var swipe_threshold = 20
var tap_time_threshold = 0.2

# Ссылки на узлы
@onready var timer = $Timer
@export var gameInterface : CanvasLayer = null
@export var loseMenu : CanvasLayer = null
@onready var game_over_score = $GameLose/Control/VBoxContainer/HBoxContainer/score

#@onready var level_label = $UI/LevelLabel
#@onready var speed_label = $UI/SpeedLabel
@onready var game_over_label = $UI/GameOverLabel
@onready var pieces_node = $GameBoard/Pieces
@onready var next_piece_display = $NextPieceDisplay
@onready var particles_container = $ParticlesContainer



func _ready():
	initialize_grid()
	start_new_game()

func initialize_grid():
	grid = []
	for y in range(GRID_HEIGHT):
		grid.append([])
		for x in range(GRID_WIDTH):
			grid[y].append(null)

func start_new_game():
	# Очистка сетки
	for y in range(GRID_HEIGHT):
		for x in range(GRID_WIDTH):
			grid[y][x] = null
	
	# Очистка визуальных элементов
	for child in pieces_node.get_children():
		child.queue_free()
	for child in $GameBoard.get_children():
		if child.is_in_group("current_piece") or child.is_in_group("ghost_piece"):
			child.queue_free()
	
	# Очистка партиклов
	for child in particles_container.get_children():
		child.queue_free()
	
	# Сброс переменных
	score = 0
	level = 1
	lines_cleared = 0
	game_over = false
	current_drop_speed = BASE_DROP_SPEED
	drop_timer = 0.0
	
	update_ui()
#	game_over_label.visible = false
	loseMenu.visible = false
	gameInterface.visible = true
	
	timer.stop()
	
	# Создание первой и следующей фигур
	next_piece = get_random_piece()
	spawn_new_piece()

func spawn_new_piece():
	current_piece = next_piece
	next_piece = get_random_piece()
	update_next_piece_display()
	
	# Начальная позиция - центр сверху
	current_position = Vector2i(GRID_WIDTH / 2, 1)
	current_rotation = 0
	drop_timer = 0.0
	
	update_ghost_position()
	
	if !is_valid_position():
		game_over = true
#		game_over_label.visible = true
		gameInterface.visible = false
		game_over_score.text = str(score) #отметил для передачи очков
		

		if Globals.chek_need_save():
			Globals.user_data['score'] = score
			share_btn.show()
		else:
			print('Нужно обновить счет')
			if Globals.check_need_send_score(score):
				Globals.user_data['score'] = score
				var url = Globals.api_path + 'users/' + Globals.user_data['user_id'] + '/update-score'
				var headers = ["Content-Type: application/json"]
				var body = JSON.stringify({
					"score": score
				})
				var error = http_request.request(
					url,
					headers,
					HTTPClient.METHOD_PUT,
					body
				)
			
		loseMenu.visible = true
		return
	
	draw_piece()
	draw_ghost_piece()

func get_random_piece():
	var pieces = PIECE_SCENES.keys()
	return pieces[randi() % pieces.size()]

func rotate_piece():
	if current_piece == "O":
		return  # O-фигура не вращается
	
	var old_rotation = current_rotation
	var old_position = current_position
	
	current_rotation = (current_rotation + 1) % 4
	
	# Попытка коррекции позиции при вращении
	if !is_valid_position():
		# Пробуем сдвинуть фигуру для корректного вращения
		var attempts = [
			Vector2i(0, 0),    # Исходная позиция
			Vector2i(1, 0),    # Вправо
			Vector2i(-1, 0),   # Влево
			Vector2i(0, 1),    # Вниз
			Vector2i(0, -1)    # Вверх
		]
		
		var found_valid = false
		for attempt in attempts:
			current_position = old_position + attempt
			if is_valid_position():
				found_valid = true
				break
		
		if !found_valid:
			current_rotation = old_rotation
			current_position = old_position
	
	## Звук при повороте
	tap_stream_player.play()
	
	update_ghost_position()
	draw_piece()
	draw_ghost_piece()
	
func is_valid_position(test_position = null, test_rotation = null):
	var pos = test_position if test_position != null else current_position
	var rot = test_rotation if test_rotation != null else current_rotation
	
	var piece_cells = get_cells_for_piece(current_piece, rot)
	
	for cell in piece_cells:
		var grid_pos = pos + cell
		
		# Проверка границ
		if grid_pos.x < 0 or grid_pos.x >= GRID_WIDTH or grid_pos.y >= GRID_HEIGHT:
			return false
		
		# Проверка столкновений
		if grid_pos.y >= 0 and grid[grid_pos.y][grid_pos.x] != null:
			return false
	
	return true

func get_current_cells():
	return get_cells_for_piece(current_piece, current_rotation)

func get_cells_for_piece(piece_type, rotation):
	var cells = PIECE_OFFSETS[piece_type].duplicate()
	
	# Применяем вращение
	for i in range(rotation):
		for j in range(cells.size()):
			# Поворот на 90 градусов против часовой стрелки: (x, y) -> (-y, x)
			var old_x = cells[j].x
			var old_y = cells[j].y
			cells[j] = Vector2i(-old_y, old_x)
	
	return cells

func move_piece(direction):
	var old_position = current_position
	current_position += direction
	
	if !is_valid_position():
		current_position = old_position
		
		# Если движение вниз невозможно - фиксируем фигуру
		if direction == Vector2i(0, 1):
			fix_piece()
			check_lines()
			spawn_new_piece()
		
		return false
	else:
		update_ghost_position()
		draw_piece()
		draw_ghost_piece()
		return true

func update_ghost_position():
	ghost_position = current_position
	
	# Опускаем призрака до столкновения
	while is_valid_position(ghost_position + Vector2i(0, 1), current_rotation):
		ghost_position += Vector2i(0, 1)

func draw_ghost_piece():
	# Очищаем предыдущее отображение призрака
	for child in $GameBoard.get_children():
		if child.is_in_group("ghost_piece"):
			child.queue_free()
	
	# Рисуем призрачную фигуру как квадраты
	var piece_cells = get_cells_for_piece(current_piece, current_rotation)
	var ghost_color = Color(1, 1, 1, 0.3)
	
	for cell in piece_cells:
		var grid_pos = ghost_position + cell
		
		if grid_pos.y >= 0:
			var block = ColorRect.new()
			block.size = Vector2(CELL_SIZE, CELL_SIZE)
			block.position = Vector2(grid_pos.x * CELL_SIZE, grid_pos.y * CELL_SIZE)
			block.color = ghost_color
			
			# Контур
			var stylebox = StyleBoxFlat.new()
			stylebox.bg_color = Color.TRANSPARENT
			stylebox.border_color = Color(1, 1, 1, 0.5)
			stylebox.border_width_left = 2
			stylebox.border_width_top = 2
			stylebox.border_width_right = 2
			stylebox.border_width_bottom = 2
			block.add_theme_stylebox_override("panel", stylebox)
			
			block.add_to_group("ghost_piece")
			$GameBoard.add_child(block)

func draw_piece():
	# Очищаем предыдущее отображение текущей фигуры
	for child in $GameBoard.get_children():
		if child.is_in_group("current_piece"):
			child.queue_free()
	
	# Рисуем текущую фигуру как цветные блоки (временно)
	var piece_cells = get_cells_for_piece(current_piece, current_rotation)
	var color = get_piece_color(current_piece)
	
	var cell_index : int = 0
	for cell in piece_cells:
		var grid_pos = current_position + cell
		
		if grid_pos.y >= 0:
			var block : BaseFigurePiece = BaseFigurePiece.new()
			
			var base_texture : Texture2D = null
			
			match current_rotation:
				0:
					base_texture = PIECE_TEXTURE[current_piece][cell_index]
				1:
					base_texture = PIECE_TEXTURE_90[current_piece][cell_index]
				2:
					base_texture = PIECE_TEXTURE_180[current_piece][cell_index]
				3:
					base_texture = PIECE_TEXTURE_270[current_piece][cell_index]
					
			
			cell_index += 1
			block.texture = base_texture
			block.size = Vector2(CELL_SIZE, CELL_SIZE)
			block.position = Vector2(grid_pos.x * CELL_SIZE, grid_pos.y * CELL_SIZE)
#			block.color = color
			
			# Контур для лучшей видимости
			var stylebox = StyleBoxFlat.new()
			stylebox.bg_color = Color.TRANSPARENT
			stylebox.border_color = color.darkened(0.3)
			stylebox.border_width_left = 2
			stylebox.border_width_top = 2
			stylebox.border_width_right = 2
			stylebox.border_width_bottom = 2
			block.add_theme_stylebox_override("panel", stylebox)
			
			block.add_to_group("current_piece")
			$GameBoard.add_child(block)

func get_piece_color(piece_type):
	var colors = {
		"I": Color.CYAN,
		"O": Color.YELLOW,
		"T": Color.PURPLE,
		"L": Color.ORANGE,
		"J": Color.BLUE,
		"S": Color.GREEN,
		"LINE": Color.RED
	}
	return colors.get(piece_type, Color.WHITE)

func fix_piece():
	var piece_cells = get_current_cells()
	
	var index_piece = 0
	for cell in piece_cells:
		var grid_pos = current_position + cell
		
		if grid_pos.y >= 0:
#			grid[grid_pos.y][grid_pos.x] = current_piece
			grid[grid_pos.y][grid_pos.x] = {
				'figure_type': current_piece,
				'rotate_index': current_rotation,
				'index_piece': index_piece
			}
			index_piece += 1
	create_fixed_piece_visual()

func create_fixed_piece_visual():
	# Создаем зафиксированную фигуру как цветные блоки
	var piece_cells = get_current_cells()
	var color = get_piece_color(current_piece)
	
	var cell_index : int = 0
	
	for cell in piece_cells:
		var grid_pos = current_position + cell
		
		
		if grid_pos.y >= 0:
			var block : BaseFigurePiece = BaseFigurePiece.new()
			block.figure_type = current_piece
			block.rotate_index = current_rotation
			block.index_piece = cell_index
			
			var base_texture : Texture2D = null
			match current_rotation:
				0:
					base_texture = PIECE_TEXTURE[current_piece][cell_index]
				1:
					base_texture = PIECE_TEXTURE_90[current_piece][cell_index]
				2:
					base_texture = PIECE_TEXTURE_180[current_piece][cell_index]
				3:
					base_texture = PIECE_TEXTURE_270[current_piece][cell_index]
					
			cell_index += 1
			block.texture = base_texture
			
			block.size = Vector2(CELL_SIZE, CELL_SIZE)
			block.position = Vector2(grid_pos.x * CELL_SIZE, grid_pos.y * CELL_SIZE)
#			block.color = color
			pieces_node.add_child(block)

func check_lines():
	var lines_to_clear = []
	
	# Проверяем заполненные линии
	for y in range(GRID_HEIGHT):
		var line_full = true
		for x in range(GRID_WIDTH):
			if grid[y][x] == null:
				line_full = false
				break
		
		if line_full:
			lines_to_clear.append(y)
	
	if lines_to_clear.size() > 0:
		clear_lines(lines_to_clear)
		update_score(lines_to_clear.size())

func clear_lines(lines_to_clear):
	# Создаем взрывы
	create_explosions(lines_to_clear)
	
	# Ждем немного для эффекта
	await get_tree().create_timer(0.3).timeout
	
	# Сортируем линии сверху вниз
	lines_to_clear.sort()
	
	# Удаляем визуальные блоки на этих линиях
	for line in lines_to_clear:
		for child in pieces_node.get_children():
			var block_y = int(child.position.y / CELL_SIZE)
			if block_y == line:
				child.queue_free()
	
	# Сдвигаем все фигуры выше удаленных линий вниз
	var lines_cleared_count = lines_to_clear.size()
	
	for i in range(lines_to_clear.size()):
		var line = lines_to_clear[i]
		
		# Сдвигаем все линии выше текущей удаленной линии
		for y in range(line - 1, -1, -1):
			for x in range(GRID_WIDTH):
				grid[y + lines_cleared_count][x] = grid[y][x]
				grid[y][x] = null
		
		lines_cleared_count -= 1
	
	# Перерисовываем все фигуры
	update_visual_grid()


func update_visual_grid():
	# Очищаем все зафиксированные фигуры
	for child in pieces_node.get_children():
		child.queue_free()
	
	# Перерисовываем все фигуры из сетки
	for y in range(GRID_HEIGHT):
		for x in range(GRID_WIDTH):
			if grid[y][x] != null:
#				var color = get_piece_color(grid[y][x])
				var block : BaseFigurePiece = BaseFigurePiece.new()
				var base_texture : Texture2D = null
				match grid[y][x]['rotate_index']:
					0:
						base_texture = PIECE_TEXTURE[grid[y][x]['figure_type']][grid[y][x]['index_piece']]
					1:
						base_texture = PIECE_TEXTURE_90[grid[y][x]['figure_type']][grid[y][x]['index_piece']]
					2:
						base_texture = PIECE_TEXTURE_180[grid[y][x]['figure_type']][grid[y][x]['index_piece']]
					3:
						base_texture = PIECE_TEXTURE_270[grid[y][x]['figure_type']][grid[y][x]['index_piece']]
				
				block.texture = base_texture
				block.size = Vector2(CELL_SIZE, CELL_SIZE)
				block.position = Vector2(x * CELL_SIZE, y * CELL_SIZE)
#				block.color = color
				pieces_node.add_child(block)
						
func create_explosions(lines):
	for line in lines:
		for x in range(GRID_WIDTH):
			if grid[line][x] != null:
				var explosion = explosion_particles_scene.instantiate()
				explosion.position = Vector2(x * CELL_SIZE + CELL_SIZE / 2, line * CELL_SIZE + CELL_SIZE / 2)
				explosion.emitting = true
				particles_container.add_child(explosion)
				
				##Проигрываю звук взрыва блоков
				expose_stream_player.play()
				
				# Автоматическое удаление
				get_tree().create_timer(2.0).timeout.connect(
					func(): 
						if is_instance_valid(explosion):
							explosion.queue_free()
				)

func update_score(lines_cleared_count):
	var points = 0
	match lines_cleared_count:
		1: points = 100 * level
		2: points = 300 * level
		3: points = 500 * level
		4: points = 800 * level
	
	score += points
	lines_cleared += lines_cleared_count
	
	# Повышаем уровень каждые 5 линий
#	var new_level = lines_cleared / 5 + 1
#	if new_level > level:
#		level = new_level
#		current_drop_speed = max(0.1, BASE_DROP_SPEED - (level - 1) * 0.1)
	update_ui()

func update_ui():
	gameInterface.update_points(score)
#	score_label.text = str(score)
#	level_label.text = "Level: " + str(level)
#	speed_label.text = "Speed: " + str(1.0 / current_drop_speed).pad_decimals(1) + " blocks/sec"

func update_next_piece_display():
	for child in next_piece_display.get_children():
		child.queue_free()
	
	# Рисуем следующую фигуру как цветные блоки
	var next_cells = PIECE_OFFSETS[next_piece].duplicate()
	var color = get_piece_color(next_piece)
	
	var cell_index : int = 0
	for cell in next_cells:
		var block : BaseFigurePiece = BaseFigurePiece.new()
		var base_texture = PIECE_TEXTURE[next_piece][cell_index]
		cell_index += 1
		block.texture = base_texture
		block.size = Vector2(CELL_SIZE, CELL_SIZE)
		block.position = Vector2(cell.x * CELL_SIZE + 100, cell.y * CELL_SIZE + 100)
#		block.color = color
		next_piece_display.add_child(block)


func _input(event):
			
#	новый контент для мобилок с дипсика
	if event is InputEventScreenTouch:
		handle_touch_event(event)
	elif event is InputEventScreenDrag:
		handle_drag_event(event)		
#	конец нового конетнта с дипсика	
	
#	блок клавой
#	if game_over:
#		if event.is_action_pressed("ui_accept"):
#			start_new_game()
#		return
#
	elif event.is_action_pressed("ui_left"):
		move_piece(Vector2i(-1, 0))
#
	elif event.is_action_pressed("ui_right"):
		move_piece(Vector2i(1, 0))
#
#	elif event.is_action_pressed("ui_down"):
#		if move_piece(Vector2i(0, 1)):
#			drop_timer = 0.0
#
	elif event.is_action_pressed("ui_up"):
		rotate_piece()
#
	elif event.is_action_pressed("ui_select"): # Пробел
		# Hard drop - мгновенное падение
		current_position = ghost_position

		## Падение блока в низ
		fall_stream_player.play()
		move_piece(Vector2i(0, 1))
#		конец блока с клавой
		
#Обработка прикосновений
func handle_touch_event(event):
	if event.pressed:
		# Начало касания
		touch_start_pos = event.position
		touch_start_time = Time.get_ticks_msec()
		is_tap = true
	else:
		# Конец касания - проверяем был ли это тап
		var touch_duration = Time.get_ticks_msec() - touch_start_time
		var touch_distance = event.position.distance_to(touch_start_pos)
		
		if is_tap and touch_duration < tap_time_threshold * 1000 and touch_distance < swipe_threshold:
			rotate_piece()  # Одиночное нажатие - поворот
		is_tap = false

#обработка свайпов
func handle_drag_event(event):
	if not is_tap:
		return
	var drag_distance = event.position - touch_start_pos
	
	# Горизонтальное перемещение
	if abs(drag_distance.x) > swipe_threshold * 2:
		if drag_distance.x > 0:
			move_piece(Vector2i(1, 0))  # Вправо
		else:
			move_piece(Vector2i(-1, 0))  # Влево
		touch_start_pos = event.position  # Сбрасываем начальную позицию
	
	# Быстрое падение (свайп вниз)
	if drag_distance.y > swipe_threshold * 4:
		fast_fall = true
		touch_start_pos = event.position

#		мгновенное падение
		# Hard drop - мгновенное падение
		current_position = ghost_position
		## Падение блока в низ
		fall_stream_player.play()
		move_piece(Vector2i(0, 1))
#		конец мгновенного падения
		is_tap = false  # Прекращаем считать это тапом

func _process(delta):
	if game_over:
		return
	
	# Автоматическое падение
	drop_timer += delta
	
	if drop_timer >= current_drop_speed:
		move_piece(Vector2i(0, 1))
		drop_timer = 0.0

#перезапуск игры
func _on_reload_btn_button_down():
	start_new_game()

#Выход в меню
func _on_home_btn_button_down():
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")


#Увеличение скорости со временем
func _on_up_down_speed_timeout():
	if current_drop_speed > MAX_SPEED_CUP:
		level += 1
		current_drop_speed = max(0.1, BASE_DROP_SPEED - (level - 1) * 0.1)

#Шторм в игре
func _on_storm_timer_timeout():
	$AnimationStorm.play("StromAnimation")


func _on_share_result_button_button_down():
#	Кнопка для участия в розыгрыше
	get_tree().change_scene_to_packed(share_scene)


func _on_http_request_for_update_user_request_completed(result, response_code, headers, body):
	pass # Replace with function body.

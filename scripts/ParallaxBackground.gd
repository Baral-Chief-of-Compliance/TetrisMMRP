extends ParallaxBackground


func _ready():
	# Настройка автоматической прокрутки
	var parallax_layer = $NearestClouds
	var back_clouds_layer = $BackClouds
	parallax_layer.motion_mirroring = Vector2(1080, 0)  # Размер зеркального отображения
	back_clouds_layer.motion_mirroring = Vector2(1080, 0)
	
	# Запуск автоматического движения
	set_process(true)

func _process(delta):
	# Двигаем фон автоматически
	scroll_base_offset.x += 100 * delta  # Скорость движения

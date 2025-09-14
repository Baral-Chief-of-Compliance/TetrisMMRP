extends AudioStreamPlayer2D

@export var tracks : Array[AudioStreamMP3] = []

@export
## Индекс текущего трека
var index_track : int = 0

## Установить трек
func set_track():
	var random = RandomNumberGenerator.new()
	index_track = random.randi_range(0, len(tracks)-1)
	stream = tracks[index_track]
	play()
	
func _ready():
	set_track()

func _on_finished():
	set_track()

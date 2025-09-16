extends CanvasLayer

@export
var points_label : Label = null


func update_points(points: int):
	points_label.text = str(points)

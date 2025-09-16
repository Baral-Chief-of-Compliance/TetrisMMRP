extends Control

@export
## Кнопка паузы
var pause_btn : TextureButton

@export
## Блок паузы
var pause_block : VBoxContainer


@export 
##Блок настроек
var settings_block : VBoxContainer


@export
## Аниматор для блюра
var animation_player : AnimationPlayer 

@export 
## Наименование анимации для появления блюра
var blur_anim_name : String = 'show_blur'

@export
## Наименование анимации для исчезновения блюра
var not_blur_anim_name : String = 'not_blur'

## Нажать на паузу
func _on_pause_btn_button_down():
	animation_player.play(blur_anim_name)	
	get_tree().paused = true
	pause_btn.hide()
	pause_block.show()
	

## Нажать продолжить
func _on_resume_btn_button_down():
	animation_player.play(not_blur_anim_name)
	get_tree().paused = false
	pause_block.hide()
	pause_btn.show()

## Кнопка настроек
func _on_settings_btn_button_down():
	pause_block.hide()
	settings_block.show()

## Кнопка домой
func _on_home_btn_button_down():
	animation_player.play(not_blur_anim_name)	
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")

## Кнопка обратно в меню паузы
func _on_back_btn_button_down():
	settings_block.hide()
	pause_block.show()

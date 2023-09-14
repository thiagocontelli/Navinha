extends Control

@onready var score = $Score:
	set(value):
		score.text = "SCORE: " + str(value)


func _on_quit_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")

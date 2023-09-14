extends Control

func _on_retry_button_pressed():
	get_tree().reload_current_scene()

func set_score(value):
	$Panel/Score.text = "SCORE: " + str(value)
	
func set_high_score(value):
	$Panel/HighScore.text = "HIGH-SCORE: " + str(value)


func _on_quit_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")

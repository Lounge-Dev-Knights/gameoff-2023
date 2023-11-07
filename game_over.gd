extends CenterContainer

var score := 0:
	set(value):
		score = value
		$PanelContainer/MarginContainer/VBoxContainer/Score.text = "Score: %d" % value


func _on_button_pressed() -> void:
	get_tree().reload_current_scene()

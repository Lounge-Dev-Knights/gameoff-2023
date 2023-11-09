extends CenterContainer

var score := 0:
	set(value):
		score = value
		$PanelContainer/MarginContainer/VBoxContainer/Score.text = "Score: %d" % value
		$LeaderboardPanel/MarginContainer/Leaderboard.current_score = value


func _on_button_pressed() -> void:
	SoundEngine.play_sound("MenuButtonSound")

func _on_button_mouse_entered():
	SoundEngine.play_sound("MenuButtonHoverSound")


func _on_leaderboard_pressed() -> void:
	$LeaderboardPanel.popup_centered()


func _on_restart_pressed() -> void:
	get_tree().reload_current_scene()

extends VBoxContainer

@onready var http := $HTTPRequest

var url := "https://gameoff-2023-leaderboard.vercel.app"
var auth_headers := [
	"x-api-key: LEADERBOARD_API_KEY"
]

var current_score = 12

func _ready() -> void:
	get_scores()

func _process(delta: float) -> void:
	if current_score != null:
		$SubmitForm.show()
		$SubmitForm/Score.text = "Your score: %d" % current_score
	else:
		$SubmitForm.hide()

func get_scores():
	http.request(url, [], HTTPClient.METHOD_GET)


func add_score(score: float, name: String):
	http.request(url, auth_headers, HTTPClient.METHOD_POST, JSON.stringify({
		"score": score,
		"name": name
	}))


func _on_http_request_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	if response_code == 201:
		print("successfully posted score")
		get_scores()
		return
	
	if response_code == 200:
		var scores: Array = JSON.parse_string(body.get_string_from_utf8())
		for node in $Scores.get_children():
			node.queue_free()
		for score in scores:
			var score_label := Label.new()
			score_label.text = "%d" % score["score"]
			score_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			var name_label := Label.new()
			name_label.text = score["name"]
			name_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
			
			var row := HBoxContainer.new()
			row.add_child(score_label)
			row.add_child(name_label)
			$Scores.add_child(row)
			
		return


func _on_button_pressed() -> void:
	get_scores()


func _on_texture_button_pressed() -> void:
	get_scores()
	$HBoxContainer/Control/TextureButton.rotation = 0
	var tween := create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property($HBoxContainer/Control/TextureButton, "rotation", 2 * PI, 0.5)
	tween.play()


func _on_submit_pressed() -> void:
	add_score(current_score, $SubmitForm/Name.text)
	current_score = null
	

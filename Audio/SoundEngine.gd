extends Node

const POOL_SIZE = 8

const sounds = {
	"MenuButtonSound": {
		"stream": preload("res://Audio/Sound/MenuButtonSound.wav"),
		"volume": -20
		},
	"MenuButtonHoverSound": {
		"stream": preload("res://Audio/Sound/MenuButtonHoverSound.wav"),
		"volume": -0
		},
	"Impact": {
		"stream": preload("res://Audio/Sound/Impact1.wav"),
		"volume": -0
		},
	"Explosion": {
		"stream": preload("res://Audio/Sound/Explosion1.wav"),
		"volume": -0
	},
	"Jump": {
		"stream": preload("res://Audio/Sound/Jump1.wav"),
		"volume": -0
	},
}



# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(POOL_SIZE):
		var player = AudioStreamPlayer.new()
		player.bus = "Sound"
		add_child(player)


func _get_idle_player():
	for player in get_children():
		if not (player as AudioStreamPlayer).playing:
			return player

func play_sound(sound_name: String, audio_player = null):
	if audio_player == null:
		audio_player = _get_idle_player()
	
	if audio_player != null:
		var sound = sounds[sound_name]
		audio_player.stream = sound["stream"]
		audio_player.volume_db = sound["volume"]
		audio_player.play()

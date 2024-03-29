extends Node2D

var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")


func _ready() -> void:
	randomize()
	$Platform/HouseAnimation.seek(0.5, true)
	MusicEngine.play_song("Music1")


var running := true
var score := 0.0


func _process(delta: float) -> void:
	if not running:
		return
	
	score += delta
	
	var slope: float = 0.2 * clamp(abs($Platform.rotation) - 0.05, 0, 0.2) * sign($Platform.rotation)

	var animation: AnimationPlayer = $Platform/HouseAnimation
	animation.seek(clamp(animation.current_animation_position + slope * delta, -1, 1), true)


	if animation.current_animation_position < 0.001 or  animation.current_animation_position > 0.999:
		gameover()
		SoundEngine.play_sound("Explosion")


func gameover() -> void:
	running = false
	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property($Platform/House, "global_position", $Platform/House.global_position + Vector2(0, 1024), 2.0)
	tween.play()
	$CanvasLayer/GameOver.score = score
	$CanvasLayer/GameOver.show()


func _physics_process(delta: float) -> void:
	$Platform.apply_torque(10000 * pow($Platform.rotation_degrees, 2) * -sign($Platform.rotation))
	
	if $Character.is_on_floor():
		var mass: float = $Character.get_total_mass()
		$Platform.apply_force(Vector2.DOWN * mass * gravity, $Character.position)


const ITEMS = [
	preload("res://items/birchnut.tscn"),
	preload("res://items/acorn.tscn"),
	preload("res://items/leaf_1.tscn"),
	preload("res://items/leaf_2.tscn"),
	preload("res://items/leaf_3.tscn"),
	preload("res://items/leaf_4.tscn"),
	preload("res://items/leaf_5.tscn"),
]


func _on_timer_timeout() -> void:
	var item = ITEMS[randi() % ITEMS.size()].instantiate()
	item.position = Vector2(randf_range(-512, 512), -1024)
	add_child(item)

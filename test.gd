extends Node2D

var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	$Platform/HouseAnimation.seek(0.5, true)

var running := true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()
	
	if not running:
		return
	
	var slope: float = 0.2 * clamp(abs($Platform.rotation) - 0.05, 0, 0.2) * sign($Platform.rotation)

	var animation: AnimationPlayer = $Platform/HouseAnimation
	animation.seek(clamp(animation.current_animation_position + slope * delta, -1, 1), true)
	
	
	if animation.current_animation_position < 0.0001 or  animation.current_animation_position > 0.9999:
		gameover()
		

func gameover() -> void:
	running = false
	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property($Platform/House, "global_position", $Platform/House.global_position + Vector2(0, 1024), 2.0)
	tween.play()
	$Platform/House

func _physics_process(delta: float) -> void:
	$Platform.apply_torque(10000 * pow($Platform.rotation_degrees, 2) * -sign($Platform.rotation))
	
	if $Character.is_on_floor():
		var mass: float = $Character.get_total_mass()
		$Platform.apply_force(Vector2.DOWN * mass * gravity, $Character.position)


func _on_timer_timeout() -> void:
	var item = preload("res://item.tscn").instantiate()
	item.position = Vector2(randf_range(-512, 512), -256)
	item.size = randf_range(16, 64)
	add_child(item)

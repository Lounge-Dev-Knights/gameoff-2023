extends RigidBody2D

var power := 5.0
var blow_force = 3000.0  # Adjust as needed


@onready var progress_bar := $ProgressBar

func _process(delta: float) -> void:
	progress_bar.visible = freeze
	progress_bar.value = power
	progress_bar.global_position = global_position + Vector2(-32, 0)
	
	if freeze:
		power -= delta
		if power < 0.0:
			queue_free()
			get_tree().set_group("character", "hold_item", null)

func _physics_process(delta):
	if freeze:
		
		for body in $Area2D.get_overlapping_bodies():
			var distance = (body.global_position - global_position).length()
			var direction = Vector2.RIGHT.rotated(rotation)
			
			var force = blow_force - ((700 - distance) * 0.5)
			body.apply_central_force(direction * force)

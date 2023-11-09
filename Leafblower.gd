extends RigidBody2D


var density := 0.001 # kg per pixel
var size := 64.0
var blow_force = 7500.0  # Adjust as needed

func _ready() -> void:
	mass = size * size * density

func _physics_process(delta):
	if freeze:
		for body in $Area2D.get_overlapping_bodies():
			var distance = (body.global_position - global_position).length()
			rotation
			var direction = Vector2.RIGHT.rotated(rotation)
			var force = blow_force-((3000-distance)*0.5)
			body.apply_central_force(direction*force)




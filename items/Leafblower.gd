extends RigidBody2D


var blow_force = 3000.0  # Adjust as needed


func _physics_process(delta):
	if freeze:
		for body in $Area2D.get_overlapping_bodies():
			var distance = (body.global_position - global_position).length()
			var direction = Vector2.RIGHT.rotated(rotation)
			
			var force = blow_force - ((700 - distance) * 0.5)
			body.apply_central_force(direction * force)

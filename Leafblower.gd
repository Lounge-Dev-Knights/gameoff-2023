extends RigidBody2D


var density := 0.001 # kg per pixel
var size := 64.0
var blow_force = 500000000.0  # Adjust as needed


func _physics_process(delta):
	for body in $Area2D.get_overlapping_bodies():
		var distance_square = pow((body.global_position - global_position).length(),2)
		body.apply_central_force(Vector2(blow_force/distance_square,0))



extends RigidBody2D

func _on_body_entered(body):
	if $Timer.time_left >0:
		return
	
	SoundEngine.play_sound("Impact")
	$Timer.start()

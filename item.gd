extends RigidBody2D


var density := 0.001 # kg per pixel
var size := 64.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var shape := RectangleShape2D.new()
	shape.size = Vector2(size, size)
	$CollisionShape2D.shape = shape
	$Nut.scale *= size / 64
	mass = size * size * density


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body):
	if $Timer.time_left >0:
		return
	SoundEngine.play_sound("Impact")
	$Timer.start()

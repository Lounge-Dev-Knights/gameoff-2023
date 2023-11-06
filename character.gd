extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

var mass := 1

var hold_item: RigidBody2D
var hold_item_collision_layer := 0
var hold_item_collision_mask := 0
var highlight_item: RigidBody2D

func _process(delta: float) -> void:
	update_highlight()
	
	if Input.is_action_just_pressed("pickup"):
		if hold_item != null:
			drop()
		elif highlight_item != null:
			pickup(highlight_item)
		
	if hold_item != null:
		hold_item.global_position = hold_item.global_position.lerp(global_position + Vector2(0, -32), 10 * delta)
	
	
func _physics_process(delta: float) -> void:
	
	if position.y > 512:
		position = Vector2(0, -256)
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func pickup(body: RigidBody2D) -> void:
	body.freeze = true
	hold_item_collision_layer = body.collision_layer
	hold_item_collision_mask = body.collision_mask
	body.collision_mask = 0
	body.collision_layer = 0
	hold_item = body
	
func drop() -> void:
	hold_item.freeze = false
	hold_item.collision_mask = hold_item_collision_mask
	hold_item.collision_layer = hold_item_collision_layer
	hold_item = null

func update_highlight() -> void:
	if highlight_item:
		highlight_item.material = null
	
	var pickup_item = get_pickup_item()
	highlight_item = pickup_item
	
	if pickup_item != null:
		pickup_item.material = preload("res://highlight_shader.tres")


	
func get_pickup_item() -> RigidBody2D:
	if hold_item == null:
		# TODO: sort by distance
		for item in $PickupArea.get_overlapping_bodies():
			return item
	
	return null

func get_total_mass() -> float:
	var total_mass := mass
	
	if hold_item:
		total_mass += hold_item.mass
	
	return total_mass

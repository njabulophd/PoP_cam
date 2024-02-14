extends CharacterBody3D

@export var ground_acceleration : float = 1.5;
const air_acceleration : float = -3.5;
const move_speed : float = 5.0
const jump = 9
@export var cam_root : Node;
#var cam_xrot = cam_root.cam_xrot;

# Get the gravity from the project settings to be synced with RigidBody nodes.
@export var gravity = 35


func _physics_process(delta):	
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= (gravity + air_acceleration)* delta
	#Debug quit
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()
	#END
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = lerp(direction.x, direction.x * move_speed, ground_acceleration);
		velocity.z = lerp(direction.z, direction.z * move_speed, ground_acceleration);# direction.z * move_speed
	else:
		velocity.x = move_toward(velocity.x, 0, move_speed)
		velocity.z = move_toward(velocity.z, 0, move_speed)

	move_and_slide()

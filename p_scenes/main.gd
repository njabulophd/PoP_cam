extends Node

@onready var player = get_node("player");
var changed_cam : bool = false;
var disable_cam_change = false;
@onready var scene_cam = get_node("scene_cam");
@onready var area_cam = get_node("room_00/room_cam/Camera3D");
@onready var player_cam = get_node("cameraRoot/cam_xrot/SpringArm3D/Camera3D");
@onready var player_cam_rotation = get_node("cameraRoot");
var entered_room : bool  = false;
# @onready var environment_cam = get_node("Camera3D")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	area_cam.look_at(player.position, Vector3.UP, false);
	if Input.is_action_just_pressed("change_cam") and disable_cam_change == false:
		print("Before change: ",changed_cam)
		changed_cam = !changed_cam;
		scene_cam.current = changed_cam;
		print("After change: ",changed_cam)
	if Input.is_action_pressed("move_forward") and player_cam.current == true:
		player.rotation.y = player_cam_rotation.rotation.y

func _on_room_00_body_entered(body):
	print(body, " has entered the area");
	if body.is_in_group("player"):
		disable_cam_change = true;
		area_cam.make_current()
		#area_cam.current = true;
	else:
		player_cam.current = true;
func _on_room_00_body_exited(body):
	disable_cam_change = false
	print(body, " has left the area");
	player_cam.current = true;

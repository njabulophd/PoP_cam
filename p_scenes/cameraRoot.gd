extends Node3D

@export var player : Node;
@export var value : float = 0.50;
@export var cam_dist : float = 0.99;
@export var invert_x: int = -1;
@export var invert_y: int = -1;
@onready var cam_root = get_node(".");
@onready var cam_xrot = get_node("cam_xrot");
@onready var player_cam = get_node("cam_xrot/SpringArm3D/Camera3D");
@export var mouse_sensitivity = 0.03;
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
func _process(delta):
	#cam_root.look_at(player.position, Vector3.UP, false)
	cam_root.position = lerp((player.position * cam_dist), player.position, value)
	#cam_root.position = player.position
func _unhandled_input(event):
	if event is InputEventMouseMotion:
		if player_cam.current == true:
			cam_xrot.rotate_x(deg_to_rad((invert_y*event.relative.y) * mouse_sensitivity));
		cam_root.rotate_y(deg_to_rad((invert_x*event.relative.x) * mouse_sensitivity));
		
func track_rotation(player, root, sway):
	pass

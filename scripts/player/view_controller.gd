## Component that assists the player in controlling the view 
class_name ViewController extends Node

const MOUSE_SPEED: float = -0.0005

@export_range(0.1, 10.0, 0.1) var mouse_sensibility: float = 1.0

@export_category("Adjustments")
@export var _camera_min_angle: float = - PI / 2
@export var _camera_max_angle: float = PI / 2

@export_category("View Origin Nodes")
## Body will be rotated in the Y Axis
@export var _body: Node3D
## Camera origin will be rotated in the X Axis
@export var _camera_origin: Node3D

## Current degrees of rotation for the view:[br]
## - x represents the X axis of the [member _camera_origin];[br]
## - y represents the Y axis of the [member _body].[br]
var _current_rotation: Vector2 = Vector2.ZERO

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _process(_delta: float) -> void:
	var mouse_vel: Vector2 = Input.get_last_mouse_velocity()
	
	_current_rotation += Vector2(mouse_vel.y, mouse_vel.x) * MOUSE_SPEED * mouse_sensibility
	_current_rotation.x = clampf(_current_rotation.x, _camera_min_angle, _camera_max_angle)
	
	_apply_rotation(_current_rotation)
	
## Applies [param rotation] to [member _body] and [member _camera_origin].
func _apply_rotation(rotation: Vector2) -> void:
	_body.rotation.y = rotation.y
	
	_camera_origin.rotation.x = clampf(rotation.x, _camera_min_angle, _camera_max_angle)

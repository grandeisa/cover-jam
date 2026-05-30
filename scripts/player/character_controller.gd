## Used to translate input as movement to a player [CharacterBody3D].[br]
## This node makes the character move with constant velocity.
class_name CharacterController extends Node

## Project gravity, defined at node instatiation.
var _gravity: float = Input.get_gravity().y

## [CharacterBody3D] to be controlled. (Preferably a parent to this node)
@export var _body: CharacterBody3D

@export_category("Physics")
## The speed in which the character moves.
@export var _speed: float = 160.0

func _physics_process(delta: float) -> void:
	var movement_input: Vector2 = Input.get_vector("p_left", "p_right", "p_backward", "p_forward").normalized() * _speed * delta
	var movement_velocity: Vector3 = Vector3.ZERO
	
	# Add X axis velocity based on player's facing direction
	movement_velocity += _body.basis.x * -movement_input.x
	
	# Add Z axis velicity based on player's facing direction
	movement_velocity += _body.basis.z * movement_input.y
	
	if not _body.is_on_floor():
		_body.velocity.y += _gravity
		
	_body.velocity = Vector3(
		movement_velocity.x,
		_body.velocity.y,
		movement_velocity.z
	)
	_body.move_and_slide()

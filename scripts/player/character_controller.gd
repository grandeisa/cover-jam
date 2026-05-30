## Used to translate input as movement to a player [CharacterBody3D].[br]
## This node makes the character move with constant velocity.
class_name CharacterController extends Node

const GRAVITY: float = 9.8

## [CharacterBody3D] to be controlled. (Preferably a parent to this node)
@export var _body: CharacterBody3D
@export var _stair_detector_ray: RayCast3D

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
	
	if  _body.is_on_floor():
		#Auto-jump when the bump have less than 0.2m
		if _stair_detector_ray.is_colliding():
			var bump_col_point = _stair_detector_ray.get_collision_point()
			var dist = bump_col_point.distance_to(_stair_detector_ray.global_position)
			if dist > 0.8:
				#Move up and forward automatically
				_body.position.y += (1 - dist)
				_body.position += _body.basis.z * (1 - dist)
	else:
		_body.velocity.y -= GRAVITY * delta
		
	_body.velocity = Vector3(
		movement_velocity.x,
		_body.velocity.y,
		movement_velocity.z
	)
	_body.move_and_slide()

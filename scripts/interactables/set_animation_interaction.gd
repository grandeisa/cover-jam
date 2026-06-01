extends InteractionBehaviour

@export var _animator: AnimationPlayer
@export var _animation: StringName

func _on_interact() -> void:
	_animator.play(_animation)
	

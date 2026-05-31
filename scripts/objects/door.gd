extends Interactable
@export var anim_player : AnimationPlayer
@export var is_open := false
@export var is_locked := false
func _on_interact() -> void:
	if is_locked:
		pass
	else:
		anim_player.play("close") if is_open else anim_player.play("open")
		is_open = not is_open

extends InteractionBehaviour

func _on_interact() -> void:
	get_parent().active = false

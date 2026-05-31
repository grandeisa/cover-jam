extends InteractionBehaviour

@export_file_path var _scene_path: String = ""

func _on_interact() -> void:
	get_tree().change_scene_to_file(_scene_path)

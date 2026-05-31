extends InteractionBehaviour

@export var _scene_path: StringName = ""

func _on_interact() -> void:
	MainScene.change_scene(_scene_path)

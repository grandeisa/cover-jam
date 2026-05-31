extends Node2D

## Path of the scene to be change into when [code]p_reset[/code] is pressed.
@export_file_path var _game_scene_path: String = ""

## Label containing the ending's content text.
@export var _content_label: RichTextLabel

func _ready() -> void:
	var ending: String = EventManager.get_first_event_ending_text()
	if not ending.is_empty():
		_content_label.text = ending


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("p_reset"):
		EventManager.reset()
		get_tree().change_scene_to_file(_game_scene_path)

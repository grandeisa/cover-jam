extends Node2D

const TITLE_CODE: StringName = "menu_ending-title_doom"
const RESET_CODE: StringName = "menu_ending-reset"

## Path of the scene to be change into when [code]p_reset[/code] is pressed.
@export_file_path var _game_scene_path: String = ""

## Label containing this scene's title.
@export var _title_label: RichTextLabel

## Label containing the ending's content text.
@export var _content_label: RichTextLabel

## Label containing the reset input hint
@export var _reset_label: RichTextLabel

func _ready() -> void:
	var ending: String = EventManager.get_first_event_ending_text()
	if not ending.is_empty():
		_content_label.text = tr(ending)
	
	_title_label.text = tr(TITLE_CODE)
	_reset_label.text = tr(RESET_CODE) + "\n\n"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("p_reset"):
		EventManager.reset()
		get_tree().change_scene_to_file(_game_scene_path)

extends Node2D

const TITLE_CODE: StringName = "menu_ending-title_doom"
const TRUE_ENDING_TITLE_CODE: StringName = "menu_ending-title_true"
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
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	var ending: String = EventManager.get_first_event_ending_text()
	if not ending.is_empty():
		_content_label.text = tr(ending).replace("{time}", EventManager.latest_time)
	if EventManager.get_first_event_for_ending().is_empty():
		_title_label.text = tr(TRUE_ENDING_TITLE_CODE)
	else:
		_title_label.text = tr(TITLE_CODE)
	_reset_label.text = tr(RESET_CODE) + "\n\n"


func _on_reset_button_pressed() -> void:
	EventManager.reset()
	MainScene.change_scene("house")

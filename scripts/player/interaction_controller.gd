## Handles interaction input and detection for a player character
class_name InteractionController extends Node

## [RayCast3D] used to detect interactable objects.
@export var _detector_ray: RayCast3D

## Used to display the text of the interactions hint.
@export var _interaction_hint_label: RichTextLabel

## Used to display the response of an interaction.
@export var _response_label: RichTextLabel

## How much time [member _response_label] will be visible.00
@export var _response_lifetime: float = 2.5

## Timer used to determne how long the response label is visible.
var _response_lifetime_timer: Timer

func _ready() -> void:
	_response_label.visible = false
	_response_lifetime_timer = Timer.new()
	_response_lifetime_timer.one_shot = true
	_response_lifetime_timer.timeout.connect(func(): _response_label.visible = false)
	add_child(_response_lifetime_timer)

func _process(_delta: float) -> void:
	_detect_interactable()
	

## Check if there is an interactable object in [member _detector_ray]'s path
## and handles interaction input.
func _detect_interactable() -> void:
	var detected_object = _detector_ray.get_collider()
	if detected_object is Interactable:
		if not detected_object.active:
			_interaction_hint_label.visible = false
			return
		
		_interaction_hint_label.text = tr(detected_object.interaction_hint)
		_interaction_hint_label.visible = true
		
		# Handle interaction.
		if Input.is_action_just_pressed("p_interact") and detected_object.active:
			detected_object.trigger_interaction()
			if not detected_object.response_text_code.is_empty():
				_response_label.text = tr(detected_object.response_text_code)
				_response_label.visible = true
				_response_lifetime_timer.start(_response_lifetime)
	else:
		_interaction_hint_label.visible = false

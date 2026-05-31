## Handles interaction input and detection for a player character
class_name InteractionController extends Node

## [RayCast3D] used to detect interactable objects.
@export var _detector_ray: RayCast3D

## Used to display the text of the interactions hint.
@export var _interaction_hint_label: RichTextLabel

# Called every frame. 'delta' is the elapsed time since the previous frame.
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
		
		_interaction_hint_label.text = detected_object.interaction_hint
		_interaction_hint_label.visible = true
		
		if Input.is_action_just_pressed("p_interact"):
			detected_object.trigger_interaction()
	else:
		_interaction_hint_label.visible = false

class_name Interactable extends Node

## Code of the localized text to be displayed when player looks at object
@export var interaction_hint: StringName = ""
## Code of the localized text to be displayed after interacting with an object
@export var response_text_code: StringName = ""

## Used to define if an object can be interacted with or not.[br]
## Interaction hint should not be displayed if this isn't active.
var active: bool = true

signal _interact

## Used to call an interaction for this object.
## In case the object is not active, the command is ignored
func trigger_interaction() -> void:
	if not active: return
	_interact.emit()

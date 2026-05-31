extends InteractionBehaviour

## Event to be triggered on interaction.
@export var _event: StringName = ""

func _on_interact() -> void:
	EventManager.trigger_event(_event)

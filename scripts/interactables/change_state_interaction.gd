extends InteractionBehaviour

@export var _next_state: Interactable
@export var _state_machine_interactable: StateMachineInteractionBehaviour

func _on_interact() -> void:
	_state_machine_interactable.set_state(_next_state)

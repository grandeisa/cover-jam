class_name StateMachineInteractionBehaviour extends InteractionBehaviour

## Uses [Interactable]s as children in order to rerout their interaction behaviour.
@export var _current_state: Interactable

func _ready() -> void:
	super._ready()
	# Called to set the initial hint and response code values in the parent.
	set_state(_current_state)

func _on_interact() -> void:
	_current_state.trigger_interaction()
	
func set_state(interaction: Interactable) -> void:
	if interaction == null: return
	_current_state = interaction
	get_parent().interaction_hint = interaction.interaction_hint
	get_parent().response_text_code = interaction.response_text_code
	get_parent().codes_changed.emit()
	_current_state.codes_changed.connect(_on_codes_changed)

func _on_codes_changed() -> void: 
	get_parent().interaction_hint = _current_state.interaction_hint
	get_parent().response_text_code = _current_state.response_text_code

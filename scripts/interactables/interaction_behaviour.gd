## [InteractionBehaviour] Nodes are supposed to be used as children of [Interaction] nodes,
## they connect automatically to their parent's [signal Interaction.interact] signal.
@abstract
class_name InteractionBehaviour extends Node

func _ready() -> void:
	var interactable: Interactable = get_parent()
	interactable.interact.connect(_on_interact)

@abstract func _on_interact() -> void

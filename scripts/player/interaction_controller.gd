## Handles interaction input and detection for a player character
class_name InteractionController extends Node

## [RayCast3D] used to detect interactable objects.
@export var _detector_ray: RayCast3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_detect_interactable()
	
	
func _detect_interactable() -> void:
	var detected_object = _detector_ray.get_collider()
	
	if detected_object is not Interactable: return
	
	print("Detected object")

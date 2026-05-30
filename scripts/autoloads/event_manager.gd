## Manages the in-game events that have to be achieved by the player.
extends Node

## List of all possible events to be checked (ordered).
const EVENT_LIST: Array[StringName] = [
	"oven_off"
]

## States of all current events.
var _event_states: Dictionary[StringName, bool] = {}

func _ready() -> void:
	reset()

## Resets all values of [member event_states] to [code]false[/code].
func reset() -> void:
	for event in EVENT_LIST:
		_event_states[event] = false

## Returns the current state for [param event].[br]
## Returns false in case the event doesn't exist.
func get_event_state(event: StringName) -> bool: return _event_states.get(event, false)

## Sets [param event] state as [code]true[/code] if it is in the list of events.
func trigger_event(event: StringName):
	if not _event_states.has(event): return
	
	_event_states[event] = true

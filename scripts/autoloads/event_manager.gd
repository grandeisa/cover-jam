## Manages the in-game events that have to be achieved by the player.
extends Node

## List of all possible events to be checked.
const EVENT_LIST: Array[StringName] = [
	"oven_off"
]

## States of all current events.
var event_states: Dictionary[StringName, bool] = {}

func _ready() -> void:
	reset()

## Resets all values of [member event_states] to [code]false[/code].
func reset() -> void:
	for event in EVENT_LIST:
		event_states[event] = false

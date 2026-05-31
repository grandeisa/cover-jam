## Manages the in-game events that have to be achieved by the player.
extends Node

## List of all possible events to be checked (ordered).
const EVENT_LIST: Array[StringName] = [
	"oven_off"
]

## Key: Events that have endings[br]
## Value: Text displayed in case of ending (event is [code]false[/code])[br]
## [b]All texts should be displayed with a BBCode enabled [RichTextLabel][/b]
const _ending_texts: Dictionary[StringName, String] = {
	"oven_off" : "Você deixou o fogão ligado. O mundo pegou fogo."
}

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

## Returns the ending text for the desired event.[br]
## Returns an empty [string] in case the ending text doesn't exist.
func get_event_ending_text(event: StringName) -> String: return _ending_texts.get(event, "")

## Returns the ending text for the first element in the [member _event_states] [Dictionary]
## that is [code]false[/code].
## Returns an empty [String] if there are no events available.
func get_first_event_ending_text() -> String:
	for event in _ending_texts.keys():
		if _event_states.get(event, true): continue
		return _ending_texts.get(event, "For some reason the text is missing...")
	
	return ""

## Sets [param event] state as [code]true[/code] if it is in the list of events.
func trigger_event(event: StringName):
	if not _event_states.has(event): return
	
	_event_states[event] = true

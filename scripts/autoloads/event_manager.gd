## Manages the in-game events that have to be achieved by the player.
extends Node

## List of all possible events to be checked (ordered).
const EVENT_LIST: Array[StringName] = [
	"on-time",
	"oven_off",
	"backpack_pickup",
	"glasses_pickup",
	"clothes_pickup",
	"clothes-on-dryer",
	"cat_pet",
	"keys_pickup",
	"house-door_lock",
	"docs_pickup",
	"docs_scanned",
	"planks_pickup",
	"basement-door_planks-on-front",
	"basement-door_blocked",
	"hammer_pickup",
	"mother",
	"computer_off",
	"map_pickup",
	"map_hidden",
	"journal_pickup",
	"journal_burn",
	"trash_pickup",
	"dumpster_filled",
	"pills_taken"
]

## Key: Events that have endings[br]
## Value: Text displayed in case of ending (event is [code]false[/code])[br]
## [b]All texts should be displayed with a BBCode enabled [RichTextLabel][/b]
const _ending_texts: Dictionary[StringName, String] = {
	"backpack_pickup" : "finale-event_backpack_pickup",
	"glasses_pickup" : "finale-event_glasses_pickup",
	"oven_off" : "finale-event_oven_off",
	"clothes-on-dryer" : "finale-event_clothes",
	"cat_pet" : "finale-event_cat",
	"house-door_lock" : "finale-event_house-door",
	"computer_off" : "finale-event_computer",
	"basement-door_blocked" : "finale-event_basement-door",
	"mother" : "finale-event_mother",
	"map_hidden" : "finale-event_magnet",
	"docs_scanned" : "finale-event_documents",
	"journal_burn" : "finale-event_journal",
	"dumpster_filled" : "finale-event_trash",
	"pills_taken" : "finale-event_pills"
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

## Returns the ending translation key for the first element in the [member _event_states] [Dictionary]
## that is [code]false[/code].
## Returns the code for the final ending if there are no events available.
func get_first_event_ending_text() -> String:
	for event in _ending_texts.keys():
		if _event_states.get(event, true): continue
		return _ending_texts.get(event, "For some reason the text is missing...")
	
	return "finale-event_true-ending"

func get_first_event_for_ending() -> String:
	for event in _ending_texts.keys():
		if _event_states.get(event, true): continue
		return event
	
	return ""

## Sets [param event] state as [code]true[/code] if it is in the list of events.
func trigger_event(event: StringName):
	if not _event_states.has(event): return
	
	_event_states[event] = true

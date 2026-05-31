extends Node

@export var level_time: float = 5.0 * 60
@export var _timer_label: RichTextLabel

var _timer: Timer


func _ready() -> void:
	_timer = Timer.new()
	_timer.one_shot = true
	_timer.timeout.connect(_on_timer_timeout)
	add_child(_timer)
	
	_timer.start(level_time)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var time_text: String = get_time_string()
	_timer_label.text = time_text
	if _timer.time_left <= 60:
		_timer_label.text = "[color=red]"+time_text+"[/color]"
	
func get_time_string() -> String:
	var time: float = _timer.time_left
	var seconds_str = ("%.3f" % time).split(".")
	var seconds: int = int(seconds_str[0]) % 60
	var minutes: int = (int(seconds_str[0]) - seconds) / 60
	var miliseconds: int = int(seconds_str[1])
	
	return "[b]%d:%d.%3d[/b]" % [minutes, seconds, miliseconds]

func _on_timer_timeout() -> void:
	EventManager.latest_time = get_time_string()
	MainScene.change_scene("end")

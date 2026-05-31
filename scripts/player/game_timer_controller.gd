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
	var time: float = _timer.time_left
	var seconds: int = int(time) % 60
	time -= seconds
	var minutes: int = (seconds - time) / 60
	time -= minutes * 60
	var miliseconds: int = int(min(time, 0.999) * 1000)
	
	_timer_label.text = "[b]%d:%d.%d[/b]" % [minutes, seconds, miliseconds]
	if minutes <= 0:
		_timer_label.text = "[shake rate=20.0 connected=1][b][color=red]%d:%d.%d[/color][/b][/shake]" % [minutes, seconds, miliseconds]
	
	

func _on_timer_timeout() -> void:
	MainScene.change_scene("end")

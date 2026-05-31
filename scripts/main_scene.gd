class_name MainScene extends Node

const STARTING_SCENE = "main-menu"

const SCENE_PATHS: Dictionary = {
	"main-menu" : "res://scenes/main_menu.tscn",
	"intro-scene" : "res://scenes/intro_scene.tscn",
	"house" : "res://scenes/test_house_scene.tscn",
	"end" : "res://scenes/end_scene.tscn" ,
}

var _loaded_scenes: Dictionary[String, PackedScene] = {}

@onready var _loading_screen: CanvasLayer = $LoadingScreen
@onready var _loading_screen_animator: AnimationPlayer = $LoadingScreen/AnimationPlayer

var _current_scene: Node

static var _instance: MainScene

func _ready() -> void:
	if _instance != null and _instance != self:
		queue_free()
		return
	_instance = self
	#_load_scene("house")
	change_scene(STARTING_SCENE)

	
static func change_scene(scene: String) -> void:
	_instance._change_scene(scene)
	
func _change_scene(scene: String) -> void:
	_loading_screen.visible = true
	_loading_screen_animator.play("loading")
	_loading_screen.visible = true
	_loading_screen_animator.play("loading")
	if scene not in _loaded_scenes.keys():
		_instance._load_scene(scene)
		while scene not in _loaded_scenes.keys():
			await get_tree().create_timer(0.001).timeout
			
	var new_scene: Node = _loaded_scenes.get(scene).instantiate()
	add_child(new_scene)
	if _current_scene:
		_current_scene.queue_free()
	_current_scene = new_scene
	_loading_screen.visible = false
	_loading_screen_animator.stop()
	

func _load_scene(scene: String) -> void:
	var path: String = SCENE_PATHS[scene]
	if ResourceLoader.load_threaded_get_status(path) == ResourceLoader.ThreadLoadStatus.THREAD_LOAD_IN_PROGRESS: return
	ResourceLoader.load_threaded_request(path)
	while ResourceLoader.load_threaded_get_status(path) != ResourceLoader.ThreadLoadStatus.THREAD_LOAD_LOADED:
		if ResourceLoader.load_threaded_get_status(path) == ResourceLoader.ThreadLoadStatus.THREAD_LOAD_FAILED:
			push_warning("ResourceLoader failed to load resource %s | Trying again..." % path)
			
		await get_tree().create_timer(0.001).timeout
	
	_loaded_scenes.set(scene, ResourceLoader.load_threaded_get(path))
	

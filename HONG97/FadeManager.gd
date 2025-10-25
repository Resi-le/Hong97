extends CanvasLayer

@onready var overlay = $ColorRect
var tween: Tween

func _ready():
	fade_in()

func fade_in(duration: float = 0.5):
	if tween and tween.is_running():
		tween.kill()
	
	tween = create_tween()

	overlay.mouse_filter = Control.MOUSE_FILTER_STOP
	tween.tween_property(overlay, "modulate:a", 0.0, duration)
	tween.tween_callback(func(): overlay.mouse_filter = Control.MOUSE_FILTER_IGNORE)

func fade_to_scene(scene_path: String, duration: float = 0.5):
	if tween and tween.is_running():
		return

	tween = create_tween()
	overlay.mouse_filter = Control.MOUSE_FILTER_STOP
	tween.tween_property(overlay, "modulate:a", 1.0, duration)

	await tween.finished
	get_tree().change_scene_to_file(scene_path)

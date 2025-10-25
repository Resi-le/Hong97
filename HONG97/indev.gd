extends TextureRect

func _ready():
	FadeManager.fade_in(0.5)

func _unhandled_input(event):
	if event.is_action_pressed("ui_accept") and event.pressed:
		if FadeManager.tween and FadeManager.tween.is_running():
			return
		FadeManager.fade_to_scene("res://Title.tscn", 0.5)

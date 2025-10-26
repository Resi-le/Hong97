extends Area2D

var speed = 800
func _process(delta):
	position.y -= speed * delta
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

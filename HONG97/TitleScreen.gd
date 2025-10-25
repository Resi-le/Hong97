extends TextureRect

func _ready():
	FadeManager.fade_in(0.5)

# 'Enter' 키 입력을 감지 (Godot 3 방식)
func _unhandled_input(event):
	# "ui_accept" 액션이면서, "눌린(pressed)" 이벤트인지 확인
	if event.is_action_pressed("ui_accept") and event.pressed:
		
		# FadeManager가 이미 씬 전환 중인지 확인 (연타 방지)
		if FadeManager.tween and FadeManager.tween.is_running():
			return
			
		# "res://story.tscn" 부분은 실제 넘어갈 씬 경로로 수정하세요!
		FadeManager.fade_to_scene("res://story.tscn", 0.5)

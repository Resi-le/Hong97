extends ColorRect
var current_line_index = 0
var is_fading_text = false
var dialogue_images = [
	"res://Sprite/Texture/story-1.png",
	"res://Sprite/Texture/story-2.png",
	"res://Sprite/Texture/story-3.png",
	"res://Sprite/Texture/story-4.png",
]
var dialogue_lines = [
	"2025년이 왔다.\n전국에서 더러운 유저들이 “롤백”를 외치며 떼로 몰려온다.",
	"불만이 폭주한다!\n주가가 떨어진다!\n그래서 카카로 본부는 '홍민철'을 비밀리에 불러들여 유저 말살 계획을 의뢰했다.",
	"홍은 혁신의 프로다.\n5천만 유저를 단 한 명도 남김없이 입막음하라!",
	"그러나, 리벤스드에서는 숏폼탭을 원래대로 개조하는 연구가 착착 진행되고 있었다!",
]
func _ready():
	FadeManager.fade_in(0.5)
	$Text.grab_focus()
	if current_line_index < dialogue_lines.size():
		$Text.bbcode_text = dialogue_lines[current_line_index]
		current_line_index += 1

func _on_text_gui_input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_action_pressed("ui_accept"):
		if is_fading_text:
			return
		if FadeManager.tween and FadeManager.tween.is_running():
			return
		if current_line_index < dialogue_lines.size():
			change_text_with_fade()
		else:
			FadeManager.fade_to_scene("res://indev.tscn", 0.5)
func change_text_with_fade():
	is_fading_text = true
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property($Text, "modulate:a", 0.0, 0.3)
	tween.tween_property($StoryIMG, "modulate:a", 0.0, 0.3)
	await tween.finished
	update_content()
	tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property($Text, "modulate:a", 1.0, 0.3)
	tween.tween_property($StoryIMG, "modulate:a", 1.0, 0.3)
	await tween.finished
	is_fading_text = false
func update_content():
	$Text.bbcode_text = dialogue_lines[current_line_index]
	$StoryIMG.texture = load(dialogue_images[current_line_index])
	current_line_index += 1

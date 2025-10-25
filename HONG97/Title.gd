extends Control

var current_line_index = 0
var is_fading_text = false
var dialogue_lines = [
	"[font=res://Font/Unifont.ttf]製造·販売\n麗始蕊[/font]\n(Resi-le)\n[font=res://Font/Unifont.ttf]版權所有\n\n允許複製[/font]",
	"[font_size=25]REMIX WANTED![/font_size]\n\n[left][font_size=25]I will accept remix and relase source code on github. (But please do not make virus)\nI welcome any kind of remix\nso make your own remix.[/font_size][/left]\n",
	"[left][font_size=25]Would you like to make your own remix?[/font_size][left]\n[/left][font_size=25]I'm looking for remixers world-wide.\nIf you interested, don't ask to me and make your own[/font_size][/left]",
	"[font_size=25]RESI-LE[/font_size]\n\n[left][font_size=25]FOR THE WHO TORTURED BY KXXAO.[/font_size][/left]",
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
			FadeManager.fade_to_scene("res://TitleScreen.tscn", 0.5)
func change_text_with_fade():
	is_fading_text = true
	var tween = create_tween()
	tween.set_parallel(false)
	tween.tween_property($Text, "modulate:a", 0.0, 0.3)
	tween.tween_callback(update_text_content)
	tween.tween_property($Text, "modulate:a", 1.0, 0.3)
	await tween.finished
	is_fading_text = false
func update_text_content():
	$Text.bbcode_text = dialogue_lines[current_line_index]
	current_line_index += 1

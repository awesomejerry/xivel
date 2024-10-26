extends PanelContainer

func _ready():
	animate_appear()
	
func animate_appear():
	var tween = create_tween()
	tween.tween_property($CenterPanel, "pivot_offset", Vector2(100,100), 0.05)
	tween.tween_property($CenterPanel, "scale", Vector2(0.1,0.1), 0.05)
	tween.tween_property(self, "modulate", Color.WHITE, 0.3)
	tween.tween_property($CenterPanel, "scale", Vector2(1,1), 0.5)

func _on_retry_button_pressed():
	$ButtonClick.play()
	Globals.restart_current_level()
	queue_free()
	


func _on_main_menu_button_pressed():
	$ButtonClick.play()
	get_tree().change_scene_to_file("res://Scenes/ui/mainMenu/mainMenu.tscn")


func _on_retry_button_mouse_entered() -> void:
	$ButtonHover.play()

func _on_main_menu_button_mouse_entered() -> void:
	$ButtonHover.play()

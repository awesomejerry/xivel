extends Control

var mapSelectContainer : PanelContainer

func _on_quit_button_pressed():
	$ButtonClick.play()
	get_tree().quit()
	

	
func _on_start_button_pressed():
	$ButtonClick.play()
	if not mapSelectContainer:
		var mscScene := preload("res://Scenes/ui/mainMenu/select_map_container.tscn")
		var msc := mscScene.instantiate()
		mapSelectContainer = msc
		add_child(msc)
		


func _on_start_button_mouse_entered() -> void:
	$ButtonHover.play()


func _on_quit_button_mouse_entered() -> void:
	$ButtonHover.play()

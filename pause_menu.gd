extends Control
var is_resuming
func _ready() -> void:
	get_tree().paused = false
	hide()
	$Blur.play("RESET") 

func _process(delta: float) -> void:
	pass
	
func resume() -> void:
	is_resuming = true
	for button in $PausePanel/PanelBox.get_children():
		button.disabled = true
	$Blur.play_backwards("Blur")
	await $Blur.animation_finished
	for button in $PausePanel/PanelBox.get_children():
		button.disabled = false
	hide()
	get_tree().paused = false
	is_resuming = false
func pause():
	get_tree().paused = true
	show()
	$Blur.play("Blur")
	await $Blur.animation_finished
	
func _input(event):
	if event is InputEventKey:
		if event.is_action_pressed("escape"):
			if get_tree().paused:
				if not is_resuming:
					resume()
			else:
				pause()
			get_viewport().set_input_as_handled()
	
func _on_restart_button_pressed() -> void:
	$Blur.play_backwards("Blur")
	await $Blur.animation_finished
	get_tree().reload_current_scene()

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_resume_button_pressed() -> void:
	resume()

extends Position3D

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("a_toggle_mouse_lock"):
		toggle_mouse_lock()

func toggle_mouse_lock() -> void:
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

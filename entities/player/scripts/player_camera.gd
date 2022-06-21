extends Position3D

@onready var player: RigidDynamicBody3D = get_parent()

func _input(event: InputEvent) -> void:
	mouse_movement(event)
	
	if Input.is_action_just_pressed("a_toggle_mouse_lock"):
		toggle_mouse_lock()

func mouse_movement(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotation.x -= event.relative.y * player.mouse_sensitivity
		rotation.x = clamp(rotation.x, deg2rad(-80), deg2rad(80))

		player.rotation.y -= event.relative.x * player.mouse_sensitivity
		player.rotation.y = wrapf(player.rotation.y, 0, deg2rad(360))

func toggle_mouse_lock() -> void:
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

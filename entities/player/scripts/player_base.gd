extends RigidDynamicBody3D

@export var speed := 5.0
@export var jump_strength := 5.0
@export var number_jumps := 2
@export var mouse_sensitivity := 0.001

@onready var _camera_pivot: Node3D = $CameraPivot
@onready var _ground_ray_cast: RayCast3D = $GroundRayCast3D

var _current_jump := 0
var _air_time := 0.0
var is_jumping := false


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta: float) -> void:
	air_time(delta)
		
func _integrate_forces(state: PhysicsDirectBodyState3D) -> void:
	character_movement(state)



func character_movement(state: PhysicsDirectBodyState3D) -> void:
	# Reset the number of jumps on touch the floor
	if _ground_ray_cast.is_colliding() and _air_time > 0.1:
		is_jumping = false
		_current_jump = 0

	# Handle Jump.		
	if Input.is_action_just_pressed("a_jump") and _current_jump < number_jumps:
		is_jumping = true
		_current_jump += 1
		
		if state.linear_velocity.y < jump_strength:
			state.linear_velocity.y = 0.0
			
		state.apply_central_impulse(Vector3.UP * jump_strength)

	# Get the input direction and handle the movement/deceleration.
	var input_dir = Input.get_vector("a_left", "a_right", "a_up", "a_down")
	var direction = (_camera_pivot.global_transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		state.linear_velocity.x = direction.x * speed
		state.linear_velocity.z = direction.z * speed
	else:
		state.linear_velocity.x = 0.0
		state.linear_velocity.z = 0.0

func air_time(delta: float) -> void:
	if is_jumping:
		_air_time += delta
	else:
		_air_time = 0.0

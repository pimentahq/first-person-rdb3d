extends Area3D

@export var jump_impulse := 16.0

func _ready() -> void:
	self.connect("body_entered", body_entered)

func body_entered(body: Node3D) -> void:
	if body.is_class("RigidDynamicBody3D"):
		body.linear_velocity.y = 0.0
		body.apply_central_impulse(Vector3.UP * jump_impulse)

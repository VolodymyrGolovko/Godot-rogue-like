extends CharacterBody2D

@onready var cursor_target := $CursorTarget
@onready var camera := $Camera2D
const MAX_CURSOR_DISTANCE = 600
const CAMERA_SHIFT_RATIO = 0.3

func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * 300
	move_and_slide()

func _process(delta):
	var world_mouse_position = get_global_mouse_position()
	var desired_position = global_position * 0.33 + world_mouse_position * 0.66
	if global_position.distance_to(desired_position) > MAX_CURSOR_DISTANCE:
		desired_position = global_position + (desired_position - global_position).normalized() * MAX_CURSOR_DISTANCE
	cursor_target.global_position = desired_position
	var camera_offset = (cursor_target.global_position - global_position) * CAMERA_SHIFT_RATIO
	camera.position = camera_offset

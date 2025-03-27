extends Camera2D

@onready var player := $"../ColorRect"
@onready var cursor_target := $"../CursorTarget"

const CAMERA_FOLLOW_RATIO = 0.5

func _process(delta):
	if not player or not cursor_target:
		return

	var target_position = player.global_position.lerp(cursor_target.global_position, CAMERA_FOLLOW_RATIO)

	position = position.lerp(target_position, 0.1)

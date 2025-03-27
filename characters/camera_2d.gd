extends Camera2D

@onready var cursor_target := $"../CursorTarget"
@onready var player := $"../ColorRect"

func _process(delta):
	if not cursor_target or not player:
		return

	var mid_position = (player.global_position + cursor_target.global_position) / 2.0
	position = mid_position

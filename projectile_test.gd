extends Area2D

var travelled_distance = 0

func _physics_process(delta):
	const SPEED = 2000
	const RENGE = 4000
	
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * SPEED * delta
	
	travelled_distance += SPEED * delta
	if travelled_distance > RENGE:
		queue_free()

extends GameObject

class_name HighObstacle

func _ready():
	is_walkable = true
	passable_for_grounded = false
	passable_for_aerial = false
	is_moveable = true
	can_be_destroyed = true
	affectable = false
	
	max_health = 10 #placeholder
	if can_be_destroyed:
		current_health = max_health

func _physics_process(delta):
	if is_moveable:
		position += velocity * delta
		velocity = velocity.lerp(Vector2.ZERO, 0.5)

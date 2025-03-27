extends GameObject

func _ready():
	is_walkable = false
	passable_for_grounded = false
	passable_for_aerial = false
	is_moveable = true
	can_be_destroyed = true
	affectable = false
	
	max_health = 10 #placeholder

extends GameObject

func _ready():
	is_walkable = true
	passable_for_grounded = true
	passable_for_aerial = true
	is_moveable = false
	can_be_destroyed = false
	affectable = true

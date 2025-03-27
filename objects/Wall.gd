extends GameObject

func _ready():
	is_walkable = false
	passable_for_grounded = false
	passable_for_aerial = false
	is_moveable = false
	can_be_destroyed = false
	affectable = false

extends GameObject

class_name Void

func _ready():
	is_walkable = false 
	passable_for_grounded = true
	passable_for_aerial = true
	is_moveable = false
	can_be_destroyed = false
	affectable = false

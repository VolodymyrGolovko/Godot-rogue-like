extends GameObject

func _ready():
	is_walkable = true
	passable_for_grounded = false
	passable_for_aerial = true
	is_moveable = false
	can_be_destroyed = false
	affectable = false


func reaction_to_grounded(obj: Object):
	#описати зникання об'єкту, падіння в пустоту (ахахах, Чайльд)
	pass

extends BaseProjectile

class_name projectile_test

func _ready():
	can_collide_allied = false
	can_collide_hostile = true
	is_grounded = false
	is_breakable = true
	can_bounce = false
	can_pierce = false
	
	character_damage = 10
	obstacle_damage = 1
	
	SPEED = 2000
	RANGE = 4000
